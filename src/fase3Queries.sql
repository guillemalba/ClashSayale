/***************** APARTADO 1 *****************/
/* 1.1
 * Enumerar el nom i el valor de dany de les cartes de tipus de tropa amb un valor de
 * velocitat d’atac superior a 100 i el nom del qual contingui el caràcter "k".
 */
select c.nombre, c.daño
from carta c join tropas t on c.nombre = t.carta
where velocidad_ataque > 100 and c.nombre like '%k%';


/* 1.2
 * Enumerar el valor de dany mitjà, el valor de dany màxim i el valor de dany mínim de les
 * cartes èpiques.
 */
select avg(daño) as daño_medio, max(daño) as daño_max, min(daño) as daño_min
from carta
where rareza = 'Epic'
group by rareza;


/* 1.3
 * Enumera el nom i la descripció de les piles i el nom de les cartes que tenen un nivell de
 * carta més gran que el nivell mitjà de totes les cartes. Ordena els resultats segons el nom
 * de les piles i el nom de les cartes de més a menys valor.
 */
select d.titulo, d.descripcion, c2.nombre, c.nivel
from deck d join compuesto c on d.id = c.deck
join carta c2 on c.carta = c2.nombre
where c.nivel > (select avg(nivel) from compuesto)
order by d.titulo desc, c2.nombre desc;


/* 1.4
 * Enumerar el nom i el dany de les cartes llegendàries de menor a major valor de dany
 * que pertanyin a una pila creada l'1 de novembre del 2021. Filtrar la sortida per tenir les
 * deu millors cartes.
 */
select c.nombre, c.daño
from carta c join compuesto c2 on c.nombre = c2.carta
join deck d on c2.deck = d.id
where c.rareza = 'Epic' and d.fecha = '2021-11-01'
group by c.nombre, c.daño
order by c.daño desc
limit 10;


/* 1.5
 * Llistar les tres primeres cartes de tipus edifici (nom i dany) en funció del dany dels
 * jugadors amb experiència superior a 250.000.
 * Base de dades: 2021-2022 Projecte – Fase 3
 */
select c.nombre, c.daño
from edificio e join carta c on c.nombre = e.carta
join compuesto c2 on c.nombre = c2.carta
join deck d on c2.deck = d.id
join jugador j on d.jugador = j.id
where j.experiencia > 250000
group by c.nombre, c.daño
order by c.daño desc
limit 3;


/* 1.6
 * Els dissenyadors del joc volen canviar algunes coses a les dades. El nom d'una carta
 * "Rascals" serà "Hal Roach's Rascals", la Raresa "Common" es dirà "Proletari".
 * Proporcioneu les ordres SQL per fer les modificacions sense eliminar les dades i
 * reimportar-les.
 */



/* 1.7
 * Enumerar els noms de les cartes que no estan en cap pila i els noms de les cartes que
 * només estan en una pila. Per validar els resultats de la consulta, proporcioneu dues
 * consultes diferents per obtenir el mateix resultat.
 */
select c.nombre
from carta c left join compuesto c2 on c.nombre = c2.carta
where c2.carta is null
union
select c.nombre
from carta c left join compuesto c2 on c.nombre = c2.carta
group by c.nombre having count(c2.carta) = 1;


/* 1.8
 * Enumera el nom i el dany de les cartes èpiques que tenen un dany superior al dany mitjà
 * de les cartes llegendàries. Ordena els resultats segons el dany de les cartes de menys
 * a més valor.
 */

select nombre, daño
from carta
where rareza = 'Epic' and daño > (select avg(daño) from carta where rareza = 'Legendary')
order by daño;




/***************** APARTADO 1 *****************/
/* 2.1
 * Enumera els missatges (text i data) escrits pels jugadors que tenen més experiència que
 * la mitjana dels jugadors que tenen una "A" en nom seu i pertanyen al clan "NoA". Donar
 * la llista de ordenada dels missatges més antics als més nous.
 */
select m.cuerpo, m.fecha
from jugador j join escribe e on j.id = e.id_emisor
join mensaje m on e.id_mensaje = m.id
where j.experiencia > (select avg(experiencia) from jugador j join formado f on j.id = f.jugador join clan c on f.clan = c.id where j.nombre like '%a%' and c.nombre = 'NoA' group by c.nombre)
order by m.fecha desc;


/* 2.2
 * Enumera el número de la targeta de crèdit, la data i el descompte utilitzat pels jugadors
 * per comprar articles de Pack Arena amb un cost superior a 200 i per comprar articles
 * que el seu nom contingui una "B".
 */
