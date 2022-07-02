
/* 5.1
 * Mostrar el nombre de jugadors que té cada clan, però només considerant els jugadors amb nom de rol que
 * contingui el text "elder". Restringir la sortida per als 5 primers clans amb més jugadors.
 */
select c.nombre, count(distinct f.jugador) as num_players
from clan as c  join formado f on c.id = f.clan
where f.role like '%elder:%'
group by c.nombre order by num_players desc limit 5;

--Consulta per la validacó
select c.nombre, count(distinct f.jugador) as num_players, f.jugador, f.role
from clan as c join formado f on c.id = f.clan
where f.role like '%elder:%'
group by c.nombre,f.jugador, f.role order by num_players;




/* 5.2
 *  Mostrar el nom dels jugadors,el text dels missatges i la data dels missatges enviats pels jugadors
 *  que tenen la carta Skeleton Army i han comprat articles abans del 01-01-2019.
 */
select j.nombre, m.cuerpo, m.fecha
from jugador as j join escribe e on j.id = e.id_emisor
                  join mensaje m on m.id = e.id_mensaje join deck d on j.id = d.jugador
                  join compuesto c on d.id = c.deck join compra c2 on j.id = c2.jugador
where c.carta like 'Skeleton Army' and c2.fecha < '2019-01-01'
group by j.nombre, m.cuerpo, m.fecha;


----Consulta per a la validacio
select j.nombre, m.cuerpo, m.fecha, c.carta,c2.fecha
from jugador as j join escribe e on j.id = e.id_emisor
                  join mensaje m on m.id = e.id_mensaje join deck d on j.id = d.jugador
                  join compuesto c on d.id = c.deck join compra c2 on j.id = c2.jugador
where c.carta like 'Skeleton Army' and c2.fecha < '2019-01-01'
group by j.nombre, m.cuerpo, m.fecha,c.carta,c2.fecha;


/* 5.3
 *  Llistar els 10 primers jugadors amb experiència superior a 100.000 que han creat més piles i han guanyat
 *  batalles a la temporada T7.
 */

--Query de la 5.3
select j.nombre, count(d.jugador) as decks_creats
from jugador as j join deck d on j.id = d.jugador
                  join batalla b on d.id = b.deck_win
where j.experiencia > 100000 and b.fecha between '2020-01-01' and '2020-08-31'
group by j.nombre order by decks_creats desc limit 10;


--Query valdiacio
select j.nombre, b.fecha
from jugador as j join deck d on j.id = d.jugador join batalla b on d.id = b.deck_win
where b.fecha between '2020-01-01' and '2020-08-31' and
    (j.nombre like '%Ktown%' or j.nombre like '%WINNER%' or j.nombre like '%KingSquid%' or j.nombre like '%Alan%'
        or j.nombre like '%Jessie%' or j.nombre like '%VORTEX%' or j.nombre like '%wayes%' or j.nombre like '%QLASH%'
        or j.nombre like '%Dirso%' or j.nombre like '%Yogui%')
group by j.nombre, b.fecha;

---Query2 validacio
select j.nombre, count(d.jugador) as decks_creats, j.experiencia
from jugador as j join deck d on j.id = d.jugador
                  join batalla b on d.id = b.deck_win
where j.experiencia > 100000 and b.fecha between '2020-01-01' and '2020-08-31'
group by j.nombre,j.experiencia, j.nombre order by decks_creats desc limit 10;


/* 5.4
 * Enumera els articles que han estat comprats més vegades i el seu cost total.
 */
select a.nombre as articulo,count(c.articulo) as nombre_vecesCompra,sum(a.coste_real) as cost_Total
from articulo as a join compra c on a.id = c.articulo
group by a.nombre,coste_real order by nombre_vecesCompra desc;


---Query de validacio
select a.nombre as articulo, a.coste_real ,count(c.articulo) as nombre_vecesCompra,a.coste_real*count(c.articulo) as cost_Total
from articulo as a join compra c on a.id = c.articulo
group by a.nombre,coste_real order by nombre_vecesCompra desc;



/* 5.5
 * Mostrar la identificació de les batalles, la durada, la data d'inici i la data de finalització dels
 * clans que la seva descripció no contingui el text "Chuck Norris". Considera només les batalles amb una
 * durada inferior a la durada mitjana de totes les batalles.
 */
