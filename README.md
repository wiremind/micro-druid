Micro & Nano druid, for E2E tests
=======================================

Dockerfiles to run nano and micro setups of [druid](https://github.com/apache/druid) for e2e tests. Some configurations are applied to maximize the response time of the Druid docker but should in no way refer to a production cluster.

Arguments
---------

Arguments that can be set while building:
- `DRUID_VERSION`: You can also change the default value in the Containerfile.

Building
--------

```
export DRUID_VERSION=XXX # 26.0.0 for example.

# For the micro image
docker build -t micro-druid:${DRUID_VERSION}-micro --build-arg DRUID_VERSION=${DRUID_VERSION} -f ./Containerfile --target druid-micro .

# For the nano image
docker build -t micro-druid:${DRUID_VERSION}-nano --build-arg DRUID_VERSION=${DRUID_VERSION} -f ./Containerfile --target druid-nano .
```

Required hardware
------------------

Nano
*********

* 1 CPU
* 4GB RAM
* Launch command: `bin/start-nano-quickstart`
* Configuration directory: `conf/druid/single-server/nano-quickstart`


Micro
*********

* 4 CPU
* 16GB RAM
* Launch command: `bin/start-micro-quickstart`
* Configuration directory: `conf/druid/single-server/micro-quickstart`
