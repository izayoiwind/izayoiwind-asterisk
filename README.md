# Asteriskお遊び用環境構築スクリプト

本スクリプトは私、はるかなぎがYouTube等で電話関係のネタを公開する際等に使用しているAsterisk環境と同等の環境をDockerで構築するためのスクリプトです。  

## 構築方法

以下のコマンドを実行するだけで簡単に構築可能です。あらかじめDockerおよびDocker Composeをインストールしておく必要があります。   
なお、Asteriskの性質上「network_mode: "host"」で構成していますので、専用でサーバを用意することを推奨します。

```bash
$ git clone https://github.com/izayoiwind/izayoiwind-asterisk.git
$ cd ./izayoiwind-asterisk
$ ./izayoiwind-asterisk-base/build.sh
$ ./izayoiwind-asterisk-app/build.sh
$ docker-compose up -d
```

最後のdocker-composeコマンドを実行してしばらく待つと、自動的に環境が構築されます。DBの構築に少々時間がかかります。（性能にもよりますが、5分程度を見込んでください。）

## セキュリティに関する注意

本スクリプトでは、外部公開を行う場合のセキュリティ等については考慮しておりませんので、外部公開を行う場合は、パスワードおよびポートの変更（同時に構築されるMySQLも含む）およびファイアウォール等の設定を行うことを強く推奨します。

## 環境説明

### 内線番号

以下の内線番号を用意しています。

| 内線番号 | ユーザID | パスワード | 備考 |
| :-- | :-- | :-- | :-- |
| 210001 | 210001 | 210001 |  |
| 210002 | 210002 | 210002 |  |
| 210003 | 210003 | 210003 |  |
| 9111010001 | 9111010001 | 9111010001 | 発信元は公衆電話扱い |
| 9111010002 | 9111010002 | 9111010002 | 発信元は公衆電話扱い  |
| 9111010003 | 9111010003 | 9111010003 | 発信元は公衆電話扱い |

### 機能

以下の機能を用意しています。

| 機能名 | 説明 | 備考 |
| :-- | :-- | :-- |
| 非通知発信 | 一般的な電話と同じように、184を先頭に付与してダイヤルすると、相手に番号が通知されず、非通知となります。 |  |
| 公衆電話発信 | 911101から始まる内線から発信した場合、発信元が公衆電話となります。 | テスト中機能 |

### 特番

以下の特番を用意しています。

| 番号 | 説明 | 備考 |
| :-- | :-- | :-- |
| 111 | 着信試験 | 機能としてはドコモの着信試験と同等、184および186を先頭に付与してかけてもよい。 |

### 内線追加およびダイヤルプランの改造

内線設定とダイヤルプランはMySQLでリアルタイム化していますので、同時に構築されるMySQLにログインし、テーブルの内容を書き換えることで再起動等することなく即座に反映されます。
また、SQLファイルの内容を変更してdocker-composeで再構築することでも適用できます。

### トーキーについて

本スクリプトに同梱しているトーキーはすべて[「VOICEVOX:四国めたん」](https://voicevox.hiroshiba.jp/)で生成したものとなります。  
gsmとwavの2つの形式で同梱しております。（実際に使用するのはgsmの方になります）

## 動作確認済みクライアント

- AgePhone（iOS／Android）
- FOMA N-02B
  - 同一LAN内の場合、ps_endpointsテーブルのrewrite_contactとrtp_symmetricをnoにしないと着信がうまくいきません。

# ライセンス

GPL v3とします。ただし、以下のファイルについては個別にライセンスが定められているため、そちらにしたがってください。

## Asterisk関連

[Asterisk](https://www.asterisk.org/)のライセンス（GPL v2）にしたがって利用してください。

* /izayoiwind-asterisk-app/resources/asterisk-18.11.2.tar.gz  
* /izayoiwind-asterisk-app/resources/config/etc/asterisk/*  
* /izayoiwind-asterisk-db/docker-entrypoint-initdb.d/02_mysql_config.sql  
* /izayoiwind-asterisk-db/docker-entrypoint-initdb.d/03_mysql_cdr.sql  

## MySQL関連

[MySQL Community Edition](https://www.mysql.com/jp/products/community/)のライセンス（GPL v2）にしたがって利用してください。

* /izayoiwind-asterisk-base/resources/mysql-community-client-plugins/*  
* /izayoiwind-asterisk-base/resources/mysql-connector-odbc/*  

## VOICEVOX関連

[「VOICEVOX利用規約」](https://voicevox.hiroshiba.jp/term)および[「ずんだもん、四国めたん音源利用規約」](https://zunko.jp/con_ongen_kiyaku.html)にしたがって利用してください。

* /izayoiwind-asterisk-app/resources/voice/*  

# 参考資料

Asterisk Project Wiki  
[https://wiki.asterisk.org/wiki/display/AST/Home](https://wiki.asterisk.org/wiki/display/AST/Home)

TR-9022 - NGNにおける網付与ユーザID情報転送に関する技術レポート  
[https://www.ttc.or.jp/application/files/8215/5436/1416/TR-9022v2.pdf](https://www.ttc.or.jp/application/files/8215/5436/1416/TR-9022v2.pdf)

Asterisk基本設定ガイド！  
[http://st-asterisk.com/](http://st-asterisk.com/)