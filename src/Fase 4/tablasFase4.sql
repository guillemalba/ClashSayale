drop table if exists Warnings;
create table Warnings
(
    affected_table  varchar(255),
    error_mesage    varchar(255),
    date            date,
    usr             varchar(255)
);

drop table if exists Ranking;
create table Ranking
(
    player      varchar(255),
    trophies    integer,
    arena       varchar(255),
    primary key (player)
);