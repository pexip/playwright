# Use with:
# docker build -f build.Dockerfile -t playwright_builder .
# docker run --rm -it -v"$(pwd):/src" playwright_builder

ARG DEBIAN_FRONTEND=noninteractive
FROM node:24-trixie

RUN apt-get update && \
    apt-get install -y --no-install-recommends zip && \
    mkdir /src

WORKDIR /src
USER node

SHELL ["/bin/bash", "-c"]
CMD rm -rf node_modules && \
    npm ci && \
    npm run clean && \
    npm run build && \
    bash utils/build/build-playwright-driver.sh && \
    echo "OUTPUT IN: utils/build/output/"
