/*
 * 1.1) Proporcions de rareses
 */
--Para obtener inicialmente las cartas que queremos tenemos que añadir cartas de cada rareza
-- ANTES DE CREAR EL TRIGGER.
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


--Trigger
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