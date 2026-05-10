FROM sharelatex/sharelatex:local

RUN tlmgr option repository https://ctan.math.utah.edu/ctan/tex-archive/systems/texlive/tlnet && \
    tlmgr install scheme-full && \
    mkdir -p /usr/share/fonts/truetype/msfonts

COPY ./fonts/ /usr/share/fonts/truetype/msfonts/

RUN apt-get update && \
    apt-get install -y --no-install-recommends fontconfig && \
    rm -rf /var/lib/apt/lists/*

RUN fc-cache -fv
