-- データベース選択
USE asterisk;

-- 既存ダイヤルプラン削除
TRUNCATE TABLE extensions;
-- 通常発信ダイヤルプラン追加
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('1', 'internal', '_X.', '1', 'Set', '__destination=${EXTEN}');
-- 184ダイヤル
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('2', 'internal', '_X.', '2', 'GotoIf', '$[${REGEX("^[1][8][4][0-9]+$" ${EXTEN})} == 1]?3:6');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('3', 'internal', '_X.', '3', 'Set', '__destination=${EXTEN:3}');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('4', 'internal', '_X.', '4', 'Set', 'CALLERID(pres)=prohib');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('5', 'internal', '_X.', '5', 'Set', 'CALLERID(name)=Anonymous');
-- 186ダイヤル
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('6', 'internal', '_X.', '6', 'GotoIf', '$[${REGEX("^[1][8][6][0-9]+$" ${EXTEN})} == 1]?7:8');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('7', 'internal', '_X.', '7', 'Set', '__destination=${EXTEN:3}');
-- 公衆電話発信
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('8', 'internal', '_X.', '8', 'GotoIf', '$[${REGEX("^[9][1][1][1][0][1][0-9]+$" ${CALLERID(num)})} == 1]?9:10');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('9', 'internal', '_X.', '9', 'Set', 'CALLERID(name)=Coin line/payphone');
-- 番号存在確認
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('10', 'internal', '_X.', '10', 'GotoIf', '$["${PJSIP_ENDPOINT("${destination}",aors)}" == ""]?19:11');
-- 発信
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('11', 'internal', '_X.', '11', 'Dial', 'PJSIP/${destination}');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('12', 'internal', '_X.', '12', 'GotoIf', '$["${DIALSTATUS}" == "BUSY"]?13:15');
-- 話中
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('13', 'internal', '_X.', '13', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('14', 'internal', '_X.', '14', 'Hangup', '');
-- 未接続
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('15', 'internal', '_X.', '15', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('16', 'internal', '_X.', '16', 'Playback', 'izayoiwind-unregistered-client');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('17', 'internal', '_X.', '17', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('18', 'internal', '_X.', '18', 'Hangup', '');
-- 現在使用されていない番号
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('19', 'internal', '_X.', '19', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('20', 'internal', '_X.', '20', 'Playback', 'izayoiwind-unknown-number');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('21', 'internal', '_X.', '21', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('22', 'internal', '_X.', '22', 'Hangup', '');
-- 着信試験開始ダイヤルプラン追加
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('23', 'internal', '111', '1', 'AGI', 'testcall.py');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('24', 'internal', '111', '2', 'Playback', 'izayoiwind-testcall-dialing');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('25', 'internal', '111', '3', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('26', 'internal', '111', '4', 'Hangup', '');
-- 着信試験開始（186強制付与端末）ダイヤルプラン追加
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('27', 'internal', '186111', '1', 'AGI', 'testcall.py');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('28', 'internal', '186111', '2', 'Playback', 'izayoiwind-testcall-dialing');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('29', 'internal', '186111', '3', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('30', 'internal', '186111', '4', 'Hangup', '');
-- 着信試験開始（184強制付与端末）ダイヤルプラン追加
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('31', 'internal', '184111', '1', 'AGI', 'testcall.py');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('32', 'internal', '184111', '2', 'Playback', 'izayoiwind-testcall-dialing');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('33', 'internal', '184111', '3', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('34', 'internal', '184111', '4', 'Hangup', '');
-- 着信試験開始（別番）ダイヤルプラン追加
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('35', 'internal', '411', '1', 'AGI', 'testcall.py');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('36', 'internal', '411', '2', 'Playback', 'izayoiwind-testcall-dialing');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('37', 'internal', '411', '3', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('38', 'internal', '411', '4', 'Hangup', '');
-- 着信試験開始（別番_186強制付与端末）ダイヤルプラン追加
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('39', 'internal', '186411', '1', 'AGI', 'testcall.py');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('40', 'internal', '186411', '2', 'Playback', 'izayoiwind-testcall-dialing');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('41', 'internal', '186411', '3', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('42', 'internal', '186411', '4', 'Hangup', '');
-- 着信試験開始（別番_184強制付与端末）ダイヤルプラン追加
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('43', 'internal', '184411', '1', 'AGI', 'testcall.py');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('44', 'internal', '184411', '2', 'Playback', 'izayoiwind-testcall-dialing');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('45', 'internal', '184411', '3', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('46', 'internal', '184411', '4', 'Hangup', '');
-- 着信試験ダイヤルプラン追加
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('47', 'internal', '9211010001', '1', 'Playback', 'izayoiwind-testcall-incoming');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('48', 'internal', '9211010001', '2', 'Goto', '1');
-- エンジェルライン用番号
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('49', 'internal', '0190104104', '1', 'Playback', 'izayoiwind-not-supported');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('50', 'internal', '0190104104', '2', 'Wait', '1');
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('51', 'internal', '0190104104', '3', 'Hangup', '');
