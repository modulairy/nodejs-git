FROM node:19.3.0-alpine3.17

RUN apk update && apk add --no-cache wget bash && apk --no-cache add openssl wget && apk add ca-certificates && update-ca-certificates
RUN apk add git

RUN wget -qO- "https://github.com/dustinblackman/phantomized/releases/download/2.1.1a/dockerized-phantomjs.tar.gz" | tar xz -C / \
    && npm install -g phantomjs-prebuilt && npm install -g nodemon
    
RUN apk --update add ttf-freefont fontconfig && rm -rf /var/cache/apk/*

RUN ulimit -n 65535

RUN mkdir -p /var/www

WORKDIR /var/www/

COPY init-project/* ./

COPY start-container /usr/local/bin/

RUN chmod +x /usr/local/bin/start-container

RUN chmod 775 /var/www/

ENV PORT=9000

EXPOSE 9000

STOPSIGNAL SIGTERM

CMD ["start-container"]
