drop table if exists arena_pack cascade;
create table arena_pack(
                           id      int,
                           arena   int,
                           gold    int
);

copy arena_pack from '/Users/Shared/Bases/Base/arena_pack.csv' csv header delimiter ',';

drop table if exists arenas cascade ;
create table arenas(
                       id      int,
                       name    varchar(255),
                       minTrophies     int,
                       maxTrophies     int
);

copy arenas from '/Users/Shared/Bases/Base/arenas.csv' csv header delimiter ',';

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

copy battles from '/Users/Shared/Bases/Base/battles.csv' csv header delimiter ',';

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

copy buildings from '/Users/Shared/Bases/Base/buildings.csv' csv header delimiter ',';

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
copy cards from '/Users/Shared/Bases/Base/cards.csv' csv header delimiter ',';

drop table if exists clan_battles cascade;
create table clan_battles(
                             battle       int,
                             clan         Varchar(255),
                             start_date   date,
                             end_date     date
);

copy clan_battles from '/Users/Shared/Bases/Base/clan_battles.csv' csv header delimiter ',';

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
copy clan_tech_structures from '/Users/Shared/Bases/Base/clan_tech_structures.csv' csv header delimiter ',';

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
copy clans from '/Users/Shared/Bases/Base/clans.csv' csv header delimiter ',';

drop table if exists friends cascade;
create table friends
(
    requester   varchar(255),
    requeted    varchar(255)
);
copy friends from '/Users/Shared/Bases/Base/friends.csv' csv  header delimiter ',';

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
copy messages_between_players from '/Users/Shared/Bases/Base/messages_between_players.csv' csv header delimiter ',';

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
copy messages_to_clans from '/Users/Shared/Bases/Base/messages_to_clans.csv' csv header delimiter ',';

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
copy player_purchases from '/Users/Shared/Bases/Base/player_purchases.csv' csv header delimiter ',';


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

copy players_quests from '/Users/Shared/Bases/Base/players_quests.csv' csv  header delimiter ',';

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
copy players from '/Users/Shared/Bases/Base/players.csv' csv  header delimiter ',';

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
copy playersachievements from '/Users/Shared/Bases/Base/playersachievements.csv' csv  header delimiter ',';

Drop table if exists playersbadge cascade;
Create table playersbadge
(
    player varchar(255),
    name   varchar(255),
    arena  int,
    date   Date,
    img    varchar(255)
);
copy playersbadge from '/Users/Shared/Bases/Base/playersbadge.csv' csv  header delimiter ',';

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
copy playerscards from '/Users/Shared/Bases/Base/playerscards.csv' csv  header delimiter ',';

Drop table if exists playersClans cascade;
Create table playersClans
(
    player varchar(255),
    clan   varchar(255),
    role   text,
    date   Date
);

copy playersClans from '/Users/Shared/Bases/Base/playersClans.csv' csv  header delimiter ',';

-----DIDAC----------------------------------------------------DIDAC----------------------

DROP TABLE IF EXISTS playersClansdonations CASCADE;
CREATE TABLE playersClansdonations
(
    player VARCHAR(255),
    clan   VARCHAR(255),
    gold   INTEGER,
    date   DATE
);
COPY playersClansdonations FROM '/Users/Shared/Bases/Base/playersClansdonations.csv' CSV HEADER DELIMITER ',';

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
COPY playersdeck FROM '/Users/Shared/Bases/Base/playersdeck.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS quests_arenas CASCADE;
CREATE TABLE quests_arenas
(
    quest_id   INTEGER,
    arena_id   INTEGER,
    gold       INTEGER,
    experience INTEGER
);
COPY quests_arenas FROM '/Users/Shared/Bases/Base/quests_arenas.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS seasons CASCADE;
CREATE TABLE seasons
(
    name     VARCHAR(50),
    startDate DATE,
    endDate  DATE
);
COPY seasons FROM '/Users/Shared/Bases/Base/seasons.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS shared_decks CASCADE;
CREATE TABLE shared_decks
(
    deck   INTEGER,
    player VARCHAR(50)
);
COPY shared_decks FROM '/Users/Shared/Bases/Base/shared_decks.csv' CSV HEADER DELIMITER ',';

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
COPY technologies FROM '/Users/Shared/Bases/Base/technologies.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS oro_gemas CASCADE;
CREATE TABLE oro_gemas
(
    oro               INTEGER,
    gemas             INTEGER,
    player            VARCHAR(255)
);
COPY oro_gemas FROM '/Users/Shared/Bases/Base/oro_gemas.csv' CSV HEADER DELIMITER ',';


