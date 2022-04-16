FROM izayoiwind-asterisk-base:latest

# ダウンロード
WORKDIR /usr/local/src/
COPY resources/asterisk/asterisk-18.11.2.tar.gz /usr/local/src/
RUN tar xvf asterisk-18.11.2.tar.gz

# ビルド
WORKDIR /usr/local/src/asterisk-18.11.2
RUN ./configure --with-jansson-bundled
RUN make
RUN make install
RUN make samples

RUN mkdir -p /var/lib/asterisk/sounds/ja

# 設定ファイルをコピー
COPY resources/config/etc/odbc.ini /etc/
COPY resources/config/etc/asterisk/cdr_adaptive_odbc.conf /etc/asterisk/
COPY resources/config/etc/asterisk/extconfig.conf /etc/asterisk/
COPY resources/config/etc/asterisk/extensions.conf /etc/asterisk/
COPY resources/config/etc/asterisk/pjsip.conf /etc/asterisk/
COPY resources/config/etc/asterisk/res_odbc.conf /etc/asterisk/
COPY resources/config/etc/asterisk/sorcery.conf /etc/asterisk/
COPY resources/config/etc/asterisk/rtp.conf /etc/asterisk/

# 音声ファイルをコピー
COPY resources/voice/gsm/izayoiwind-not-supported.gsm /var/lib/asterisk/sounds/ja/
COPY resources/voice/gsm/izayoiwind-testcall-dialing.gsm /var/lib/asterisk/sounds/ja/
COPY resources/voice/gsm/izayoiwind-testcall-incoming.gsm /var/lib/asterisk/sounds/ja/
COPY resources/voice/gsm/izayoiwind-unknown-number.gsm /var/lib/asterisk/sounds/ja/
COPY resources/voice/gsm/izayoiwind-unregistered-client.gsm /var/lib/asterisk/sounds/ja/

# 着信試験スクリプトセットアップ
RUN mkdir -p /opt/izayowind-test-telephony/scripts/
COPY resources/scripts/testcall.sh /opt/izayowind-test-telephony/scripts/
RUN chmod 755 /opt/izayowind-test-telephony/scripts/testcall.sh
COPY resources/scripts/testcall.py /var/lib/asterisk/agi-bin/
RUN chmod 755 /var/lib/asterisk/agi-bin/testcall.py
RUN pip3 install pyst2
