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

## Dockerコンテナへの入り方

以下のコマンドでDockerコンテナに入ることが可能です。

```bash
$ docker exec -it izayoiwind-asterisk-app /bin/bash
```

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
| 111<br>または<br>411 | 着信試験 | 機能としてはドコモの着信試験と同等、184および186を先頭に付与してかけてもよい。<br>端末の仕様によって111への発信ができない場合は代わりに411へ発信することで同一の機能を利用できる。 |

### 内線追加およびダイヤルプランの改造

内線設定とダイヤルプランはMySQLでリアルタイム化していますので、同時に構築されるMySQLにログインし、テーブルの内容を書き換えることで再起動等することなく即座に反映されます。
また、SQLファイルの内容を変更してdocker-composeで再構築することでも適用できます。

MySQLにログインするには、以下のアカウントを使用してください。  
ただし、docker-compose.ymlのrootパスワードを変更している場合は、そのパスワードを使用してください。
| ユーザ名 | パスワード | データベース |
| :-- | :-- | :-- |
| root | Izay0iw1nD_AstEr1sK | asterisk |

内線およびダイヤルプランは以下のSQLに記載しています。

| 種別 | 場所 | ファイル名 |
| :-- | :-- | :-- |
| 内線 | izayoiwind-asterisk-db/docker-endpoint-initdb.d | 05_izayoiwind_telephony_peers.sql |
| ダイヤルプラン | izayoiwind-asterisk-db/docker-endpoint-initdb.d | 04_izayoiwind_telephony_extension.sql |

### トーキーについて

本スクリプトに同梱しているトーキーはすべて[「VOICEVOX:四国めたん」](https://voicevox.hiroshiba.jp/)で生成したものとなります。  
gsmとwavの2つの形式で同梱しております。（実際に使用するのはgsmの方になります）

## 動作確認済みクライアント

動作確認を行ったクライアントを記載します。  
発着信、通話に支障があるものは使用可否を不可としています。

| クライアント名 | 提供元 | 種別 | 使用可否 | 特記事項 |
| :-- | :-- | :-- | :--: | :-- |
| AgePhone（iOS）|	株式会社ageet |ソフトフォン（スマートフォン） | ○ | 特記事項なし。 |
| Android標準SIPクライアント| Google LLC |ソフトフォン（スマートフォン） | △ | SoftBank 303SHで確認。ユーザ名は一般的な「内線番号@SIPサーバアドレス」の形式ではなく、内線番号のみを指定すればよい。発着信は問題なくできるが、通話品質に問題があるため、非推奨。（音声の遅延が非常に大きく、使い物にならない。） |
| FOMA N-02B | 株式会社NTTドコモ | 携帯電話 | ○ | TTC-SIP設定はOFFにすること。Asteriskと同一ネットワーク内で使用する場合、rewrite_contactとrtp_symmetricをnoにしないと着信ができない。 |
| FOMA N-07E | 株式会社NTTドコモ | 携帯電話 | ○ | FOMA N-02Bと同様。 |
| FOMA N902iL | 株式会社NTTドコモ | 携帯電話 | × | 着信時に異常動作。着信画面が表示され、すぐに着信画面が閉じるという動作を何度も繰り返してしまう。原因不明。 |
| FOMA N906iL | 株式会社NTTドコモ | 携帯電話 | ○ | SIPシーケンス設定は基本SIP固定にすること。プレゼンスサーバは未設定でよい。Asteriskと同一ネットワーク内で使用する場合でも、rewrite_contactとrtp_symmetricはyesで問題なし。 |
| VoIPアダプタ | 東日本電信電話株式会社<br>西日本電信電話株式会社 | VoIPアダプタ | ○ | ps_aorsのmax_contactsを1に、remove_existingをyesに設定することで問題なく使用できる。（本スクリプトでは予め設定済み）この2つを設定しないと、30分ほどで着信ができなくなる。仕様上、1XX番号へは強制的に回線ポート経由での発信になるため、当該番号への発信不可。 |

# ライセンス

GPL v3とします。ただし、以下のファイルについては個別にライセンスが定められているため、そちらにしたがってください。

## Asterisk関連

[Asterisk](https://www.asterisk.org/)のライセンス（GPL v2）にしたがって利用してください。

* /izayoiwind-asterisk-app/resources/asterisk-18.30.0.tar.gz  
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