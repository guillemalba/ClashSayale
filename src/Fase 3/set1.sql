/***************** APARTADO 1 *****************/
/* 1.1
 * Enumerar el nom i el valor de dany de les cartes de tipus de tropa amb un valor de
 * velocitat d’atac superior a 100 i el nom del qual contingui el caràcter "k".
 */
select c.nombre, c.daño
from carta c join tropas t on c.nombre = t.carta
where velocidad_ataque > 100 and (c.nombre like '%k%' or c.nombre like '%K%');

--Validación

select c.nombre, c.velocidad_ataque
from carta c join tropas t on c.nombre = t.carta
order by c.velocidad_ataque desc;


/* 1.2
 * Enumerar el valor de dany mitjà, el valor de dany màxim i el valor de dany mínim de les
 * cartes èpiques.
 */
select avg(daño) as daño_medio, max(daño) as daño_max, min(daño) as daño_min
from carta
group by rareza having rareza = 'Epic';

--Query para comprobar que los valores son correctos.
select nombre, daño, rareza from carta order by daño desc;

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

--Query para comprobar que los valores son correctos.
select titulo from deck where fecha = '2021-11-01';


/* 1.5
 * Llistar les tres primeres cartes de tipus edifici (nom i dany) en funció del dany dels
 * jugadors amb experiència superior a 250.000.
 * Base de dades: 2021-2022 Projecte – Fase 3
 */
select c.nombre, c.daño
from edificio ed join carta c on c.nombre = ed.carta
join encuentra e on c.nombre = e.carta
join jugador j on e.jugador = j.id
where j.experiencia > 250000
group by c.nombre, c.daño
order by c.daño desc
limit 3;

--Query de validación
select c.nombre, c.daño, j.nombre, j.experiencia
from edificio ed join carta c on c.nombre = ed.carta
join encuentra e on c.nombre = e.carta
join jugador j on e.jugador = j.id
where j.experiencia > 250000
order by c.daño desc;


/* 1.6
 * Els dissenyadors del joc volen canviar algunes coses a les dades. El nom d'una carta
 * "Rascals" serà "Hal Roach's Rascals", la Raresa "Common" es dirà "Proletari".
 * Proporcioneu les ordres SQL per fer les modificacions sense eliminar les dades i
 * reimportar-les.
 */
--Update rareza
update carta
set rareza = 'Common'
where rareza like 'Proletari';

--Update nombre
update carta
set nombre = 'Hal Roach''s Rascals'
where nombre like 'Rascals';

update compuesto
set carta = 'Hal Roach''s Rascals'
where carta = 'Rascals';

update encuentra
set carta = 'Hal Roach''s Rascals'
where carta = 'Rascals';

update tropas
set carta = 'Hal Roach''s Rascals'
where carta = 'Rascals';

/********************************************************************/
/*****************Queries de validación pre update*******************/
/********************************************************************/
--update rareza
select *
from carta
where rareza = 'Common'
order by nombre;

--update nombre
select *
from carta
where carta.nombre = 'Rascals';

select *
from compuesto
where carta = 'Rascals'
order by deck;

select *
from encuentra
where carta = 'Rascals'
order by jugador;

select carta, daño_aparicion, 'tropas' as tipo
from tropas
where carta = 'Rascals';

/**************************************************************************/
/********************Queries de validación post update*********************/
/**************************************************************************/
--Update rareza
select *
from carta
where rareza = 'Proletari'
order by nombre;

--update nombre
select *
from carta
where carta.nombre = 'Hal Roach''s Rascals';

select *
from compuesto
where carta = 'Hal Roach''s Rascals'
order by deck;

select *
from encuentra
where carta = 'Hal Roach''s Rascals'
order by jugador;

select carta, daño_aparicion, 'Hal Roach''s Rascals' as tipo
from tropas
where carta = 'Hal Roach''s Rascals';






/* 1.7
 * Enumerar els noms de les cartes que no estan en cap pila i els noms de les cartes que
 * només estan en una pila. Per validar els resultats de la consulta, proporcioneu dues
 * consultes diferents per obtenir el mateix resultat.
 */
--Para que salga un output se tiene que ejecutar estos inserts:
insert into carta (nombre, daño, velocidad_ataque, rareza, arena)
values ('Enanos Felices', 103, 200, 'Common', 54000028);

--Creamos su relacion con el deck Cantabria goblins del jugador #YC0JJ2PV
insert into compuesto(carta, deck, nivel)
values ('Enanos Felices', 585, 5);

insert into encuentra(jugador, carta, fecha_mejora, nivel_actual)
values ('#YC0JJ2PV', 'Enanos Felices', '2021-04-04', 5);
--Al estar en un solo deck tendría que salir en el output

--Query 1
select c.nombre
from carta c left join compuesto c2 on c.nombre = c2.carta
where c2.carta is null
union
select c.nombre
from carta c join compuesto c2 on c.nombre = c2.carta
group by c.nombre having count(c2.carta) = 1;

--Query 2
select c.nombre
from carta c
where c.nombre not in (select compuesto.carta from compuesto)
union
select c.nombre
from carta c join compuesto c2 on c.nombre = c2.carta
group by c.nombre having count(c2.carta) = 1;


--Validación
select c.nombre, count(c2.carta) as Decks
from carta c left join compuesto c2 on c.nombre = c2.carta
group by c.nombre having count(c2.carta) < 2;

select distinct c.nombre from carta c left join compuesto c2 on c.nombre = c2.carta
where c2.carta is null;


/* 1.8
 * Enumera el nom i el dany de les cartes èpiques que tenen un dany superior al dany mitjà
 * de les cartes llegendàries. Ordena els resultats segons el dany de les cartes de menys
 * a més valor.
 */

select nombre, daño
from carta
where rareza = 'Epic' and daño > (select avg(daño) from carta where rareza = 'Legendary')
order by daño;

--Query de validación
select nombre, daño
from carta
where rareza = 'Epic'
order by daño;

select avg(daño) from carta where rareza = 'Legendary';