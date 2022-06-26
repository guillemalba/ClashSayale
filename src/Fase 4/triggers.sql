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
drop function if exists actualiza_compra() cascade;
create or replace function actualiza_compra() returns trigger as $$
begin
    if(new.articulo = Any(select id_p_oferta from paquete_oferta) ) then
        update jugador
        set gemas = gemas + (select po.gemas_contenido
            from paquete_oferta as po
            where po.id_p_oferta = new.articulo)
        where id = new.jugador;

        update jugador
        set oro = oro + (select po.oro_contenido
            from paquete_oferta as po
            where po.id_p_oferta = new.articulo)
        where id = new.jugador;
    end if;

    if(new.articulo = Any(select id_paquete from paquete_arena)) then
        update jugador--no Entra, la suma si que lo hace bien solo sale aqui el null;
        set oro = oro + (select n.oro from nivel_arena as n
                                                where n.paquete = new.articulo and n.arena = (select arena.id from arena, jugador
                                                                                                  where jugador.trofeos between arena.min_trofeos and arena.max_trofeos
                                                                                                    and jugador.id = new.jugador
                                                                                                    and arena.max_trofeos <> 32767)) --limit1))*/
        where id = new.jugador;
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
--Comprovamos el cambio
select * from jugador where id = '#202C2CU0U';



--Fem select per saber quina arena es troba el jugador
select arena.id from arena, jugador
 where jugador.trofeos between arena.min_trofeos and arena.max_trofeos
   and jugador.id = '#202C2CU0U'
   and arena.max_trofeos <> 32767;

--El oro que deberia sumar
select n.oro from nivel_arena as n
where n.paquete = 140 and n.arena =(select arena.id from arena, jugador
                                    where jugador.trofeos between arena.min_trofeos and arena.max_trofeos
                                      and jugador.id = '#202C2CU0U'
                                      and arena.max_trofeos <> 32767);



