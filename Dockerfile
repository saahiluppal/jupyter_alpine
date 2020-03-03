FROM alpine:3.10

ARG REQ_FILE='requirements.txt'
COPY ${REQ_FILE} /tmp/${REQ_FILE}

RUN apk update && apk add \
        build-base \
        libzmq \
        musl-dev \
        python3 \
        python3-dev \
        zeromq-dev

RUN pip3 install pyzmq
RUN apk del build-base musl-dev zeromq-dev python3-dev
RUN python3 -m pip --no-cache-dir install -r /tmp/${REQ_FILE}

RUN mkdir -pv /notebooks
COPY config.json /root/.jupyter/jupyter_notebook_config.json
VOLUME [ "/notebooks" ]

ENTRYPOINT [ "/usr/bin/jupyter-notebook" ]

EXPOSE 8888