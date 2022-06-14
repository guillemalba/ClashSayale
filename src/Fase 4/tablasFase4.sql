drop table if exists Warnings;
create table Warnings
(
    affected_table  varchar(255),
    error_mesage    varchar(255),
    date            date,
    usr             varchar(255)
);


drop table if exists OPCardBlackList;
create table OPCardBlackList
(
    nombre          varchar(255),
    entering_date   date,
    unique(nombre)
);