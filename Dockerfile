FROM debian:trixie

# Gestion de l'env
ENV QT_QPA_PLATFORM=offscreen
ENV XDG_RUNTIME_DIR=/tmp/runtime-TidalProducer

# Gestion des packets systeme
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git jackd2 qjackctl zlib1g-dev gcc g++ ghc cabal-install ca-certificates

RUN apt-get install -y --no-install-recommends \
    supercollider sc3-plugins sc3-plugins-language sc3-plugins-server \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# User + dossier runtime Qt
RUN useradd -m -G audio TidalProducer \
    && mkdir -p /tmp/runtime-TidalProducer \
    && chown TidalProducer:audio /tmp/runtime-TidalProducer \
    && chmod 700 /tmp/runtime-TidalProducer

USER TidalProducer
WORKDIR /home/TidalProducer

RUN export VERS=$(git ls-remote https://github.com/musikinformatik/SuperDirt.git | grep tags | tail -n1 | awk -F/ '{print $NF}'); \
    echo "Quarks.checkForUpdates({Quarks.install(\"SuperDirt\", \"$VERS\"); thisProcess.recompile(); 0.exit; });" > install_superdirt.scd \
    && sclang install_superdirt.scd \
    && rm install_superdirt.scd

RUN cabal update \
    && cabal install tidal --lib


CMD ["sleep", "5000"]
