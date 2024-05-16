# Micro & Nano druid, for E2E tests

Dockerfiles to run nano and micro setups of [druid](https://github.com/apache/druid) for e2e tests. Some configurations are applied to maximize the response time of the Druid docker but should in no way refer to a production cluster.

## Arguments

Arguments that can be set while building:
- `DRUID_VERSION`: You can also change the default value in the Containerfile.

## Building

```
export DRUID_VERSION=XXX # 26.0.0 for example.

# For the micro image
docker build -t micro-druid:${DRUID_VERSION}-micro --build-arg DRUID_VERSION=${DRUID_VERSION} -f ./Containerfile --target druid-micro .

# For the nano image
docker build -t micro-druid:${DRUID_VERSION}-nano --build-arg DRUID_VERSION=${DRUID_VERSION} -f ./Containerfile --target druid-nano .
```

## Configuration
The `conf` folder must stay the same as the upstream one that can be found here:
- https://github.com/apache/druid/tree/26.0.1/examples/conf

Run this script when updating the druid version:
```bash
./scripts/download_upstream_conf.sh
```

## Required hardware
- https://github.com/apache/druid/blob/26.0.1/docs/operations/single-server.md
