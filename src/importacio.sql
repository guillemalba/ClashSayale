drop table if exists arena_pack cascade;
create table arena_pack(
                           id      int,
                           arena   int,
                           gold    int
);

copy arena_pack from '/Users/guillemalba/Downloads/DB2021-2022-datasets/arena_pack.csv' csv header delimiter ',';

drop table if exists arenas cascade ;
create table arenas(
                       id      int,
                       name    varchar(255),
                       minTrophies     int,
                       maxTrophies     int
);

copy arenas from '/Users/guillemalba/Downloads/DB2021-2022-datasets/arenas.csv' csv header delimiter ',';

drop table if exists battles cascade;
create table battles(
                        winner             int,
                        loser              int,
                        winner_score       int,
                        loser_score        int,
                        date               date,
                        duration           time,
                        clan_battle        int
);

copy battles from '/Users/guillemalba/Downloads/DB2021-2022-datasets/battles.csv' csv header delimiter ',';

drop table if exists buildings cascade;
create table buildings(
                          building           varchar(255),
                          cost                int,
                          trophies            int,
                          prerequisite        Varchar(255),
                          mod_damage          int,
                          mod_hit_speed       int,
                          mod_radius          int,
                          mod_spawn_damage    int,
                          mod_lifetime        int,
                          description         text
);

copy buildings from '/Users/guillemalba/Downloads/DB2021-2022-datasets/buildings.csv' csv header delimiter ',';

drop table if exists cards cascade;
create table cards(
                      name            varchar(255),
                      rarity          varchar(100),
                      arena           int,
                      damage          int,
                      hit_speed       int,
                      spawn_damage    int,
                      lifetime        int,
                      radious         int
);
copy cards from '/Users/guillemalba/Downloads/DB2021-2022-datasets/cards.csv' csv header delimiter ',';

drop table if exists clan_battles cascade;
create table clan_battles(
                             battle       int,
                             clan         Varchar(255),
                             start_date   date,
                             end_date     date
);

copy clan_battles from '/Users/guillemalba/Downloads/DB2021-2022-datasets/clan_battles.csv' csv header delimiter ',';

-----------DANI-------------------------------------------------------------DANI-------------

drop table if exists clan_tech_structures cascade;
create table clan_tech_structures
(
    clan        varchar(255),
    tech        varchar(255),
    structure   varchar(255),
    date        date,
    level       integer
);
copy clan_tech_structures from '/Users/guillemalba/Downloads/DB2021-2022-datasets/clan_tech_structures.csv' csv header delimiter ',';

drop table if exists clans cascade;
create table clans
(
    tag                 varchar(255),
    name                varchar(255),
    description         text,
    requiredTrophies    integer,
    score               integer,
    trophies            integer
);
copy clans from '/Users/guillemalba/Downloads/DB2021-2022-datasets/clans.csv' csv header delimiter ',';

drop table if exists friends cascade;
create table friends
(
    requester   varchar(255),
    requeted    varchar(255)
);
copy friends from '/Users/guillemalba/Downloads/DB2021-2022-datasets/friends.csv' csv  header delimiter ',';

drop table if exists messages_between_players cascade;
create table messages_between_players
(
    id          int,
    sender      varchar(255),
    receiver    varchar(255),
    text        text,
    date        date,
    answer      integer
);
copy messages_between_players from '/Users/guillemalba/Downloads/DB2021-2022-datasets/messages_between_players.csv' csv header delimiter ',';

drop table if exists messages_to_clans cascade;
create table messages_to_clans
(
    id          int,
    sender      varchar(255),
    receiver    varchar(255),
    text        text,
    date        date,
    answer      integer
);
copy messages_to_clans from '/Users/guillemalba/Downloads/DB2021-2022-datasets/messages_to_clans.csv' csv header delimiter ',';

drop table if exists player_purchases cascade;
create table player_purchases
(
    player              varchar(255),
    credit_card         bigint,
    buy_id              integer,
    buy_name            varchar(255),
    buy_cost            float,
    buy_stock           integer,
    date                date,
    discount            float,
    arenapack_id        integer,
    chest_name          varchar(255),
    chest_rarity        varchar(255),
    chest_unlock_time   integer,
    chest_num_cards     integer,
    bundle_gold         integer,
    bundle_gems         integer,
    emote_name          varchar(255),
    emote_path          varchar(255)
);
copy player_purchases from '/Users/guillemalba/Downloads/DB2021-2022-datasets/player_purchases.csv' csv header delimiter ',';


