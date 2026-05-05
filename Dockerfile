# syntax=docker/dockerfile:1

FROM node:25-alpine

ENV NODE_ENV=production
WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci --omit=dev --ignore-scripts \
  && npm cache clean --force

USER node

ENTRYPOINT ["node", "/app/node_modules/smee-client/bin/smee.js"]
CMD ["--help"]
