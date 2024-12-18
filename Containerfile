FROM eclipse-temurin:11@sha256:f9af81bc9f96546a315c135c69af1d6c8b33f2ca727d87286d8e758ca647ec2a AS builder

ARG DRUID_VERSION=28.0.1
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

FROM builder AS druid-micro

ENTRYPOINT ["/app/bin/start-micro-quickstart"]

FROM builder AS druid-nano

ENTRYPOINT ["/app/bin/start-nano-quickstart"]

EXPOSE 8081 8082 8083 8888 8091