---------------GUILLEM----------------------------------------------GUILLEM-------------

Drop table if exists players_quests cascade;
Create table players_quests
(
    player_tag        varchar(255),
    quest_id          int,
    quest_title       varchar(255),
    quest_description varchar(255),
    quest_requirement varchar(255),
    quest_depends     int,
    unlock            Date

);

copy players_quests from '/Users/guillemalba/Downloads/DB2021-2022-datasets/players_quests.csv' csv  header delimiter ',';

Drop table if exists players cascade;
Create table players
(
    tag        varchar(255),
    name       varchar(255),
    experience int,
    trophies   int,
    cardnumber bigint,
    cardexpiry Date

);
copy players from '/Users/guillemalba/Downloads/DB2021-2022-datasets/players.csv' csv  header delimiter ',';

Drop table if exists playersachievements cascade;
Create table playersachievements
(
    player      varchar(255),
    name        varchar(255),
    description varchar(255),
    arena       int,
    date        Date,
    gems        int
);
copy playersachievements from '/Users/guillemalba/Downloads/DB2021-2022-datasets/playersachievements.csv' csv  header delimiter ',';

Drop table if exists playersbadge cascade;
Create table playersbadge
(
    player varchar(255),
    name   varchar(255),
    arena  int,
    date   Date,
    img    varchar(255)
);
copy playersbadge from '/Users/guillemalba/Downloads/DB2021-2022-datasets/playersbadge.csv' csv  header delimiter ',';

Drop table if exists playerscards cascade;
Create table playerscards
(
    player varchar(255),
    id     int,
    name   varchar(255),
    level  int,
    amount int,
    date   Date
);
copy playerscards from '/Users/guillemalba/Downloads/DB2021-2022-datasets/playerscards.csv' csv  header delimiter ',';

Drop table if exists playersClans cascade;
Create table playersClans
(
    player varchar(255),
    clan   varchar(255),
    role   text,
    date   Date
);

copy playersClans from '/Users/guillemalba/Downloads/DB2021-2022-datasets/playersClans.csv' csv  header delimiter ',';

-----DIDAC----------------------------------------------------DIDAC----------------------

DROP TABLE IF EXISTS playersClansdonations CASCADE;
CREATE TABLE playersClansdonations
(
    player VARCHAR(255),
    clan   VARCHAR(255),
    gold   INTEGER,
    date   DATE
);
COPY playersClansdonations FROM '/Users/guillemalba/Downloads/DB2021-2022-datasets/playersClansdonations.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS playersdeck CASCADE;
CREATE TABLE playersdeck
(
    player      VARCHAR(255),
    deck        INTEGER,
    title       VARCHAR(255),
    description TEXT,
    date        DATE,
    card        INTEGER,
    level       INTEGER
);
COPY playersdeck FROM '/Users/guillemalba/Downloads/DB2021-2022-datasets/playersdeck.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS quests_arenas CASCADE;
CREATE TABLE quests_arenas
(
    quest_id   INTEGER,
    arena_id   INTEGER,
    gold       INTEGER,
    experience INTEGER
);
COPY quests_arenas FROM '/Users/guillemalba/Downloads/DB2021-2022-datasets/quests_arenas.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS seasons CASCADE;
CREATE TABLE seasons
(
    name     VARCHAR(50),
    startDate DATE,
    endDate  DATE
);
COPY seasons FROM '/Users/guillemalba/Downloads/DB2021-2022-datasets/seasons.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS shared_decks CASCADE;
CREATE TABLE shared_decks
(
    deck   INTEGER,
    player VARCHAR(50)
);
COPY shared_decks FROM '/Users/guillemalba/Downloads/DB2021-2022-datasets/shared_decks.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS technologies CASCADE;
CREATE TABLE technologies
(
    technology       VARCHAR(50),
    cost             INTEGER,
    max_level        INTEGER,
    prerequisite     VARCHAR(50),
    prereq_level     INTEGER,
    mod_damage       INTEGER,
    mod_hit_speed    INTEGER,
    mod_radius       INTEGER,
    mod_spawn_damage INTEGER,
    mod_lifetime     INTEGER,
    description      text
);
COPY technologies FROM '/Users/guillemalba/Downloads/DB2021-2022-datasets/technologies.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS oro_gemas CASCADE;
CREATE TABLE oro_gemas
(
    oro               INTEGER,
    gemas             INTEGER,
    player            VARCHAR(255)
);
COPY oro_gemas FROM '/Users/guillemalba/Downloads/DB2021-2022-datasets/oro_gemas.csv' CSV HEADER DELIMITER ',';


