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
        update jugador
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
execute function actualiza_compra();

--Validació

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
execute function actualiza_missatges_jugador();

--Validació

--Insert sense paraules prohibides
insert into mensaje(id,cuerpo,fecha,idmensajerespondido) values (1001, 'me encanta este juego bro','2022-06-13',null);
insert into escribe(id_emisor, id_receptor, id_mensaje) values('#2092CR2RV','#208GJV',(select id from mensaje order by id desc limit 1));

--Fem els inserts per activar el trigger( amb una paraula prohibida)
insert into mensaje(id,cuerpo,fecha,idmensajerespondido) values (1002, 'Eres una zorra','2022-06-13',null);
insert into escribe(id_emisor, id_receptor, id_mensaje) values('#202C2CU0U','#208GJV',(select id from mensaje order by id desc limit 1));

--Fem els insert per activar el trigger( amb mes d'una paraula)
insert into mensaje(id,cuerpo,fecha,idmensajerespondido) values (1003, 'Eres una zorra y puta','2022-06-13',null);
insert into escribe(id_emisor, id_receptor, id_mensaje) values('#202U2J08Q','#208GJV',(select id from mensaje order by id desc limit 1));


--Comprobem les taules afectades
select * from warnings where affected_table like 'Mensaje';
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
                insert into warnings(affected_table, error_mesage, date, usr) values('Mensaje','Missatge d odi enviat amb la paraula '||(select palabraBanned from aux2 where id = contador)|| ' al clan ' || (select c.id from clan as c where c.id = new.receptor),new.fecha,(select j.nombre from jugador as j where j.id = new.emisor));
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
execute function actualiza_missatges_clan();


--Validació

--Insert d'un missatge sense paraules prohibides
insert into mensaje_clan(id,cuerpo,fecha,emisor,receptor,mensaje_respondido) values (1001, 'Me encanta este juego ',
                                                                                     '2022-06-13','#2092CR2RV','#8YQ9LPPV',null);

--Insert d'un missatge amb una paraula prohibida
insert into mensaje_clan(id,cuerpo,fecha,emisor,receptor,mensaje_respondido) values (1002, 'Eres una zorra ','2022-06-13',
                                                                                     '#202C2CU0U','#8YQ9LPPV',null);

--Insert d'un missatge amb més d'una paraula prohibida
insert into mensaje_clan(id,cuerpo,fecha,emisor,receptor,mensaje_respondido) values (1003, 'Eres una tonto y desgraciado ',
                                                                                     '2022-06-13','#202U2J08Q','#8YQ9LPPV',null);
--Comprobem les taules afectades
select * from warnings where affected_table like 'Mensaje';
select * from jugador where nombre like '%_Banned_%';


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