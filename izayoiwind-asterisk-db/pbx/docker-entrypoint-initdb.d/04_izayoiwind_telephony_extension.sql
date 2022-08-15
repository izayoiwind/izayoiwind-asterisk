-- データベース選択
USE asterisk;

-- 既存ダイヤルプラン削除
TRUNCATE TABLE extensions;

-- レコードID、トランクが1回線の場合は変更しなくてもよい。
SET @record_id = 'trunk';
-- アカウントの電話番号
-- 06_izayoiwind_telephony_trunk.sqlで設定したものと同じ番号を指定する。
SET @account_phone_number = '123456';

INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('1', 'internal', '_X.', '1', 'Dial', CONCAT('PJSIP/${EXTEN}@', @record_id));
INSERT INTO extensions (`id`, `context`, `exten`, `priority`, `app`, `appdata`) VALUES ('2', 'internal', @account_phone_number, '1', 'Dial', 'PJSIP/210001&PJSIP/210002&PJSIP/210003');