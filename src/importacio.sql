drop table if exists arena_pack cascade;
create table arena_pack(
    id      int,
    arena   int,
    gold    int
);

copy arena_pack from '/Users/Shared/Bases/Base/arena_pack.csv' csv header delimiter ',';

drop table if exists arenas cascade ;
create table arenas(
    id      int,
    name    varchar(255),
    minTrophies     int,
    maxTrophies     int
);

copy arenas from '/Users/Shared/Bases/Base/arenas.csv' csv header delimiter ',';

drop table if exists battles cascade;
create table battles(
    winner             int,
    loser              int,
    winner_score       int,
    loser_score        int,
    date               date,
    duration           time,
    clan_battle        int
);

copy battles from '/Users/Shared/Bases/Base/battles.csv' csv header delimiter ',';

drop table if exists buildings cascade;
create table buildings(
    building           varchar(255),
    cost                int,
    trophies            int,
    prerequisite        Varchar(255),
    mod_damage          int,
    mod_hit_speed       int,
    mod_radius          int,
    mod_spawn_damage    int,
    mod_lifetime        int,
    description         text
);

copy buildings from '/Users/Shared/Bases/Base/buildings.csv' csv header delimiter ',';

drop table if exists cards cascade;
create table cards(
    name            varchar(255),
    rarity          varchar(100),
    arena           int,
    damage          int,
    hit_speed       int,
    spawn_damage    int,
    lifetime        int,
    radious         int
);
copy cards from '/Users/Shared/Bases/Base/cards.csv' csv header delimiter ',';

drop table if exists clan_battles cascade;
create table clan_battles(
    battle       int,
    clan         Varchar(255),
    start_date   date,
    end_date     date
);

copy clan_battles from '/Users/Shared/Bases/Base/clan_battles.csv' csv header delimiter ',';

-----------DANI-------------------------------------------------------------DANI-------------

drop table if exists clan_tech_structures cascade;
create table clan_tech_structures
(
    clan        varchar(255),
    tech        varchar(255),
    structure   varchar(255),
    date        date,
    level       integer
);
copy clan_tech_structures from '/Users/Shared/Bases/Base/clan_tech_structures.csv' csv header delimiter ',';

drop table if exists clans cascade;
create table clans
(
    tag                 varchar(255),
    name                varchar(255),
    description         text,
    requiredTrophies    integer,
    score               integer,
    trophies            integer
);
copy clans from '/Users/Shared/Bases/Base/clans.csv' csv header delimiter ',';

drop table if exists friends cascade;
create table friends
(
    requester   varchar(255),
    requeted    varchar(255)
);
copy friends from '/Users/Shared/Bases/Base/friends.csv' csv  header delimiter ',';

drop table if exists messages_between_players cascade;
create table messages_between_players
(
    id          int,
    sender      varchar(255),
    receiver    varchar(255),
    text        text,
    date        date,
    answer      integer
);
copy messages_between_players from '/Users/Shared/Bases/Base/messages_between_players.csv' csv header delimiter ',';

drop table if exists messages_to_clans cascade;
create table messages_to_clans
(
    id          int,
    sender      varchar(255),
    receiver    varchar(255),
    text        text,
    date        date,
    answer      integer
);
copy messages_to_clans from '/Users/Shared/Bases/Base/messages_to_clans.csv' csv header delimiter ',';

drop table if exists player_purchases cascade;
create table player_purchases
(
    player              varchar(255),
    credit_card         bigint,
    buy_id              integer,
    buy_name            varchar(255),
    buy_cost            float,
    buy_stock           integer,
    date                date,
    discount            float,
    arenapack_id        integer,
    chest_name          varchar(255),
    chest_rarity        varchar(255),
    chest_unlock_time   integer,
    chest_num_cards     integer,
    bundle_gold         integer,
    bundle_gems         integer,
    emote_name          varchar(255),
    emote_path          varchar(255)
);
copy player_purchases from '/Users/Shared/Bases/Base/player_purchases.csv' csv header delimiter ',';


