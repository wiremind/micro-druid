FROM eclipse-temurin:11 AS builder

ARG DRUID_VERSION=26.0.0
ENV DRUID_VERSION=$DRUID_VERSION

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libfindbin-libs-perl=2* \
    && rm -rf /var/lib/apt/lists/*

RUN wget --progress=dot:giga http://apache.crihan.fr/dist/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz \
    && tar -xzf apache-druid-${DRUID_VERSION}-bin.tar.gz \
    && rm apache-druid-${DRUID_VERSION}-bin.tar.gz

COPY conf/ /apache-druid-${DRUID_VERSION}/conf

RUN mv /apache-druid-${DRUID_VERSION} /app

WORKDIR /app

FROM builder as druid-micro

ENTRYPOINT ["/app/bin/start-micro-quickstart"]

FROM builder as druid-nano

ENTRYPOINT ["/app/bin/start-nano-quickstart"]

EXPOSE 8081 8082 8083 8888 8091