(select b.id, b.durada, p.fecha_inicio, p.fecha_fin,c.descripcion
 from clan as c join pelea as p on p.clan = c.id join batalla_clan as bc on p.batalla_clan = bc.id
                join batalla b on p.batalla_clan = b.batalla_clan
 where b.durada < (select avg(durada) from batalla)
 group by b.id, b.durada, p.fecha_inicio, p.fecha_fin, c.descripcion order by  b.durada)
except
select b.id, b.durada, p.fecha_inicio, p.fecha_fin,c.descripcion
from clan as c join pelea as p on p.clan = c.id join batalla_clan as bc on p.batalla_clan = bc.id
               join batalla b on p.batalla_clan = b.batalla_clan
where c.descripcion like '%Chuck Norris%'
group by b.id, b.durada, p.fecha_inicio, p.fecha_fin, c.descripcion order by durada;


--Querys de validación
select c.descripcion from clan as c
except
select c.descripcion from clan as c
where  c.descripcion like '%Chuck Norris%' or c.descripcion like '%ChuckNorris%' ;

select avg(durada) from batalla;



/* 5.6
 * Enumerar el nom i l'experiència dels jugadors que pertanyen a un clan que té una tecnologia el nom
 * del qual conté la paraula "Militar" i aquests jugadors havien comprat el 2021 més de 5 articles.
 */
select j.nombre, j.experiencia,count(c2.jugador),t.nombre
from jugador as j join formado f on j.id = f.jugador join clan c on c.id = f.clan
                  join clan_modificador cm on c.id = cm.clan join modificador m on cm.modificador = m.nombre
                  join tecnologias t on m.nombre = t.nombre join compra c2 on j.id = c2.jugador
where t.nombre like '%Militar%' and c2.fecha between '2021-01-01' and '2021-12-31'
group by j.nombre, j.experiencia,t.nombre having count(c2.jugador) > 5;


--Consulta de validacio
select j.nombre, j.experiencia,count(c2.jugador), t.nombre,c.nombre
from jugador as j join formado f on j.id = f.jugador join clan c on c.id = f.clan
                  join clan_modificador cm on c.id = cm.clan join modificador m on cm.modificador = m.nombre
                  join tecnologias t on m.nombre = t.nombre join compra c2 on j.id = c2.jugador
where t.nombre like '%Militar%'and c2.fecha between '2021-01-01' and '2021-12-31'
group by j.nombre, j.experiencia, t.nombre,c.nombre; --having count(c2.jugador) > 5;


/* 5.7
 * Indiqueu el nom dels jugadors que tenen totes les cartes amb el major valor de dany.
 */
select  j.nombre as jugador
from jugador as j join encuentra e on e.jugador = j.id
                  join carta c on  e.carta = c.nombre
where c.daño > 200
group by j.nombre having count(j.nombre) > 15;


--Query de validacio1 Algun jugador sin  una de esas cartas.
select j.nombre from jugador as j
except
select  j.nombre as jugador
from jugador as j join encuentra e on e.jugador = j.id
                  join carta c on  e.carta = c.nombre
where c.daño > 200
group by j.nombre having count(j.nombre) > 15;


--Query validacio2
select  j.nombre as jugador, c.nombre as nomCarta, c.daño
from jugador as j join encuentra e on e.jugador = j.id
                  join carta c on  e.carta = c.nombre
where c.daño > 200
group by j.nombre, c.nombre, c.daño order by j.nombre;


--Query validacio3
select  j.nombre as jugador, c.nombre as c, c.daño
from jugador as j join encuentra e on e.jugador = j.id
                  join carta c on  e.carta = c.nombre
where j.nombre like '%ᴢᴇʙᴀʀᴅɪ%'
group by j.nombre, c.nombre;



/* 5.8
 * Retorna el nom de les cartes i el dany que pertanyen a les piles el nom de les quals conté la paraula
 * "Madrid" i van ser creats per jugadors amb experiència superior a 150.000. Considereu només les cartes
 * amb dany superior a 200 i els jugadors que van aconseguir un èxit en el 2021. Enumera el resultat des
 * dels valors més alts del nom de la carta fins als valors més baixos del nom de la carta.
 */