select c.tarjeta, c.fecha, c.descuento
from compra c join jugador j on c.jugador = j.id
join articulo a on c.articulo = a.id
join paquete_arena pa on a.id = pa.id_paquete
where a.coste_real > 200
union
select c.tarjeta, c.fecha, c.descuento
from compra c join jugador j on c.jugador = j.id
join articulo a on c.articulo = a.id
join paquete_arena pa on a.id = pa.id_paquete
where a.nombre like '%b%';


/* 2.3
 * Enumerar el nom i el nombre d’articles comprats, així com el cost total dels articles
 * comprats i l’experiència dels jugadors que els van demanar. Filtra la sortida amb els 5
 * articles en què els usuaris han gastat més diners.
 */
select a.nombre, count(c.articulo) as num_compras, a.coste_real*count(c.articulo) as coste_total
from compra c join articulo a on c.articulo = a.id
group by a.id
order by coste_total desc;


/* 2.4
 * Donar els números de les targetes de crèdit que s'han utilitzat més.
 */
select t.numero_tarjeta
from compra c join tarjeta t on c.tarjeta = t.numero_tarjeta
group by t.numero_tarjeta having count(c.tarjeta) = (select count(c.tarjeta) from compra c join tarjeta t on c.tarjeta = t.numero_tarjeta group by t.numero_tarjeta order by count(c.tarjeta) desc limit 1);

/* 2.5
 * Donar els descomptes totals de les emoticones comprades durant l'any 2020
 */
select sum(c.descuento), count(c.id)
from compra c join articulo a on c.articulo = a.id
join emoticono e on a.id = e.id_emoticono
where c.fecha between '2020-01-01' and '2020-12-31';


/* 2.6
 * Enumerar el nom, experiència i número de targeta de crèdit dels jugadors amb
 * experiència superior a 150.000. Filtra les targetes de crèdit que no han estat utilitzades
 * per comprar cap article. Donar dues consultes diferents per obtenir el mateix resultat.
 */
select j.nombre, j.experiencia, t.numero_tarjeta
from jugador j join tarjeta t on j.tarjeta = t.numero_tarjeta
left join compra c on j.id = c.jugador
where c.jugador is null;

--Podemos ver que solo hay un jugador que no ha comprado ningun articulo, por lo tanto
--la query anterior es correcta
select count(distinct jugador) as num_jugadores
from compra;



/* 2.7
 * Retorna el nom dels articles comprats pels jugadors que tenen més de 105 cartes o pels
 * jugadors que han escrit més de 4 missatges. Ordeneu els resultats segons el nom de
 * l'article de més a menys valor.
 */
select distinct a.nombre
from jugador j join compra c on j.id = c.jugador
join articulo a on c.articulo = a.id
join encuentra e on j.id = e.jugador
where j.nombre in (
    select j.nombre -- Jugadores con mas de 105 cartas
    from jugador j join encuentra e on j.id = e.jugador
    group by j.nombre, j.id having count(e.carta) > 105
    UNION
    select j.nombre -- Jugadores con mas de 4 mensajes escritos
    from jugador j join escribe e on j.id = e.id_emisor
    group by j.nombre having count(e.id_mensaje) > 4
    )
order by a.nombre desc;


/*  2.8
 * Retorna els missatges (text i data) enviats a l'any 2020 entre jugadors i que hagin estat
 * respostos, o els missatges sense respostes enviats a un clan. Ordena els resultats
 * segons la data del missatge i el text del missatge de més a menys valor.
 */
(select cuerpo, fecha
from mensaje
where idmensajerespondido is not null and fecha between '2020-01-01' and '2020-12-31'
order by fecha desc, cuerpo desc)
union all
select cuerpo, fecha
from mensaje_clan
where mensaje_respondido is null
order by fecha desc, cuerpo desc;


/***************** APARTADO 1 *****************/
/* 3.1
 * Llistar els clans (nom i descripció) i el nombre de jugadors que tenen una experiència
 * superior a 200.000. Filtra la sortida per tenir els clans amb més trofeus requerits.
 */


/* 3.2
 * Llistar els 15 jugadors amb més experiència, la seva experiència i el nom del clan que pertany si el clan que ha
 * investigat una tecnologia amb un cost superior a 1000.
 */


/* 3.3
 * Enumera l’identificador, la data d'inici i la durada de les batalles que van començar després del "01-01-2021" i en
 * què van participar clans amb trofeus mínims superiors a 6900. Donar només 5 batalles amb la major durada.
 */


