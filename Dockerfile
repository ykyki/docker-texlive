FROM ubuntu

ENV TL_VERSION 2024
ENV TL_PATH    /usr/local/texlive/${TL_VERSION}
ENV PATH       ${TL_PATH}/bin/x86_64-linux:/bin:${PATH}
ENV BASE_URL   https://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet
# ENV BASE_URL   https://texlive.texjp.org/${TL_VERSION}/tlnet

WORKDIR /tmp

RUN apt update  && \
    apt upgrade -y && \
    apt install -y \
    wget unzip make git ghostscript \
    perl-modules && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mkdir install-tl-unx && \
    wget -qO- "${BASE_URL}/install-tl-unx.tar.gz" | \
    tar -xz -C ./install-tl-unx --strip-components=1 && \
    printf "%s\n" \
    "TEXDIR ${TL_PATH}" \
    "selected_scheme scheme-full" \
    "option_doc 0" \
    "option_src 0" \
    > ./install-tl-unx/texlive.profile && \
    ./install-tl-unx/install-tl \
    -repository "${BASE_URL}" \
    -profile ./install-tl-unx/texlive.profile && \
    rm -rf *

RUN cjk-gs-integrate --cleanup --force && \
    cjk-gs-integrate --force && \
    kanji-config-updmap-sys --jis2004 haranoaji && \
    luaotfload-tool -u -f

RUN adduser --disabled-password texuser
USER texuser

VOLUME ["${TL_PATH}/texmf-var/luatex-cache"]

WORKDIR /workdir

CMD [ "bash" ]

