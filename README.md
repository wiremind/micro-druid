Micro & Nano druid, for E2E tests
=======================================

Dockerfiles to run nano and micro setups of [druid](https://github.com/apache/druid) for e2e tests. Some configurations are applied to maximize the response time of the Druid docker but should in no way refer to a production cluster.

Arguments
---------

Arguments that can be set while building:
- `DRUID_VERSION`: 0.19.0 by default
- `DRUID_COORDINATOR_CONF_FILE`: path to the runtime.properties of the coordinator service. 

Building
--------

Every time a `^[0-9.]+` tag is pushed, two docker images `micro-{tag}` and `micro-{tag}` are built and published [here](https://hub.docker.com/repository/docker/wiremind/mino-druid).


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
