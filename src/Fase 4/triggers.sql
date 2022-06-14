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

    --Proporciones Rare
    if ((((select count(distinct nombre) from carta where rareza = 'Rare')*100)/(select count(distinct nombre) from carta)) not between 25.1 and 26.9) then
        insert into warnings(affected_table, error_mesage,date, usr)
        values('Carta', 'Proporcions de raresa no respectades: ' || 'Rare' || ' la proporció actual és '||
                        (((select count(distinct nombre) from carta where rareza = 'Rare')*100)/(select count(distinct nombre) from carta))
                            ||'% quan hauria de ser ' || 26 || '%', current_date, user);
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

    --Proporciones Champion
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

drop function if exists actualization_gift;
create or replace function actualization_gift() returns trigger as $$
begin
    update encuentra
    set nivel_actual = 14
    where carta = new.carta and jugador = new.jugador;
    return null;
end;
$$ language plpgsql;


drop trigger if exists card_actualization_gift on encuentra;
create trigger card_actualization_gift after insert on encuentra
for each row
execute function actualization_gift();


--Consultas e insert de prueba
insert into encuentra (jugador, carta, fecha_mejora, nivel_actual)
values('#VQJ9UUP','Putin',current_date,1);

select e.jugador, e.carta, e.fecha_mejora, e.nivel_actual from encuentra e
where jugador = '#VQJ9UUP' and carta = 'Putin';


/*
 * 1.3) Targetes OP que necessiten revisió
 */


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
* 4.2) Batalla amb jugadors
*/
select * from batalla order by fecha;
select * from deck order by id;



select * from arena order by max_trofeos;
select * from arenas order by mintrophies;


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

delete from batalla
where fecha = '2024-02-14';

insert into batalla(id, deck_win, deck_lose, fecha, durada, puntos_win, puntos_lose, batalla_clan)
values (99999, 103, 102, '2024-02-14', '09:50:50', 69, -69, null);

select * from jugador order by trofeos desc;
