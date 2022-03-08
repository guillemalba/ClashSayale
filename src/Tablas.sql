/*------------ GUILLEM (VERDE)------------*/
drop table if exists Tarjeta cascade;
create table Tarjeta
(
    numero_tarjeta  bigint,
    fecha_caducidad date,
    primary key (numero_tarjeta)
);
insert into Tarjeta (numero_tarjeta, fecha_caducidad)
select distinct cardnumber, cardexpiry from players;


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
    role    text,
    primary key (clan, jugador),
    foreign key (clan) references Clan (id),
    foreign key (jugador) references Jugador (id)
);
insert into Formado(clan, jugador,fecha,role)
select distinct clan,player,date,role
from playersclans;


drop table if exists Dona cascade;
create table Dona
(
    id      serial,
    clan    varchar(255),
    jugador varchar(255),
    oro     int,
    fecha   date,
    primary key (id),
    foreign key (clan) references Clan (id),
    foreign key (jugador) references Jugador (id)
);
insert into Dona(clan,jugador,oro,fecha)
select distinct clan,player,gold,date
from playersclansdonations;


drop table if exists Insignia cascade;
create table Insignia
(
    nombre    varchar(255),
    imagenUrl text,
    primary key (nombre)
);
insert into Insignia (nombre, imagenUrl)
select distinct name, img from playersbadge;

/*
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
import into Adquiere(clan,insignia,fecha)
select distinc clan, insignia, dete
from clan_insignia;
*/


drop table if exists Batalla_Clan cascade;
create table Batalla_Clan
(
    id integer,
    primary key (id)
);
insert into Batalla_Clan(id) select distinct battle from clan_battles;


drop table if exists Pelea cascade;
create table Pelea
(
    batalla_clan integer,
    clan         varchar(255),
    fecha_inicio date,
    fecha_fin     date,
    primary key (batalla_clan, clan)
);
insert into Pelea(batalla_clan, clan, fecha_inicio, fecha_fin)
select battle, clan, start_date, end_date
from clan_battles;


drop table if exists Arena cascade;
create table Arena
(
    id          integer,
    nombre      varchar(255),
    max_trofeos integer,
    min_trofeos integer,
    primary key (id)
);
insert into Arena (id, nombre, max_trofeos, min_trofeos)
select distinct id, name, minTrophies, maxTrophies from arenas;


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
insert into Consigue(insignia, arena, jugador, fecha)
select distinct name,arena,player,date
from playersbadge;


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
    foreign key (emisor) references Jugador (id),
    foreign key (receptor) references Clan (id)
);
insert into Mensaje_clan(id, cuerpo, fecha, emisor, receptor, mensaje_respondido)
select distinct id,text,date,sender,receiver,answer
from messages_to_clans;


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
insert into Modificador(nombre, coste_oro, descripcion, daño, vel_ataque, daño_aparicion, radio, vida, dependencia)
select distinct building,cost,description,mod_damage,mod_hit_speed,mod_spawn_damage,mod_radius,mod_lifetime,prerequisite
from buildings
UNION
select distinct technology,cost,description,mod_damage,mod_hit_speed,mod_spawn_damage,mod_radius,mod_lifetime,prerequisite
from technologies;



drop table if exists Tecnologias cascade;
create table Tecnologias
(
    nombre    varchar(255),
    nivel_max integer,
    dep_level integer,
    primary key (nombre),
    foreign key (nombre) references Modificador (nombre)
);
insert into Tecnologias(nombre, nivel_max, dep_level)
select distinct technology,max_level,prereq_level
from technologies;


drop table if exists Estructura cascade;
create table Estructura
(
    nombre  varchar(255),
    trofeos integer,
    primary key (nombre),
    foreign key (nombre) references Modificador (nombre)
);
insert into Estructura(nombre, trofeos)
select distinct building, trophies
from buildings;


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
insert into Clan_modificador(clan, modificador, nivel, fecha)
select clan,concat_ws('',tech,structure),level,date
from clan_tech_structures;


/*------------ MARIO (AZUL)------------*/
drop table if exists Deck cascade;
create table Deck
(
    id          integer,
    titulo      varchar(255),
    descripcion text,
    fecha       date,
    jugador     varchar(255),
    primary key (id),
    foreign key (jugador) references Jugador(id)
);
insert into Deck(id,titulo,descripcion,fecha,jugador)
select distinct deck,title,description,date,player
from playersdeck;


drop table if exists Ve cascade;
create table Ve
(
    deck    integer,
    jugador varchar(255),
    primary key (deck, jugador),
    foreign key (deck) references Deck (id),
    foreign key (jugador) references Jugador (id)
);
insert into Ve(deck,jugador)
select distinct deck,player
from shared_decks;


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
select distinct p.id, p.name, c.damage, c.hit_speed, c.rarity, c.arena
from cards as c right join playerscards as p on c.name = p.name;


