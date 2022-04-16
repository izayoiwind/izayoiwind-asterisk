#!/usr/bin/python3.8
import os
import sys
import datetime
from asterisk.agi import *

agi = AGI()
agi.verbose("着信試験スクリプト実行を開始します")
caller_id = agi.env['agi_callerid']
agi.verbose(caller_id)
call_file = open("/tmp/{}.txt".format(caller_id), "w")
call_file.write("Channel: PJSIP/{}\nCallerid:Unavailable\nWaitTime:30\nContext: internal\nExtension: 9211010001".format(caller_id))
call_file.close()
# コピー実行を予約する
agi.verbose("着信試験ファイルをコピーします")
os.system("echo \"/opt/izayowind-test-telephony/scripts/testcall.sh {}\" | at now".format(caller_id))
agi.verbose("着信試験ファイルコピーを予約しました")
