FROM openjdk:8-jre
ARG DRUID_VERSION=0.19.0
ARG DRUID_COORDINATOR_CONF_FILE=apache-druid-${DRUID_VERSION}/conf/druid/single-server/micro-quickstart/coordinator-overlord/runtime.properties

RUN wget http://apache.crihan.fr/dist/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz \
    && tar -xzf apache-druid-${DRUID_VERSION}-bin.tar.gz \
    && rm apache-druid-${DRUID_VERSION}-bin.tar.gz \
    && apt-get update \
    && apt-get install -y bash perl \
    && rm -rf /var/lib/apt/lists/* \
    && echo druid.manager.segments.pollDuration=PT5S >> ${DRUID_COORDINATOR_CONF_FILE} \
    && echo druid.manager.config.pollDuration=PT5S >> ${DRUID_COORDINATOR_CONF_FILE} \
    && echo druid.manager.rules.pollDuration=PT5S >> ${DRUID_COORDINATOR_CONF_FILE}

ENV DRUID_VERSION=$DRUID_VERSION

ENTRYPOINT apache-druid-${DRUID_VERSION}/bin/start-micro-quickstart

