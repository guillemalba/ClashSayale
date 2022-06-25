/*
* 3.1) Cop d'efecte
*/
drop function if exists leaders_function cascade;
create or replace function leaders_function() returns trigger as $$
BEGIN
    insert into removed_member (clan, player, fecha, role)
    select clan, jugador, fecha, old.role from Formado
    where role is null and jugador not in (select player from removed_member)
    group by clan, jugador;
    if (((select count(player) from removed_member where clan = new.clan group by clan) >= 5) and
        ((select max(fecha)-min(fecha) from Formado where role is null or role like 'leader%' group by clan having clan = new.clan
                                                                                                               and min(fecha) = (select fecha from Formado where role like 'leader%' and clan = new.clan)) <= 1)) then
        insert into removed_member
        select * from formado where clan = new.clan and role like 'leader%';
        delete from formado
        where role is null or role like 'leader%' and clan = new.clan;
        insert into formado
        select * from removed_member where clan = new.clan and role not like 'leader%';
        delete from removed_member
        where role not like 'leader%' and clan = new.clan;
        if ((select count(role) from formado where clan = new.clan and role like 'coLeader%' group by clan) <= 1
            or (select count(role) from formado where clan = new.clan and role like 'coLeader%' group by clan) is null) then
            update formado
            set role = 'leader: They have the same privileges as Co-leaders however the Leader is the only player in the Clan who can kick and demote everyone. Transferring leadership of a clan will demote the transferring player''s role to Co-Leader and their desired player will take the Leader role.'
            where jugador like (select jugador from formado where clan = new.clan order by role limit 1);
            return null;
        else
            update formado
            set role = 'leader: They have the same privileges as Co-leaders however the Leader is the only player in the Clan who can kick and demote everyone. Transferring leadership of a clan will demote the transferring player''s role to Co-Leader and their desired player will take the Leader role.'
            where jugador like (select jugador from formado where clan = new.clan and role like 'coLeader%' order by role limit 1);
            return null;
        end if;
    end if;
    return null;
END;
$$ language plpgsql;

drop trigger if exists excess_expel on formado;
create trigger excess_expel after update on formado for each row
execute function leaders_function();

-- Cas AMB coLeader
update formado set role = null, fecha = '2021-08-07' where jugador like '#PP2YY2RG';
update formado set role = null, fecha = '2021-08-07' where jugador like '#QJYV9L9Q';
update formado set role = null, fecha = '2021-08-07' where jugador like '#Y9G2LLG02';
update formado set role = null, fecha = '2021-08-07' where jugador like '#2PVCG9GQ';
update formado set role = null, fecha = '2021-08-07' where jugador like '#8YL988LL8';
update formado set role = null, fecha = '2021-08-07' where jugador like '#2GRQQU02'; -- membre d'un clan diferent
update formado set fecha = '2021-08-06' where jugador like '#28GUPGY2';

-- Cas SENSE coLeader
update formado
set role = null, fecha = '2021-08-07'
where jugador like '#PP2YY2RG2' or jugador like '#QJYV9L9Q2' or jugador like '#Y9G2LLG022' or jugador like '#2PVCG9GQ2' or jugador like '#8YL988LL82';
update formado
set fecha = '2021-08-06'
where jugador like '#28GUPGY22';

-- Select general
select * from removed_member;

-- Select comprovació
select * from formado order by clan, role;

/*
 3.2) Hipocresia de trofeus minims
 */
drop function if exists check_trofies cascade ;
create or replace function check_trofies() returns trigger as $$
BEGIN
    if (new.trofeos < (select c.minimo_trofeos from clan c join formado f on c.id = f.clan where f.jugador = new.id)) then
        insert into removed_player (clan, player, role)
        values ((select clan from formado where jugador = new.id), new.id, (select role from formado where jugador = new.id));
        delete from formado
        where jugador = new.id;
        if ((select role from removed_player where player = new.id) like 'leader%') then
            if ((select count(role) from formado where jugador = new.id and role like 'coLeader%' group by clan) < 1
                or (select count(role) from formado where jugador = new.id and role like 'coLeader%' group by clan) is null) then
                update formado
                set role = 'leader: They have the same privileges as Co-leaders however the Leader is the only player in the Clan who can kick and demote everyone. Transferring leadership of a clan will demote the transferring player''s role to Co-Leader and their desired player will take the Leader role.'
                where jugador like (select jugador from formado where clan = (select clan from removed_player where player = new.id)
                                    group by clan, jugador limit 1);
            else
                update formado
                set role = 'leader: They have the same privileges as Co-leaders however the Leader is the only player in the Clan who can kick and demote everyone. Transferring leadership of a clan will demote the transferring player''s role to Co-Leader and their desired player will take the Leader role.'
                where jugador like (select jugador from formado where clan = (select clan from removed_player where player = new.id)
                                                                  and role like 'coLeader%' group by clan, jugador limit 1);
            end if;
        end if;
    end if;
    return null;
end;
$$ language plpgsql;

drop trigger if exists min_trofies on jugador;
create trigger min_trofies after update on jugador for each row
execute function check_trofies();

-- Update de prova eliminant un no líder
update jugador
set trofeos = 0
where id = '#8PQ9QCPL';

-- Update de prova eliminant el líder AMB coLeader
update jugador
set trofeos = 0
where id = '#28GUPGY2';

-- Update de prova eliminant el líder SENSE coLeader
update jugador
set trofeos = 0
where id = '#28GUPGY22';

-- Select general
select * from removed_player;

-- Select de comprovacion
select * from formado order by clan, role;

/*
 * 3.3) Mals perdedors
 */
drop function if exists check_admin cascade;
create or replace function check_admin() returns trigger as $$
BEGIN
    if ((select current_user) not like 'admin') then
        insert into warnings(affected_table, error_mesage, date, usr)
        VALUES ('Batalla', concat('S''ha intentat esborrar la batalla ', cast(old.id as text), ' on l''usuari ',
                                  (select d.jugador from deck d join batalla b on d.id = b.deck_lose where b.deck_lose = old.deck_lose and b.id = old.id),
                                  ' va perdre ', old.puntos_lose, ' trofeus'), (select current_date), (select current_user));
        return null;
    else
        insert into removed_batle(deleted_by, id, deck_win, deck_lose, fecha, durada, puntos_win, puntos_lose, batalla_clan)
        VALUES ((select current_user),old.id, old.deck_win, old.deck_lose, old.fecha, old.durada, old.puntos_win, old.puntos_lose, old.batalla_clan);
        return old;
    end if;
end;
$$ language plpgsql;

drop trigger if exists user_admin on batalla;
create trigger user_admin before delete on batalla for each row
execute function check_admin();

-- Delete sense ser admin
delete from batalla
where id = 1;
select * from warnings;

-- Delete sent admin
set role admin;
delete from batalla
where id = 2;

-- Select general
select * from removed_batle;

-- Select de comprovació
select * from batalla;