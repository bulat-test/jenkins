FROM dgls/node-base:1.0.0

RUN mkdir -p /var/www/log/FootCourtProxy/

COPY FootCourtProxy /var/www/FootCourtProxy

WORKDIR /var/www/FootCourtProxy/proxy

CMD pm2 start pm2_config.json; pm2 logs