DROP TABLE IF EXISTS clan_insignia CASCADE;
CREATE TABLE clan_insignia
(
    insignia    VARCHAR(255),
    clan        VARCHAR(255),
    fecha       date
);
COPY clan_insignia FROM '/Users/guillemalba/Downloads/DB2021-2022-datasets/clan_insignia.csv' CSV HEADER DELIMITER ',';
--/Users/guillemalba/Downloads/DB2021-2022-datasets/



/******************* INSERTS *******************/
insert into Tarjeta (numero_tarjeta, fecha_caducidad)
select distinct cardnumber, cardexpiry from players;


insert into Jugador (id, nombre, experiencia, trofeos, oro, gemas, tarjeta)
select distinct tag, name, experience, trophies, oro, gemas, cardnumber
from players join oro_gemas on player = tag;


insert into Clan (id, nombre, descripcion, minimo_trofeos, puntuacion, trofeos_totales)
select distinct tag, name, description, requiredtrophies, score, trophies from clans;


insert into Formado(clan, jugador,fecha,role)
select distinct clan,player,date,role
from playersclans;


insert into Dona(clan,jugador,oro,fecha)
select distinct clan,player,gold,date
from playersclansdonations;


insert into Insignia (nombre, imagenUrl)
select distinct name, img from playersbadge;


insert into Adquiere(clan,insignia,fecha)
select distinct clan, insignia, fecha
from clan_insignia;


insert into Batalla_Clan(id) select distinct battle from clan_battles;


insert into Pelea(batalla_clan, clan, fecha_inicio, fecha_fin)
select battle, clan, start_date, end_date
from clan_battles;


insert into Arena (id, nombre, max_trofeos, min_trofeos)
select distinct id, name, minTrophies, maxTrophies from arenas;


insert into Consigue(insignia, arena, jugador, fecha)
select distinct name,arena,player,date
from playersbadge;


insert into Mensaje_clan(id, cuerpo, fecha, emisor, receptor, mensaje_respondido)
select distinct id,text,date,sender,receiver,answer
from messages_to_clans;


insert into Modificador(nombre, coste_oro, descripcion, daño, vel_ataque, daño_aparicion, radio, vida, dependencia)
select distinct building,cost,description,mod_damage,mod_hit_speed,mod_spawn_damage,mod_radius,mod_lifetime,prerequisite
from buildings
UNION
select distinct technology,cost,description,mod_damage,mod_hit_speed,mod_spawn_damage,mod_radius,mod_lifetime,prerequisite
from technologies;


insert into Tecnologias(nombre, nivel_max, dep_level)
select distinct technology,max_level,prereq_level
from technologies;


insert into Estructura(nombre, trofeos)
select distinct building, trophies
from buildings;


insert into Clan_modificador(clan, modificador, nivel, fecha)
select clan,concat_ws('',tech,structure),level,date
from clan_tech_structures;


insert into Deck(id,titulo,descripcion,fecha,jugador)
select distinct deck,title,description,date,player
from playersdeck;


insert into Ve(deck,jugador)
select distinct deck,player
from shared_decks;


insert into Carta (nombre, daño, velocidad_ataque, rareza, arena)
select distinct p.name, c.damage, c.hit_speed, c.rarity, c.arena
from cards as c right join playerscards as p on c.name = p.name;

insert into Carta (nombre)
select distinct c.name
from cards c left join playerscards p on c.name = p.name
where p.name is null;

insert into Edificio (carta, vida)
select distinct p.name, c.lifetime
from cards as c right join playerscards as p on c.name = p.name
where c.lifetime is not null;