--Fem insert d'un paquet d'arena(es sumen 1311 d'or)
insert  into compra(jugador, tarjeta, articulo, fecha, descuento)
values ('#202C2CU0U',626381901632479,140,'2022-06-13',12.64);
--Comprovamos el cambio
select * from jugador where id = '#202C2CU0U';


--Fem insert d'un cofre que no ens dona ni or ni gemes (no canvia res)
insert  into compra(jugador, tarjeta, articulo, fecha, descuento)
values ('#202C2CU0U',626381901632479,38,'2022-06-13',12.64);

--Fem la compra de un emoticono que no ens dona ni or ni gemes
insert  into compra(jugador, tarjeta, articulo, fecha, descuento)
values ('#202C2CU0U',626381901632479,48,'2022-06-13',12.64);
--Comprovamos el cambio
select * from jugador where id = '#202C2CU0U';




/*
 *2.2) Com tenim les taules de missatges y missatges jugadors separades, fem dos triggers que ens permetin controlar els dos tipus de missatges.
 */

--Funcio/trigger dels misssatges entre jugadors
drop function if exists actualiza_missatges_jugador() cascade;
create or replace function actualiza_missatges_jugador() returns trigger as $$
begin
    --creamos tabla aux para guardar el mensaje
    drop table if exists aux;
    create table aux(
        palabra   varchar(255)
    );
    insert into aux(palabra) select regexp_split_to_table((select cuerpo from mensaje where id = new.id_mensaje),' ');

    if((select Count(palabra) from aux where palabra in (select bannedword from bannedwords)) > 0 ) then

        update jugador
        set nombre = '_Banned_' || nombre
        where id = new.id_emisor;

        drop table if exists aux2;
        create table aux2(
            id              serial,
            palabraBanned   varchar(255)
        );
        insert into aux2(palabraBanned) select palabra from aux where palabra in (select bannedword from bannedwords);

        DECLARE
            contador integer := 1;
        begin
            loop
                insert into warnings(affected_table, error_mesage, date, usr) values('Mensaje','Missatge d odi enviat amb la paraula '||(select palabraBanned from aux2 where id = contador)|| ' a l usuari ' || new.id_receptor,(select fecha from mensaje where id = new.id_mensaje),(select j.nombre from jugador as j where j.id = new.id_emisor));
            if contador = (select count(palabraBanned)from aux2) then
                Exit;
            end if;
                contador = contador +1;
        end loop;
        end;
    end if;
    drop table if exists aux;
    drop table if exists aux2;
    return null;
    end
$$ language plpgsql;

drop trigger if exists Banned_Words on escribe;
create trigger Banned_Words after insert on escribe
    for each row
execute procedure actualiza_missatges_jugador();
--

--Borrem missatge
delete from escribe where id_mensaje = 1001;
delete from mensaje where id = 1001;
delete from escribe where id_mensaje = 1002;
delete from mensaje where id = 1002;
delete from escribe where id_mensaje = 1003;
delete from mensaje where id = 1003;

--Tornem a ficar el nom que tocaba
update jugador set nombre = '⚡Manoel⚡' where id  = '#202C2CU0U';
update jugador set nombre = 'ClashKiller125' where id = '#202U2J08Q';

--Borrem el warning
delete from warnings where affected_table = 'Mensaje';



--Validació

--Insert sense paraules prohibides
insert into mensaje(id,cuerpo,fecha,idmensajerespondido) values (1001, 'me encanta este juego bro','2022-06-13',null);
insert into escribe(id_emisor, id_receptor, id_mensaje) values('#202C2CU0U','#208GJV',(select id from mensaje order by id desc limit 1));

--Fem els inserts per activar el trigger( amb una paraula prohibida)
insert into mensaje(id,cuerpo,fecha,idmensajerespondido) values (1002, 'Eres una zorra','2022-06-13',null);
insert into escribe(id_emisor, id_receptor, id_mensaje) values('#202C2CU0U','#208GJV',(select id from mensaje order by id desc limit 1));

--Fem els insert per activar el trigger( amb mes d'una paraula)
insert into mensaje(id,cuerpo,fecha,idmensajerespondido) values (1003, 'Eres una zorra y puta','2022-06-13',null);
insert into escribe(id_emisor, id_receptor, id_mensaje) values('#202U2J08Q','#208GJV',(select id from mensaje order by id desc limit 1));


--Comprobem les taules afectades
select * from warnings where affected_table = 'mensaje';
select * from jugador where nombre like '%_Banned_%';


--Funcio/Trigger per al missatges del clan
drop function if exists actualiza_missatges_clan() cascade;
create or replace function actualiza_missatges_clan() returns trigger as $$
begin

    --creamos tabla aux para guardar el mensaje
    drop table if exists aux;
    create table aux(
        palabra   varchar(255)
    );
    insert into aux(palabra) select regexp_split_to_table(new.cuerpo,' ');

    if((select Count(palabra) from aux where palabra in (select bannedword from bannedwords)) >0 ) then

    update jugador
    set nombre = '_Banned_' || nombre
    where id = new.emisor;

    drop table if exists aux2;
    create table aux2(
            id              serial,
            palabraBanned   varchar(255)
    );
    insert into aux2(palabraBanned) select palabra from aux where palabra in (select bannedword from bannedwords);

    DECLARE
        contador integer := 1;

    begin
        loop
            insert into warnings(affected_table, error_mesage, date, usr) values('Mensaje','Missatge d odi enviat amb la paraula '||(select palabraBanned from aux2 where id = contador)|| ' al clan ' || (select c.nombre from clan as c where c.id = new.receptor),new.fecha,(select j.nombre from jugador as j where j.id = new.emisor));
            if contador = (select count(palabraBanned)from aux2) then
                Exit;
            end if;
            contador = contador +1;
        end loop;

        end;
        drop table if exists aux;
        drop table if exists aux2;
    end if;
    return null;

end
$$ language plpgsql;

drop trigger if exists Banned_Words2 on mensaje_clan;
create trigger Banned_Words2 after insert on mensaje_clan
    for each row
execute procedure actualiza_missatges_clan();


--Insert d'un missatge sense paraules prohibides
insert into mensaje_clan(id,cuerpo,fecha,emisor,receptor,mensaje_respondido) values (1001, 'Me encanta este juego ','2022-06-13','#202C2CU0U','#8YQ9LPPV',null);

--Insert d'un missatge amb una paraula prohibida
insert into mensaje_clan(id,cuerpo,fecha,emisor,receptor,mensaje_respondido) values (1002, 'Eres una zorra ','2022-06-13','#202C2CU0U','#8YQ9LPPV',null);

--Insert d'un missatge amb més d'una paraula prohibida
insert into mensaje_clan(id,cuerpo,fecha,emisor,receptor,mensaje_respondido) values (1003, 'Eres una tonto y desgraciado ','2022-06-13','##202U2J08Q','#8YQ9LPPV',null);



--Tornem a ficar el nom que tocaba
update jugador set nombre = '⚡Manoel⚡' where id  = '#202C2CU0U';
update jugador set nombre = 'ClashKiller125' where id = '#202U2J08Q';

--Borrem el warning
delete from warnings where affected_table = 'Mensaje';

--Borramos el mensaje
delete from mensaje_clan where id = 1001;
delete from mensaje_clan where id = 1002;
delete from mensaje_clan where id = 1003;





/*
* 2.3) Final de temporada
*/
drop trigger if exists update_ranking on temporada;

drop function if exists finalitza_temporada;
create or replace function finalitza_temporada() returns trigger as $$
begin
    truncate ranking;
    WITH last_season AS (
        (select * from temporada where fecha_final = ((select fecha_inicio from temporada where fecha_final = new.fecha_final) - INTERVAL '1 DAY'))
    )
    insert into ranking(player, trophies, arena)
        (select j.id, SUM(wins_and_loses) as total_trophies, (select arena.nombre from arena, jugador
                                                              where jugador.trofeos between arena.min_trofeos and arena.max_trofeos
                                                                and jugador.id = j.id
                                                                and arena.max_trofeos <> 32767
                                                              limit 1)
         from (
                  /* suma todos los trofeos de las victorias */
                  select jugador.id, sum(batalla.puntos_win) as wins_and_loses
                  from batalla
                           join deck on batalla.deck_win = deck.id
                           join jugador on deck.jugador = jugador.id
                  where batalla.fecha between (select last_season.fecha_inicio from last_season) and (select last_season.fecha_final from last_season)
                  group by jugador.id
                  union all
                  /* resta todos los trofeos de las derrotas */
                  select jugador.id, sum(batalla.puntos_lose) as wins_and_loses
                  from batalla
                           join deck on batalla.deck_lose = deck.id
                           join jugador on deck.jugador = jugador.id
                  where batalla.fecha between (select last_season.fecha_inicio from last_season) and (select last_season.fecha_final from last_season)
                  group by jugador.id
              ) j
         group by j.id);
    return null;
end;
$$ language plpgsql;

create trigger update_ranking after insert on temporada
    for each row
execute function finalitza_temporada();

insert into temporada (nombre, fecha_inicio, fecha_final)
VALUES ('t11', '2022-01-01', '2022-12-31');

select *
from ranking order by trophies desc;

delete from temporada where nombre = 't11';


/*
* 4.1) Completar una missió
*/
drop function if exists finalitza_misio() cascade;
create or replace function finalitza_misio() returns trigger as $$
begin

    if(new.mision in (select m.id from mision as m where m.mision_dep is null))  then

    update jugador
    set oro = oro + (select ma.recompensa_oro from mision_arena as ma
                        join mision m on m.id = ma.mision join realiza r on m.id = r.mision
                            where new.mision = ma.mision and ma.arena = (select arena.id from arena, jugador
                                                                         where jugador.trofeos between arena.min_trofeos and arena.max_trofeos
                                                                           and jugador.id = new.jugador
                                                                           and arena.max_trofeos <> 32767) --limit 1)
                        limit 1)
    where id = new.jugador;

    update jugador
    set experiencia = experiencia + (select ma.experiencia from mision_arena as ma
                                        join mision m on m.id = ma.mision join realiza r on m.id = r.mision
                                            where new.mision = ma.mision and ma.arena = (select arena.id from arena, jugador
                                                                  where jugador.trofeos between arena.min_trofeos and arena.max_trofeos
                                                                    and jugador.id = new.jugador
                                                                    and arena.max_trofeos <> 32767)--limit 1)
                                            limit 1)
    where id = new.jugador;


    else
        --Aqui poner si tiene requerimiento cumplido
       if (new.jugador in (select r.jugador from realiza as r join mision m on m.id = r.mision where m.id =(select m.mision_dep from mision as m where m.id = new.mision ))) then
            update jugador
            set oro = oro + (select ma.recompensa_oro from mision_arena as ma
                                                               join mision m on m.id = ma.mision join realiza r on m.id = r.mision
                             where new.mision = ma.mision and ma.arena = (select arena.id from arena, jugador
                                                                          where jugador.trofeos between arena.min_trofeos and arena.max_trofeos
                                                                            and jugador.id = new.jugador
                                                                            and arena.max_trofeos <> 32767) --limit 1)
                             limit 1)
            where id = new.jugador;

            update jugador
            set experiencia = experiencia + (select ma.experiencia from mision_arena as ma
                                                                            join mision m on m.id = ma.mision join realiza r on m.id = r.mision
                                             where new.mision = ma.mision and ma.arena = (select arena.id from arena, jugador
                                                                                          where jugador.trofeos between arena.min_trofeos and arena.max_trofeos
                                                                                            and jugador.id = new.jugador
                                                                                            and arena.max_trofeos <> 32767)--limit 1)
                                             limit 1)
            where id = new.jugador;
            else
                insert into warnings(affected_table, error_mesage, date, usr) values ('realiza','L entrada de la quest per a ' || (select m.nombre from mision as m where m.id = new.mision)|| 's ha realitzat sense completar el ' || (select m.nombre from mision as m where m.id = (select m.mision_dep from mision as m where m.id = new.mision))|| ' prerequisit',
                                                                                      new.fecha,(select j.nombre from jugador as j where j.id = new.jugador));
        end if;
    end if;
    return null;
