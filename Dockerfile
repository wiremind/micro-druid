FROM openjdk:8-jre
ARG DRUID_VERSION=0.19.0
ARG DRUID_COORDINATOR_CONF_FILE=apache-druid-${DRUID_VERSION}/conf/druid/single-server/micro-quickstart/coordinator-overlord/runtime.properties
ARG DRUID_HISTORICAL_CONF_FILE=apache-druid-${DRUID_VERSION}/conf/druid/single-server/micro-quickstart/historical/runtime.properties
ARG DRUID_COMMON_CONF_FILE=apache-druid-${DRUID_VERSION}/conf/druid/single-server/micro-quickstart/_common/common.runtime.properties

RUN wget http://apache.crihan.fr/dist/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz \
    && tar -xzf apache-druid-${DRUID_VERSION}-bin.tar.gz \
    && rm apache-druid-${DRUID_VERSION}-bin.tar.gz \
    && apt-get update \
    && apt-get install -y bash perl \
    && rm -rf /var/lib/apt/lists/* \
    && echo druid.manager.segments.pollDuration=PT5S >> ${DRUID_COORDINATOR_CONF_FILE} \
    && echo druid.manager.config.pollDuration=PT5S >> ${DRUID_COORDINATOR_CONF_FILE} \
    && echo druid.manager.rules.pollDuration=PT5S >> ${DRUID_COORDINATOR_CONF_FILE} \
    # Add the postgresql-metadata-storage extension, we don't want to add/maintain entrypoints or config files in this repo, looking for a cleaner solution...
    && sed -i 's/^druid.extensions.loadList=.*/druid.extensions.loadList=["druid-hdfs-storage", "druid-kafka-indexing-service", "druid-datasketches", "postgresql-metadata-storage"]/g' ${DRUID_COMMON_CONF_FILE} \
    # Set a tier for the historical(s)
    && sed -i "/^druid.server.tier=/d" ${DRUID_HISTORICAL_CONF_FILE} \
    && printf "\n# Historical(s) tier\n" >> ${DRUID_HISTORICAL_CONF_FILE} \
    && echo "druid.server.tier=_internally_data_node" >> ${DRUID_HISTORICAL_CONF_FILE}

ENV DRUID_VERSION=$DRUID_VERSION

ENTRYPOINT apache-druid-${DRUID_VERSION}/bin/start-micro-quickstart

