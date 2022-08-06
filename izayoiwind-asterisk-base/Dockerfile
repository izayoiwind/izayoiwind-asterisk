FROM ubuntu:jammy

# apt-utilsの警告抑制
ENV DEBCONF_NOWARNINGS yes
# タイムゾーン設定
ENV TZ Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# アップデート
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade

# 日本語化
RUN apt-get -y install language-pack-ja && \
    update-locale LANG=ja_JP.UTF-8 && \
    locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8  
ENV LANGUAGE ja:en  
ENV LC_ALL ja_JP.UTF-8

# 必須ツール
RUN apt-get -y install wget unixodbc mysql-client make gcc g++ patch uuid-dev libssl-dev libedit-dev libxml2-dev libsqlite3-dev unixodbc-dev sox libsrtp2-dev libjansson-dev python3-pip at file

# MySQL ODBC
COPY resources/mysql-community-client-plugins/mysql-community-client-plugins_8.0.30-1ubuntu22.04_amd64.deb /tmp/
COPY resources/mysql-connector-odbc/mysql-connector-odbc_8.0.30-1ubuntu22.04_amd64.deb /tmp/
COPY resources/mysql-connector-odbc/mysql-connector-odbc-setup_8.0.30-1ubuntu22.04_amd64.deb /tmp/
RUN apt-get -y install /tmp/mysql-community-client-plugins_8.0.30-1ubuntu22.04_amd64.deb
RUN apt-get -y install /tmp/mysql-connector-odbc_8.0.30-1ubuntu22.04_amd64.deb
RUN apt-get -y install /tmp/mysql-connector-odbc-setup_8.0.30-1ubuntu22.04_amd64.deb
