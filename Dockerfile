FROM openjdk:8-jre
ARG DRUID_VERSION=0.19.0

RUN wget http://apache.crihan.fr/dist/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz \
    && tar -xzf apache-druid-${DRUID_VERSION}-bin.tar.gz \
    && rm apache-druid-${DRUID_VERSION}-bin.tar.gz

RUN apt-get update \
    && apt-get install -y bash perl \
    && rm -rf /var/lib/apt/lists/*

COPY conf/ /apache-druid-${DRUID_VERSION}/conf

ENV DRUID_VERSION=$DRUID_VERSION

ENTRYPOINT apache-druid-${DRUID_VERSION}/bin/start-micro-quickstart