select c.nombre, c.daño
from carta c join compuesto c2 on c.nombre = c2.carta join deck d on d.id = c2.deck
             join jugador j on d.jugador = j.id join desbloquea d2 on j.id = d2.jugador
where d.titulo like '%Madrid%' and j.experiencia > 150000 and d2.fecha between '2021-01-01' and '2021-12-31'
group by c.nombre, c.daño having c.daño > 200 order by c.nombre desc;

--Query de validacion
select c.nombre, c.daño, d.titulo, j.experiencia, d2.fecha
from carta c join compuesto c2 on c.nombre = c2.carta join deck d on d.id = c2.deck
             join jugador j on d.jugador = j.id join desbloquea d2 on j.id = d2.jugador
where d.titulo like '%Madrid%' and j.experiencia > 150000 and d2.fecha between '2021-01-01' and '2021-12-31'
group by c.nombre, c.daño,d.titulo,j.experiencia, d2.fecha having c.daño > 200 order by c.nombre desc;


/* 5.9
 * Enumerar el nom, l’experiència i el nombre de trofeus dels jugadors que no han comprat res. Així, el nom,
 * l'experiència i el número de trofeus dels jugadors que no han enviat cap missatge. Ordenar la sortida de
 * menor a més valor en el nom del jugador.
 */

(select j.nombre, j.experiencia, j.trofeos
 from jugador as j
 group by j.nombre, j.experiencia, j.trofeos
 except
 select j.nombre, j.experiencia, j.trofeos
 from jugador as j join compra c on j.id = c.jugador
 group by j.nombre, j.experiencia, j.trofeos)
union
(select j.nombre, j.experiencia, j.trofeos
 from jugador as j
 group by j.nombre, j.experiencia, j.trofeos
 except
 select j.nombre, j.experiencia, j.trofeos
 from jugador as j join escribe e on j.id = e.id_emisor
 group by j.nombre, j.experiencia, j.trofeos)
order by nombre asc;



--Consulta de validacio

select j.nombre, j.experiencia, j.trofeos
from jugador as j
group by j.nombre, j.experiencia, j.trofeos;

select j.nombre, j.experiencia, j.trofeos
from jugador as j join compra c on j.id = c.jugador
group by j.nombre, j.experiencia, j.trofeos;

----------------

select j.nombre,j.experiencia,j.trofeos
from jugador as j
group by j.nombre,j.experiencia,j.trofeos;

select j.nombre,j.experiencia,j.trofeos
from jugador as j join escribe e on j.id = e.id_emisor
group by j.nombre,j.experiencia,j.trofeos;



/* 5.10
 * Llistar les cartes comunes que no estan incloses en cap pila i que pertanyen a jugadors amb experiència
 * superior a 200.000. Ordena la sortida amb el nom de la carta.
 */

--Ejecutamos la query y vemos que no sale ninguna carta.
(select c.nombre
 from carta as c join encuentra e on c.nombre = e.carta
                 join jugador j on j.id = e.jugador
 where j.experiencia >200000
 group by c.nombre, c.rareza having c.rareza = 'Common'
 order by c.nombre)
except
(select c.nombre from carta as c join compuesto c2 on c.nombre = c2.carta
 group by c.nombre order by nombre);





--Para validar que el la consulta esta bien, pese a que el resultado es 0, insertamos 4 carta que cumplan esas condiciones
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




--Ejecutamos la query y vemos que en el output salen las 4 cartas que hemos creado.
(select c.nombre
 from carta as c join encuentra e on c.nombre = e.carta
                 join jugador j on j.id = e.jugador
 where j.experiencia >200000
 group by c.nombre, c.rareza having c.rareza = 'Common'
 order by c.nombre)
except
(select c.nombre from carta as c join compuesto c2 on c.nombre = c2.carta
 group by c.nombre order by nombre);



/* 5.11
 * Llistar el nom dels jugadors que han sol·licitat amics, però no han estat sol·licitats com a amics.
 */

select j.nombre
from jugador as j join amigo a on j.id = a.id_jugador_emisor
group by j.nombre
except
select j.nombre
from jugador as j join amigo a2 on j.id = a2.id_jugador_receptor
group by j.nombre;


