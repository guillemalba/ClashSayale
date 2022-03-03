/*------------ GUILLEM (VERDE)------------*/
Drop table if exists Jugador cascade;
Create table Jugador
(
    id          Varchar(255),
    nombre      Varchar(255),
    experiencia int,
    trofeos     int,
    oro         int,
    gemas       int,
    primary key (id)
);

Drop Table If Exists Clan Cascade;
Create Table Clan
(
    id              varchar(255),
    nombre          varchar(255),
    descripcion     text,
    trofeos_totales int,
    minimo_trofeos  int,
    puntuacion      int,
    Primary Key (id)
);

Drop table if exists Formado cascade;
Create table Formado
(
    clan    Varchar(255),
    jugador Varchar(255),
    fecha   date,
    role    Varchar(255),
    primary key (clan, jugador),
    foreign key (clan) references Clan (id),
    foreign key (jugador) references Jugador (id)
);

Drop table if exists Dona cascade;
Create table Dona
(
    clan    varchar(255),
    jugador varchar(255),
    oro     int,
    fecha   date,
    primary key (clan, jugador),
    foreign key (clan) references Clan (id),
    foreign key (jugador) references Jugador (id)
);

Drop table if exists Insignia cascade;
Create table Insignia
(
    nombre    varchar(255),
    imagenUrl text,
    primary key (nombre)
);

Drop table if exists Adquiere cascade;
Create table Adquiere
(
    clan     varchar(255),
    insignia varchar(255),
    fecha    date,
    primary key (clan, insignia),
    foreign key (clan) references Clan (id),
    foreign key (insignia) references Insignia (nombre)
);

Drop table if exists Batalla_Clan cascade;
Create table Batalla_Clan
(
    id serial,
    primary key (id)
);

Drop table if exists Participa cascade;
create table Participa
(
    batalla_clan integer,
    clan         varchar(255), /*TODO: tipo?*/
    fecha_inicio date,
    fech_fin     date,
    primary key (batalla_clan, clan)
);

drop table if exists Arena cascade;
create table Arena
(
    id          serial, --TODO mirar si se pueden forzar datos en un serial. Si no se puede ponerlo integer.
    nombre      varchar(255),
    max_trofeos integer,
    min_trofeos integer,
    primary key (id)
);

Drop table if exists Consigue cascade;
Create table Consigue
(
    insignia varchar(255),
    arena    integer,
    jugador  varchar(255),
    fecha    date,
    primary key (insignia, arena, jugador),
    foreign key (jugador) references Jugador (id),
    foreign key (insignia) references Insignia (nombre),
    foreign key (arena) references Arena (id)
);

drop table if exists Mensaje_clan cascade;
create table Mensaje_clan
(
    id                 serial,
    cuerpo             text,
    fecha              date,
    emisor             varchar(255), /*TODO: tipo?*/
    receptor           varchar(255), /*TODO: tipo?*/
    mensaje_respondido integer,
    primary key (id),
    foreign key (mensaje_respondido) references Mensaje_clan (id),
    foreign key (emisor) references Clan (id),
    foreign key (receptor) references Clan (id)
);

drop table if exists Modificador cascade;
create table Modificador
(
    nombre         varchar(255),
    coste_oro      integer,
    descripcion    text,
    daño           integer,
    vel_ataque     integer,
    daño_aparicion integer,
    radio          integer,
    vida           integer,
    dependencia    varchar(255),
    primary key (nombre),
    foreign key (dependencia) references Modificador (nombre)
);

drop table if exists Tecnologias cascade;
create table Tecnologias
(
    nombre    varchar(255),
    nivel_max integer,
    dep_level integer,
    primary key (nombre),
    foreign key (nombre) references Modificador (nombre)
);

drop table if exists Estructura cascade;
create table Estructura
(
    nombre  varchar(255),
    trofeos integer,
    primary key (nombre),
    foreign key (nombre) references Modificador (nombre)
);

