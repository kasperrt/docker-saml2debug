FROM php:7-apache

COPY php.ini /usr/local/etc/php/

RUN apt-get update && apt-get install -y git zip unzip

RUN curl -o /tmp/composer.phar http://getcomposer.org/composer.phar \
  && mv /tmp/composer.phar /usr/local/bin/composer && chmod a+x /usr/local/bin/composer

RUN cd /var/ && git clone https://github.com/simplesamlphp/simplesamlphp.git simplesamlphp && \
	cd simplesamlphp && \
	cp -r config-templates/* config/ && \
	cp -r metadata-templates/* metadata/ && \
	composer install

COPY 000-default.conf /etc/apache2/sites-enabled/

RUN cd /var/simplesamlphp && composer require simplesamlphp/simplesamlphp-module-saml2debug:dev-master