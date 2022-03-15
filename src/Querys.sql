/**********************************************************************************************************/
/************************************* QUERIES DE PRUEBA **************************************************/
/**********************************************************************************************************/

-- 1) Muestra el articulo mas comprado de la tienda
select a2.nombre, a2.coste_real, count(c2.id) as num_compras
from Articulo as a2 join compra as c2 on a2.id = c2.articulo
group by a2.id having count(c2.id) = (select count(c.id) from articulo as a
                                        join compra as c on a.id = c.articulo
group by a.id order by count(c.id) desc limit 1)
order by count(c2.id) desc;



-- 2) Muestra el nombre de los 10 primeros jugadores que haya participado en mas temporadas,

select count(p.temporada) as num_temp,p.jugador,j.nombre
from participa as p join jugador as j on p.jugador = j.id
group by j.nombre,p.jugador
order by num_temp desc,jugador
limit 10;


/*******************************************CARTAS*****************************************/

-- 1) Muestra el nombre, el daño, el daño de aparición y su arena, de la carta del tipo tropa
--    que sea Legendary, y que tenga el mayor daño y daño de aparición en ese orden.
select c.nombre as nombre, c.daño as daño, t.daño_aparicion as dañoAparicion, c.arena
from carta as c join tropas as t on c.id = t.carta
where c.rareza like 'Legendary'
group by c.nombre,daño,c.arena,t.daño_aparicion order by c.daño desc,t.daño_aparicion desc ;

-- 2) Muestra las 5 cartas mas usadas en los decks y su nivel
select c.nombre as nombre, count(co.carta) as num_veces, co.nivel as nivel
from carta as c join compuesto co on c.id = co.carta
group by c.nombre, co.nivel order by num_veces desc limit 5;


-- 3) Muestra las 5 carta que mas jugadores han encontrado en el año 2020

select c.nombre as nombre, count(e.carta) as num_cartas
from carta as c join encuentra e on c.id = e.carta and e.fecha_mejora between '2020-01-01' and '2020-12-31'
group by c.nombre order by num_cartas desc limit 5;

-- 4) Muestra nombre y el daño de las cartas del tipo edificio que sea epica o legendaria y tenga mas vida,
--    ordenadas por vida
select c.nombre as nombre, c.daño as daño, e.vida as vida
from carta as c join edificio as e on c.id = e.carta
where c.rareza like 'Legendary' or c.rareza like 'Epic'
group by c.nombre,daño,e.vida order by e.vida desc;



/*********************************************CLAN***********************************************************/

-- 1) Muestra el nombre y el daño de los 5 modificadores con mas daño, que sea estructura, que no depende de ningun
-- otro modificador y que tenga almenos 1100 trofeos.
select m.nombre, m.daño
from modificador as m join estructura as e on m.nombre = e.nombre
where m.dependencia is null  and m.daño is not null and e.trofeos > 1100
order by m.daño desc limit 5;

-- 2) Muestra los 5 clanes con mayor cantidad y numero de donaciones durante el mes de noviembre del 2021
select c.nombre as nombre, sum(d.oro) cantidad_oro, count(d.id) as num_donaciones
from clan as c join dona d on c.id = d.clan and d.fecha between '2021-10-01' and '2021-10-31'
group by c.nombre order by cantidad_oro desc limit 5;


-- 3) Muestra los 5 clanes que han obtenido mas insignias
select c.nombre as nombre, count(a.clan) as num_insignias
from clan as c join adquiere a on c.id = a.clan
group by c.nombre order by num_insignias desc limit 5;

-- 4) Muestra los clanes donde se han escrito mas mensajes
select c.nombre as nombre, count(mc.receptor) as num_mensajes
from clan as c join mensaje_clan as mc on c.id = mc.receptor
group by c.nombre order by num_mensajes desc limit 5;

/*************************************************JUGADORES*************************************************/

-- 1) Encuentra el jugador que mas solicitudes de amistad ha enviado
select j.id, j.nombre, j.experiencia,j.trofeos, count(a.id_jugador_emisor) as num_solicitudes
from jugador as j join amigo a on j.id = a.id_jugador_emisor
group by j.id, j.nombre, j.experiencia,j.trofeos
order by count(a.id_jugador_emisor) desc
limit 5;

-- 2) Encuentra todos los jugadores que han recibido una solicitud de amistad de "Alireza"
select j.id
from jugador as j join amigo a on j.id = a.id_jugador_receptor
                  join jugador as j2 on a.id_jugador_emisor = j2.id
where j2.nombre = 'Alireza';

-- 3) Top 10 jugadores que han respondido a más mensajes
select j.id, j.nombre, count(m.id) as num_repuestas
from jugador as j join escribe as e on j.id = e.id_emisor
                  join mensaje as m on e.id_mensaje = m.id
where m.idmensajerespondido is not null
group by j.id, j.nombre
order by count(m.id) desc
limit 10;

/************************************************BATALLAS******************************************************/

-- 1) Top 10 clanes que han ganado mas batallas contra otro clan
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

