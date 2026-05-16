FROM nginx:1.31

RUN rm /etc/nginx/conf.d/default.conf
COPY ./data/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80