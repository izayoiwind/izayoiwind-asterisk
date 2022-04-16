create database asterisk charset utf8mb4;
create database asterisk_cdr charset utf8mb4;
create user 'asterisk'@'%' identified by 'asterisk';
create user 'asterisk_cdr'@'%' identified by 'asterisk_cdr';
grant all on asterisk.* to 'asterisk'@'%' with grant option;
grant all on asterisk_cdr.* to 'asterisk_cdr'@'%' with grant option;

