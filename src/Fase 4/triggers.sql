/*
 * 1.1) Proporcions de rareses
 */

drop trigger if exists rarity_proportions_warning on carta;

drop function if exists proportions_rarity;
create or replace function proportions_rarity() returns trigger as $$
begin

    --Proporciones Common
    if ((((select count(distinct nombre) from carta where rareza = 'Common')*100)/(select count(distinct nombre) from carta)) <> 31) then
        insert into warnings(affected_table, error_mesage,date, usr)
        values('Carta', 'Proporcions de raresa no respectades: ' || 'Common' || ' la proporció actual és '||
                    (((select count(distinct nombre) from carta where rareza = 'Common')*100)/(select count(distinct nombre) from carta))
                    ||'% quan hauria de ser ' || 31 || '%', current_date, user);
    end if;

    --Proporciones Rare
    if ((((select count(distinct nombre) from carta where rareza = 'Rare')*100)/(select count(distinct nombre) from carta)) <> 26) then
        insert into warnings(affected_table, error_mesage,date, usr)
        values('Carta', 'Proporcions de raresa no respectades: ' || 'Rare' || ' la proporció actual és '||
                        (((select count(distinct nombre) from carta where rareza = 'Rare')*100)/(select count(distinct nombre) from carta))
                            ||'% quan hauria de ser ' || 26 || '%', current_date, user);
    end if;

    --Proporciones Epic
    if ((((select count(distinct nombre) from carta where rareza = 'Epic')*100)/(select count(distinct nombre) from carta)) <> 23) then
        insert into warnings(affected_table, error_mesage,date, usr)
        values('Carta', 'Proporcions de raresa no respectades: ' || 'Epic' || ' la proporció actual és '||
                    (((select count(distinct nombre) from carta where rareza = 'Epic')*100)/(select count(distinct nombre) from carta))
                    ||'% quan hauria de ser ' || 23 || '%', current_date, user);
    end if;

    --Proporciones Legendary
    if ((((select count(distinct nombre) from carta where rareza = 'Legendary')*100)/(select count(distinct nombre) from carta)) <> 17) then
        insert into warnings(affected_table, error_mesage,date, usr)
        values('Carta', 'Proporcions de raresa no respectades: ' || 'Legendary' || ' la proporció actual és '||
                    (((select count(distinct nombre) from carta where rareza = 'Legendary')*100)/(select count(distinct nombre) from carta))
                    ||'% quan hauria de ser ' || 17 || '%', current_date, user);
    end if;

    --Proporciones Champion
    if ((((select count(distinct nombre) from carta where rareza = 'Champion')*100)/(select count(distinct nombre) from carta)) <> 3) then
        insert into warnings(affected_table, error_mesage,date, usr)
        values('Carta', 'Proporcions de raresa no respectades: ' || 'Champion' || ' la proporció actual és '||
                    (((select count(distinct nombre) from carta where rareza = 'Champion')*100)/(select count(distinct nombre) from carta))
                    ||'% quan hauria de ser ' || 3 || '%', current_date, user);
    end if;
    return null;
end;
$$ language plpgsql;

create trigger rarity_proportions_warning after insert on carta
for each row
execute function proportions_rarity();



--Para obtener inicialmente las cartas que queremos tenemos que añadir cartas de cada rareza.
--Epic + 2 cartas
update carta
set rareza = 'Epic'
where nombre in (select nombre from carta where rareza is null limit 2);

--Common +9
update carta
set rareza = 'Common'
where rareza is null;

--Rare +6
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Carta1', 100, 100, 'Rare');

insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Carta2', 100, 100, 'Rare');

insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Carta3', 100, 100, 'Rare');

insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Carta4', 100, 100, 'Rare');

insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Carta5', 100, 100, 'Rare');

insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Carta6', 100, 100, 'Rare');

--Legendary +4
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('CartaLeng1', 100, 100, 'Legendary');

insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('CartaLeng2', 100, 100, 'Legendary');

insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('CartaLeng3', 100, 100, 'Legendary');

insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('CartaLeng4', 100, 100, 'Legendary');

--Champion +1
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('CartaChamp1', 100, 100, 'Champion');


