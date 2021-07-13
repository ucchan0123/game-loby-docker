## Dockerized starter template for Laravel + Vue CLI project.

## 概要

このプロジェクトについての詳細は、以下のトピックのいずれかをご覧ください。

* [Stack](#stack-includes)
* [Prerequisites](#prerequisites)
* [Structure](#about-the-structure)
* [Installation](#installation)
* [Basic usage](#basic-usage)
* [Database](#database)
* [Mailhog](#mailhog)
* [Logs](#logs)
* [Running commands](#running-commands-from-containers)

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
Laravel API と Vue CLI はバックエンドとフロントエンドで完全に別れています。 

認証機能は「Laravel Sanctum」のクッキーベースのセッション認証を採用しています。 

その認証には、SPAとAPIが同じトップレベルドメインを共有している必要があったため、dockerを使って開発環境を作りました。 

## Installation

Vue CLIプロジェクトの設定
```
# Vue CLIプロジェクトのクローン
$ git clone git@github.com:wizgeek-jp/XXXX.git ./src/client
  → clientディレクトリをVue CLIプロジェクトのルートディレクトリとします。

# ホスト側で「yarn install」の実行
  → yarn installをdockerコンテナ内で実行するととても遅いため、ホスト側で実行します。

# hostとportの設定
「vue.config.js」にてhostを「'0.0.0.0'」 、portを「3000」に設定してください。
```

Laravelプロジェクトの設定
```
# Laravelプロジェクトのクローン
$ git clone git@github.com:wizgeek-jp/XXXX.git ./src/api
  → apiディレクトリをLaravelプロジェクトのルートディレクトリとします。

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
## Basic usage

Vue CLIの開発ビルドは `docker-compose up` を実行すると自動的に実行します。 

ソースコードを保存するたびに自動でブラウザに反映されますが、dockerコンテナ内でのビルドが遅いため、反映までに少し時間がかかります。 

フロントのURLはこちら [http://localhost:8080](http://localhost:8080) 

バックエンドAPIのURLはこちら [http://localhost:8080/api](http://localhost:8080/api) 

バックエンドの画面が見たくなったらこちら [http://localhost:8081](http://localhost:8081) 

## Database

ホストからDBへ接続したい場合は、以下のパラーメーターを使用します。
```
HOST: localhost
PORT: 13306
DB: app
USER: app
PASSWORD: app
```

## Mailhog
送信されたメールがどのように見えるかを確認したい場合は、 [http://localhost:8026](http://localhost:8026) にアクセスしてください。 

これは、SMTPテスト用のテストメールキャッチャーツールです。送信されたメールはすべてここに保存されます。

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
