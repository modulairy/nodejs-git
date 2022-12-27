FROM node:19.3.0-alpine3.17

RUN apk update && apk upgrade && apk add bash
RUN apk add git

RUN mkdir -p /var/www

WORKDIR /var/www/

COPY init-project/* ./

COPY start-container /usr/local/bin/
ENV PORT=9000

EXPOSE 9000

STOPSIGNAL SIGTERM

CMD ["start-container"]