/* RUEBAS */
--Porcentajes de cada rareza
select 'Common' as rareza , ((select count(distinct nombre) from carta where rareza = 'Common')*100)/count(distinct nombre) as porcentaje
from carta
union
select 'Rare' as rareza , ((select count(distinct nombre) from carta where rareza = 'Rare')*100)/count(distinct nombre) as porcentaje
from carta
union
select 'Legendary' as rareza , ((select count(distinct nombre) from carta where rareza = 'Legendary')*100)/count(distinct nombre) as porcentaje
from carta
union
select 'Epic' as rareza , ((select count(distinct nombre) from carta where rareza = 'Epic')*100)/count(distinct nombre) as porcentaje
from carta
union
select 'Champion' as rareza , ((select count(distinct nombre) from carta where rareza = 'Champion')*100)/count(distinct nombre) as porcentaje
from carta;

--Foto 1
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Añadida1', 100, 100, 'Epic');

--Foto 2
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Añadida2', 100, 100, 'Rare');

--Foto 3
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Añadida3', 100, 100, 'Legendary');

--Foto 4
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Añadida4', 100, 100, 'Common');

--Foto 5
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Añadida5', 100, 100, 'Epica');

--Foto 6
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Añadida6', 100, 100, 'Epica');

--Foto 7
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Añadida7', 100, 100, 'Champion');

delete from carta where nombre = 'Añadida1' or nombre = 'Añadida2' or nombre = 'Añadida3' or nombre = 'Añadida4' or nombre = 'Añadida5' or nombre = 'Añadida6' or nombre = 'Añadida7';



/*
 * 1.2) Regal d'actualització de cartes
 */
drop trigger if exists card_actualization_gift on encuentra;

drop function if exists actualization_gift;
create or replace function actualization_gift() returns trigger as $$
begin
    update encuentra
    set nivel_actual = 14
    where carta = new.carta and jugador = new.jugador;
    return null;
end;
$$ language plpgsql;

create trigger card_actualization_gift after insert on encuentra
for each row
execute function actualization_gift();


--Consultas e insert de prueba
insert into encuentra (jugador, carta, fecha_mejora, nivel_actual)
values('#VQJ9UUP','Gus',current_date,1);

select e.jugador, e.carta, e.fecha_mejora, e.nivel_actual from encuentra e
where jugador = '#VQJ9UUP' and carta = 'Gus';

delete from encuentra where jugador = '#VQJ9UUP' and carta = 'Gus';


/*
 * 1.3) Targetes OP que necessiten revisió
 */
drop trigger if exists OPCard_trigger on batalla;

drop function if exists OPCard_function;
create or replace function OPCard_function() returns trigger as $$
begin
    --Insertamos todos las cartas que superen el porcentaje de victorias en la lista sin repeticiones.
    insert into OPCardBlackList (nombre, entering_date)
    select distinct c3.nombre, current_date
    from carta c3 join compuesto co on c3.nombre = co.carta
    join deck d on co.deck = d.id
    where (d.id = new.deck_win) or (d.id = new.deck_win)
    group by c3.nombre having (((select count(b.id) as Num_victorias
                                from batalla b join deck d on b.deck_win = d.id
                                join compuesto c on d.id = c.deck
                                join carta ca on ca.nombre = c.carta
                                group by ca.nombre having ca.nombre = c3.nombre
                                )*100)/(
                                select count(b.id) as Num_partidas
                                from batalla b join deck d on b.deck_win = d.id or b.deck_lose = d.id
                                join compuesto c on d.id = c.deck
                                join carta ca on ca.nombre = c.carta
                                group by ca.nombre having ca.nombre = c3.nombre)) > 90
    on conflict (nombre)
    do nothing;

    --Miramos si las cartas repetidas llevan más de una semana en la lista negra
    update carta set daño = daño - (daño*0.01), velocidad_ataque = velocidad_ataque - (velocidad_ataque*0.01)
    where nombre in (select distinct c3.nombre
                     from carta c3 join compuesto co on c3.nombre = co.carta
                     join deck d on co.deck = d.id
                     where (d.id = new.deck_win) or (d.id = new.deck_win)
                     group by c3.nombre having (((select count(b.id) as Num_victorias
                                                 from batalla b join deck d on b.deck_win = d.id
                                                 join compuesto c on d.id = c.deck
                                                 join carta ca on ca.nombre = c.carta
                                                 group by ca.nombre having ca.nombre = c3.nombre
                                                 )*100)/(
                                                 select count(b.id) as Num_partidas
                                                 from batalla b join deck d on b.deck_win = d.id or b.deck_lose = d.id
                                                 join compuesto c on d.id = c.deck
                                                 join carta ca on ca.nombre = c.carta
                                                 group by ca.nombre having ca.nombre = c3.nombre)) > 50

                     intersect

                     select nombre
                     from opcardblacklist
                     where ((extract(EPOCH from current_timestamp) - extract(EPOCH from entering_date))/86400) >= 7
    );

    return null;