-- 2) Musetra los clanes con más jugadores
select c.nombre as clan, count(distinct f.jugador) as num_players
from clan as c join formado as f on c.id = f.clan
group by c.nombre
order by count(distinct f.jugador) desc;

-- 3) Muestra el top 10 jugadores que hayan ganado mas batallas de clan y el clan al que pertenecen
select j.id, j.nombre as jugador, count(distinct b.id), c.nombre as clan
from jugador as j join deck as d on j.id = d.jugador
                  join batalla as b on d.id = b.deck_win
                  join formado as f on j.id = f.jugador
                  join clan as c on f.clan = c.id
where b.batalla_clan is  not null
group by j.id, j.nombre, c.nombre
order by count(b.id) desc
limit 20;


/*********************************************TIENDA***************************************************/

-- 1) Muestra top 10 jugadores que han comprado mas articulos y cuanto dinero se han gastado
select j.nombre, count(c.id) as num_compras, sum(a.coste_real) as dinero_total
from jugador as j join compra as c on j.id = c.jugador
                  join articulo as a on c.articulo = a.id
group by j.nombre
order by count(c.id) desc
limit 10;

-- 2) Muestra los 10 jugadores que mas han ahorrado con descuentos
select j.nombre as jugador, sum(c.descuento)
from jugador as j join compra as c on j.id = c.jugador
group by j.nombre
order by sum(c.descuento) desc
limit 10;

-- 3) Muestra top 5 jugadores que  han comprado mas articulos de cada tipo
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

/*********************************************MISIONES**********************************************/
-- 1) Encuentra el top 10 jugadores que mas misiones han hecho
select j.nombre, count(r.id) as num_misiones
from jugador as j join realiza as r on j.id = r.jugador
group by j.nombre
order by num_misiones desc
limit 10;

-- 2) Encuentra el jugador que mas dinero ha ganado con misiones
select j.nombre, sum(ma.recompensa_oro) as dinero
from jugador as j join realiza as r on j.id = r.jugador
                  join mision as m on r.mision = m.id
                  join mision_arena ma on m.id = ma.mision
group by j.nombre
order by dinero desc
limit 10;

-- 3) Encuentra aquellos jugadores que hayan realizado una mision y desbloqueado un logro en un mismo dia
-- de 2021
select distinct (j.nombre) as jugador, r.fecha as mision, d.fecha as logro
from jugador as j join realiza as r on j.id = r.jugador
                  join mision m on r.mision = m.id join mision_arena as ma on m.id = ma.mision
                  join desbloquea as d on j.id = d.jugador join logro as l on d.id_logro = l.id
where r.fecha = d.fecha and r.fecha > '2021-01-01'
order by r.fecha desc;

/**********************************************Logros*******************************************************/
-- 1) Encuentra el top 10 jugador que mas logros ha conseguido y cuantas gemas ha conseguido con ellos
select j.nombre, sum(l.recompensa_gemas) as gemas_ganadas, count(d.jugador) as num_logros
from jugador as j join desbloquea d on j.id = d.jugador
                  join logro l on d.id_logro = l.id
group by j.nombre order by num_logros desc, gemas_ganadas desc limit 10;

-- 2) Encuentra los 5 jugadores con nombre no complejo que hayan desbloqueado el logro 'Team Player' en la arena
-- 'ArenaClanWars1 - Clan War Arena'
select distinct (j.nombre), a.nombre, l.nombre
from jugador as j join desbloquea d on j.id = d.jugador join logro l on l.id = d.id_logro
join arena a on d.arena = a.id
where l.nombre like 'Team Player' and j.nombre not like '% %'
  and a.nombre like '%ArenaClanWars1 - Clan War Arena%'
order by j.nombre desc limit 5;


/**********************************************Arena**********************************************************/
-- 1) Encuentra las 5 Arenas en las que se han conseguido mas logros
select a.nombre, count(d.arena) as num_logros
from arena as a join desbloquea d on a.id = d.arena
Group By a.nombre order by num_logros desc limit 5;

-- 2) Encuentra las 5 Arenas en las que se han conseguido mas insignias en 2021
select a.nombre, count(c.arena) as num_insignias
from arena as a join consigue c on a.id = c.arena join insignia i on c.insignia = i.nombre
    and  c.fecha between '2021-01-01' and '2021-12-31'
group by a.nombre order by num_insignias desc limit 5;

-- 3) Que 5 arenas han generado mas oro con los cofres y la arena tenga minimo 3000 copas
select a.nombre, sum(na.oro) as cantidad_oro
from arena as a join nivel_arena na on a.id = na.arena
    and a.min_trofeos >= 3000
group by a.nombre order by cantidad_oro desc limit 5;

-- 4) En que 5 arenas puedes hacer mas misiones y generar mas dinero?
select a.nombre, count(ma.arena) as num_misiones, sum(ma.recompensa_oro) as cantidad_oro
from arena as a join mision_arena ma on a.id = ma.arena
group by a.nombre order by num_misiones desc, cantidad_oro desc limit 5;




