# pukiwiki-on-centos

## はじめに

- Pukiwikiのdockerイメージを作成
- OS: CentOS5.11
- Pukiwiki: 1.4.7

## docker build

```sh
curl -LO http://prdownloads.sourceforge.jp/pukiwiki/12957/pukiwiki-1.4.7_notb.tar.gz
docker build -t nemodija/pukiwiki:1.4.7 .
```

## docker run

```sh
docker run -d -it -p 80:80 --name wiki nemodija/pukiwiki:1.4.7
```

## docker Push

```sh
docker login
docker push nemodija/pukiwiki:1.4.7
```
