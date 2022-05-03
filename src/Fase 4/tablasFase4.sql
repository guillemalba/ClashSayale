drop table if exists Warnings;
create table Warnings
(
    affected_table  varchar(255),
    error_mesage    varchar(255),
    date            date,
    usr             varchar(255)
);