end;
$$ language plpgsql;

create trigger OPCard_trigger after insert on batalla
    for each row
execute function OPCard_function();


/*******************************************************************************************
 *
 ******************** PRUEBAS PARA VER SI FUNCIONA LA CONSULTA *****************************
 *
 ******************************************************************************************/

-- Creamos un nuevo deck con la carta Gus para que tengan un porcentaje mayor que
-- 90 de victorias. También veremos las características iniciales de la carta.
insert into deck (id) values (100);
insert into compuesto (carta, deck) values ('Gus', 100);
select * from carta where nombre = 'Gus';


-- Con esté insert creamos una nueva battalla en la que participa como deck ganador
-- el deck anterior, veremos que aparece la carta de gus en la blackList.
insert into batalla(id, deck_win, deck_lose)
values (9999, 100, 101);


-- Insertamos otra batalla y vemos que no cambia los datos de la carta porque no hace
-- mas de semana que está en la lista.
insert into batalla(id, deck_win, deck_lose)
values (10000, 100, 101);
select * from carta where nombre = 'Gus';

-- Ahora modificamos la tabla para que parezca que la carta lleva mas de una semana en
-- la lista y volvemos a añadir otra batalla para ver si cambian sus carcterísticas.
update opcardblacklist set entering_date = '2022-06-7' where nombre = 'Gus';
insert into batalla(id, deck_win, deck_lose) values (10001, 100, 101);
select * from carta where nombre = 'Gus';


delete from batalla where id = 9999;
delete from batalla where id = 10000;
delete from batalla where id = 10001;
update carta set daño = 103, velocidad_ataque = 200 where nombre = 'Gus';
delete from compuesto where carta = 'Gus' and deck = 100;
delete from deck where id = 100;


/*
* 2.1) Actualitza les compres dels jugadors
*/

--Ahora mismo solo suma cuando compras paquete de oferta
drop function if exists actualiza_compra();
create or replace function actualiza_compra() returns trigger as $$
begin
    if(new.articulo = Any(select id_p_oferta from paquete_oferta) ) then
        update jugador
        set gemas = gemas + (select po.gemas_contenido
            from paquete_oferta as po
            where po.id_p_oferta = new.articulo)
        where jugador.id = new.jugador;

        update jugador
        set oro = oro + (select po.oro_contenido
            from paquete_oferta as po
            where po.id_p_oferta = new.articulo)
        where jugador.id = new.jugador;
    end if;

    if(new.articulo = Any(select id_paquete from paquete_arena)) then
        update jugador
        set oro = oro + (select n.oro from nivel_arena as n
                                               join paquete_arena pa on pa.id_paquete = n.paquete
                                               join articulo a on a.id = pa.id_paquete
                                                where pa.id_paquete = new.articulo and n.arena = (select d2.arena
                                                                 from desbloquea as d2
                                                                          join jugador j2 on d2.jugador = j2.id
                                                                 where jugador = new.jugador and d2.fecha = (select Max(fecha)
                                                                                                              from desbloquea where jugador = new.jugador)))
        where jugador.id = new.jugador;
    end if;

    return null;
end
$$ language plpgsql;

drop trigger if exists update_player_items on compra;
create trigger update_player_items after insert on compra
    for each row
execute procedure actualiza_compra();




--Tornar a ficar la pasta y las gemas al jugador de proves
update  jugador set oro = 310498, gemas = 78625 where id = '#202C2CU0U';


--Treiem el or i les gemes del jugador abans
select * from jugador where id = '#202C2CU0U';