/* 3.4
 * Enumera per a cada clan el nombre d'estructures i el cost total d'or. Considera les estructures creades a l'any 2020
 * i amb trofeus mínims superiors a 1200. Donar només la informació dels clans que tinguin més de 2 estructures.
 */


/* 3.5
 * Enumera el nom dels clans, la descripció i els trofeus mínims ordenat de menor a major nivell de trofeus mínims per
 * als clans amb jugadors que tinguin més de 200.000 d’experiència i el rol co-líder.
 */


/* 3.6
 * Necessitem canviar algunes dades a la base de dades. Hem d'incrementar un 25% el cost de les tecnologies que
 * utilitzen els clans amb trofeus mínims superiors a la mitjana de trofeus mínims de tots els clans.
 */


/* 3.7
 * Enumerar el nom i la descripció de la tecnologia utilitzada pels clans que tenen una estructura "Monument"
 * construïda després del "01-01-2021". Ordena les dades segons el nom i la descripció de les tecnologies.
 */


/* 3.8
 * Enumera els clans amb un mínim de trofeus superior a 6900 i que hagin participat a totes les batalles de clans.
 */



/***************** APARTADO 1 *****************/
/* 4.1
 * Enumera el nom, els trofeus mínims, els trofeus màxims de les arenes que el seu títol comença per "A" i tenen un
 * paquet d’arena amb or superior a 8000.
 */
select a.nombre, a.max_trofeos, a.min_trofeos
from arena a
    join nivel_arena na on a.id = na.arena
where nombre like 'A%'
and oro >= 8000;

/* 4.2
 * Llista de nom, data d'inici, data de finalització de les temporades i, de les batalles d'aquestes temporades, el nom
 * del jugador guanyador si el jugador té més victòries que derrotes i la seva experiència és més gran de 200.000.
 */

select t.nombre,
       t.fecha_inicio,
       t.fecha_final,
       j.nombre  as nombre_jugador,
       d.jugador as id_jugador,
       b.fecha   as fecha_batalla
from temporada as t
         join participa p on t.nombre = p.temporada
         join jugador as j on p.jugador = j.id
         join deck d on j.id = d.jugador
         join batalla b on d.id = b.deck_win
where b.fecha >= t.fecha_inicio
  and b.fecha <= t.fecha_final
  and j.id in (select w.jugador
               from (select d.jugador, COUNT(d.id) as num_wins
                     from deck d
                              join batalla b on d.id = b.deck_win
                     group by d.jugador) as w
                        join (select d.jugador, COUNT(d.id) as num_loses
                              from deck d
                                       join batalla b on d.id = b.deck_lose
                              group by d.jugador) as l on w.jugador = l.jugador
               where w.num_wins - l.num_loses > 0
                 and w.jugador in (select jj.id
                                   from jugador jj
                                   where jj.experiencia > 200000))
order by t.fecha_inicio asc;

select * from temporada;

select * from jugador;

select * from batalla;

select j.nombre
from jugador j
where experiencia > 200000;

select d.jugador, COUNT(d.id) as num_wins
from deck d join batalla b on d.id = b.deck_win
group by d.jugador
order by num_wins desc;

select d.jugador, COUNT(d.id) as num_loses
from deck d join batalla b on d.id = b.deck_lose
group by d.jugador
order by num_loses desc;


select w.jugador, w.num_wins, l.num_loses, w.num_wins - l.num_loses as difference
from (select d.jugador, COUNT(d.id) as num_wins
      from deck d
               join batalla b on d.id = b.deck_win
      group by d.jugador) as w
         join (select d.jugador, COUNT(d.id) as num_loses
               from deck d
                        join batalla b on d.id = b.deck_lose
               group by d.jugador) as l on w.jugador = l.jugador
where w.num_wins - l.num_loses > 0
  and w.jugador in (select j.id
                    from jugador j
                    where j.experiencia > 200000);

select * from temporada
order by temporada.fecha_inicio asc;

select *
from batalla
where batalla.id not in (select b.id
                         from temporada as t
                                  join participa p on t.nombre = p.temporada
                                  join jugador as j on p.jugador = j.id
                                  join deck d on j.id = d.jugador
                                  join batalla b on d.id = b.deck_win
                         where b.fecha >= t.fecha_inicio
                           and b.fecha <= t.fecha_final);

select * from deck
where deck.id = 167;

select * from jugador
where jugador.id = '#GVJLCYC';