---------------GUILLEM----------------------------------------------GUILLEM-------------

Drop table if exists players_quests cascade;
Create table players_quests
(
    player_tag        varchar(255),
    quest_id          int,
    quest_title       varchar(255),
    quest_description varchar(255),
    quest_requirement varchar(255),
    quest_depends     varchar(255),
    unlock            Date

);

copy players_quests from '/Users/Shared/Bases/Base/players_quests.csv' csv  header delimiter ',';

Drop table if exists players cascade;
Create table players
(
    tag        varchar(255),
    name       varchar(255),
    experience int,
    trophies   int,
    cardnumber bigint,
    cardexpiry Date

);
copy players from '/Users/Shared/Bases/Base/players.csv' csv  header delimiter ',';

Drop table if exists playersachievements cascade;
Create table playersachievements
(
    player      varchar(255),
    name        varchar(255),
    description varchar(255),
    arena       int,
    date        Date,
    gems        int
);
copy playersachievements from '/Users/Shared/Bases/Base/playersachievements.csv' csv  header delimiter ',';

Drop table if exists playersbadge cascade;
Create table playersbadge
(
    player varchar(255),
    name   varchar(255),
    arena  int,
    date   Date,
    img    varchar(255)
);
copy playersbadge from '/Users/Shared/Bases/Base/playersbadge.csv' csv  header delimiter ',';

Drop table if exists playerscards cascade;
Create table playerscards
(
    player varchar(255),
    id     int,
    name   varchar(255),
    level  int,
    amount int,
    date   Date
);
copy playerscards from '/Users/Shared/Bases/Base/playerscards.csv' csv  header delimiter ',';

Drop table if exists playersClans cascade;
Create table playersClans
(
    player varchar(255),
    clan   varchar(255),
    role   text,
    date   Date
);

copy playersClans from '/Users/Shared/Bases/Base/playersClans.csv' csv  header delimiter ',';

-----DIDAC----------------------------------------------------DIDAC----------------------

DROP TABLE IF EXISTS playersClansdonations CASCADE;
CREATE TABLE playersClansdonations
(
    player VARCHAR(255),
    clan   VARCHAR(255),
    gold   INTEGER,
    date   DATE
);
COPY playersClansdonations FROM '/Users/Shared/Bases/Base/playersClansdonations.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS playersdeck CASCADE;
CREATE TABLE playersdeck
(
    player      VARCHAR(255),
    deck        INTEGER,
    title       VARCHAR(255),
    description TEXT,
    date        DATE,
    card        INTEGER,
    level       INTEGER
);
COPY playersdeck FROM '/Users/Shared/Bases/Base/playersdeck.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS quests_arenas CASCADE;
CREATE TABLE quests_arenas
(
    quest_id   INTEGER,
    arena_id   INTEGER,
    gold       INTEGER,
    experience INTEGER
);
COPY quests_arenas FROM '/Users/Shared/Bases/Base/quests_arenas.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS seasons CASCADE;
CREATE TABLE seasons
(
    name     VARCHAR(50),
    starDate DATE,
    endDate  DATE
);
COPY seasons FROM '/Users/Shared/Bases/Base/seasons.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS shared_decks CASCADE;
CREATE TABLE shared_decks
(
    deck   INTEGER,
    player VARCHAR(50)
);
COPY shared_decks FROM '/Users/Shared/Bases/Base/shared_decks.csv' CSV HEADER DELIMITER ',';

DROP TABLE IF EXISTS technologies CASCADE;
CREATE TABLE technologies
(
    technology       VARCHAR(50),
    cost             INTEGER,
    max_level        INTEGER,
    prerequisite     VARCHAR(50),
    prereq_level     INTEGER,
    mod_damage       INTEGER,
    mod_hit_speed    INTEGER,
    mod_radius       INTEGER,
    mod_spawn_damage INTEGER,
    mod_lifetime     INTEGER,
    description      text
);
COPY technologies FROM '/Users/Shared/Bases/Base/technologies.csv' CSV HEADER DELIMITER ',';