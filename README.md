## Dockerized starter template for Laravel + Vue CLI project.

## 概要

このプロジェクトについての詳細は、以下のトピックのいずれかをご覧ください。

* [Stack](#stack-includes)
* [Structure](#about-the-structure)
* [Installation](#installation)
* [Basic usage](#basic-usage)
* [Database](#database)
* [Logs](#logs)
* [Running commands](#running-commands-from-containers)

## Stack includes
* Laravel
* Vue CLI
* MySQL
* Nginx

## About the structure
Laravel API と Vue CLI はバックエンドとフロントエンドで完全に別れています。 

認証機能は「Laravel Sanctum」のクッキーベースのセッション認証を採用しています。 

その認証には、SPAとAPIが同じトップレベルドメインを共有している必要があったため、dockerを使って開発環境を作りました。 

## Installation

### Vue CLIプロジェクトの設定

● Vue CLIプロジェクトのクローン  
`$ git clone git@github.com:wizgeek-jp/XXXX.git ./src/client`

● **[重要]** ホスト側で「yarn install」の実行  
  → yarn installをdockerコンテナ内で実行するととても遅いため、ホスト側で実行します。

● hostとportの設定  
「vue.config.js」にてhostを「'0.0.0.0'」 、portを「3000」に設定してください。


### Laravel APIプロジェクトの設定
```
# Laravel APIプロジェクトのクローン
$ git clone git@github.com:wizgeek-jp/XXXX.git ./src/api
```

### Laravel Adminプロジェクトの設定
```
# Laravel Adminプロジェクトのクローン
$ git clone git@github.com:wizgeek-jp/XXXX.git ./src/admin
```

### `/etc/hosts` の設定

```
127.0.0.1       membars.wancommu.local
127.0.0.1       api.membars.wancommu.local
127.0.0.1       admin.wancommu.local
127.0.0.1       webpay.local
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
PORT: 3307
DB: api_mysql
USER: app
PASSWORD: app
```

Laravel Adminプロジェクト
```
HOST: localhost
PORT: 3308
DB: admin_mysql
USER: app
PASSWORD: app
```

## Logs
すべての **nginx** ログは `docker/dev/nginx/logs` ディレクトリにあります。

dockerコンテナのログを見るには、以下のコマンドを使用します。
```
# すべてのコンテナ
docker-compose logs

# コンテナごと
docker-compose logs <container>
```

## Running commands from containers
コンテナのcliの中からコマンドを実行することができます。コンテナの中に入るには、以下のコマンドを実行します。
```
# PHP
docker-compose exec php bash

# NODE
docker-compose exec client /bin/sh
```
