# Minha Biblioteca - Flutter

## Build 

### Web

Criar build:
```shell
flutter build web
```

Servir aplicação localmente em container:

```shell
docker run --rm -it -h "minha-biblioteca.dev" -v "${PWD}/build/web:/usr/local/apache2/htdocs" --name httpd -p 8888:80 httpd
```