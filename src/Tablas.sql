/*------------ GUILLEM (VERDE)------------*/
drop table if exists Tarjeta cascade;
create table Tarjeta
(
    numero_tarjeta  bigint,
    fecha_caducidad date,
    primary key (numero_tarjeta)
);

insert into Tarjeta (numero_tarjeta, fecha_caducidad) select distinct cardnumber, cardexpiry from players;

drop table if exists Jugador cascade;
create table Jugador
(
    id          varchar(255),
    nombre      varchar(255),
    experiencia int,
    trofeos     int,
    oro         int,
    gemas       int,
    tarjeta     bigint,
    primary key (id),
    foreign key (tarjeta) references Tarjeta(numero_tarjeta)
);

insert into Jugador (id, nombre, experiencia, trofeos, oro, gemas, tarjeta)
select distinct tag, name, experience, trophies, oro, gemas, cardnumber
from players join oro_gemas on player = tag;

drop table if exists Clan cascade ;
create table Clan
(
    id              varchar(255),
    nombre          varchar(255),
    descripcion     text,
    trofeos_totales int,
    minimo_trofeos  int,
    puntuacion      int,
    Primary Key (id)
);

insert into Clan (id, nombre, descripcion, minimo_trofeos, puntuacion, trofeos_totales)
select distinct tag, name, description, requiredtrophies, score, trophies from clans;

drop table if exists Formado cascade;
create table Formado
(
    clan    Varchar(255),
    jugador Varchar(255),
    fecha   date,
    role    Varchar(255),
    primary key (clan, jugador),
    foreign key (clan) references Clan (id),
    foreign key (jugador) references Jugador (id)
);

drop table if exists Dona cascade;
create table Dona
(
    clan    varchar(255),
    jugador varchar(255),
    oro     int,
    fecha   date,
    primary key (clan, jugador),
    foreign key (clan) references Clan (id),
    foreign key (jugador) references Jugador (id)
);

drop table if exists Insignia cascade;
create table Insignia
(
    nombre    varchar(255),
    imagenUrl text,
    primary key (nombre)
);

insert into Insignia (nombre, imagenUrl)
select distinct name, img from playersbadge;

drop table if exists Adquiere cascade;
create table Adquiere
(
    clan     varchar(255),
    insignia varchar(255),
    fecha    date,
    primary key (clan, insignia),
    foreign key (clan) references Clan (id),
    foreign key (insignia) references Insignia (nombre)
);

drop table if exists Batalla_Clan cascade;
create table Batalla_Clan
(
    id integer,
    primary key (id)
);

drop table if exists Participa cascade;
create table Participa
(
    batalla_clan integer,
    clan         varchar(255),
    fecha_inicio date,
    fech_fin     date,
    primary key (batalla_clan, clan)
);

drop table if exists Arena cascade;
create table Arena
(
    id          integer,
    nombre      varchar(255),
    max_trofeos integer,
    min_trofeos integer,
    primary key (id)
);

insert into Arena (id, nombre, max_trofeos, min_trofeos) select distinct id, name, minTrophies, maxTrophies from arenas;

drop table if exists Consigue cascade;
create table Consigue
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
    id                 integer,
    cuerpo             text,
    fecha              date,
    emisor             varchar(255),
    receptor           varchar(255),
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
    id          integer,
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
    id               integer,
    nombre           varchar(255),
    daño             integer,
    velocidad_ataque integer,
    rereza           varchar(255),
    arena            integer,
    primary key (id),
    foreign key (arena) references Arena (id)
);

insert into Carta (id, nombre, daño, velocidad_ataque, rereza, arena)
select distinct AVG(p.id), c.name, c.damage, c.hit_speed, c.rarity, c.arena
from cards as c join playerscards as p on c.name = p.name
group by c.name, c.damage, c.hit_speed, c.rarity, c.arena;

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
drop table if exists Mensaje cascade;
create table Mensaje
(
    id                  integer,
    cuerpo              text,
    fecha               Date,
    idMensajeRespondido int,
    primary key (id),
    foreign key (idMensajeRespondido) references Mensaje (id)
);

drop table if exists Escribe cascade ;
create table Escribe
(
    id_emisor   varchar(255),
    id_receptor varchar(255),
    id_mensaje  integer,
    primary key (id_emisor, id_receptor, id_mensaje),
    foreign key (id_emisor) references Jugador (id),
    foreign key (id_receptor) references Jugador (id),
    foreign key (id_mensaje) references Mensaje (id)
);

drop table if exists Amigo cascade;
create table Amigo
(
    id_jugador_emisor   varchar(255),
    id_jugador_receptor varchar(255),
    primary key (id_jugador_emisor, id_jugador_receptor),
    foreign key (id_jugador_emisor) references Jugador (id),
    foreign key (id_jugador_receptor) references Jugador (id)
);

drop table if exists Articulo cascade ;
create table Articulo
(
    id           integer,
    coste_real   integer,
    veces_compra integer,
    nombre       varchar(50),
    primary key (id)
);

drop table if exists Emoticono cascade;
create table Emoticono
(
    id_emoticono    integer,
    nombre          varchar(50),
    path            varchar(255),
    primary key (id_emoticono),
    foreign key (id_emoticono) references Articulo (id)
);

drop table if exists Cofre cascade;
create table Cofre
(
    id_cofre            int,
    nombre              varchar(255),
    rareza              varchar(255),
    tiempo_desbloqueo   int,
    num_cartas          int,
    primary key (id_cofre),
    foreign key (id_cofre) references Articulo (id)
);

drop table if exists Paquete_Arena cascade;
create table Paquete_Arena
(
    id_p_arena  int,
    oro         int,
    arena       int,
    primary key (id_p_arena),
    foreign key (id_p_arena) references Articulo (id),
    foreign key (arena) references Arena (id)
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

drop table if exists Compra cascade ;
create table Compra
(
    id_jugador  varchar(255),
    id_tarjeta  bigint,
    id_articulo integer,
    primary key (id_jugador, id_tarjeta, id_articulo),
    foreign key (id_jugador) references Jugador (id),
    foreign key (id_tarjeta) references Tarjeta (numero_tarjeta),
    foreign key (id_articulo) references Articulo (id)
);