drop table if exists Edificio cascade;
create table Edificio
(
    carta integer,
    vida  integer,
    foreign key (carta) references Carta (id)
);
insert into Edificio (carta, vida)
select distinct p.id, c.lifetime
from cards as c right join playerscards as p on c.name = p.name
where c.lifetime is not null;


drop table if exists Tropas cascade;
create table Tropas
(
    carta          integer,
    daño_aparicion integer,
    foreign key (carta) references Carta (id)
);
insert into Tropas (carta, daño_aparicion)
select distinct p.id, c.spawn_damage
from cards as c right join playerscards as p on c.name = p.name
where c.spawn_damage is not null;


drop table if exists Encantamiento cascade;
create table Encantamiento
(
    carta        integer,
    radio_efecto integer,
    foreign key (carta) references Carta (id)
);
insert into Encantamiento (carta, radio_efecto)
select distinct p.id, c.radious
from cards as c right join playerscards as p on c.name = p.name
where radious is not null;


drop table if exists compuesto cascade;
create table compuesto
(
    carta   integer,
    deck    integer,
    nivel   integer,
    primary key (carta, deck),
    foreign key (carta) references Carta (id),
    foreign key (deck) references Deck (id)
);
insert into compuesto(carta, deck, nivel)
select card,deck,level
from playersdeck;


drop table if exists Encuentra cascade;
create table Encuentra
(
    jugador            varchar(255),
    carta              integer,
    fecha_mejora       date,
    nivel_actual       integer,
    primary key (jugador, carta),
    foreign key (jugador) references Jugador (id),
    foreign key (carta) references Carta (id)
);
insert into Encuentra(jugador, carta, fecha_mejora, nivel_actual)
select player, id, date, level
from playerscards;


/*------------ DANIEL (AMARILLO)------------*/
drop table if exists Temporada cascade;
create table Temporada
(
    nombre       varchar(255),
    fecha_inicio date,
    fecha_final  date,
    primary key (nombre)
);
insert into Temporada(nombre, fecha_inicio, fecha_final)
select distinct name,startDate,enddate
from seasons;


drop table if exists Logro cascade;
create table Logro
(
    id               serial,
    nombre           varchar(255),
    descripcion      text,
    recompensa_gemas integer,
    primary key (id)
);
insert into Logro(nombre, descripcion, recompensa_gemas)
select distinct name,description,gems
from playersachievements
group by name,description,gems;


drop table if exists Desbloquea cascade;
create table Desbloquea
(
    jugador     varchar(255),
    arena       integer,
    id_logro    integer,
    fecha       date,
    primary key (jugador, arena, id_logro),
    foreign key (jugador) references Jugador (id),
    foreign key (arena) references Arena (id)
);
insert into Desbloquea(jugador, arena,id_logro, fecha)
select distinct pa.player, pa.arena, l.id, pa.date
from playersachievements as pa Join Logro as l on pa.name = l.nombre and pa.description = l.descripcion and pa.gems = l.recompensa_gemas;


drop table if exists Mision cascade;
create table Mision
(
    id            integer,
    nombre        varchar(255),
    descripcion   text,
    requerimiento text,
    mision_dep    integer,
    primary key (id),
    foreign key (mision_dep) references Mision (id)
);
insert into Mision (id, nombre, descripcion, requerimiento, mision_dep)
select distinct quest_id, quest_title, quest_description, quest_requirement, quest_depends
from players_quests;


drop table if exists Realiza cascade;   --TODO se puede añadir un pk mas con la fecha o se tiene que añadir ID?
create table Realiza
(
    id      serial,
    mision  integer,
    jugador varchar(255),
    fecha   date,
    primary key (id),
    foreign key (mision) references Mision (id),
    foreign key (jugador) references Jugador (id)
);
insert into Realiza (mision, jugador, fecha)
select distinct quest_id, player_tag, unlock
from players_quests;


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
insert into Mision_arena (mision, arena, experiencia, recompensa_oro)
select distinct quest_id, arena_id, experience, gold
from quests_arenas;


drop table if exists Batalla cascade;
create table batalla
(
    id              serial,
    deck_win        integer,
    deck_lose       integer,
    fecha           date,
    durada          time,
    puntos_win      integer,
    puntos_lose     integer,
    batalla_clan    integer,
    primary key (id),
    foreign key (deck_win) references Deck (id),
    foreign key (deck_lose) references Deck (id),
    foreign key (batalla_clan) references Batalla_Clan (id)
);
insert into Batalla(deck_win, deck_lose, fecha, durada, puntos_win, puntos_lose, batalla_clan)
select winner, loser, date, duration, winner_score, loser_score, clan_battle
from battles;


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
insert into Mensaje(id, cuerpo, fecha, idMensajeRespondido)
select distinct id,text,date,answer
from messages_between_players;


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
insert into Escribe(id_emisor, id_receptor, id_mensaje)
select distinct sender,receiver,id
from messages_between_players;


