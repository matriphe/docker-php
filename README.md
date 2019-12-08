# PHP with Composer and Laravel

This image is built on top of official [php:latest (fpm)](https://hub.docker.com/_/php image).

It contains all default PHP extensions, but they are disabled by default. To enable an extension on runtime, just pass the desired extension's name to the `PHP_EXTENSIONS` environment variable, separating the different extensions with semicolon (`;`).

## Feature

* Composer
* Prestissimo
* Laravel installer
* Laravel Envoy installer

## Usage

```sh
docker run -it --rm -e PHP_EXTENSIONS="apcu;amqp;mongodb" matriphe/php:latest
```

## Extensions

### Disabled by default

Enable this extension using PHP_EXTENSIONS environment.

- `amqp`
- `apcu`
- `bcmath`
- `bz2`
- `exif`
- `gd`
- `gettext`
- `gmp`
- [`igbinary`](https://github.com/igbinary/igbinary)
- `intl`
- `memcached`
- `mongodb`
- `opcache`
- `pcntl`
- `pdo_mysql`
- `pdo_pgsql`
- `redis`
- `soap`
- `sockets`
- `xdebug`

### Base Extensions (Enabled by default)

These extensions can't be disabled.

- `Core`
- `ctype`
- `curl`
- `date`
- `dom`
- `fileinfo`
- `filter`
- `ftp`
- `hash`
- `iconv`
- `json`
- `libxml`
- `mbstring`
- `mysqlnd`
- `openssl`
- `pcre`
- `PDO`
- `pdo_sqlite`
- `Phar`
- `posix`
- `readline`
- `Reflection`
- `session`
- `SimpleXML`
- `sodium`
- `SPL`
- `sqlite3`
- `standard`
- `tokenizer`
- `xml`
- `xmlreader`
- `xmlwriter`
- `zip`
- `zlib`
