FROM izayoiwind-asterisk-base:latest

# ダウンロード
WORKDIR /usr/local/src/
COPY resources/asterisk/asterisk-18.13.0.tar.gz /usr/local/src/
RUN tar xvf asterisk-18.13.0.tar.gz

# ビルド
WORKDIR /usr/local/src/asterisk-18.13.0
RUN ./configure --with-jansson-bundled && \
    make menuselect.makeopts && \
    menuselect/menuselect \
    --enable CORE-SOUNDS-JA-WAV \
    --enable CORE-SOUNDS-JA-ULAW \
    --enable CORE-SOUNDS-JA-ALAW \
    --enable CORE-SOUNDS-JA-GSM \
    --enable CORE-SOUNDS-JA-G729 \
    --enable CORE-SOUNDS-JA-G722 \
    --enable CORE-SOUNDS-JA-SLN16 \
    --enable CORE-SOUNDS-JA-SIREN7 \
    --enable CORE-SOUNDS-JA-SIREN14 && \
    make && \
    make install && \
    make samples

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
