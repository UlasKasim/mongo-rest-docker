FROM mongo

WORKDIR /usr/src/configs

COPY mongo.conf .
COPY file.key .

RUN chmod 400 file.key
RUN chown -R mongodb:mongodb /usr/src/configs

EXPOSE 27017

CMD [ "--config","./mongo.conf"]