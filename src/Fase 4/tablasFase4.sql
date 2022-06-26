drop table if exists Warnings;
create table Warnings
(
    affected_table  varchar(255),
    error_mesage    varchar(255),
    date            date,
    usr             varchar(255)
);

drop table if exists BannedWords;
create table BannedWords(
    bannedword   varchar(255)
);

insert into BannedWords(bannedword) values('tonto');
insert into BannedWords(bannedword) values('puta');
insert into BannedWords(bannedword) values('desgraciado');
insert into BannedWords(bannedword) values('marica');
insert into BannedWords(bannedword) values('maricon');
insert into BannedWords(bannedword) values('zorra');
insert into BannedWords(bannedword) values('cancer');
insert into BannedWords(bannedword) values('burru');
insert into BannedWords(bannedword) values('capullo');
insert into BannedWords(bannedword) values('cabron');
insert into BannedWords(bannedword) values('subnormal');




drop table if exists OPCardBlackList;
create table OPCardBlackList
(
    nombre          varchar(255),
    entering_date   date,
    unique(nombre)
);

drop table if exists Ranking;
create table Ranking
(
    player      varchar(255),
    trophies    integer,
    arena       varchar(255),
    primary key (player)
);

-- SET 3
-- 3.1) Taula en la que afegim els membres expulsats
drop table if exists removed_member cascade;
create table removed_member (
    clan varchar(20),
    player varchar(20),
    fecha date,
    role text
);

-- 3.2) Taula on afegim els membres expulsats permanentment
drop table if exists removed_player;
create table removed_player(
   clan varchar(20),
   player varchar(20),
   role text
);

-- 3.3) Taula on afegim les batalles borrades
drop table if exists removed_batle;
create table removed_batle (
   deleted_by varchar(20),
   id int,
   deck_win int,
   deck_lose int,
   fecha date,
   durada time,
   puntos_win int,
   puntos_lose int,
   batalla_clan int
);