# Docker-based development environment for deformula.
# The host does not need R installed; everything runs inside the image
# built from ./Dockerfile. See that file for the available targets.

IMAGE := deformula-dev

# Run as the invoking user so that generated files (man/, NAMESPACE,
# deformula.Rcheck/) are not left owned by root on the host.
# HOME must point somewhere writable, otherwise R fails to start.
DOCKER_RUN := docker run --rm \
	-v "$(CURDIR)":/pkg \
	-w /pkg \
	-u $(shell id -u):$(shell id -g) \
	-e HOME=/tmp \
	$(IMAGE)

.PHONY: image document test check win mac submit readme shell clean

image:
	docker build -t $(IMAGE) .

document:
	$(DOCKER_RUN) Rscript -e 'roxygen2::roxygenise()'

test:
	$(DOCKER_RUN) Rscript -e 'devtools::test()'

check:
	$(DOCKER_RUN) sh -c 'R CMD build . && R CMD check --as-cran deformula_*.tar.gz'

# Pre-submission checks on the platforms this image cannot provide.
# Both upload the tarball to a build service and mail the result to the
# Maintainer address in DESCRIPTION -- nothing useful appears on stdout.
win:
	$(DOCKER_RUN) Rscript -e 'devtools::check_win_devel()'

mac:
	$(DOCKER_RUN) Rscript -e 'devtools::check_mac_release()'

# Submit to CRAN. Uploads the tarball together with cran-comments.md as the
# "Optional comment", then records CRAN-SUBMISSION. CRAN still mails a
# confirmation link that a human has to click.
#
# Needs a tty: submit_cran() guards itself with utils::menu(), which returns 0
# when R is not interactive -- the submission would abort without saying so.
submit:
	docker run --rm -it \
		-v "$(CURDIR)":/pkg \
		-w /pkg \
		-u $(shell id -u):$(shell id -g) \
		-e HOME=/tmp \
		$(IMAGE) R --quiet --interactive -e 'devtools::submit_cran()'

readme:
	$(DOCKER_RUN) Rscript -e 'devtools::build_readme()'

shell:
	docker run --rm -it \
		-v "$(CURDIR)":/pkg \
		-w /pkg \
		-u $(shell id -u):$(shell id -g) \
		-e HOME=/tmp \
		$(IMAGE) bash

clean:
	rm -rf deformula.Rcheck deformula_*.tar.gz src/*.o src/*.so
