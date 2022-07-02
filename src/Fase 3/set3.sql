/***************** APARTADO 3 *****************/
/* 3.1
 * Llistar els clans (nom i descripció) i el nombre de jugadors que tenen una experiència
 * superior a 200.000. Filtra la sortida per tenir els clans amb més trofeus requerits.
 */
select c.nombre as clan, c.descripcion, count(f.jugador) as num_judaors_XP200000
from clan c join formado f on c.id = f.clan join jugador j on j.id = f.jugador
where j.experiencia > 200000 and c.minimo_trofeos = (select max(minimo_trofeos) from clan)
group by c.nombre, c.descripcion, c.minimo_trofeos
order by c.minimo_trofeos desc;

--1a Query de validació
select c.nombre, count(f.jugador)
from clan c join formado f on c.id = f.clan join jugador j on f.jugador = j.id
where j.experiencia > 200000
group by c.nombre;

-- 2a query de validacio
select c.nombre as clan, c.descripcion, count(f.jugador) as num_judaors_XP200000
from clan c join formado f on c.id = f.clan join jugador j on j.id = f.jugador
where j.experiencia < 200000 and c.minimo_trofeos < (select max(minimo_trofeos) from clan)
group by c.nombre, c.descripcion, c.minimo_trofeos
order by c.minimo_trofeos desc;

/* 3.2
 * Llistar els 15 jugadors amb més experiència, la seva experiència i el nom del clan que pertany
 * si el clan que ha investigat una tecnologia amb un cost superior a 1000.
 */
select distinct j.nombre, j.experiencia, c.nombre
from jugador as j join formado f on j.id = f.jugador join clan c on c.id = f.clan
                  join clan_modificador cm on c.id = cm.clan join modificador m on cm.modificador = m.nombre
                  join tecnologias t on m.nombre = t.nombre
where m.coste_oro > 1000
order by j.experiencia desc limit 15;

-- Query de validació: el mateix objectiu utilitzant un altre cami
select j.nombre
from jugador j join formado f on f.jugador = j.id
where f.clan in (select c.id
                 from tecnologias t
                          join modificador m on t.nombre = m.nombre
                          join clan_modificador cm on m.nombre = cm.modificador
                          join clan c on cm.clan = c.id
                 where m.coste_oro > 1000)
order by j.experiencia desc limit 15;

/* 3.3
 * Enumera l’identificador, la data d'inici i la durada de les batalles que van començar després del "01-01-2021" i en
 * què van participar clans amb trofeus mínims superiors a 6900. Donar només 5 batalles amb la major durada.
 */
select b.id, b.fecha, b.durada
from batalla as b join batalla_clan bc on bc.id = b.batalla_clan
                  join pelea p on bc.id = p.batalla_clan join clan c on c.id = p.clan
where b.fecha > '01-01-2021' and c.minimo_trofeos > 6900
group by b.id, b.fecha, b.durada
order by durada desc limit 5;

-- Query de validacio: batalles abans de la data
select b.id, b.fecha, b.durada
from batalla as b join batalla_clan bc on bc.id = b.batalla_clan
                  join pelea p on bc.id = p.batalla_clan join clan c on c.id = p.clan
where b.fecha < '01-01-2021' and c.minimo_trofeos > 6900
group by b.id, b.fecha, b.durada
order by durada desc limit 5;


/* 3.4
 * Enumera per a cada clan el nombre d'estructures i el cost total d'or. Considera les estructures creades a l'any 2020
 * i amb trofeus mínims superiors a 1200. Donar només la informació dels clans que tinguin més de 2 estructures.
 */
select c.nombre as nombre2, count(e.nombre) as nombre_estructuras, sum(m.coste_oro) as coste_total_oro
from clan as c left join clan_modificador cm on c.id = cm.clan
               join modificador m on cm.modificador = m.nombre join estructura e on m.nombre = e.nombre
where cm.fecha >= '01-01-2020' and cm.fecha <= '31-12-2020' and c.minimo_trofeos > 1200
group by c.nombre having count(e.nombre) > 2;

-- Query de validacio
select c.nombre as nombre2, count(e.nombre) as nombre_estructuras, sum(m.coste_oro) as coste_total_oro
from clan as c left join clan_modificador cm on c.id = cm.clan
               join modificador m on cm.modificador = m.nombre join estructura e on m.nombre = e.nombre
group by c.nombre;


/* 3.5
 * Enumera el nom dels clans, la descripció i els trofeus mínims ordenat de menor a major nivell de trofeus mínims per
 * als clans amb jugadors que tinguin més de 200.000 d’experiència i el rol co-líder.
 */
select distinct c.nombre, c.descripcion, c.minimo_trofeos
from clan c join formado f on c.id = f.clan join jugador j on j.id = f.jugador
where j.experiencia > 200000 and f.role LIKE 'coLeader%'
order by c.minimo_trofeos asc;