drop table if exists Amigo cascade;
create table Amigo
(
    id_jugador_emisor   varchar(255),
    id_jugador_receptor varchar(255),
    primary key (id_jugador_emisor, id_jugador_receptor),
    foreign key (id_jugador_emisor) references Jugador (id),
    foreign key (id_jugador_receptor) references Jugador (id)
);
insert into Amigo(id_jugador_emisor, id_jugador_receptor)
select distinct requester,requeted
from friends;


drop table if exists Articulo cascade ;
create table Articulo
(
    id           integer,
    coste_real   float,
    veces_compra integer,
    nombre       varchar(50),
    primary key (id)
);
insert into Articulo(id, coste_real, veces_compra, nombre)
select distinct buy_id, buy_cost, buy_stock, buy_name
from player_purchases;


drop table if exists Emoticono cascade;
create table Emoticono
(
    id_emoticono    integer,
    nombre          varchar(50),
    path            varchar(255),
    primary key (id_emoticono),
    foreign key (id_emoticono) references Articulo (id)
);
insert into Emoticono(id_emoticono, nombre, path)
select distinct buy_id, emote_name, emote_path
from player_purchases
where emote_name is not null;


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
insert into Cofre(id_cofre, nombre, rareza, tiempo_desbloqueo, num_cartas)
select distinct buy_id, chest_name, chest_rarity, chest_unlock_time, chest_num_cards
from player_purchases
where chest_name is not null;


drop table if exists Paquete_Arena cascade;
create table Paquete_Arena
(
    id_paquete  int,
    primary key (id_paquete),
    foreign key (id_paquete) references Articulo (id)
);
insert into Paquete_Arena(id_paquete)
select distinct buy_id
from player_purchases
where arenapack_id is not null;


drop table if exists Nivel_Arena cascade;
create table Nivel_Arena
(
    id      serial,
    arena   integer,
    paquete integer,
    oro     integer,
    primary key (id),
    foreign key (arena) references Arena(id),
    foreign key (paquete) references Paquete_Arena(id_paquete)
);
insert into Nivel_Arena(arena, paquete, oro)
select distinct a.arena, p.buy_id, a.gold
from arena_pack as a join player_purchases as p on p.arenapack_id = a.id;


drop table if exists Paquete_Oferta cascade;
create table Paquete_Oferta
(
    id_p_oferta     int,
    oro_contenido   int,
    gemas_contenido int,
    primary key (id_p_oferta),
    foreign key (id_p_oferta) references Articulo (id)
);
insert into Paquete_Oferta(id_p_oferta, oro_contenido, gemas_contenido)
select distinct buy_id, bundle_gold, bundle_gems from player_purchases
where bundle_gold is not null;


drop table if exists Compra cascade ;
create table Compra
(
    id          serial,
    jugador     varchar(255),
    tarjeta     bigint,
    articulo    integer,
    fecha       date,
    descuento    float,
    primary key (id),
    foreign key (jugador) references Jugador (id),
    foreign key (tarjeta) references Tarjeta (numero_tarjeta),
    foreign key (articulo) references Articulo (id)
);
insert into Compra(jugador, tarjeta, articulo, fecha, descuento)
select player, credit_card, buy_id, date, discount
from player_purchases;



drop table if exists Participa cascade;
create table Participa
(
    temporada varchar(255),
    jugador   varchar(255),
    primary key (temporada,jugador),
    foreign key (temporada) references Temporada (nombre) --TODO: no hay ninguna tabla que nos relacione esto.
);
insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T1' and b.fecha BETWEEN '2017-01-01' AND '2017-08-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2017-01-01' AND '2017-08-31' and t.nombre like 'T1';

insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T2' and b.fecha BETWEEN '2017-09-01' AND '2017-12-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2017-09-01' AND '2017-12-31' and t.nombre like 'T2';

insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T3' and b.fecha BETWEEN '2018-01-01' AND '2018-08-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2018-01-01' AND '2018-08-31' and t.nombre like 'T3';

------------------------------------------------------- tu de aqui hacia abajo putita

/*select distinct *
from batalla as b join deck as d on b.deck_win = d.id
join compuesto as c on d.id = c.deck
join jugador as j on c.jugador = j.id
where deck_win = 101;
*/

/************* QUERIES DE PRUEBA *************/

--Muestra el articulo mas comprado de la tienda
select a2.nombre, a2.coste_real, count(c2.id) as num_compras
from Articulo as a2 join compra as c2 on a2.id = c2.articulo
group by a2.id having count(c2.id) = (select count(c.id) from articulo as a join compra as c on a.id = c.articulo group by a.id order by count(c.id) desc limit 1)
order by count(c2.id) desc;

--Muestra top 3 jugadores que han comprado mas articulos y cuanto dinero se han gastado



--cuales son los 5 modificadores con mas daño, que sea estructura, que no depende de ningun otro modificador y que tenga almenos 1100 trofeos.
select m.nombre, m.daño
from modificador as m join estructura as e on m.nombre = e.nombre
where m.dependencia is null  and m.daño is not null and e.trofeos > 1100
order by m.daño desc limit 5;

