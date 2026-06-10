# ------------------------------------------------------------------------ base ---
# Installs the necessary software, copies config files, and the app directory.

# Insert your memes here
FROM archlinux:latest as base

# Install all packages
RUN pacman -Sy --noconfirm \
        supervisor \
        nginx \
        php-fpm

# Supervisord setup
COPY ./docker/data/supervisord/supervisord.conf /etc/supervisord.conf

# nginx setup
RUN rm /etc/nginx/nginx.conf
COPY ./docker/data/nginx/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80

# PHP setup
COPY ./docker/data/php-fpm/www.conf /etc/php-fpm.d/www.conf

# Finally, our code
VOLUME /app
COPY ./app /app

# Set entry point
CMD ["supervisord", "-c", "/etc/supervisord.conf"]


# ------------------------------------------------------------------- developer ---
# Exposes additional services for inspecting and debugging

FROM base AS developer

# Supervisor control panel
EXPOSE 9001


# -------------------------------------------------- [unnamed] Production image ---
# The build that goes to Google Cloud Run

FROM base

