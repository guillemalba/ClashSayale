/*------------ GUILLEM (VERDE)------------*/
Drop table if exists Jugador cascade;
Create table Jugador
(
    id          Varchar(50),
    nombre      Varchar(50),
    experiencia int,
    trofeos     int,
    oro         int,
    gemas       int,
    primary key (id)
);

Drop Table If Exists Clan Cascade;
Create Table Clan
(
    id             Varchar(25),
    nombre         Varchar(50),
    descripcion    Text,
    trofeos_totales int,
    minimo_trofeos  int,
    puntuacion     int,
    Primary Key (id)
);

Drop table if exists Formado cascade;
Create table Formado
(
    id_clan     Varchar(50),
    id_jugador  Varchar(50),
    fecha date,
    role Varchar(50),
    primary key (id_clan, id_jugador),
    foreign key (id_clan) references Clan (id),
    foreign key (id_jugador) references Jugador (id)
);

Drop table if exists Dona cascade;
Create table Dona
(
    id_clan        Varchar(50),
    id_jugador     Varchar(50),
    oro           int,
    fecha          date,
    primary key (id_clan, id_jugador),
    foreign key (id_clan) references Clan (id),
    foreign key (id_jugador) references Jugador (id)
);

Drop table if exists Insignia cascade;
Create table Insignia
(
    nombre        serial,           /*TODO: tipo?*/
    imagenUrl     text,
    primary key (nombre)
);

Drop table if exists Adquiere cascade;
Create table Adquiere
(
    id_clan     Varchar(50),
    id_insignia int,
    fecha       date,
    primary key (id_clan, id_insignia),
    foreign key (id_clan) references Clan (id),
    foreign key (id_insignia) references Insignia (id)
);

Drop table if exists Batalla_Clan cascade;
Create table Batalla_Clan
(
    id         serial,
    primary key (id)
);

DROP TABLE IF EXISTS Participa CASCADE;
CREATE TABLE Participa
(
    batalla_clan INTEGER,
    clan         VARCHAR(50),       /*TODO: tipo?*/
    fecha_inicio  Date,
    fech_fin   Date,
    PRIMARY KEY (batalla_clan, clan)
);

Drop table if exists Consigue cascade;
Create table Consigue
(
    id_insignia int,
    id_arena    int,
    id_jugador  Varchar(50),
    fecha       date,
    primary key (id_insignia, id_arena, id_jugador),
    foreign key (id_jugador) references Jugador (id),
    foreign key (id_insignia) references Insignia (id),
    foreign key (id_arena) references Arena (id)
);

Drop table if exists Mensaje_clan cascade;
Create table Mensaje_clan
(
    id                      serial,
    cuerpo                  text,
    fecha                   Date,
    emisor                  int,         /*TODO: tipo?*/
    receptor                int,         /*TODO: tipo?*/
    id_mensaje_respondido   int,
    primary key (id),
    foreign key (id_mensaje_respondido) references Mensaje_clan (id)
);

Drop table if exists Tecnologia cascade;
Create table Tecnologia
(
    nombre          Varchar(50),
    coste_oro       int,
    descripcion     text,
    nivel_max       int,
    dep_level       int,
    damage          int,        /*TODO: tipo?*/
    deploy_damage   int,        /*TODO: tipo?*/
    radio           int,        /*TODO: tipo?*/
    vel_ataque      int,        /*TODO: tipo?*/
    vida            int,        /*TODO: tipo?*/
    tec_dep         int,        /*TODO: tipo?*/
    primary key (nombre),
    foreign key (tec_dep) references Modificadors (id) /*TODO: tipo?*/
);

Drop table if exists Estructura cascade;
Create table Estructura
(
    nombre          Varchar(50),
    coste_oro       int,
    descripcion     text,
    trofeos         int,
    damage          int,        /*TODO: tipo?*/
    deploy_damage   int,        /*TODO: tipo?*/
    radio           int,        /*TODO: tipo?*/
    vel_ataque      int,        /*TODO: tipo?*/
    vida            int,        /*TODO: tipo?*/
    tec_dep         int,        /*TODO: tipo?*/
    primary key (nombre),
    foreign key (tec_dep) references Modificadors (id) /*TODO: tipo?*/
);

Drop table if exists Modificador cascade;
Create table Modificador
(
    id_clan         serial,
    estructura      Varchar(50),
    tecnologia      text,
    costeOro        int,
    nivel           int,
    fecha           date,
    primary key (id_clan, estructura, tecnologia),
    foreign key (id_clan) references Clan (id), /*TODO: tipo?*/
    foreign key (estructura) references Estructura (nombre), /*TODO: tipo?*/
    foreign key (tecnologia) references Tecnologia (nombre) /*TODO: tipo?*/

);

