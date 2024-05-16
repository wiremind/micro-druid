#!/bin/bash

REPO_URL="https://github.com/apache/druid.git"

BRANCH_OR_TAG="26.0.1"

CURRENT_DATE=$(date +"%Y-%m-%d-%H-%M-%S")

CLONE_DIR="/tmp/druid-${BRANCH_OR_TAG}-${CURRENT_DATE}"

git clone --depth 1 --branch "$BRANCH_OR_TAG" "$REPO_URL" "$CLONE_DIR"

cp -R "$CLONE_DIR/examples/conf" conf

git apply patches/conf/*