--Fem insert d'un jugador que compra un paqquet d'oferta(es sumen 65701 d'or y 10 gemes)
insert  into compra(jugador, tarjeta, articulo, fecha, descuento)
values ('#202C2CU0U',626381901632479,83,'2022-06-13',12.64);

--Fem insert d'un paquet d'arena(es sumen 8377 d'or)
insert  into compra(jugador, tarjeta, articulo, fecha, descuento)
values ('#202C2CU0U',626381901632479,4,'2022-06-13',12.64);


--Fem insert d'un article que no ens dona ni or ni gemes (no canvia res)
insert  into compra(jugador, tarjeta, articulo, fecha, descuento)
values ('#202C2CU0U',626381901632479,80,'2022-06-13',12.64);

--Tornem a treure l'or i les gemes del jugador per veure la diferencia
select * from jugador where id = '#202C2CU0U';


/*
* 4.1) Completar una missió
*/




/*
* 2.3) Final de temporada
*/
drop function if exists finalitza_temporada;
create or replace function finalitza_temporada() returns trigger as $$
begin
    --select * from temporada where fecha_final = ((select fecha_inicio from temporada where fecha_final = new.fecha_inicio) - INTERVAL '1 DAY');

    select * from

    insert into ranking (player, trophies, arena)
    values ((select temporada.nombre from temporada where fecha_final = ((select fecha_inicio from temporada where fecha_final = new.fecha_final) - INTERVAL '1 DAY')), 10000, 'yay');

    return null;
end;
$$ language plpgsql;

drop trigger if exists update_ranking on temporada;
create trigger update_ranking after insert on temporada
    for each row
execute function finalitza_temporada();


delete from temporada where nombre = 't11';
delete from ranking where arena = 'yay';

insert into temporada (nombre, fecha_inicio, fecha_final)
VALUES ('t11', '2022-01-01', '2022-12-31');

select temporada.nombre from temporada where fecha_final = ((select fecha_inicio from temporada where fecha_final = '2022-01-01') - INTERVAL '1 DAY');



(select temporada.nombre from temporada where fecha_final = ((select fecha_inicio from temporada where fecha_final = new.fecha_inicio) - INTERVAL '1 DAY'));


select * from temporada where fecha_final = (SELECT (select fecha_inicio from temporada where fecha_final = new.fecha_inicio) - INTERVAL '1 DAY');
select * from temporada where fecha_final = (SELECT (select fecha_inicio from temporada where nombre = 'T10') - INTERVAL '1 DAY');

select * from temporada order by fecha_final desc;
select * from ranking;

SELECT (select fecha_inicio from temporada where fecha_final = '2021-12-31') - INTERVAL '1 DAY';



select players.tag, sum(batalla.puntos_win)
from batalla, players, deck
where batalla.fecha between '2021-09-01' and '2021-12-31'
  and players.tag = '#28CVU99UQ'
  and deck.id = batalla.deck_win
  and deck.jugador = players.tag
group by players.tag;

select batalla.id, players.tag, batalla.puntos_win from batalla
    join deck on batalla.deck_win = deck.id or batalla.deck_lose = deck.id
    --join deck on batalla.deck_lose = deck.id
    join players on deck.jugador = players.tag
where batalla.fecha between '2021-09-01' and '2021-12-31' and players.tag = '#28CVU99UQ'
group by batalla.id, players.tag
order by players.tag;

select players.tag, sum(batalla.puntos_win)
from batalla
         join deck on batalla.deck_win = deck.id-- or batalla.deck_lose = deck.id
--join deck on batalla.deck_lose = deck.id
         join players on deck.jugador = players.tag
where batalla.fecha between '2021-09-01' and '2021-12-31'
  and players.tag = '#28CVU99UQ'
group by players.tag;

select players.tag, sum(batalla.puntos_lose)
from batalla
         join deck on batalla.deck_lose = deck.id
         join players on deck.jugador = players.tag
where batalla.fecha between '2021-09-01' and '2021-12-31'
  and players.tag = '#28CVU99UQ'
group by players.tag;

insert into ranking(player, trophies, arena)
select p.tag, SUM(wins_and_loses) as total_trophies, 'hehe'
from (
         /* suma todos los trofeos de las victorias */
         select players.tag, sum(batalla.puntos_win) as wins_and_loses
         from batalla
                  join deck on batalla.deck_win = deck.id
                  join players on deck.jugador = players.tag
         where batalla.fecha between '2021-09-01' and '2021-12-31'
           and players.tag = '#28CVU99UQ'
         group by players.tag
         union all
         /* resta todos los trofeos de las derrotas */
         select players.tag, sum(batalla.puntos_lose) as wins_and_loses
         from batalla
                  join deck on batalla.deck_lose = deck.id
                  join players on deck.jugador = players.tag
         where batalla.fecha between '2021-09-01' and '2021-12-31'
           and players.tag = '#28CVU99UQ'
         group by players.tag
     ) p
group by p.tag;

select * from players;
select * from compuesto;
select * from carta;
select * from deck;
select * from batalla where id = 8059;


/*
* 4.2) Batalla amb jugadors
*/
drop function if exists actualiza_batalla;
create or replace function actualiza_batalla() returns trigger as $$
begin
    update jugador
    set trofeos = trofeos + new.puntos_win
    where jugador.id in (
        select deck.jugador
        from deck, batalla
        where deck.id = batalla.deck_win
            and new.id = batalla.id
        );
    update jugador
    set trofeos = trofeos + new.puntos_lose
    where jugador.id in (
        select deck.jugador
        from deck, batalla
        where deck.id = batalla.deck_lose
            and new.id = batalla.id
    );
    return null;
end;
$$ language plpgsql;

drop trigger if exists update_player_trophies on batalla;
create trigger update_player_trophies after insert on batalla
    for each row
execute function actualiza_batalla();

/* Validacions */
insert into batalla(id, deck_win, deck_lose, fecha, durada, puntos_win, puntos_lose, batalla_clan)
values (99999, 103, 102, '2024-02-14', '09:50:50', 10000, -10000, null);

select jugador.id, jugador.nombre, jugador.trofeos from jugador
where id = '#9Q8UCU0Q0'
   or id = '#QV2PYL';

delete from batalla
where fecha = '2024-02-14';


/*
* 4.3) Corrupció de dades
*/
drop function if exists corrupcio_dades;
create or replace function corrupcio_dades() returns trigger as $$
begin

    if (new.clan not in
        (select clan.id
         from clan)
        ) then
        insert into warnings(affected_table, error_mesage, date, usr)
        values ('Dona', 'Jugador '|| new.jugador || ': Intent de donar ' || new.oro || ' de or a un clan anomenat ' || new.clan || ' que no existeix',
                current_date, user);
        return null;
    end if;

    if (new.jugador not in
        (
            select players.tag
            from players
                     join formado on formado.jugador = players.tag
                     join clan on formado.clan = clan.id)
        ) then
        insert into warnings(affected_table, error_mesage, date, usr)
        values ('Dona', 'Jugador '|| new.jugador || ': Intent de donar ' || new.oro || ' de or a ' || new.clan || ' sense pertanyer al clan',
                current_date, user);
        return null;
    end if;

    if (new.oro is null or new.oro < 1)
    then
        insert into warnings(affected_table, error_mesage, date, usr)
        values ('Dona', 'Jugador '|| new.jugador || ': Intent de donar or amb valor "null" o "0". Or ha de ser un valor mes gran que 0.',
                current_date, user);
        return null;
    end if;

    return new;
end;
$$ language plpgsql;

drop trigger if exists player_donation_warning on dona;
create trigger player_donation_warning before insert or update on dona
    for each row
execute function corrupcio_dades();

truncate warnings;

insert into players(tag, name, experience, trophies, cardnumber, cardexpiry)
values ('#MYTAG', 'Bartolo', 100000, 20000, 20202002, '2030-01-01');

insert into dona(clan, jugador, oro, fecha)
values ('#MYCLAN', '#MYTAG', 10, '2022-08-08');

insert into dona(clan, jugador, oro, fecha)
values ('#9GUCJRL0', '#MYTAG', 20, '2022-08-08');

insert into dona(clan, jugador, oro, fecha)
values ('#9GUCJRL0', '#CGJ8JRCR', null, '2022-08-08');

insert into dona(clan, jugador, oro, fecha)
values ('#9GUCJRL0', '#CGJ8JRCR', 0, '2022-08-08');

update dona
set oro = null
where dona.id = 5400;

select *
from warnings;


select * from clan;

select *
from players
where players.tag = '#MYTAG';

delete from players
    where tag = '#MYTAG';

insert into players(tag, name, experience, trophies, cardnumber, cardexpiry)
values ('#MYTAG', 'Bartolo', 100000, 20000, 20202002, '2030-01-01');

select players.tag from players
    join formado on formado.jugador = players.tag
    join clan on formado.clan = clan.id;

select *
from players;

select *
from formado
where clan = '#9GUCJRL0';

select * from dona;



