## docker build --build-arg JHUB_VER=1.4.2 --build-arg PY_VER=3.8 --build-arg DIST=debian --build-arg CODEBOOK_BASE_HASH=a7ee3ce --build-arg DEPLOY_KEY=wt-ephys-no-curation-deploy.pem --build-arg REPO_OWNER=dj-sciops --build-arg REPO_NAME=wt-ephys-no-curation -f codebook.Dockerfile -t registry.vathes.com/sciops/codebook-wt-ephys-no-curation:v0.0.0 .

## Single Stage
ARG JHUB_VER
ARG PY_VER
ARG DIST
FROM datajoint/djlabhub:${JHUB_VER}-py${PY_VER}-${DIST}-561b765

RUN printf "git" >> /tmp/apt_requirements.txt && \
    /entrypoint.sh echo "installed"

USER root
RUN mkdir /home/user_data && \
    chown -R anaconda:anaconda /home/user_data && \
    chmod -R 775 /home/user_data
USER anaconda

ARG REPO_OWNER
ARG REPO_NAME
WORKDIR /tmp
RUN git clone https://github.com/${REPO_OWNER}/${REPO_NAME} && \
    pip install ./${REPO_NAME} && \
    cp -r ./${REPO_NAME}/notebooks/ /home && \
    cp -r ./${REPO_NAME}/images/ /home/notebooks/ || true && \
    cp ./${REPO_NAME}/README.md /home/notebooks/ && \
    cp -r ./${REPO_NAME}/user_data/ /home || true && \
    rm -rf /tmp/${REPO_NAME}

WORKDIR /home
