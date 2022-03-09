FROM mongo

WORKDIR /usr/src/configs

COPY replicaSet.js .
COPY setup.sh .

CMD ["sh","/usr/src/configs/setup.sh"]