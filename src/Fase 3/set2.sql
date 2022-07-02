/***************** APARTADO 2 *****************/
/* 2.1
 * Enumera els missatges (text i data) escrits pels jugadors que tenen més experiència que
 * la mitjana dels jugadors que tenen una "A" en nom seu i pertanyen al clan "NoA". Donar
 * la llista de ordenada dels missatges més antics als més nous.
 */
select m.cuerpo, m.fecha
from jugador j join escribe e on j.id = e.id_emisor
               join mensaje m on e.id_mensaje = m.id
where j.experiencia > (
    select avg(experiencia)
    from jugador j join formado f on j.id = f.jugador
                   join clan c on f.clan = c.id
    where (j.nombre like '%a%' or j.nombre like '%A%') and c.nombre = 'NoA')
order by m.fecha;

--Consultas de validación
select j.nombre, experiencia
from jugador j join formado f on j.id = f.jugador
               join clan c on f.clan = c.id
where (j.nombre like '%a%' or j.nombre like '%A%') and  c.nombre = 'NoA';

select avg(experiencia)
from jugador j join formado f on j.id = f.jugador
               join clan c on f.clan = c.id
where (j.nombre like '%a%' or j.nombre like '%A%') and  c.nombre = 'NoA';

select j.nombre, j.experiencia, c.nombre
from jugador j join formado f on j.id = f.jugador
               join clan c on c.id = f.clan
where c.nombre = 'NoA';

select m.cuerpo, m.fecha, j.experiencia
from jugador j join escribe e on j.id = e.id_emisor
               join mensaje m on e.id_mensaje = m.id
where j.nombre = 'King Tyler'
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
where a.nombre like '%b%' or a.nombre like '%B%';

--Conslutas de veridificación
select a.nombre, a.coste_real
from compra c join jugador j on c.jugador = j.id
              join articulo a on c.articulo = a.id
              join paquete_arena pa on a.id = pa.id_paquete;

select a.nombre, a.coste_real
from compra c join jugador j on c.jugador = j.id
              join articulo a on c.articulo = a.id
              join paquete_arena pa on a.id = pa.id_paquete;

/* 2.3
 * Enumerar el nom i el nombre d’articles comprats, així com el cost total dels articles
 * comprats i l’experiència dels jugadors que els van demanar. Filtra la sortida amb els 5
 * articles en què els usuaris han gastat més diners.
 */
select a.nombre, count(c.articulo) as num_compras, a.coste_real*count(c.articulo) as coste_total, avg(j.experiencia) as experiencia
from compra c join articulo a on c.articulo = a.id
              join jugador j on c.jugador = j.id
group by a.id
order by coste_total desc
limit 5;

--Consultas de validación
select a.coste_real, j.nombre, j.experiencia
from compra c join articulo a on c.articulo = a.id
              join jugador j on c.jugador = j.id
where a.nombre = 'White Goldenrod';

/* 2.4
 * Donar els números de les targetes de crèdit que s'han utilitzat més.
 */
select t.numero_tarjeta
from compra c join tarjeta t on c.tarjeta = t.numero_tarjeta
group by t.numero_tarjeta having count(c.tarjeta) = (
    select count(c.tarjeta)
    from compra c join tarjeta t on c.tarjeta = t.numero_tarjeta
    group by t.numero_tarjeta
    order by count(c.tarjeta) desc
    limit 1);


/* 2.5
 * Donar els descomptes totals de les emoticones comprades durant l'any 2020
 */
select sum(c.descuento)
from compra c join articulo a on c.articulo = a.id
              join emoticono e on a.id = e.id_emoticono
where c.fecha between '2020-01-01' and '2020-12-31';

--Consulta de validación
select c.descuento, extract(year from c.fecha)
from compra c join articulo a on c.articulo = a.id
              join emoticono e on a.id = e.id_emoticono;


/* 2.6
 * Enumerar el nom, experiència i número de targeta de crèdit dels jugadors amb
 * experiència superior a 150.000. Filtra les targetes de crèdit que no han estat utilitzades
 * per comprar cap article. Donar dues consultes diferents per obtenir el mateix resultat.
 */

--Query 1
select j.nombre, j.experiencia, t.numero_tarjeta
from jugador j join tarjeta t on j.tarjeta = t.numero_tarjeta
               left join compra c on j.id = c.jugador
where c.jugador is null and experiencia > 150000;


--Query 2
select j.nombre, j.experiencia, t.numero_tarjeta
from jugador j join tarjeta t on j.tarjeta = t.numero_tarjeta
where j.experiencia > 150000 and t.numero_tarjeta not in (
    select distinct tarjeta
    from compra
);


--Podemos ver que solo hay un jugador que no ha comprado ningun articulo, por lo tanto
--la query anterior es correcta
select count(distinct jugador) as num_jugadores
from compra;

select numero_tarjeta
from tarjeta
    except
select tarjeta
from compra;



/* 2.7
 * Retorna el nom dels articles comprats pels jugadors que tenen més de 105 cartes o pels
 * jugadors que han escrit més de 4 missatges. Ordeneu els resultats segons el nom de
 * l'article de més a menys valor.
 */
select distinct a.nombre
from jugador j join compra c on j.id = c.jugador
               join articulo a on c.articulo = a.id
where j.id in (
    select j.id -- Jugadores con mas de 105 cartas
    from jugador j join encuentra e on j.id = e.jugador
    group by j.id having count(e.carta) > 105
    UNION
    select j.id -- Jugadores con mas de 4 mensajes escritos
    from jugador j join escribe e on j.id = e.id_emisor
    group by j.id having count(e.id_mensaje) > 4
)
order by a.nombre desc;


/*  2.8
 * Retorna els missatges (text i data) enviats a l'any 2020 entre jugadors i que hagin estat
 * respostos, o els missatges sense respostes enviats a un clan. Ordena els resultats
 * segons la data del missatge i el text del missatge de més a menys valor.
 */
select distinct j.cuerpo, j.fecha
from mensaje j join mensaje j2 on j.id = j2.idmensajerespondido
union all
select cuerpo, fecha
from mensaje_clan
where id in (
    select m.id
    from mensaje_clan m left join mensaje_clan m2 on m2.mensaje_respondido = m.id
    where m2.id is null
)
order by fecha desc, cuerpo desc;

--Validaciones primera parte
select distinct j.id, j.cuerpo, j.fecha, j2.id as Respuesta
from mensaje j join mensaje j2 on j.id = j2.idmensajerespondido;

select *
from mensaje
where idmensajerespondido = 287;

--Validaciones segunda parte
select cuerpo, fecha, id
from mensaje_clan
where id in (
    select m.id
    from mensaje_clan m left join mensaje_clan m2 on m2.mensaje_respondido = m.id
    where m2.id is null
)
order by fecha desc, cuerpo desc;

select count(id)
from mensaje_clan
where mensaje_respondido = 683;
