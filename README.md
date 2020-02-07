# stream-logger

## Overview

The [stream-logger.py](stream-logger.py) python script consumes data
from various stream sources (Kafka, RabbitMQ) and logs it.
This is mostly used for testing the contents of of a queue.
The `senzing/stream-logger` docker image is a wrapper for use in docker formations (e.g. docker-compose, kubernetes).

To see all of the subcommands, run:

```console
$ ./stream-logger.py --help
usage: stream-logger.py [-h]
                        {kafka,rabbitmq,sleep,version,docker-acceptance-test}
                        ...

Log contents from a stream. For more information, see
https://github.com/senzing/stream-logger

positional arguments:
  {kafka,rabbitmq,sleep,version,docker-acceptance-test}
                        Subcommands (SENZING_SUBCOMMAND):
    kafka               Read JSON Lines from Apache Kafka topic.
    rabbitmq            Read JSON Lines from RabbitMQ queue.
    sleep               Do nothing but sleep. For Docker testing.
    version             Print version of program.
    docker-acceptance-test
                        For Docker acceptance testing.

optional arguments:
  -h, --help            show this help message and exit
```

To see the options for a subcommand, run commands like:

```console
./stream-logger.py kafka --help
```

### Related artifacts

1. [DockerHub](https://hub.docker.com/r/senzing/stream-logger)
1. [Helm Chart](https://github.com/Senzing/charts/tree/master/charts/senzing-stream-logger)

### Contents

1. [Expectations](#expectations)
    1. [Space](#space)
    1. [Time](#time)
    1. [Background knowledge](#background-knowledge)
1. [Demonstrate using Command Line](#demonstrate-using-command-line)
    1. [Install](#install)
    1. [Run from command line](#run-from-command-line)
1. [Demonstrate using Docker](#demonstrate-using-docker)
    1. [Initialize Senzing](#initialize-senzing)
    1. [Configuration](#configuration)
    1. [Volumes](#volumes)
    1. [Docker network](#docker-network)
    1. [Docker user](#docker-user)
    1. [External database](#external-database)
    1. [Database support](#database-support)
    1. [Run docker container](#run-docker-container)
1. [Develop](#develop)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Build docker image for development](#build-docker-image-for-development)
1. [Examples](#examples)
1. [Errors](#errors)
1. [References](#references)

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps you'll need to make some choices.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

## Expectations

### Space

This repository and demonstration require 6 GB free disk space.

### Time

Budget 40 minutes to get the demonstration up-and-running, depending on CPU and network speeds.

### Background knowledge

This repository assumes a working knowledge of:

1. [Docker](https://github.com/Senzing/knowledge-base/blob/master/WHATIS/docker.md)

## Demonstrate using Command Line

### Install

1. Install prerequisites:
    1. [Debian-based installation](docs/debian-based-installation.md) - For Ubuntu and [others](https://en.wikipedia.org/wiki/List_of_Linux_distributions#Debian-based)
    1. [RPM-based installation](docs/rpm-based-installation.md) - For Red Hat, CentOS, openSuse and [others](https://en.wikipedia.org/wiki/List_of_Linux_distributions#RPM-based).
1. Install mock-data-generator
    1. See [github.com/Senzing/mock-data-generator](https://github.com/Senzing/mock-data-generator#using-command-line)

### Run from command line

1. Run command.
    Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    ./stream-logger.py version
    ```

## Demonstrate using Docker

### Initialize Senzing

1. If Senzing has not been initialized, visit
   "[How to initialize Senzing with Docker](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/initialize-senzing-with-docker.md)".

### Configuration

Configuration values specified by environment variable or command line parameter.

- **[SENZING_DATA_SOURCE](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_data_source)**
- **[SENZING_DATA_VERSION_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_data_version_dir)**
- **[SENZING_DATABASE_URL](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_database_url)**
- **[SENZING_DEBUG](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_debug)**
- **[SENZING_ENTITY_TYPE](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_entity_type)**
- **[SENZING_ETC_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_etc_dir)**
- **[SENZING_G2_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_g2_dir)**
- **[SENZING_INPUT_URL](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_input_url)**
- **[SENZING_KAFKA_BOOTSTRAP_SERVER](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_kafka_bootstrap_server)**
- **[SENZING_KAFKA_GROUP](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_kafka_group)**
- **[SENZING_KAFKA_TOPIC](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_kafka_topic)**
- **[SENZING_LOG_LEVEL](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_log_level)**
- **[SENZING_MONITORING_PERIOD](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_monitoring_period)**
- **[SENZING_NETWORK](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_network)**
- **[SENZING_PROCESSES](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_processes)**
- **[SENZING_QUEUE_MAX](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_queue_max)**
- **[SENZING_RABBITMQ_HOST](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_rabbitmq_host)**
- **[SENZING_RABBITMQ_PASSWORD](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_rabbitmq_password)**
- **[SENZING_RABBITMQ_QUEUE](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_rabbitmq_queue)**
- **[SENZING_RABBITMQ_USERNAME](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_rabbitmq_username)**
- **[SENZING_RUNAS_USER](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_runas_user)**
- **[SENZING_SLEEP_TIME](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_sleep_time)**
- **[SENZING_SUBCOMMAND](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_subcommand)**
- **[SENZING_THREADS_PER_PROCESS](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_threads_per_process)**
- **[SENZING_VAR_DIR](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md#senzing_var_dir)**

### Volumes

:thinking:
"[How to initialize Senzing with Docker](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/initialize-senzing-with-docker.md)"
places files in different directories.
The following examples show how to identify each output directory.

1. **Example #1:**
   To mimic an actual RPM installation,
   identify directories for RPM output in this manner:

    ```console
    export SENZING_DATA_VERSION_DIR=/opt/senzing/data/1.0.0
    export SENZING_ETC_DIR=/etc/opt/senzing
    export SENZING_G2_DIR=/opt/senzing/g2
    export SENZING_VAR_DIR=/var/opt/senzing
    ```

1. :pencil2: **Example #2:**
   If Senzing directories were put in alternative directories,
   set environment variables to reflect where the directories were placed.
   Example:

    ```console
    export SENZING_VOLUME=/opt/my-senzing

    export SENZING_DATA_VERSION_DIR=${SENZING_VOLUME}/data/1.0.0
    export SENZING_ETC_DIR=${SENZING_VOLUME}/etc
    export SENZING_G2_DIR=${SENZING_VOLUME}/g2
    export SENZING_VAR_DIR=${SENZING_VOLUME}/var
    ```

1. :thinking: If internal database is used, permissions may need to be changed in `/var/opt/senzing`.
   Example:

    ```console
    sudo chown $(id -u):$(id -g) -R ${SENZING_VAR_DIR}
    ```

### Docker network

:thinking: **Optional:**  Use if docker container is part of a docker network.

1. List docker networks.
   Example:

    ```console
    sudo docker network ls
    ```

1. :pencil2: Specify docker network.
   Choose value from NAME column of `docker network ls`.
   Example:

    ```console
    export SENZING_NETWORK=*nameofthe_network*
    ```

1. Construct parameter for `docker run`.
   Example:

    ```console
    export SENZING_NETWORK_PARAMETER="--net ${SENZING_NETWORK}"
    ```

### Docker user

:thinking: **Optional:**  The docker container runs as "USER 1001".
Use if a different userid (UID) is required.

1. :pencil2: Manually identify user.
   User "0" is root.
   Example:

    ```console
    export SENZING_RUNAS_USER="0"
    ```

   Another option, use current user.
   Example:

    ```console
    export SENZING_RUNAS_USER=$(id -u)
    ```

1. Construct parameter for `docker run`.
   Example:

    ```console
    export SENZING_RUNAS_USER_PARAMETER="--user ${SENZING_RUNAS_USER}"
    ```

### External database

:thinking: **Optional:**  Use if storing data in an external database.
If not specified, the internal SQLite database will be used.

1. :pencil2: Specify database.
   Example:

    ```console
    export DATABASE_PROTOCOL=postgresql
    export DATABASE_USERNAME=postgres
    export DATABASE_PASSWORD=postgres
    export DATABASE_HOST=senzing-postgresql
    export DATABASE_PORT=5432
    export DATABASE_DATABASE=G2
    ```

1. Construct Database URL.
   Example:

    ```console
    export SENZING_DATABASE_URL="${DATABASE_PROTOCOL}://${DATABASE_USERNAME}:${DATABASE_PASSWORD}@${DATABASE_HOST}:${DATABASE_PORT}/${DATABASE_DATABASE}"
    ```

1. Construct parameter for `docker run`.
   Example:

    ```console
    export SENZING_DATABASE_URL_PARAMETER="--env SENZING_DATABASE_URL=${SENZING_DATABASE_URL}"
    ```

### Database support

:thinking: **Optional:**  Some database need additional support.
For other databases, these steps may be skipped.

1. **Db2:** See
   [Support Db2](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/support-db2.md)
   instructions to set `SENZING_OPT_IBM_DIR_PARAMETER`.
1. **MS SQL:** See
   [Support MS SQL](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/support-mssql.md)
   instructions to set `SENZING_OPT_MICROSOFT_DIR_PARAMETER`.

### Run docker container

1. :pencil2: Set environment variables.
   Example:

    ```console
    export SENZING_SUBCOMMAND=kafka
    export SENZING_DATA_SOURCE=TEST
    export SENZING_KAFKA_BOOTSTRAP_SERVER=senzing-kafka:9092
    export SENZING_KAFKA_TOPIC=senzing-kafka-topic
    export SENZING_MONITORING_PERIOD=60
    ```

1. Run docker container.
   Example:

    ```console
    sudo docker run \
      --env SENZING_SUBCOMMAND="${SENZING_SUBCOMMAND}" \
      --env SENZING_DATA_SOURCE="${SENZING_DATA_SOURCE}" \
      --env SENZING_KAFKA_BOOTSTRAP_SERVER="${SENZING_KAFKA_BOOTSTRAP_SERVER}" \
      --env SENZING_KAFKA_TOPIC="${SENZING_KAFKA_TOPIC}" \
      --env SENZING_MONITORING_PERIOD="${SENZING_MONITORING_PERIOD}" \
      --interactive \
      --rm \
      --tty \
      --volume ${SENZING_DATA_VERSION_DIR}:/opt/senzing/data \
      --volume ${SENZING_ETC_DIR}:/etc/opt/senzing \
      --volume ${SENZING_G2_DIR}:/opt/senzing/g2 \
      --volume ${SENZING_VAR_DIR}:/var/opt/senzing \
      ${SENZING_DATABASE_URL_PARAMETER} \
      ${SENZING_NETWORK_PARAMETER} \
      ${SENZING_OPT_IBM_DIR_PARAMETER} \
      ${SENZING_OPT_MICROSOFT_DIR_PARAMETER} \
      ${SENZING_RUNAS_USER_PARAMETER} \
      senzing/stream-logger
    ```

## Develop

### Prerequisite software

The following software programs need to be installed:

1. [git](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-git.md)
1. [make](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-make.md)
1. [docker](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-docker.md)

### Clone repository

For more information on environment variables,
see [Environment Variables](https://github.com/Senzing/knowledge-base/blob/master/lists/environment-variables.md).

1. Set these environment variable values:

    ```console
    export GIT_ACCOUNT=senzing
    export GIT_REPOSITORY=stream-logger
    export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

1. Follow steps in [clone-repository](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/clone-repository.md) to install the Git repository.

### Build docker image for development

1. **Option #1:** Using `docker` command and GitHub.

    ```console
    sudo docker build \
      --tag senzing/stream-logger \
      https://github.com/senzing/stream-logger.git
    ```

1. **Option #2:** Using `docker` command and local repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo docker build --tag senzing/stream-logger .
    ```

1. **Option #3:** Using `make` command.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo make docker-build
    ```

    Note: `sudo make docker-build-development-cache` can be used to create cached docker layers.

## Examples

1. Examples of use:
    1. [docker-compose-demo](https://github.com/Senzing/docker-compose-demo)
    1. [kubernetes-demo](https://github.com/Senzing/kubernetes-demo)
    1. [rancher-demo](https://github.com/Senzing/rancher-demo/tree/master/docs/db2-cluster-demo.md)

## Errors

1. See [docs/errors.md](docs/errors.md).

## References
