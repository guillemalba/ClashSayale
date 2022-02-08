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

--Insert Into  Clan(id,nombre,description,trofeosTotales,minimoTrofeos,puntuacion,nMiembros)
--Select Distinct tag,name,description,trophies,requiredtrophies,score,count(tag)-- como meto el numero de id que hay?
--From clans;




Drop table if exists BatallaClan cascade; --> por rellenar
Create table BatallaClan
(
    id serial,
    data_inici  date,
    data_final  date,
    primary key (id)
);
Insert Into  BatallaClan(data_inici,data_final)
Select Distinct start_date,end_date
From clan_battles;


Drop table if exists Lucha cascade; --> por rellenar
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

Drop table if exists insignia cascade; --> rellenar
Create table insignia
(
    id        serial,
    titulo    Varchar(50),
    imagenUrl text,
    primary key (id)
);

Drop table if exists Adquiere cascade; -->Rellenar i preguntar como
Create table Adquiere
(
    idClan     Varchar(50),
    idInsignia int,
    Data       date,
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

Drop table if exists Hacen cascade;
create table Hacen(
    idModificador       int,
    idClan              Varchar(50),
    primary key (idModificador,idClan),
    foreign key (idModificador) references Modificadors(id),
    foreign key (idClan) references Clan (id)
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
    Data       date,
    primary key (idJugador, idInsignia),
    foreign key (idJugador) references Jugador (id),
    foreign key (idInsignia) references Insignia (id)
);

Drop table if exists Formado cascade;
Create table Formado
(
    idClan      Varchar(50),
    idJugador   Varchar(50),
    data_inici  date,
    data_final  date,
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
    oro           int,
    data          date,
    primary key (idClan, idJugador, idModificador),
    foreign key (idClan) references Clan (id),
    foreign key (idJugador) references Jugador (id),
    foreign key (idModificador) references Modificadors (id)
);


--Azul
DROP TABLE IF EXISTS Arena CASCADE;
CREATE TABLE Arena
(
    titulo      VARCHAR(50),
    min_trofeos INTEGER,
    max_trofeos INTEGER,
    PRIMARY KEY (titulo)
);

drop table if exists Carta cascade;
create table Carta
(
    id                  serial,
    Nombre              varchar(50),
    Dano                integer,
    velocidad_ataque    integer,
    rareza              varchar(50),
    arena               varchar(50),
    primary key (id),
    foreign key (arena) references Arena(titulo)
);



Drop table if exists Mejoran cascade;
create table Mejoran(
    idModificador       int,
    idCarta             int,
    primary key (idModificador,idCarta),
    foreign key (idModificador) references Modificadors(id),
    foreign key (idCarta) references Carta(id)
);


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

Drop table if exists Depende cascade;
Create table Depende(
    idEstructura1        int,
    idEstructura2        int,
    primary key(idEstructura1,idEstructura2),
    foreign key (idEstructura1) references Estructura(idModificador),
    foreign key (idEstructura2) references Estructura(idModificador)
);
/****GROC****/


DROP TABLE IF EXISTS Temporada CASCADE; --Season
CREATE TABLE Temporada
(
    ID           SERIAL,
    nombre       VARCHAR(255),
    fecha_inicio DATE,
    fecha_final  DATE,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS Participa CASCADE;
CREATE TABLE Participa
(
    id_temporada    INTEGER,
    id_jugador      VARCHAR(50),
    puntos          INTEGER,
    n_victorias     INTEGER,
    n_derrotas      INTEGER,
    PRIMARY KEY (id_temporada, id_jugador),
    FOREIGN KEY (id_temporada) REFERENCES Temporada (ID),
    FOREIGN KEY (id_jugador) REFERENCES Jugador (ID)
);

DROP TABLE IF EXISTS Desbloquea CASCADE;
CREATE TABLE Desbloquea
(
    titulo_arena   VARCHAR(50),
    id_jugador VARCHAR(50),
    PRIMARY KEY (titulo_arena, id_jugador),
    FOREIGN KEY (titulo_arena) REFERENCES Arena (titulo),
    FOREIGN KEY (id_jugador) REFERENCES Jugador (ID)
);

DROP TABLE IF EXISTS Logro CASCADE;
CREATE TABLE Logro
(
    ID                  INTEGER,
    titulo              VARCHAR(255),
    recompensa_gemas    INTEGER,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS Obtiene CASCADE;
CREATE TABLE Obtiene
(
    id_jugador      VARCHAR(50),
    titulo_arena    VARCHAR(50),
    id_logro        INTEGER,
    data         DATE,
    PRIMARY KEY (id_jugador, titulo_arena, id_logro),
    FOREIGN KEY (id_jugador) REFERENCES Jugador (ID),
    FOREIGN KEY (titulo_arena) REFERENCES Arena (titulo),
    FOREIGN KEY (id_logro) REFERENCES Logro (ID)
);

DROP TABLE IF EXISTS Batalla_Jugadores CASCADE;
CREATE TABLE Batalla_Jugadores
(
    ID              SERIAL,
    fecha           DATE,
    durada          TIME,
    puntuacion      INTEGER,
    id_batalla_clan INTEGER,
    PRIMARY KEY (ID),
    FOREIGN KEY (id_batalla_clan) REFERENCES BatallaClan (id)
);

DROP TABLE IF EXISTS Ocurre CASCADE;
CREATE TABLE Ocurre
(
    id_temporada INTEGER,
    id_batalla   INTEGER,
    PRIMARY KEY (id_temporada, id_batalla),
    FOREIGN KEY (id_temporada) REFERENCES Temporada (ID),
    FOREIGN KEY (id_batalla) REFERENCES Batalla_Jugadores (ID)
);


DROP TABLE IF EXISTS Mision CASCADE;
CREATE TABLE Mision (
    ID              SERIAL,
    nombre          VARCHAR(255),
    description     VARCHAR(255),
    recompensa_oro  INTEGER,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS Realiza CASCADE;
CREATE TABLE Realiza
(
    id_mision  INTEGER,
    id_jugador varchar(50),
    fecha      DATE,
    PRIMARY KEY (id_mision, id_jugador),
    FOREIGN KEY (id_jugador) REFERENCES Jugador (ID),
    FOREIGN KEY (id_mision) REFERENCES Mision (ID)
);

DROP TABLE IF EXISTS Depende;
CREATE TABLE Depende
(
    id_mision_dependiente   INTEGER,
    id_mision_necesaria     INTEGER,
    PRIMARY KEY (id_mision_dependiente, id_mision_necesaria),
    FOREIGN KEY (id_mision_necesaria) REFERENCES Mision (ID),
    FOREIGN KEY (id_mision_dependiente) REFERENCES Mision (ID)
);

/* -----------------------------------AZUL */

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
    id_deck_win     integer,
    id_deck_lose    integer,
    id_temporada    integer,
    id_batalla      integer,
    punts_win       integer,
    punts_lose      integer,
    primary key (id_deck_win, id_deck_lose, id_temporada, id_batalla),
    foreign key (id_deck_win) references Deck (id),
    foreign key (id_deck_lose) references Deck(id),
    foreign key (id_temporada) references Temporada(ID),
    foreign key (id_batalla) references Batalla_Jugadores(ID)
);


drop table if exists Edificio cascade;
create table Edificio
(
    id_edificio integer,
    vida        integer,
    primary key (id_edificio),
    foreign key (id_edificio) references Carta(id)
);

drop table if exists Tropas cascade;
create table Tropas
(
    id_tropas           integer,
    damage_aparicion    integer,
    primary key (id_tropas),
    foreign key (id_tropas) references Carta(id)
);

drop table if exists Encantamiento cascade;
create table Encantamiento
(
    id_encantamiento integer,
    radio_efecto     integer,
    primary key (id_encantamiento),
    foreign key (id_encantamiento) references Carta (id)
);

--MORADO
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


Drop table if exists Escribe cascade;
Create table Escribe
(
    id_emisor           int,
    id_receptor         int,
    id_mensaje          int,
    primary key (id_emisor, id_receptor, id_mensaje),
    foreign key (id_emisor) references Mensaje (id),
    foreign key (id_receptor) references Mensaje (id),
    foreign key (id_mensaje) references Mensaje (id)
);

Drop table if exists Amigo cascade;
Create table Amigo
(
    id_jugador_1            Varchar(50),
    id_jugador_2            Varchar(50),
    primary key (id_jugador_1, id_jugador_2),
    foreign key (id_jugador_1) references Jugador (id),
    foreign key (id_jugador_2) references Jugador (id)
);

Drop table if exists Tarjeta cascade;
Create table Tarjeta
(
    id                      int,
    primary key (id)
);

Drop table if exists Posee cascade;
Create table Posee
(
    id_jugador              Varchar(50),
    id_tarjeta              int,
    primary key (id_jugador, id_tarjeta),
    foreign key (id_jugador) references Jugador (id),
    foreign key (id_tarjeta) references Tarjeta (id)
);

Drop table if exists Articulo cascade;
Create table Articulo
(
    id                      int,
    coste_real              int,    /*TODO: validar tipo*/
    veces_compra            int,    /*TODO: validar tipo*/
    primary key (id)
);

Drop table if exists Compra cascade;
Create table Compra
(
    id_jugador              Varchar(50),
    id_tarjeta              int,
    id_articulo             int,
    descuento               int,    /*TODO: tipo*/
    fecha                   Date,    /*TODO: tipo*/
    primary key (id_jugador, id_tarjeta, id_articulo),
    foreign key (id_jugador) references Jugador (id),
    foreign key (id_tarjeta) references Tarjeta (id),
    foreign key (id_articulo) references Articulo (id)
);

Drop table if exists Cofre cascade;
Create table Cofre
(
    id_cofre              int,
    oro_contenido         int,    /*TODO: validar tipo*/
    gemas_contenido       int,    /*TODO: validar tipo*/
    id_mision              int,
    primary key (id_cofre),
    foreign key (id_cofre) references Articulo (id), -- TODO:
    foreign key (id_mision) references Mision (id) -- TODO:
);

Drop table if exists Paquete_Arena cascade;
Create table Paquete_Arena
(
    id_p_arena              int,
    oro_contenido           int,    /*TODO: validar tipo*/
    titulo_arena            varchar(50),    /*TODO: validar tipo*/
    primary key (id_p_arena),
    foreign key (id_p_arena) references Articulo (id), -- TODO:
    foreign key (titulo_arena) references Arena(titulo)
);

Drop table if exists Paquete_Oferta cascade;
Create table Paquete_Oferta
(
    id_p_oferta              int,
    oro_contenido              int,          /*TODO: validar tipo*/
    gemas_contenido            int,    /*TODO: validar tipo*/
    primary key (id_p_oferta),
    foreign key (id_p_oferta) references Articulo (id)
);

Drop table if exists Emoticono cascade;
create table Emoticono(
    idEmoticono     int,
    JPEG            Varchar(100),
    primary key (idEmoticono),
    foreign key (idEmoticono) references Articulo (id)
);

Drop table if exists Contiene cascade;
create table Contiene(
    idCofre         int,
    idCarta         int,
    primary key (idCofre,idCarta),
    foreign key (idCofre) references Cofre(id_cofre),
    foreign key (idCarta) references Carta(id)
);