-- Query de validació
select distinct c.nombre, c.descripcion, c.minimo_trofeos
from clan c join (select distinct f.clan, f.jugador
                  from formado f join jugador j on f.jugador = j.id
                  where role like 'coLeader%' and j.experiencia > 200000) as Q1 on q1.clan = c.id
order by c.minimo_trofeos asc;

/* 3.6
 * Necessitem canviar algunes dades a la base de dades. Hem d'incrementar un 25% el cost de les tecnologies que
 * utilitzen els clans amb trofeus mínims superiors a la mitjana de trofeus mínims de tots els clans.
 */

    -- Select 1 de validació
    select m.nombre, m.coste_oro
    from tecnologias t left join modificador m on t.nombre = m.nombre
                       join clan_modificador cm on m.nombre = cm.modificador
    where cm.clan in (
        select id
        from clan
        where minimo_trofeos > (select avg(minimo_trofeos) from clan)
    )
    group by m.nombre, m.coste_oro;

-- Main answer
update modificador
set coste_oro = coste_oro + coste_oro*0.25
where nombre in (
    select m.nombre
    from tecnologias t left join modificador m on t.nombre = m.nombre
                       join clan_modificador cm on m.nombre = cm.modificador
    where cm.clan in (
        select id
        from clan
        where minimo_trofeos > (select avg(minimo_trofeos) from clan)
    )
    group by m.nombre
);

    -- Select de validació
    select m.nombre, m.coste_oro
    from tecnologias t left join modificador m on t.nombre = m.nombre
                       join clan_modificador cm on m.nombre = cm.modificador
    where cm.clan in (
        select id
        from clan
        where minimo_trofeos > (select avg(minimo_trofeos) from clan)
    )
    group by m.nombre, m.coste_oro;

/* 3.7
 * Enumerar el nom i la descripció de la tecnologia utilitzada pels clans que tenen una estructura "Monument"
 * construïda després del "01-01-2021". Ordena les dades segons el nom i la descripció de les tecnologies.
 */
select distinct t.nombre, m.descripcion
from tecnologias t join modificador m on t.nombre = m.nombre
                   join clan_modificador cm on m.nombre = cm.modificador
                   join clan c on cm.clan = c.id
where c.nombre in (
    select c2.nombre
    from clan c2 join clan_modificador cm2 on c2.id = cm2.clan
                 join modificador m2 on cm2.modificador = m2.nombre
                 join estructura e2 on m2.nombre = e2.nombre
    where e2.nombre like 'Monument' and cm2.fecha > '01-01-2021'
)
order by t.nombre, m.descripcion;


-- Afegim una estrctura nova
insert into modificador(nombre, coste_oro, descripcion, daño, vel_ataque, daño_aparicion, radio, vida, dependencia)
values ('#newTech', 320, '5.7 validation', 2,4, null, 2, 1, null);

insert into tecnologias(nombre, nivel_max, dep_level)
VALUES ('#newTech', 4, 5);

insert into clan(id, nombre, descripcion, trofeos_totales, minimo_trofeos, puntuacion)
values ('#036ABCD', 'New Tech Clan', 'Goal: 3.7 validation (Chuck Norris)', 2780, 2700, 89000);

insert into clan_modificador(clan, modificador, nivel, fecha)
values ('#036ABCD', 'Monument', 6, '02-01-2021');

insert into clan_modificador(clan, modificador, nivel, fecha)
values ('#036ABCD', '#newTech', 7, '02-01-2021');

/* 3.8
 * Enumera els clans amb un mínim de trofeus superior a 6900 i que hagin participat a totes les batalles de clans.
 */

--Query del enunciado
select c.nombre
from clan c join pelea p on p.clan = c.id join batalla_clan bc on bc.id = p.batalla_clan
where c.minimo_trofeos > 6900
group by c.id, c.nombre having count(distinct bc.id) = (select count(distinct id) from batalla_clan);

--Añadimos el clan
insert into clan(id, nombre, descripcion, trofeos_totales, minimo_trofeos, puntuacion)
values ('#JDI23H9S', 'La Salle', 'Este es el clan de los estudiantes de la salle.', 20, 7000, 6800);

--Añdadimos todas sus batallas
insert into pelea (batalla_clan, clan, fecha_inicio, fecha_fin)
select id, '#JDI23H9S', '2019-02-21', '2021-12-31' from batalla_clan;

--Query del enunciado
select c.nombre
from clan c join pelea p on p.clan = c.id join batalla_clan bc on bc.id = p.batalla_clan
where c.minimo_trofeos > 6900
group by c.id, c.nombre having count(distinct bc.id) = (select count(distinct id) from batalla_clan);