select j.nombre
from jugador as j join amigo a on j.id = a.id_jugador_emisor
group by j.nombre
intersect
select j.nombre
from jugador as j join amigo a2 on j.id = a2.id_jugador_receptor
group by j.nombre;




/* 5.12
 * Enumerar el nom dels jugadors i el nombre d'articles comprats que tenen un cost superior al cost mitjà
 * de tots els articles. Ordenar el resultat de menor a major valor del nombre de comandes.
 */
select j.nombre, count(c.id)
from jugador as j join compra c on j.id = c.jugador
                  join articulo a on a.id = c.articulo
where a.coste_real > (select avg(coste_real) from articulo)
group by j.nombre order by count(j.nombre) asc;


--VAlidacio

select avg(coste_real) from articulo;

select j.nombre, count(c.id), a.coste_real
from jugador as j join compra c on j.id = c.jugador
                  join articulo a on a.id = c.articulo
where a.coste_real > (select avg(coste_real) from articulo)
group by j.nombre,a.coste_real
order by count(j.nombre) asc;



/* 5.13
 * Poseu a zero els valors d'or i gemmes als jugadors que no han enviat cap missatge o que han enviat el
 * mateix nombre de missatges que el jugador que més missatges ha enviat.
 */


select *
from jugador
where jugador.id = '#22UCV0000';

update jugador
set oro   = 0,
    gemas = 0
where jugador.id in (
    select t.id
    from (
             /* Selects players with number of messages sended to clans */
             select jugador.id, jugador.nombre, count(emisor) as num_mensajes_enviados
             from clan
                      join mensaje_clan mc on clan.id = mc.receptor
                      join jugador on mc.emisor = jugador.id
             group by jugador.id, jugador.nombre
             union all
             /* Selects players with number of messages sended to players */
             select jugador.id, jugador.nombre, count(id_mensaje) as num_mensajes_enviados_a_clanes
             from jugador
                      join escribe on jugador.id = escribe.id_emisor
                      join mensaje on escribe.id_mensaje = mensaje.id
             group by jugador.id
         ) t
    group by t.nombre, t.id
    having sum(num_mensajes_enviados) = (
        select MAX(total_mensajes_enviados)
        from (
                 /* Devuelve una lista con el total de mensajes enviados por jugadores a jugadores y jugadores a clanes */
                 select t.id, t.nombre, SUM(num_mensajes_enviados) as total_mensajes_enviados
                 from (
                          /* Selects players with number of messages sended to clans */
                          select jugador.id, jugador.nombre, count(emisor) as num_mensajes_enviados
                          from clan
                                   join mensaje_clan mc on clan.id = mc.receptor
                                   join jugador on mc.emisor = jugador.id
                          group by jugador.id, jugador.nombre
                          union all
                          /* Selects players with number of messages sended to players */
                          select jugador.id, jugador.nombre, count(id_mensaje) as num_mensajes_enviados
                          from jugador
                                   join escribe on jugador.id = escribe.id_emisor
                                   join mensaje on escribe.id_mensaje = mensaje.id
                          group by jugador.id
                      ) t
                 group by t.nombre, t.id
             ) t2
    ))
   or jugador.id not in (
    /* Selects players with number of messages sended to a clan */
    select jugador.id
    from clan
             join mensaje_clan mc on clan.id = mc.receptor
             join jugador on mc.emisor = jugador.id
    group by jugador.id, jugador.nombre
    union all
    /* Selects players with number of messages sended to players */
    select jugador.id
    from jugador
             join escribe on jugador.id = escribe.id_emisor
             join mensaje on escribe.id_mensaje = mensaje.id
    group by jugador.id
);


--consulta 5.13
--Como no hay ningun usuario que no haya enviado ningun mensaje, hacemos un insert de un jugador que cumpla estas condiciones.
insert into jugador (id, nombre, experiencia, trofeos, oro, gemas, tarjeta)
values ('#22UCV0000', 'Manolo', 100, 100, 1000, 200, null);

select *
from jugador
where jugador.id = '#22UCV0000';

delete from jugador
where jugador.id = '#22UCV0000';