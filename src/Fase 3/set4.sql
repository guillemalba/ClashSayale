/***************** APARTADO 4 *****************/
/* 4.1
 * Enumera el nom, els trofeus mínims, els trofeus màxims de les arenes que el seu títol comença per "A" i tenen un
 * paquet d’arena amb or superior a 8000.
 */
select a.nombre, a.max_trofeos, a.min_trofeos
from arena a
         join nivel_arena na on a.id = na.arena
         join paquete_arena pa on na.paquete = pa.id_paquete
where oro >= 8000
group by a.nombre, a.max_trofeos, a.min_trofeos
having nombre like 'A%';

/* query de validacion */
select DISTINCT (arena)
from nivel_arena
         join arena a on a.id = nivel_arena.arena
where oro > 8000
  and a.nombre like 'A%'
order by arena;


/* 4.2
 * Llista de nom, data d'inici, data de finalització de les temporades i, de les batalles d'aquestes temporades, el nom
 * del jugador guanyador si el jugador té més victòries que derrotes i la seva experiència és més gran de 200.000.
 */
select t.nombre,
       t.fecha_inicio,
       t.fecha_final,
       j.nombre  as nombre_jugador,
       d.jugador as id_jugador
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

/* 4.3
 * Llistar la puntuació total dels jugadors guanyadors de batalles de cada temporada. Filtrar la sortida per considerar
 * només les temporades que han començat i acabat el 2019.
 */
select t.nombre as temporada,
       j.nombre  as nombre_jugador,
       d.jugador as id_jugador,
       SUM(b.puntos_win) as suma_puntos
from temporada as t
         join participa p on t.nombre = p.temporada
         join jugador as j on p.jugador = j.id
         join deck d on j.id = d.jugador
         join batalla b on d.id = b.deck_win
where b.fecha >= t.fecha_inicio
  and b.fecha <= t.fecha_final
  and EXTRACT(YEAR FROM t.fecha_inicio) = 2019
  and EXTRACT(YEAR FROM t.fecha_final) = 2019
  and j.id in (select w.jugador
               from (select d.jugador
                     from deck d
                              join batalla b on d.id = b.deck_win
                     group by d.jugador) as w)
group by t.nombre, j.nombre, d.jugador
order by t.nombre asc, suma_puntos desc;

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

/* Query de validacio */
select *
from arena
where arena.nombre not in (select a.nombre
                           from arena a,
                                jugador j,
                                insignia i,
                                consigue c
                           where j.experiencia > 170000
                             and c.jugador = j.id
                             and a.id = c.arena
                             and i.nombre = c.insignia
                             and c.fecha >= '2021-10-25'
                           group by a.nombre);


/* 4.5
 * Enumerar el nom de la insígnia, els noms de les cartes i el dany de les cartes dels jugadors amb una experiència
 * superior a 290.000 i obtingudes en arenes el nom de les quals comença per "A" o quan la insígnia no té imatge. Així,
 * considera només els jugadors que tenen una carta el nom de la qual comença per "Lava".
 */
select distinct i.nombre, c.nombre, c.daño
from insignia i join consigue co on i.nombre = co.insignia join jugador j on co.jugador = j.id
                join encuentra e on j.id = e.jugador join carta c on c.nombre = e.carta
                join arena a on a.id = c.arena
where (j.experiencia > 290000 and a.nombre like 'A%') or i.imagenurl is null
    and j.nombre in (select j.nombre
                     from carta c join encuentra e on c.nombre = e.carta join jugador j on e.jugador = j.id
                     where c.nombre like 'Lava%')
order by i.nombre, c.nombre, c.daño;

-- Query de validacion
select * from insignia where imagenurl is null;


/* 4.6
 * Donar el nom de les missions que donen recompenses a totes les arenes el títol de les quals comença per "t" o acaba
 * per "a". Ordena el resultat pel nom de la missió.
 */
select m.nombre as nombre_mission, a.nombre as nombre_arena
from mision as m
         join mision_arena ma on m.id = ma.mision
         join arena as a on ma.arena = a.id
where a.nombre like 'T%'
   or a.nombre like '%a'
order by m.nombre asc;


/* 4.7
 * Donar el nom de les arenes amb jugadors que al novembre o desembre de 2021 van obtenir insígnies si el nom de
 * l’arena conté la paraula "Lliga", i les arenes tenen jugadors que al 2021 van obtenir èxits el nom dels quals conté
 * la paraula "Friend".
 */
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
group by a.nombre
order by a.nombre;

/* He cambiado la palabra "Lliga" por "Legendary" para que salga algun resultado ya que ninguna arena lleva la palabra LLiga */
select a.nombre as nombre_arena
from consigue as c
         join arena a on a.id = c.arena
         join jugador j on j.id = c.jugador
         join insignia i on i.nombre = c.insignia
where a.nombre like '%Legendary%'
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
group by a.nombre
order by a.nombre;

/* 4.8
 * Retorna el nom de les cartes que pertanyen a jugadors que van completar missions el nom de les quals inclou la
 * paraula "Armer" i l'or de la missió és més gran que l'or mitjà recompensat en totes les missions de les arenes.
 */
select c.nombre as nombre_carta
from carta c
         join encuentra e on c.nombre = e.carta
         join jugador j on e.jugador = j.id
where j.id in (select j2.id
               from jugador j2
                        join realiza r on j2.id = r.jugador
                        join mision m on r.mision = m.id
                        join mision_arena ma on m.id = ma.mision
               where m.descripcion like '%Armer%'
                 and ma.recompensa_oro > (select AVG(mision_arena.recompensa_oro) as media from mision_arena)
               group by j2.id
)
group by c.nombre;