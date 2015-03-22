# Docker PHP

Build from [PHP official docker repo](https://registry.hub.docker.com/u/library/php/).

## To Build

```
cd /path/to/repo/docker/php
docker build -t php .
```

This command will build a docker image named "php" from location "."

## To Run

```bash
docker run -d -p 9000:9000 --name phpfpm php
```

This command will run using default configuration, listening on port 9000. To change the configuration `php.ini` (read only), just add -v to command like this.

```bash
docker run -d -p 9000:9000 -v /path/to/php/config/php.ini:/etc/php-fpm/php.ini:ro --name phpfpm php
```

## Ingredients

* Debian 7.0 wheezy
* PHP 5.6.7