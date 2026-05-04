# smee-client-image

BaseInfra-owned Docker image for running [`smee-client`](https://github.com/probot/smee-client)
as a small GitHub webhook relay.

The image contains only the upstream Smee client. It does not include PR-Agent,
LiteLLM, BaseInfra application code, credentials, or webhook secrets.

## Image

```text
ghcr.io/baseinfra/smee-client:5.0.0-baseinfra1
```

BaseInfra deploys should pin an explicit tag. Do not use `latest`.

## Usage

```sh
docker run --rm ghcr.io/baseinfra/smee-client:5.0.0-baseinfra1 \
  --url https://smee.io/example-channel \
  --target http://baseinfra-web:3000/api/webhooks/github
```

The container entrypoint is:

```text
node /app/node_modules/smee-client/bin/smee.js
```

Any arguments passed to `docker run` are forwarded to `smee-client`.

## Local Validation

```sh
npm ci
npm audit --omit=dev
docker buildx build --platform linux/amd64 --load -t smee-client:local .
docker run --rm smee-client:local --version
docker run --rm smee-client:local --help
```

Expected version output:

```text
5.0.0
```

The help output should include `--url` and `--target`.

## Publishing

GitHub Actions builds the image for every pull request without pushing. Pushes to
`main` and version tags publish multi-arch images for `linux/amd64` and
`linux/arm64` to GHCR.

Published tags:

- `5.0.0-baseinfra1`
- `5.0`
- `sha-<short-sha>`

## Versioning

When the upstream `smee-client` package changes, update the package dependency
and reset the BaseInfra suffix:

```text
5.0.1-baseinfra1
```

For packaging-only or security rebuilds, keep the upstream version and increment
the suffix:

```text
5.0.0-baseinfra2
```
