-- データベース選択
USE asterisk;

-- 既存内線番号削除
TRUNCATE TABLE ps_aors;
TRUNCATE TABLE ps_auths;
TRUNCATE TABLE ps_endpoints;
TRUNCATE TABLE ps_globals;
-- 内線番号
INSERT INTO ps_aors (id, max_contacts, qualify_frequency) VALUES ('210001', 2, 10);
INSERT INTO ps_aors (id, max_contacts, qualify_frequency) VALUES ('210002', 2, 10);
INSERT INTO ps_aors (id, max_contacts, qualify_frequency) VALUES ('210003', 2, 10);
INSERT INTO ps_auths (id, auth_type, password, username) VALUES ('210001', 'userpass', '210001', '210001');
INSERT INTO ps_auths (id, auth_type, password, username) VALUES ('210002', 'userpass', '210002', '210002');
INSERT INTO ps_auths (id, auth_type, password, username) VALUES ('210003', 'userpass', '210003', '210003');
INSERT INTO ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, rewrite_contact, rtp_symmetric, language) VALUES ('210001', 'transport-udp', '210001', '210001', 'internal', 'all', 'g726,g722,ulaw,alaw,gsm', 'no', 'yes', 'yes', 'ja');
INSERT INTO ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, rewrite_contact, rtp_symmetric, language) VALUES ('210002', 'transport-udp', '210002', '210002', 'internal', 'all', 'g726,g722,ulaw,alaw,gsm', 'no', 'yes', 'yes', 'ja');
INSERT INTO ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, rewrite_contact, rtp_symmetric, language) VALUES ('210003', 'transport-udp', '210003', '210003', 'internal', 'all', 'g726,g722,ulaw,alaw,gsm', 'no', 'yes', 'yes', 'ja');
INSERT INTO ps_globals (id, keep_alive_interval) VALUES ('210001', 100);
INSERT INTO ps_globals (id, keep_alive_interval) VALUES ('210002', 100);
INSERT INTO ps_globals (id, keep_alive_interval) VALUES ('210003', 100);

-- 公衆電話
INSERT INTO ps_aors (id, max_contacts, qualify_frequency) VALUES ('9111010001', 2, 10);
INSERT INTO ps_aors (id, max_contacts, qualify_frequency) VALUES ('9111010002', 2, 10);
INSERT INTO ps_aors (id, max_contacts, qualify_frequency) VALUES ('9111010003', 2, 10);
INSERT INTO ps_auths (id, auth_type, password, username) VALUES ('9111010001', 'userpass', '9111010001', '9111010001');
INSERT INTO ps_auths (id, auth_type, password, username) VALUES ('9111010002', 'userpass', '9111010002', '9111010002');
INSERT INTO ps_auths (id, auth_type, password, username) VALUES ('9111010003', 'userpass', '9111010003', '9111010003');
INSERT INTO ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, rewrite_contact, 
rtp_symmetric, language) VALUES ('9111010001', 'transport-udp', '9111010001', '9111010001', 'internal', 'all', 'g726,g722,ulaw,alaw,gsm', 'no', 'yes', 'yes', 'ja');
INSERT INTO ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, rewrite_contact, rtp_symmetric, language) VALUES ('9111010002', 'transport-udp', '9111010002', '9111010002', 'internal', 'all', 'g726,g722,ulaw,alaw,gsm', 'no', 'yes', 'yes', 'ja');
INSERT INTO ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, rewrite_contact, rtp_symmetric, language) VALUES ('9111010003', 'transport-udp', '9111010003', '9111010003', 'internal', 'all', 'g726,g722,ulaw,alaw,gsm', 'no', 'yes', 'yes', 'ja');
INSERT INTO ps_globals (id, keep_alive_interval) VALUES ('9111010001', 100);
INSERT INTO ps_globals (id, keep_alive_interval) VALUES ('9111010002', 100);
INSERT INTO ps_globals (id, keep_alive_interval) VALUES ('9111010003', 100);