end
$$ language plpgsql;

drop trigger if exists update_misio on realiza;
create trigger update_misio after insert on realiza
    for each row
execute procedure finalitza_misio();

--Arenea 17
select * from jugador where id = '#202C2CU0U';
--Mision sin prerequisito -> arena 17 mision 2 = exp-154954 oro-16
insert into realiza(mision, jugador, fecha) values(2,'#202C2CU0U','2022-06-13');


--Arenea 17
select * from jugador where id = '#202C2CU0U';
--Mision con prerequisito cumplido -> arena 17 mision 50 = exp-3832 oro-192
insert into realiza(mision, jugador, fecha) values(50,'#202C2CU0U','2022-06-13');


--Arenea 17
select * from jugador where id = '#202C2CU0U';
--Mision con prerequisito no cumplido -> prereq 13 no cumplida
insert into realiza(mision, jugador, fecha) values(47,'#202C2CU0U','2022-06-13');
--Mirem el warning que ens indica que no s ha sumat re
select * from warnings;


--Torna a tot el seu valor normal
update jugador set oro = 310498 where id = '#202C2CU0U';
update jugador set experiencia = 126481 where id = '#202C2CU0U';
delete from realiza where id = 1001;
delete from realiza where id = 1002;
delete from realiza where id = 1003;
delete from warnings where affected_table = 'realiza';



