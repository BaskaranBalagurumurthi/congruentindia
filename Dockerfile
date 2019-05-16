FROM drupal:8.5.3-apache

RUN apt-get update && apt-get install -y htop nano curl imagemagick git mc vim zip unzip nmap telnet mysql-client net-tools wget apt-utils libxml2 libxml2-dev;

# Install extra php extensions we need.
# Use docker php helpers to install php extensions.
# To install more extensions include them separated by spaces (i.e. 'mbstring pdo pdo_mysql zip').
# RUN set -ex && docker-php-ext-install -j "$(nproc)" 'mbstring';

# Install uploadprogress.
RUN git clone https://github.com/Jan-E/uploadprogress.git /tmp/php-uploadprogress && \
  cd /tmp/php-uploadprogress && \
  phpize && \
  ./configure --prefix=/usr && \
  make && make install && \
  echo 'extension=uploadprogress.so' > /usr/local/etc/php/conf.d/uploadprogress.ini && \
  rm -rf /tmp/*

# Install Xdebug.
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Override apache settings.
COPY ./etc/apache/sites-available/000-default.conf /etc/apache2/sites-available/
#COPY ./etc/apache/sites-available/default-ssl.conf /etc/apache2/sites-available/

# Override php settings.
COPY ./etc/php/php.ini /usr/local/etc/php/

# Override opcache settings.
COPY ./etc/php/opcache-recommended.ini /usr/local/etc/php/conf.d/

# Override xdebug settings.
COPY ./etc/php/xdebug.ini /usr/local/etc/php/conf.d/

# Install composer by using multi-stage builds (docker 17.04 and above)
COPY --from=composer:1.6 /usr/bin/composer /usr/bin/composer
# Make composer bin executables public available
ENV PATH="/usr/local/bin:/usr/bin:/var/www/vendor/bin:${PATH}"

# Copy drush script to run the drush file installed by composer from anywhere.
COPY ./etc/drush.sh /usr/local/bin/drush
RUN chmod +x /usr/local/bin/drush

# Add alias ll.
RUN echo "alias ll='ls -alF'" >> /root/.bashrc

WORKDIR /var/www/web

COPY ./etc/package.json  /var/www/

#
# SEE installing node:
# https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
#
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get update
# RUN apt-get install -y build-essential
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN cd /var/www/
RUN npm install -g docker
RUN cd ../..
# RUN cd usr/bin; ln -s nodejs node; cd ../..

#
# Install gulp
#
RUN npm install -g gulp

#
#Install compass
#
RUN apt-get install -y ruby-full && \
    gem install sass && \
    gem install compass
#gem install less

# Add a custom project's entrypoint.
# Creates empty database to install interactives for the first time if needed.
COPY ./etc/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]o

# Copy SSL key to apache directory
COPY ./etc/apache/ssl/docker-selfsigned.crt /etc/apache2/ssl/
COPY ./etc/apache/ssl/docker-selfsigned.key /etc/apache2/ssl/
COPY ./etc/apache/ports.conf /etc/apache2/
RUN a2enmod rewrite
RUN a2enmod ssl

EXPOSE 80
EXPOSE 443

# Download console.
RUN curl https://drupalconsole.com/installer -L -o drupal.phar

# Install console.
RUN mv drupal.phar /usr/local/bin/drupal && \
    chmod +x /usr/local/bin/drupal && \
    drupal init --override

WORKDIR /var/www/web

RUN drupal settings:set checked "true"