drop table if exists Clan_modificador cascade;
Create table Clan_modificador
(
    clan        varchar(255),
    modificador varchar(255),
    nivel       int,
    fecha       date,
    primary key (clan, modificador),
    foreign key (clan) references Clan (id),
    foreign key (modificador) references Modificador (nombre)
);


/*------------ MARIO (AZUL)------------*/
drop table if exists Deck cascade;
create table Deck
(
    id          serial,
    titulo      varchar(255),
    descripcion text,
    fecha       date,
    primary key (id)
);

drop table if exists Ve cascade;
create table Ve
(
    deck    integer,
    jugador varchar(255),
    primary key (deck, jugador),
    foreign key (deck) references Deck (id),
    foreign key (jugador) references Jugador (id)
);

drop table if exists Carta cascade;
create table Carta
(
    id               serial,
    nombre           varchar(255),
    daño             integer,
    velocidad_ataque integer,
    rereza           varchar(255),
    arena            integer,
    primary key (id),
    foreign key (arena) references Arena (id)
);

drop table if exists Edificio cascade;
create table Edificio
(
    carta integer,
    vida  integer,
    foreign key (carta) references Carta (id)
);

drop table if exists Tropas cascade;
create table Tropas
(
    carta          integer,
    daño_aparicion integer,
    foreign key (carta) references Carta (id)
);

drop table if exists Encantamiento cascade;
create table Encantamiento
(
    carta        integer,
    radio_efecto integer,
    foreign key (carta) references Carta (id)
);

drop table if exists Formado cascade;
create table Formado
(
    carta   integer,
    deck    integer,
    jugador varchar(255),
    nivel   integer,
    primary key (carta, deck, jugador),
    foreign key (carta) references Carta (id),
    foreign key (deck) references Deck (id),
    foreign key (jugador) references Jugador (id)
);

drop table if exists Encuentra cascade;
create table Encuentra
(
    jugador            varchar(255),
    carta              integer,
    fecha_desbloqueada date,
    fecha_mejora       date,
    nivel_actual       integer,
    primary key (jugador, carta),
    foreign key (jugador) references Jugador (id),
    foreign key (carta) references Carta (id)
);

/*------------ DANIEL (VERDE)------------*/
drop table if exists Temporada cascade;
create table Temporada
(
    nombre       varchar(255),
    fecha_inicio date,
    fecha_final  date,
    primary key (nombre)
);

drop table if exists Participa cascade;
create table Participa
(
    temporada varchar(255),
    jugador   varchar(255),
    primary key (temporada, jugador),
    foreign key (temporada) references Temporada (nombre)
);

drop table if exists Logro cascade;
create table Logro
(
    nombre           varchar(255),
    descripcion      text,
    recompensa_gemas integer,
    primary key (nombre)
);

drop table if exists Desbloquea cascade;
create table Desbloquea
(
    jugador varchar(255),
    arena   integer,
    logro   varchar(255),
    fecha   date,
    primary key (jugador, arena, logro),
    foreign key (jugador) references Jugador (id),
    foreign key (arena) references Arena (id)
);

drop table if exists Mision cascade;
create table Mision
(
    id            integer,
    nombre        varchar(255),
    dscripcion    text,
    requerimiento text,
    mision_dep    integer,
    primary key (id),
    foreign key (mision_dep) references Mision (id)
);

drop table if exists Realiza cascade;
create table Realiza
(
    mision  integer,
    jugador varchar(255),
    fecha   date,
    primary key (mision, jugador),
    foreign key (mision) references Mision (id),
    foreign key (jugador) references Jugador (id)
);

drop table if exists Mision_arena cascade;
create table Mision_arena
(
    mision         integer,
    arena          integer,
    experiencia    integer,
    recompensa_oro integer,
    primary key (mision, arena),
    foreign key (mision) references Mision (id),
    foreign key (arena) references Arena (id)
);