select * from participa
where participa.jugador = '#GVJLCYC';



select * from batalla
order by batalla.fecha desc;


/* 4.3
 * Llistar la puntuació total dels jugadors guanyadors de batalles de cada temporada. Filtrar la sortida per considerar
 * només les temporades que han començat i acabat el 2019.
 */
select t.nombre,
       t.fecha_inicio,
       t.fecha_final,
       j.nombre  as nombre_jugador,
       d.jugador as id_jugador,
       b.fecha   as fecha_batalla,
       b.puntos_win
from temporada as t
         join participa p on t.nombre = p.temporada
         join jugador as j on p.jugador = j.id
         join deck d on j.id = d.jugador
         join batalla b on d.id = b.deck_win
where b.fecha >= t.fecha_inicio
  and b.fecha <= t.fecha_final
  and j.id in (select w.jugador
               from (select d.jugador
                     from deck d
                              join batalla b on d.id = b.deck_win
                     group by d.jugador) as w)
order by j.nombre asc, t.nombre asc;


select j.nombre,
       SUM(b.puntos_win) as total_points
from jugador j,
     batalla b,
     deck d
where b.deck_win = d.id
  and j.id = d.jugador
  and EXTRACT(YEAR FROM b.fecha) = 2019
group by j.nombre
order by total_points desc;

select * from batalla;

/* 4.4
 * Enumerar els noms de les arenes en què els jugadors veterans (experiència superior a 170.000) van obtenir insígnies
 * després del "25-10-2021". Ordenar el resultat segons el nom de l’arena en ordre ascendent.
 */
select a.nombre
from arena a,
     jugador j,
     insignia i,
     consigue c
where j.experiencia > 170000
  and c.jugador = j.id
  and a.id = c.arena
  and i.nombre = c.insignia
  and c.fecha >= '2021-10-25'
group by a.nombre
order by a.nombre asc;

/* 4.5
 * Enumerar el nom de la insígnia, els noms de les cartes i el dany de les cartes dels jugadors amb una experiència
 * superior a 290.000 i obtingudes en arenes el nom de les quals comença per "A" o quan la insígnia no té imatge. Així,
 * considera només els jugadors que tenen una carta el nom de la qual comença per "Lava".
 */


/* 4.6
 * Donar el nom de les missions que donen recompenses a totes les arenes el títol de les quals comença per "t" o acaba
 * per "a". Ordena el resultat pel nom de la missió.
 */
select m.nombre as nombre_mission, a.nombre as nombre_arena
from mision as m
         join mision_arena ma on m.id = ma.mision
         join arena as a on ma.arena = a.id
where a.nombre like 't%'
   or a.nombre like '%a'
order by m.nombre asc;


/* 4.7
 * Donar el nom de les arenes amb jugadors que al novembre o desembre de 2021 van obtenir insígnies si el nom de
 * l’arena conté la paraula "Lliga", i les arenes tenen jugadors que al 2021 van obtenir èxits el nom dels quals conté
 * la paraula "Friend".
 */
select *
from arena;
where insignia.nombre like '%Lliga%';

select a.nombre as nombre_arena
from consigue as c
         join arena a on a.id = c.arena
         join jugador j on j.id = c.jugador
         join insignia i on i.nombre = c.insignia
where a.nombre like '%Lliga%'
and EXTRACT(YEAR FROM c.fecha) = 2021
and (EXTRACT(MONTH FROM c.fecha) = 11 or EXTRACT(MONTH FROM c.fecha) = 12)
and j.id in (select j.id
             from desbloquea d
                      join arena a on a.id = d.arena
                      join jugador j on j.id = d.jugador
                      join logro l on l.id = d.id_logro
             where l.nombre like '%Friend%'
               and EXTRACT(YEAR FROM d.fecha) = 2021
             group by j.id)
order by a.nombre;

/* Selecciona els ids dels jugadors que que al 2021 van obtenir èxits el nom dels quals conté la paraula "Friend".*/
select j.id
from desbloquea d
         join arena a on a.id = d.arena
         join jugador j on j.id = d.jugador
         join logro l on l.id = d.id_logro
where l.nombre like '%Friend%'
and EXTRACT(YEAR FROM d.fecha) = 2021
group by j.id
order by j.id;

/* 4.8
 * Retorna el nom de les cartes que pertanyen a jugadors que van completar missions el nom de les quals inclou la
 * paraula "Armer" i l'or de la missió és més gran que l'or mitjà recompensat en totes les missions de les arenes.
 */