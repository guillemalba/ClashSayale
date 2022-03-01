/*------------ GUILLEM (VERDE)------------*/
drop table if exists Jugador cascade;
create table Jugador
(
    id          varchar(255),
    nombre      varchar(255),
    experiencia int,
    trofeos     int,
    oro         int,
    gemas       int,
    primary key (id)
);

drop table if exists Clan cascade;
create table Clan
(
    id             varchar(255),
    nombre         varchar(255),
    descripcion    text,
    trofeos_totales int,
    minimo_trofeos  int,
    puntuacion     int,
    primary key (id)
);

drop table if exists Formado cascade;
create table Formado
(
    id_clan     varchar(255),
    id_jugador  varchar(255),
    fecha date,
    role varchar(255),
    primary key (id_clan, id_jugador),
    foreign key (id_clan) references Clan (id),
    foreign key (id_jugador) references Jugador (id)
);

drop table if exists Dona cascade;
create table Dona
(
    id_clan        varchar(255),
    id_jugador     varchar(255),
    oro            int,
    fecha          date,
    primary key (id_clan, id_jugador),
    foreign key (id_clan) references Clan (id),
    foreign key (id_jugador) references Jugador (id)
);

drop table if exists Insignia cascade;
create table Insignia
(
    nombre        varchar(255),
    imagen_url     text,
    primary key (nombre)
);

drop table if exists Adquiere cascade;
create table Adquiere
(
    id_clan     varchar(255),
    id_insignia int,
    fecha       date,
    primary key (id_clan, id_insignia),
    foreign key (id_clan) references Clan (id),
    foreign key (id_insignia) references Insignia (nombre)
);

drop table if exists Batalla_Clan cascade;
create table Batalla_Clan
(
    id         serial,
    primary key (id)
);

drop table if exists Participa cascade;
create table Participa
(
    batalla_clan integer,
    clan         varchar(255),
    fecha_inicio  date,
    fech_fin   date,
    primary key (batalla_clan, clan)
);

drop table if exists Consigue cascade;
create table Consigue
(
    id_insignia int,
    id_arena    int,
    id_jugador  varchar(255),
    fecha       date,
    primary key (id_insignia, id_arena, id_jugador),
    foreign key (id_jugador) references Jugador (id),
    foreign key (id_insignia) references Insignia (nombre),
    foreign key (id_arena) references Arena (id)
);

drop table if exists Mensaje_clan cascade;
create table Mensaje_clan
(
    id                      serial,
    cuerpo                  text,
    fecha                   date,
    emisor                  varchar(255),
    receptor                varchar(255),
    id_mensaje_respondido   int,
    primary key (id),
    foreign key (id_mensaje_respondido) references Mensaje_clan (id)
);

drop table if exists Tecnologia cascade;
create table Tecnologia
(
    nombre          varchar(255),
    coste_oro       int,
    descripcion     text,
    nivel_max       int,
    dep_level       int,
    damage          int,
    deploy_damage   int,
    radio           int,
    vel_ataque      int,
    vida            int,
    tec_dep         varchar(255),
    primary key (nombre),
    foreign key (tec_dep) references Tecnologia (nombre)
);

drop table if exists Estructura cascade;
create table Estructura
(
    nombre          varchar(255),
    coste_oro       int,
    descripcion     text,
    trofeos         int,
    damage          int,
    deploy_damage   int,
    radio           int,
    vel_ataque      int,
    vida            int,
    tec_dep         varchar(255),
    primary key (nombre),
    foreign key (tec_dep) references Estructura (nombre)
);

drop table if exists Modificador cascade;
create table Modificador
(
    id_clan         varchar(255),
    estructura      varchar(255),
    tecnologia      varchar(255),
    costeOro        int,
    nivel           int,
    fecha           date,
    primary key (id_clan, estructura, tecnologia),
    foreign key (id_clan) references Clan (id),
    foreign key (estructura) references Estructura (nombre),
    foreign key (tecnologia) references Tecnologia (nombre)

);