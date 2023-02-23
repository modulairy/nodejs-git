FROM node:19.3.0-alpine3.17

ENV PHANTOMJS_VERSION=2.1.1

RUN apk update && apk upgrade && apk add bash
RUN apk add git

RUN apk add --no-cache fontconfig curl curl-dev    
RUN cd /tmp && curl -Ls https://github.com/dustinblackman/phantomized/releases/download/${PHANTOMJS_VERSION}/dockerized-phantomjs.tar.gz | tar xz
RUN cp -R lib lib64  /
RUN cp -R usr/lib/x86_64-linux-gnu /usr/lib
RUN cp -R usr/share /usr/share
RUN cp -R etc/fonts /etc   
RUN curl -k -Ls https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 | tar -jxf -
RUN cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs


RUN mkdir -p /var/www

RUN npm install -g html-pdf

RUN apk --update add ttf-freefont fontconfig && rm -rf /var/cache/apk/*

WORKDIR /var/www/

COPY init-project/* ./

COPY start-container /usr/local/bin/

RUN chmod +x /usr/local/bin/start-container

RUN chmod 775 /var/www/

ENV PORT=9000

EXPOSE 9000

STOPSIGNAL SIGTERM

CMD ["start-container"]
