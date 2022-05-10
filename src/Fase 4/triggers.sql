/*
 * 1.1) Proporcions de rareses
 */
drop function if exists proportions_rarity;
create or replace function proportions_rarity() returns trigger as $$
begin
    --Proporciones Common
    if ((((select count(distinct nombre) from carta where rareza = 'Common')*100)/(select count(distinct nombre) from carta)) not between 30.1 and 31.9) then
        insert into warnings(affected_table, error_mesage,date, usr)
        values('Carta', 'Proporcions de raresa no respectades: ' || 'Common' || ' la proporció actual és '||
                    (((select count(distinct nombre) from carta where rareza = 'Common')*100)/(select count(distinct nombre) from carta))
                    ||'% quan hauria de ser ' || 31 || '%', current_date, user);
    end if;

    --Proporciones Epic
    if ((((select count(distinct nombre) from carta where rareza = 'Epic')*100)/(select count(distinct nombre) from carta)) not between 22.1 and 23.9) then
        insert into warnings(affected_table, error_mesage,date, usr)
        values('Carta', 'Proporcions de raresa no respectades: ' || 'Epic' || ' la proporció actual és '||
                    (((select count(distinct nombre) from carta where rareza = 'Epic')*100)/(select count(distinct nombre) from carta))
                    ||'% quan hauria de ser ' || 23 || '%', current_date, user);
    end if;

    --Proporciones Legendary
    if ((((select count(distinct nombre) from carta where rareza = 'Legendary')*100)/(select count(distinct nombre) from carta)) not between 16.1 and 17.9) then
        insert into warnings(affected_table, error_mesage,date, usr)
        values('Carta', 'Proporcions de raresa no respectades: ' || 'Legendary' || ' la proporció actual és '||
                    (((select count(distinct nombre) from carta where rareza = 'Legendary')*100)/(select count(distinct nombre) from carta))
                    ||'% quan hauria de ser ' || 17 || '%', current_date, user);
    end if;

    --Proporciones Legendary
    if ((((select count(distinct nombre) from carta where rareza = 'Champion')*100)/(select count(distinct nombre) from carta)) not between 2.1 and 3.9) then
        insert into warnings(affected_table, error_mesage,date, usr)
        values('Carta', 'Proporcions de raresa no respectades: ' || 'Champion' || ' la proporció actual és '||
                    (((select count(distinct nombre) from carta where rareza = 'Champion')*100)/(select count(distinct nombre) from carta))
                    ||'% quan hauria de ser ' || 3 || '%', current_date, user);
    end if;
    return null;
end;
$$ language plpgsql;

drop trigger if exists rarity_proportions_warning on carta;

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

--Comprobaciones
select count(distinct nombre) from carta;

select count(distinct nombre) from carta where rareza = 'Common';
select count(distinct nombre) from carta where rareza = 'Legendary';
select count(distinct nombre) from carta where rareza = 'Epic';
select count(distinct nombre) from carta where rareza = 'Champion';

--Foto 1
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Añadida1', 100, 100, 'Epic');

--Foto 2
insert into carta(nombre, daño, velocidad_ataque, rareza)
values ('Añadida2', 100, 100, 'Common');

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

