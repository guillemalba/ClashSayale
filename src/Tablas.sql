Drop Table If Exists Clan Cascade;
Create Table Clan
(
    id             Varchar(25),
    nombre         Varchar(50),
    description    Text,
    nMiembros      int,
    trofeosTotales int,
    minimoTrofeos  int,
    puntuacion     int,
    Primary Key (id)
);

Drop table if exists BatallaClan cascade;
Create table BatallaClan
(
    id serial,
    primary key (id)
);

Drop table if exists Lucha cascade;
Create table Lucha
(
    idBatalla int,
    idClan1   Varchar(25),
    idClan2   Varchar(25),
    idGanador Varchar(25),
    primary key (idBatalla, idClan1, idClan2, idGanador),
    foreign key (idBatalla) references BatallaClan (id),
    foreign key (idClan1) references Clan (id),
    foreign key (idClan2) references Clan (id),
    foreign key (idGanador) references Clan (id)
);

Drop table if exists insignia cascade;
Create table insignia
(
    id        serial,
    titulo    Varchar(50),
    imagenUrl text,
    primary key (id)
);

Drop table if exists Adquiere cascade;
Create table Adquiere
(
    idClan     Varchar(50),
    idInsignia int,
    primary key (idClan, idInsignia),
    foreign key (idClan) references Clan (id),
    foreign key (idInsignia) references Insignia (id)
);

Drop table if exists Rol cascade;
Create table Rol
(
    id          serial,
    nombre      Varchar(50),
    description text,
    primary key (id)
);

Drop table if exists Modificadors cascade;
Create table Modificadors
(
    id          serial,
    nombre      Varchar(50),
    description text,
    costeOro    int,
    primary key (id)
);

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

Drop table if exists Consigue cascade;
Create table Consigue
(
    idJugador  Varchar(50),
    idInsignia int,
    primary key (idJugador, idInsignia),
    foreign key (idJugador) references Jugador (id),
    foreign key (idInsignia) references Insignia (id)
);

Drop table if exists Formado cascade;
Create table Formado
(
    idClan    Varchar(50),
    idJugador Varchar(50),
    primary key (idClan, idJugador),
    foreign key (idClan) references Clan (id),
    foreign key (idJugador) references Jugador (id)
);

Drop table if exists Dona cascade;
Create table Dona
(
    idClan        Varchar(50),
    idJugador     Varchar(50),
    idModificador int,
    cantidad      int,
    primary key (idClan, idJugador, idModificador),
    foreign key (idClan) references Clan (id),
    foreign key (idJugador) references Jugador (id),
    foreign key (idModificador) references Modificadors (id)
);

/*----------------------------------------------Herencia no se com es fa*/
Drop table if exists Tecnologia cascade;
Create table Tecnologia
(
    nivelMax      int,
    Dependencia   Varchar(50),
    idModificador int,
    primary key (idModificador),
    foreign key (idModificador) references Modificadors (id)
);

Drop table if exists Estructura cascade;
Create table Estructura
(
    minTrofeos    int,
    dependencia   Varchar(50),
    idModificador int,
    primary key (idModificador),
    foreign key (idModificador) references Modificadors (id)
);

/*-------Morado*/


Drop table if exists Mensaje cascade;
Create table Mensaje
(
    id                  serial,
    titulo              Varchar(50),
    cuerpo              text,
    fecha               Date,
    idMensajeRespondido int,
    idClan              Varchar(50),
    primary key (id),
    foreign key (idMensajeRespondido) references Mensaje (id),
    foreign key (idClan) references Clan (id)
);

/* AZUL */

drop table if exists Deck cascade;
create table Deck
(
    id              serial,
    nombre          varchar(50),
    fecha_creacion  date,
    descripcion     text,
    id_jugador      varchar(50),
    primary key (id),
    foreign key (id_jugador) references Jugador (id)
);

drop table if exists Carta cascade;
create table Carta
(
    id                  serial,
    Nombre              varchar(50),
    Dano                integer,
    velocidad_ataque    integer,
    rareza              varchar(50),
    arena               integer,
    primary key (id)
);--Falta poner el foreign key de arena

drop table if exists Ve cascade;
create table Ve
(
    id_deck     integer,
    id_jugador  varchar(50),
    primary key (id_deck, id_jugador),
    foreign key (id_deck) references Deck(id),
    foreign key (id_jugador) references Jugador(id)
);

drop table if exists Deck_carta cascade;
create table Deck_carta
(
    id_carta    integer,
    id_deck     integer,
    primary key (id_carta, id_deck),
    foreign key (id_carta) references Carta(id),
    foreign key (id_deck) references Deck(id)
);

drop table if exists Encuentra cascade;
create table Encuentra
(
    id_jugador          varchar(50),
    id_carta            integer,
    fecha_desbloqueada  date,
    fecha_mejora        date,
    nivel_actual        integer,
    primary key (id_carta, id_jugador),
    foreign key (id_jugador) references Jugador(id),
    foreign key (id_carta) references Carta(id)
);

drop table if exists Luchan cascade;
create table Luchan
(
    id_deck1        integer,
    id_deck2        integer,
    titulo_arena    varchar(50),
    id_batalla      integer,
    id_ganador      integer,
    primary key (id_deck1, id_deck2, titulo_arena, id_batalla),
    foreign key (id_deck1) references Deck (id),
    foreign key (id_deck2) references Deck(id)
);--Falta poner el foreign key de batalla y arena
/* AZUL */

drop table if exists Deck cascade;
create table Deck
(
    id              serial,
    nombre          varchar(50),
    fecha_creacion  date,
    descripcion     text,
    id_jugador      varchar(50),
    primary key (id),
    foreign key (id_jugador) references Jugador (id)
);

drop table if exists Carta cascade;
create table Carta
(
    id                  serial,
    Nombre              varchar(50),
    Dano                integer,
    velocidad_ataque    integer,
    rareza              varchar(50),
    arena               integer,
    primary key (id)
);--Falta poner el foreign key de arena

drop table if exists Ve cascade;
create table Ve
(
    id_deck     integer,
    id_jugador  varchar(50),
    primary key (id_deck, id_jugador),
    foreign key (id_deck) references Deck(id),
    foreign key (id_jugador) references Jugador(id)
);

drop table if exists Deck_carta cascade;
create table Deck_carta
(
    id_carta    integer,
    id_deck     integer,
    primary key (id_carta, id_deck),
    foreign key (id_carta) references Carta(id),
    foreign key (id_deck) references Deck(id)
);

drop table if exists Encuentra cascade;
create table Encuentra
(
    id_jugador          varchar(50),
    id_carta            integer,
    fecha_desbloqueada  date,
    fecha_mejora        date,
    nivel_actual        integer,
    primary key (id_carta, id_jugador),
    foreign key (id_jugador) references Jugador(id),
    foreign key (id_carta) references Carta(id)
);

drop table if exists Luchan cascade;
create table Luchan
(
    id_deck1        integer,
    id_deck2        integer,
    titulo_arena    varchar(50),
    id_batalla      integer,
    id_ganador      integer,
    primary key (id_deck1, id_deck2, titulo_arena, id_batalla),
    foreign key (id_deck1) references Deck (id),
    foreign key (id_deck2) references Deck(id)
);--Falta poner el foreign key de batalla y arena