/*
* 4.2) Batalla amb jugadors
*/
drop trigger if exists update_player_trophies on batalla;

drop function if exists actualiza_batalla;
create or replace function actualiza_batalla() returns trigger as $$
begin
    update jugador
    set trofeos = trofeos + new.puntos_win
    where jugador.id = (
        select deck.jugador
        from deck
        where deck.id = new.deck_win
    );
    update jugador
    set trofeos = trofeos + new.puntos_lose
    where jugador.id = (
        select deck.jugador
        from deck
        where deck.id = new.deck_lose
    );
    return null;
end;
$$ language plpgsql;

create trigger update_player_trophies after insert on batalla
    for each row
execute function actualiza_batalla();

/* Introducimos la nueva batalla */
insert into batalla(id, deck_win, deck_lose, fecha, durada, puntos_win, puntos_lose, batalla_clan)
values (99999, 103, 102, '2024-02-14', '09:50:50', 10000, -10000, null);

select jugador.id, jugador.nombre, jugador.trofeos from jugador
where id = '#9Q8UCU0Q0'
   or id = '#QV2PYL';

/* Volvemos a introducir los valores iniciales de los jugadores */
update jugador
set trofeos = 7606
where id = '#QV2PYL';

update jugador
set trofeos = 7540
where id = '#9Q8UCU0Q0';

/* Eliminamos la batalla que hemos introducido */
delete from batalla
where fecha = '2024-02-14';


/*
* 4.3) Corrupció de dades
*/
drop trigger if exists player_donation_warning on dona;

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

    if (new.clan not in
        (
            select clan.id
            from clan join formado on formado.clan = clan.id
            join jugador on formado.jugador = jugador.id
            where jugador.id = new.jugador)
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

create trigger player_donation_warning before insert or update on dona
    for each row
execute function corrupcio_dades();

truncate warnings;

/* introducimos un nuevo jugador que no pertenezca a ningun clan */
insert into jugador(id, nombre, experiencia, trofeos, oro, gemas)
values ('#MYTAG', 'Bartolo', 100000, 20000, 1000, 100);

/* introducimos una donacion a un clan que no existe */
insert into dona(clan, jugador, oro, fecha)
values ('#MYCLAN', '#MYTAG', 10, '2022-08-08');

/* introducimos una donacion de un jugador que no pertenece al clan que quiere donar */
insert into dona(clan, jugador, oro, fecha)
values ('#9GUCJRL0', '#MYTAG', 20, '2022-08-08');

/* introducimos una donacion de un jugadro que pertenece al clan, pero con valor de oro = null */
insert into dona(clan, jugador, oro, fecha)
values ('#9GUCJRL0', '#CGJ8JRCR', null, '2022-08-08');

/* introducimos una donacion de un jugadro que pertenece al clan, pero con valor de oro = 0 */
insert into dona(clan, jugador, oro, fecha)
values ('#9GUCJRL0', '#CGJ8JRCR', 0, '2022-08-08');

/* update de una donacion con valor de oro = null */
update dona
set oro = null
where dona.id = 5000;

select *
from warnings;

/* introducimos una donacion valida */
insert into dona(clan, jugador, oro, fecha)
values ('#9GUCJRL0', '#8QR8V08YG', 100, '2022-08-08');

select *
from dona where jugador = '#8QR8V08YG';