DROP TABLE IF EXISTS clan_insignia CASCADE;
CREATE TABLE clan_insignia
(
    insignia    VARCHAR(255),
    clan        VARCHAR(255),
    fecha       DATE
);
COPY clan_insignia FROM '/Users/Shared/Bases/Base/clan_insignia.csv' CSV HEADER DELIMITER ',';



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


insert into Carta (id, nombre, daño, velocidad_ataque, rareza, arena)
select distinct p.id, p.name, c.damage, c.hit_speed, c.rarity, c.arena
from cards as c right join playerscards as p on c.name = p.name;


insert into Edificio (carta, vida)
select distinct p.id, c.lifetime
from cards as c right join playerscards as p on c.name = p.name
where c.lifetime is not null;


insert into Tropas (carta, daño_aparicion)
select distinct p.id, c.spawn_damage
from cards as c right join playerscards as p on c.name = p.name
where c.spawn_damage is not null;


insert into Encantamiento (carta, radio_efecto)
select distinct p.id, c.radious
from cards as c right join playerscards as p on c.name = p.name
where radious is not null;


insert into compuesto(carta, deck, nivel)
select card,deck,level
from playersdeck;


insert into Encuentra(jugador, carta, fecha_mejora, nivel_actual)
select player, id, date, level
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
where t.nombre like'T4' and b.fecha BETWEEN '2018-01-01' AND '2018-08-31'
union
select distinct t.nombre, j.id
from batalla as b join deck as d on b.deck_lose = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where b.fecha BETWEEN '2018-09-01' AND '2018-12-31' and t.nombre like 'T4';

insert into Participa (temporada, jugador)
select distinct t.nombre , j.id
from batalla as b join deck as d on b.deck_win = d.id
                  join jugador as j on j.id = d.jugador, temporada as t
where t.nombre like'T5' and b.fecha BETWEEN '2018-01-01' AND '2018-08-31'
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






/************************************* QUERIES DE PRUEBA **************************************************/



--Muestra el articulo mas comprado de la tienda
select a2.nombre, a2.coste_real, count(c2.id) as num_compras
from Articulo as a2 join compra as c2 on a2.id = c2.articulo
group by a2.id having count(c2.id) = (select count(c.id) from articulo as a join compra as c on a.id = c.articulo group by a.id order by count(c.id) desc limit 1)
order by count(c2.id) desc;

--Muestra el nombre y el daño de los 5 modificadores con mas daño, que sea estructura, que no depende de ningun otro modificador y que tenga almenos 1100 trofeos.
select m.nombre, m.daño
from modificador as m join estructura as e on m.nombre = e.nombre
where m.dependencia is null  and m.daño is not null and e.trofeos > 1100
order by m.daño desc limit 5;

--Muestra el nombre de los 10 primeros jugadores que haya participado en mas temporadas,

select count(p.temporada) as num_temp,p.jugador,j.nombre
from participa as p join jugador as j on p.jugador = j.id
group by j.nombre,p.jugador
order by num_temp desc,jugador
limit 10;

--Muestra el nombre, el daño, el daño de aparición y su arena, de la carta del tipo tropa
--que sea Legendary, y que tenga el mayor daño y daño de aparición en ese orden.
select c.nombre as nombre, c.daño as daño, t.daño_aparicion as dañoAparicion, c.arena
from carta as c join tropas as t on c.id = t.carta
where c.rareza like 'Legendary'
group by c.nombre,daño,c.arena,t.daño_aparicion order by c.daño desc,t.daño_aparicion desc ;


/*JUGADORES*/

-- Encuentra el jugador que mas solicitudes de amistad ha enviado
select j.id, j.nombre, j.experiencia,j.trofeos, count(a.id_jugador_emisor) as num_solicitudes
from jugador as j join amigo a on j.id = a.id_jugador_emisor
group by j.id, j.nombre, j.experiencia,j.trofeos
order by count(a.id_jugador_emisor) desc
limit 5;

