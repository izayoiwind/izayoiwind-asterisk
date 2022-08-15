-- データベース選択
USE asterisk;

-- レコードID、トランクが1回線の場合は変更しなくてもよい。
-- この値を変更する場合、ダイヤルプランも合わせて変更する必要がある。
SET @record_id = 'trunk';
-- 接続先SIPサーバ
SET @sip_server = 'XXX.XXX.XXX.XXX';
-- アカウントの電話番号
SET @account_phone_number = '123456';
-- アカウントのユーザID
SET @user_id = 'USERID';
-- アカウントのパスワード
SET @password = 'PASSWORD';
-- DTMFモード、基本的にautoでよい。
SET @dtmf_mode = 'auto';
-- ポートが存在しない場合でも強制的に要求を送る設定。NAT越えの場合はyesとする。
SET @force_rport = 'no';
-- コンタクトのIPアドレス、ポートの書き換えを許容するかどうかの設定。NAT越えの場合はyesとする。
SET @rewrite_contact = 'no';
-- RTPの送信先を、Asteriskが受信したIPアドレスおよびポートに送る設定。NAT越えの場合はyesとする。
SET @rtp_symmetric = 'no';

DELETE FROM ps_aors WHERE id = @record_id;
DELETE FROM ps_auths WHERE id = @record_id;
DELETE FROM ps_endpoint_id_ips WHERE id = @record_id;
DELETE FROM ps_registrations WHERE id = @record_id;
DELETE FROM ps_endpoints WHERE id = @record_id;

INSERT INTO ps_aors (
    id, 
    contact
) VALUES (
    @record_id, 
    CONCAT('sip:', @sip_server)
);
INSERT INTO ps_auths (
    id, 
    auth_type, 
    password, 
    username
) VALUES (
    @record_id, 
    'userpass', 
    @user_id, 
    @password
);
INSERT INTO ps_endpoint_id_ips (
    id, 
    endpoint, 
    `match`
) VALUES (
    @record_id, 
    @record_id, 
    @sip_server
);
INSERT INTO ps_registrations (
    id, 
    client_uri, 
    contact_user,
    outbound_auth, 
    retry_interval,
    server_uri, 
    transport
) VALUES (
    @record_id, 
    CONCAT('sip:', @account_phone_number, '@', @sip_server), 
    @account_phone_number,
    @record_id, 
    30,
    CONCAT('sip:', @sip_server), 
    'transport-udp'
);
INSERT INTO ps_endpoints (
    id, 
    transport, 
    aors, 
    context, 
    disallow, 
    allow, 
    direct_media,
    dtmf_mode,
    force_rport, 
    identify_by,
    outbound_auth,
    rewrite_contact, 
    rtp_symmetric,
    language,
    from_domain,
    from_user
) VALUES (
    @record_id, 
    'transport-udp', 
    @record_id, 
    'internal', 
    'all', 
    'g726,g722,ulaw,alaw,gsm', 
    'no', 
    @dtmf_mode,
    @force_rport,
    'username', 
    @record_id,
    @rewrite_contact, 
    @rtp_symmetric,
    'ja',
    @sip_server,
    @account_phone_number
);
