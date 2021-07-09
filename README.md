## Dockerized starter template for Laravel + Vue CLI project.

## 使い方

Vue CLIプロジェクトの設定
```
# Vue CLIプロジェクトのクローン
$ git clone git@github.com:wizgeek-jp/XXXX.git ./src/client

# ホスト側で「yarn install」の実行
  →yarn installをdockerコンテナ内で実行するととても遅いため、ホスト側で実行します。

# hostとportの設定
「vue.config.js」にてhostを「'0.0.0.0'」 、portを「3000」に設定してください。
```

Laravelプロジェクトの設定
```
# Laravelプロジェクトのクローン
$ git clone git@github.com:wizgeek-jp/XXXX.git ./src/api

# envのコピー（適宜設定変更）
$ cp .env.api ./src/api/.env
```

dockerの起動
```
# 初回クローン時
$ make init

# docker起動
$ make up

# docker停止
$ make down
```

## Vue CLIの開発について
このdocker環境はdockerコンテナ内で開発ビルド（`yarn serve`）を実行します。 

ソースコードを保存するたびに自動でブラウザに反映されますが、dockerコンテナ内でのビルドが遅いため、反映までに少し時間がかかります。 

フロントのURLはこちら [http://localhost:8080](http://localhost:8080) 

バックエンドAPIのURLはこちら [http://localhost:8080/api](http://localhost:8080/api) 

バックエンドの画面が見たくなったらこちらから [http://localhost:8081](http://localhost:8081) 

## Overview
Look at one of the following topics to learn more about the project

* [Stack](#stack-includes)
* [Structure](#about-the-structure)
* [Installation](#installation)
* [Basic usage](#basic-usage)
    * [Manual installation](#manual-installation)
* [Environment](#environment)
* [Vue CLI](#vue-cli)
* [Laravel](#laravel)
    * [Artisan](#artisan)
    * [File storage](#file-storage)
* [Makefile](#makefile)
* [Database](#database)
* [Mailhog](#mailhog)
* [Logs](#logs)
* [Running commands](#running-commands-from-containers)
* [Reinstallation](#reinstallation-frameworks)

## Stack includes
* Laravel
* Vue CLI
* MySQL
* Nginx
* Mailhog (SMTP testing)

## Prerequisites
- Docker-compose
- Make tool

## About the structure
Laravel API and Vue CLI are totally separate from each other and there are some reasons why I don't mix them up.
- First, throwing two frameworks together is a guaranteed mess in the future.
- API should be the only one layer of coupling. 
- You can host them on the different servers.
- You can even split them into separate repositories if (when) the project will grow.  
- You can even add a third project, for example, a mobile APP, which will use the same API also.

## Basic usage
Your base url is ```http://localhost:8080```. All requests to Laravel API must be sent using to the url starting with `/api` prefix. Nginx server will proxy all requests with ```/api``` prefix to the node static server which serves the Nuxt. 

There is also available [http://localhost:8081](http://localhost:8081) url which is handled by Laravel and should be used for testing purposes only.

You **don't** need to configure the api to allow cross origin requests because all requests are proxied through the Nginx.

## Environment
To up all containers, run the command:
```
# Make command
make up

# Full command
docker-compose up -d
```

To shut down all containers, run the command:
```
# Make command
make down

# Full command
docker-compose down
```

## Vue CLI
Your application is available at the [http://localhost:8080](http://localhost:8080) url.

## Requests
Example of API request:
```
this.$axios.post('/api/register', { 
    email: this.email, 
    password: this.password 
});
```

Async data
```
async asyncData ({ app }) {
    const [subjectsResponse, booksResponse] = await Promise.all([
      app.$axios.$get('/api/subjects'),
      app.$axios.$get('/api/books')
    ])

    return {
      subjects: subjectsResponse.data,
      books: booksResponse.data
    }
},
```

## Laravel
Laravel API is available at the [http://localhost:8080/api](http://localhost:8080/api) url.   

There is also available [http://localhost:8081](http://localhost:8081) url which is handled by Laravel and should be used for testing purposes only.

#### Artisan
Artisan commands can be used like this
```
docker-compose exec php php artisan migrate
```

If you want to generate a new controller or any laravel class, all commands should be executed from the current user like this, which grants all needed file permissions
```
docker-compose exec --user "$(id -u):$(id -g)" php php artisan make:controller HomeController
```

## Makefile
There are a lot of useful make commands you can use. 
All of them you should run from the project directory where `Makefile` is located.

Examples:
```
# Up docker containers
make up

# Apply the migrations
make db-migrate

# Run tests
make test

# Down docker containers
make down
```

Feel free to explore it and add your commands if you need them.

## Database
If you want to connect to MySQL database from an external tool, for example _Sequel Pro_ or _Navicat_, use the following parameters
```
HOST: localhost
PORT: 13306
DB: app
USER: app
PASSWORD: app   
```

## Mailhog
If you want to check how all sent mail look, just go to [http://localhost:8026](http://localhost:8026).
It is the test mail catcher tool for SMTP testing. All sent mails will be stored here.

## Logs
All **_nginx_** logs are available inside the _docker/nginx/logs_ directory.

To view docker containers logs, use the command:
```
# All containers
docker-compose logs

# Concrete container
docker-compose logs <container>
```

## Running commands from containers
You can run commands from inside containers' cli. To enter into the container run the following command:
```
# PHP
docker-compose exec php bash

# NODE
docker-compose exec client /bin/sh
```
