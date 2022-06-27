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


--Arenea 17
select * from jugador where id = '#202C2CU0U';
--Mision con prerequisito cumplido -> arena 17 mision 50 = exp-3832 oro-192
insert into realiza(mision, jugador, fecha) values(50,'#202C2CU0U','2022-06-13');
--Arenea 17
select * from jugador where id = '#202C2CU0U';


--Arenea 17
select * from jugador where id = '#202C2CU0U';
--Mision con prerequisito no cumplido -> prereq 13 no cumplida
insert into realiza(mision, jugador, fecha) values(47,'#202C2CU0U','2022-06-13');
--Mirem el warning que ens indica que no s ha sumat re
select * from warnings;
--Arenea 17
select * from jugador where id = '#202C2CU0U';

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

