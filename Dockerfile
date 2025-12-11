# Dockerfile
## Build
FROM node:18-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci --no-audit --no-fund

COPY . .

# If you need the Google Sheets API key, create a .env file
# in the repo root before building so dotenv-webpack can pick it up.
# e.g.:
#   AppKey=YOUR_GOOGLE_API_KEY

RUN npm run build

## Release
FROM nginx:alpine

LABEL maintainer=courseproduction@bcit.ca
LABEL org.opencontainers.image.source="https://github.com/bcit-ltc/heme-analyzer-app"
LABEL org.opencontainers.image.description="This web app simulates a generalized User Interface of a Heme Analyzer."

COPY conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
