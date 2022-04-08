# Dockerized starter template for Laravel + Vue CLI project.

## 概要

このプロジェクトについての詳細は、以下のトピックのいずれかをご覧ください。

* [Stack](#stack-includes)
* [Structure](#about-the-structure)
* [Installation](#installation)
* [Basic usage](#basic-usage)
* [Database](#database)
* [Running commands](#running-commands-from-containers)

## Stack includes
* Laravel
* Vue CLI
* MySQL
* Nginx

## About the structure
Laravel API と Vue CLI はバックエンドとフロントエンドで完全に別れています。 

認証機能は「Laravel Sanctum」のクッキーベースのセッション認証を採用しています。 

## Installation

### Vue CLIプロジェクトの設定
```
● Vue CLIプロジェクトのクローン
※srcディレクトリ内に「client」というディレクトリ名に変更しクローンする
$ git clone git@github.com:wizgeek-jp/wizplayee.io.git ./src/client

● ホスト側でyarn installの実行
```

### Laravel APIプロジェクトの設定
```
# Laravel APIプロジェクトのクローン
※srcディレクトリ内に「api」というディレクトリ名に変更しクローンする
$ git clone git@github.com:wizgeek-jp/api.wizplayee.io.git ./src/api
```

### `/etc/hosts` の設定

```
127.0.0.1 members.vue-laravel.work
127.0.0.1 api.members.vue-laravel.work
```

### dockerの起動
```
# 初回クローン時
$ make init

# docker起動
$ make up

# docker停止
$ make down
```
## Basic usage

### Vue CLIの開発について
`docker-compose up` を実行するとコンテナ内で自動的に `yarn serve` を実行します。 

ソースコードを保存するたびに自動でブラウザに反映されますが、dockerコンテナ内でのビルドが遅いため、反映までに少し時間がかかります。 

## Database

ホストからDBへ接続したい場合は、以下のパラーメーターを使用します。 

Laravel APIプロジェクト
```
HOST: localhost
PORT: 33060
DB: api_mysql
USER: app
PASSWORD: app
```

## Running commands from containers
コンテナのcliの中からコマンドを実行することができます。コンテナの中に入るには、以下のコマンドを実行します。
```
# api
docker-compose exec api-php bash

# client
docker-compose exec client /bin/sh
```
