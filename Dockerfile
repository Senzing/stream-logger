ARG BASE_IMAGE=senzing/senzing-base:1.4.0
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2020-02-06

LABEL Name="senzing/stream-logger" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

# Install packages via apt.

RUN apt-get update \
 && apt-get -y install \
    librdkafka-dev \
 && rm -rf /var/lib/apt/lists/*

# Install packages via PIP.

RUN pip3 install \
    configparser \
    confluent-kafka \
    psutil \
    pika

# Copy files from repository.

COPY ./rootfs /
COPY ./stream-logger.py /app/

# Make non-root container.

USER 1001

# Runtime execution.

ENV SENZING_DOCKER_LAUNCHED=true

WORKDIR /app
ENTRYPOINT ["/app/stream-logger.py"]
