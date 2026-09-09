# Development and CRAN-check environment for the deformula package.
#
#   make image      build this image (only needed once)
#   make document   regenerate NAMESPACE and man/
#   make test       run the testthat suite
#   make check      R CMD build + R CMD check --as-cran
#
# The tag is pinned so that check results stay reproducible.
FROM rocker/r-ver:4.5.1

# System libraries required to build devtools and its dependencies.
# qpdf and pandoc are required by "R CMD check --as-cran".
RUN apt-get update && apt-get install -y --no-install-recommends \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libgit2-dev \
        libfontconfig1-dev \
        libharfbuzz-dev \
        libfribidi-dev \
        libfreetype6-dev \
        libpng-dev \
        libtiff5-dev \
        libjpeg-dev \
        qpdf \
        pandoc \
    && rm -rf /var/lib/apt/lists/*

RUN install2.r --error --skipinstalled \
        Rcpp \
        devtools \
        roxygen2 \
        testthat \
        covr

# "R CMD check --as-cran" builds a PDF manual and validates the HTML manual.
# Without these the check reports an ERROR and a NOTE that say nothing about
# the package itself. install_texlive.sh installs TinyTeX under /opt/texlive
# world-readable and registers it in Renviron.site, so it works for any uid.
RUN /rocker_scripts/install_texlive.sh \
    && apt-get update && apt-get install -y --no-install-recommends tidy \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/local/texlive/bin/linux:${PATH}"

# TinyTeX ships a minimal scheme; add the LaTeX packages that Rd2pdf needs.
RUN tlmgr install \
        amsfonts \
        amsmath \
        courier \
        ec \
        epsf \
        fancyvrb \
        helvetic \
        hyperref \
        inconsolata \
        times \
        upquote \
        url \
    && tlmgr path add \
    && fmtutil-sys --all > /dev/null 2>&1 || true

# Debian/Ubuntu builds of R inject hardening flags that "R CMD check" reports
# as non-portable. They are a property of this image, not of the package, so
# strip them to keep the check output equivalent to the CRAN machines.
RUN sed -i \
        -e 's/ -Wformat -Werror=format-security -Wdate-time//' \
        /usr/local/lib/R/etc/Makeconf

WORKDIR /pkg