insert into Tropas (carta, daño_aparicion)
select distinct p.name, c.spawn_damage
from cards as c right join playerscards as p on c.name = p.name
where c.spawn_damage is not null;


insert into Encantamiento (carta, radio_efecto)
select distinct p.name, c.radious
from cards as c right join playerscards as p on c.name = p.name
where radious is not null;


insert into compuesto(carta, deck, nivel)
select distinct pc.name, pd.deck, pd.level
from playersdeck pd join playerscards pc on pd.card = pc.id;


insert into Encuentra(jugador, carta, fecha_mejora, nivel_actual)
select player, name, date, level
from playerscards;


insert into Temporada(nombre, fecha_inicio, fecha_final)
select distinct name,startDate,enddate
from seasons;


insert into Logro(nombre, descripcion, recompensa_gemas)
select distinct name,description,gems
from playersachievements
group by name,description,gems;


insert into Desbloquea(jugador, arena,id_logro, fecha)
select distinct pa.player, pa.arena, l.id, pa.date
from playersachievements as pa Join Logro as l on pa.name = l.nombre and pa.description = l.descripcion and pa.gems = l.recompensa_gemas;


insert into Mision (id, nombre, descripcion, requerimiento, mision_dep)
select distinct quest_id, quest_title, quest_description, quest_requirement, quest_depends
from players_quests;


insert into Realiza (mision, jugador, fecha)
select distinct quest_id, player_tag, unlock
from players_quests;


insert into Mision_arena (mision, arena, experiencia, recompensa_oro)
select distinct quest_id, arena_id, experience, gold
from quests_arenas;


insert into Batalla(deck_win, deck_lose, fecha, durada, puntos_win, puntos_lose, batalla_clan)
select winner, loser, date, duration, winner_score, loser_score, clan_battle
from battles;


insert into Mensaje(id, cuerpo, fecha, idMensajeRespondido)
select distinct id,text,date,answer
from messages_between_players;


insert into Escribe(id_emisor, id_receptor, id_mensaje)
select distinct sender,receiver,id
from messages_between_players;


insert into Amigo(id_jugador_emisor, id_jugador_receptor)
select distinct requester,requeted
from friends;


insert into Articulo(id, coste_real, veces_compra, nombre)
select distinct buy_id, buy_cost, buy_stock, buy_name
from player_purchases;


insert into Emoticono(id_emoticono, nombre, path)
select distinct buy_id, emote_name, emote_path
from player_purchases
where emote_name is not null;


insert into Cofre(id_cofre, nombre, rareza, tiempo_desbloqueo, num_cartas)
select distinct buy_id, chest_name, chest_rarity, chest_unlock_time, chest_num_cards
from player_purchases
where chest_name is not null;


insert into Paquete_Arena(id_paquete)
select distinct buy_id
from player_purchases
where arenapack_id is not null;


insert into Nivel_Arena(arena, paquete, oro)
select distinct a.arena, p.buy_id, a.gold
from arena_pack as a join player_purchases as p on p.arenapack_id = a.id;


insert into Paquete_Oferta(id_p_oferta, oro_contenido, gemas_contenido)
select distinct buy_id, bundle_gold, bundle_gems from player_purchases
where bundle_gold is not null;


insert into Compra(jugador, tarjeta, articulo, fecha, descuento)
select player, credit_card, buy_id, date, discount
from player_purchases;


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

insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T4' and b.fecha BETWEEN '2018-09-01' AND '2018-12-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2018-09-01' AND '2018-12-31' and t.nombre like 'T4';

insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T5' and b.fecha BETWEEN '2019-01-01' AND '2019-08-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2019-01-01' AND '2019-08-31' and t.nombre like 'T5';

insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T6' and b.fecha BETWEEN '2019-09-01' AND '2019-12-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2019-09-01' AND '2019-12-31' and t.nombre like 'T6';

insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T7' and b.fecha BETWEEN '2020-01-01' AND '2020-08-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2020-01-01' AND '2020-08-31' and t.nombre like 'T7';

insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T8' and b.fecha BETWEEN '2020-09-01' AND '2020-12-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2020-09-01' AND '2020-12-31' and t.nombre like 'T8';

insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T9' and b.fecha BETWEEN '2021-01-01' AND '2021-08-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2021-01-01' AND '2021-08-31' and t.nombre like 'T9';

insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T10' and b.fecha BETWEEN '2021-09-01' AND '2021-12-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2021-09-01' AND '2021-12-31' and t.nombre like 'T10';





/*INSERTS PARA TENER UN OUTPUT CORRECTO EN TODAS LAS CONSULTAS LA FASE 3*/
--Añadimos el clan
insert into clan(id, nombre, descripcion, trofeos_totales, minimo_trofeos, puntuacion)
values ('#JDI23H9S', 'La Salle', 'Este es el clan de los estudiantes de la salle.', 20, 7000, 6800);

--Añdadimos todas sus batallas
insert into pelea (batalla_clan, clan, fecha_inicio, fecha_fin)
select id, '#JDI23H9S', '2019-02-21', '2021-12-31' from batalla_clan;


--Insertamos 4 cartas nuevas
insert into carta (nombre, daño, velocidad_ataque, rareza, arena)
values ('Barbaros', 103, 200, 'Common', 54000028);

insert into carta (nombre, daño, velocidad_ataque, rareza, arena)
values ('Gus', 103, 200, 'Common', 54000028);

insert into carta (nombre, daño, velocidad_ataque, rareza, arena)
values ('Putin', 103, 200, 'Common', 54000028);

insert into carta (nombre, daño, velocidad_ataque, rareza, arena)
values ('Mortero', 103, 200, 'Common', 54000028);


--Creamos una relacion de dos jugadores con dos cartas de las 4 que hemos creado anteriormente.
insert into encuentra (jugador, carta, fecha_mejora, nivel_actual)
values ('#LUGVG9PC', 'Barbaros', '01-01-2021', 5);

insert into encuentra (jugador, carta, fecha_mejora, nivel_actual)
values ('#LUGVG9PC', 'Gus', '01-01-2021', 5);

insert into encuentra (jugador, carta, fecha_mejora, nivel_actual)
values ('#PQLGJ90Y', 'Putin', '01-01-2021', 5);

insert into encuentra (jugador, carta, fecha_mejora, nivel_actual)
values ('#PQLGJ90Y', 'Mortero', '01-01-2021', 5);


-- Drops de los CSV utilizados para la importación de datos.
drop table if exists arena_pack cascade;

drop table if exists arenas cascade ;

drop table if exists battles cascade;

drop table if exists buildings cascade;

drop table if exists cards cascade;

drop table if exists clan_battles cascade;

drop table if exists clan_tech_structures cascade;

drop table if exists clans cascade;

drop table if exists friends cascade;

drop table if exists messages_between_players cascade;

drop table if exists messages_to_clans cascade;

drop table if exists player_purchases cascade;

Drop table if exists players_quests cascade;

Drop table if exists players cascade;

Drop table if exists playersachievements cascade;

Drop table if exists playersbadge cascade;

Drop table if exists playerscards cascade;

Drop table if exists playersClans cascade;

DROP TABLE IF EXISTS playersClansdonations CASCADE;

DROP TABLE IF EXISTS playersdeck CASCADE;

DROP TABLE IF EXISTS quests_arenas CASCADE;

DROP TABLE IF EXISTS seasons CASCADE;

DROP TABLE IF EXISTS shared_decks CASCADE;

DROP TABLE IF EXISTS technologies CASCADE;

DROP TABLE IF EXISTS batalla CASCADE;

DROP TABLE IF EXISTS batalla_clan CASCADE;

DROP TABLE IF EXISTS clan_insignia CASCADE;

DROP TABLE IF EXISTS clan_modificador CASCADE;

DROP TABLE IF EXISTS compuesto CASCADE;

DROP TABLE IF EXISTS mensaje_clan CASCADE;

DROP TABLE IF EXISTS modificador CASCADE;

DROP TABLE IF EXISTS nivel_arena CASCADE;

DROP TABLE IF EXISTS oro_gemas CASCADE;

DROP TABLE IF EXISTS pelea CASCADE;

DROP TABLE IF EXISTS tecnologias CASCADE;

DROP TABLE IF EXISTS mision_arena CASCADE;