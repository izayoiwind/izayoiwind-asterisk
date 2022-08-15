-- データベース選択
USE asterisk;

-- 最大レジスト数、基本的には1を設定すればよい。
SET @max_contacts = 1;
-- 再レジスト時に既存のコンタクトを上書きするかどうかの設定。
-- yesを設定することによってNTTのVoIPアダプタ等、
-- レジスト時にコンタクトURIにランダムの値を用いる機種において、
-- 電源投入後約30分で着信不能になる事象を抑制することが可能。
SET @remove_existing = 'yes';
-- 疎通確認の間隔、NATを越える場合で着信ができなくなる場合は10等を設定すると解消する場合がある。
-- ただし、RT58i等のヤマハ製VoIPルータの場合、0以外にすると着信できなくなるため注意。
-- この方法（内部的にはSIP OPTIONSパケットを送る）は相性があるため、
-- 携帯電話等、バッテリーの持ちに影響が出る場合を除いて、
-- 基本的にはコンタクトの有効期限を短くする方法を推奨する。
SET @qualify_frequency = 0;
-- DTMFモード、基本的にautoでよい。
SET @dtmf_mode = 'auto';
-- ポートが存在しない場合でも強制的に要求を送る設定。NAT越えの場合はyesとする。
SET @force_rport = 'no';
-- コンタクトのIPアドレス、ポートの書き換えを許容するかどうかの設定。NAT越えの場合はyesとする。
SET @rewrite_contact = 'no';
-- RTPの送信先を、Asteriskが受信したIPアドレスおよびポートに送る設定。NAT越えの場合はyesとする。
SET @rtp_symmetric = 'no';
-- コンタクトの有効期限。デフォルトでは3600秒である。
-- NATテーブルによるタイムアウトの場合、この時間を短くすることでも解消できる。
SET @maximum_expiration = 240;
-- 使用できないコンタクトを削除するかどうか。
SET @remove_unavailable = 'yes';

-- 既存内線番号削除
TRUNCATE TABLE ps_aors;
TRUNCATE TABLE ps_auths;
TRUNCATE TABLE ps_endpoints;
TRUNCATE TABLE ps_globals;
-- 内線番号
INSERT INTO ps_aors (id, max_contacts, remove_existing, qualify_frequency, maximum_expiration, remove_unavailable) VALUES ('210001', @max_contacts, @remove_existing, @qualify_frequency, @maximum_expiration, @remove_unavailable);
INSERT INTO ps_aors (id, max_contacts, remove_existing, qualify_frequency, maximum_expiration, remove_unavailable) VALUES ('210002', @max_contacts, @remove_existing, @qualify_frequency, @maximum_expiration, @remove_unavailable);
INSERT INTO ps_aors (id, max_contacts, remove_existing, qualify_frequency, maximum_expiration, remove_unavailable) VALUES ('210003', @max_contacts, @remove_existing, @qualify_frequency, @maximum_expiration, @remove_unavailable);
INSERT INTO ps_auths (id, auth_type, password, username) VALUES ('210001', 'userpass', '210001', '210001');
INSERT INTO ps_auths (id, auth_type, password, username) VALUES ('210002', 'userpass', '210002', '210002');
INSERT INTO ps_auths (id, auth_type, password, username) VALUES ('210003', 'userpass', '210003', '210003');
INSERT INTO ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, dtmf_mode, force_rport, rewrite_contact, rtp_symmetric, language) VALUES ('210001', 'transport-udp', '210001', '210001', 'internal', 'all', 'g726,g722,ulaw,alaw,gsm', 'no', @dtmf_mode, @force_rport, @rewrite_contact, @rtp_symmetric, 'ja');
INSERT INTO ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, dtmf_mode, force_rport, rewrite_contact, rtp_symmetric, language) VALUES ('210002', 'transport-udp', '210002', '210002', 'internal', 'all', 'g726,g722,ulaw,alaw,gsm', 'no', @dtmf_mode, @force_rport, @rewrite_contact, @rtp_symmetric, 'ja');
INSERT INTO ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, dtmf_mode, force_rport, rewrite_contact, rtp_symmetric, language) VALUES ('210003', 'transport-udp', '210003', '210003', 'internal', 'all', 'g726,g722,ulaw,alaw,gsm', 'no', @dtmf_mode, @force_rport, @rewrite_contact, @rtp_symmetric, 'ja');
INSERT INTO ps_globals (id, keep_alive_interval) VALUES ('210001', 100);
INSERT INTO ps_globals (id, keep_alive_interval) VALUES ('210002', 100);
INSERT INTO ps_globals (id, keep_alive_interval) VALUES ('210003', 100);