--Encuentra todos los jugadores que han recibido una solicitud de amistad de "Alireza"
select j.id
from jugador as j join amigo a on j.id = a.id_jugador_receptor
join jugador as j2 on a.id_jugador_emisor = j2.id
where j2.nombre = 'Alireza';


--Top 10 jugadores que han respondido a más mensajes
select j.id, j.nombre, count(m.id) as num_repuestas
from jugador as j join escribe as e on j.id = e.id_emisor
join mensaje as m on e.id_mensaje = m.id
where m.idmensajerespondido is not null
group by j.id, j.nombre
order by count(m.id) desc
limit 10;

/*BATALLAS*/

--Top 10 clanes que han ganado mas batallas contra otro clan
select c.id, c.nombre as clan, c.trofeos_totales, count(b.id) as num_victorias
from clan as c join pelea as p on p.clan = c.id
join batalla_clan as bc on bc.id = p.batalla_clan
join batalla as b on b.batalla_clan = bc.id
join deck as d on d.id = b.deck_win
join jugador as j on d.jugador = j.id
join formado as f on j.id = f.jugador
where c.id = f.clan
group by c.id, c.nombre, c.trofeos_totales
limit 10;

--Musetra los clanes con más jugadores
select c.nombre as clan, count(distinct f.jugador) as num_players
from clan as c join formado as f on c.id = f.clan
group by c.nombre
order by count(distinct f.jugador) desc;

--Muestra el top 10 jugadores que hayan ganado mas batallas de clan y el clan al que pertenecen
select j.id, j.nombre as jugador, count(distinct b.id), c.nombre as clan
from jugador as j join deck as d on j.id = d.jugador
                  join batalla as b on d.id = b.deck_win
                  join formado as f on j.id = f.jugador
                  join clan as c on f.clan = c.id
where b.batalla_clan is  not null
group by j.id, j.nombre, c.nombre
order by count(b.id) desc
limit 20;


/*TIENDA*/

--Muestra top 10 jugadores que han comprado mas articulos y cuanto dinero se han gastado
select j.nombre, count(c.id) as num_compras, sum(a.coste_real) as dinero_total
from jugador as j join compra as c on j.id = c.jugador
join articulo as a on c.articulo = a.id
group by j.nombre
order by count(c.id) desc
limit 10;

--Muestra los 10 jugadores que mas han ahorrado con descuentos
select j.nombre as jugador, sum(c.descuento)
from jugador as j join compra as c on j.id = c.jugador
group by j.nombre
order by sum(c.descuento) desc
limit 10;

--Muestra top 5 jugadores que  han comprado mas articulos de cada tipo
(select j.nombre as jugador, count(c.id) as compras, 'Cofre' as tipo_articulo
from jugador j join compra c on j.id = c.jugador
join cofre c2 on c.articulo = c2.id_cofre
group by j.nombre
order by compras desc
limit 5)
union
(select j.nombre as jugador, count(c.id) as compras, 'Emoticono' as tipo_articulo
from jugador j join compra c on j.id = c.jugador
join emoticono e on c.articulo = e.id_emoticono
group by j.nombre
order by compras desc
limit 5)
union
(select j.nombre as jugador, count(c.id) as compras, 'Paquete Arena' as tipo_articulo
from jugador j join compra c on j.id = c.jugador
join paquete_arena p on c.articulo = p.id_paquete
group by j.nombre
order by compras desc
limit 5)
union
(select j.nombre as jugador, count(c.id) as compras, 'Paquete Oferta' as tipo_articulo
from jugador j join compra c on j.id = c.jugador
join paquete_oferta p on c.articulo = p.id_p_oferta
group by j.nombre
order by compras desc
limit 5);

/*MISIONES*/
--Encuentra el top 10 jugadores que mas misiones han hecho
select j.nombre, count(r.id) as num_misiones
from jugador as j join realiza as r on j.id = r.jugador
group by j.nombre
order by num_misiones desc
limit 10;

--Encuentra el jugador que mas dinero ha ganado con misiones
select j.nombre, sum(ma.recompensa_oro) as dinero
from jugador as j join realiza as r on j.id = r.jugador
join mision as m on r.mision = m.id
join mision_arena ma on m.id = ma.mision
group by j.nombre
order by dinero desc
limit 10;