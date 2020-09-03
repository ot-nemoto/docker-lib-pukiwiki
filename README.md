# docker-lib-pukiwiki

## はじめに

- Pukiwikiのdockerイメージを作成
- OS: CentOS5.11
- Pukiwiki: 1.4.7

## docker build

```sh
curl -LO http://prdownloads.sourceforge.jp/pukiwiki/12957/pukiwiki-1.4.7_notb.tar.gz
docker build -t nemodija/pukiwiki:0.9.1 .
```

## docker run

```sh
docker run -d -it -p 80:80 --name wiki nemodija/pukiwiki:0.9.1
```

### ホスト側にwikiを配置(`/wiki`)し、マウントする

.htpasswd がなければ、wiki配下にBasic認証ファイルを作成

```sh
htpasswd -c -b /wiki/.htpasswd <user> <password>
```

wikiディレクトリのパーミッションを変更し、コンテナを起動

```sh
sudo chown -R 48:48 /wiki
docker run -d -it -v /wiki:/var/www/html/wiki -p 80:80 --name wiki nemodija/pukiwiki:0.9.1
```

### sendmailコマンドのSMTPサーバを指定する

```sh
docker run -d -it -e MSP=mail -p 80:80 --name wiki nemodija/pukiwiki:0.9.1
```