drop table if exists Batalla cascade;
create table batalla
(
    deck_win     integer,
    deck_lose    integer,
    fecha        date,
    durada       int, --TODO Que tipo de variable es 3:23:00? date?
    puntos_win   integer,
    puntos_lose  integer,
    batalla_clan integer,
    primary key (deck_lose, deck_win),
    foreign key (deck_win) references Deck (id),
    foreign key (deck_lose) references Deck (id),
    foreign key (batalla_clan) references Batalla_Clan (id)
);

/*------------ DIDAC (MORADO)------------*/
Drop table if exists Mensaje cascade;
Create table Mensaje
(
    id                  serial,
    cuerpo              text,
    fecha               Date,
    idMensajeRespondido int,
    primary key (id),
    foreign key (idMensajeRespondido) references Mensaje (id)
);

DROP TABLE IF EXISTS Escribe CASCADE;
CREATE TABLE Escribe
(
    id_emisor   INT,
    id_receptor INT,
    id_mensaje  INT,
    PRIMARY KEY (id_emisor, id_receptor, id_mensaje),
    FOREIGN KEY (id_emisor) REFERENCES Jugador (id),
    FOREIGN KEY (id_receptor) REFERENCES Jugador (id),
    FOREIGN KEY (id_mensaje) REFERENCES Mensaje (id)
);

DROP TABLE IF EXISTS Amigo CASCADE;
CREATE TABLE Amigo
(
    id_jugador_emisor   INT,
    id_jugador_receptor INT,
    PRIMARY KEY (id_jugador_emisor, id_jugador_receptor),
    FOREIGN KEY (id_jugador_emisor) REFERENCES Jugador (id),
    FOREIGN KEY (id_jugador_receptor) REFERENCES Jugador (id)
);

DROP TABLE IF EXISTS Compra CASCADE;
CREATE TABLE Compra
(
    id_jugador  INT,
    id_tarjeta  INT,
    id_articulo INT,
    PRIMARY KEY (id_jugador, id_tarjeta, id_articulo),
    FOREIGN KEY (id_jugador) REFERENCES Jugador (id),
    FOREIGN KEY (id_tarjeta) REFERENCES Tarjeta (card_number),
    FOREIGN KEY (id_articulo) REFERENCES Articulo (id)
);

DROP TABLE IF EXISTS Tarjeta CASCADE;
CREATE TABLE Tarjeta
(
    card_number     INT,
    fecha_caducidad INT,
    jugador_id      INT,
    PRIMARY KEY (card_number),
    FOREIGN KEY (jugador_id) REFERENCES Jugador (id)
);

DROP TABLE IF EXISTS Articulo CASCADE;
CREATE TABLE Articulo
(
    id           INT,
    coste_real   FLOAT,
    veces_compra INT,
    nombre       VARCHAR(50),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Emoticono CASCADE;
CREATE TABLE Emoticono
(
    id     int,
    nombre VARCHAR(50),
    path   varchar(255),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES Articulo (id)
);

DROP TABLE IF EXISTS Cofre CASCADE;
CREATE TABLE Cofre
(
    id                int,
    nombre            varchar(255),
    rareza            varchar(255),
    tiempo_desbloqueo int,
    num_cartas        int,
    primary key (id),
    foreign key (id) references Articulo (id)
);

drop table if exists Paquete_Arena cascade;
create table Paquete_Arena
(
    id_p_arena int,
    oro        int,
    arena_id   int,
    primary key (id_p_arena),
    foreign key (id_p_arena) references Articulo (id),
    foreign key (arena_id) references Arena (id)
);

drop table if exists Paquete_Oferta cascade;
create table Paquete_Oferta
(
    id_p_oferta     int,
    oro_contenido   int,
    gemas_contenido int,
    primary key (id_p_oferta),
    foreign key (id_p_oferta) references Articulo (id)
);