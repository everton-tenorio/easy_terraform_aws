FROM node:18-alpine

WORKDIR /app

RUN apk add --no-cache git
RUN git clone --branch build-branch https://github.com/everton_tenorio/easy_terraform_aws.git .

EXPOSE 3000

CMD ["node", "server/index.mjs"]
