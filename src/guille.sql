/*COLOR MORADO actualizado con los errores de la fase 1*/ -- TODO: falta definir algunos tipos
/*Drop table if exists Mensaje cascade;
Create table Mensaje
(
    id                  serial,
    titulo              Varchar(50),
    cuerpo              text,
    fecha               Date,
    idMensajeRespondido int,
    idClan              Varchar(50),
    primary key (id),
    foreign key (idMensajeRespondido) references Mensaje (id),
    foreign key (idClan) references Clan (id)
);

Drop table if exists Escribe cascade;
Create table Escribe
(
    id_emisor           int,
    id_receptor         int,
    id_mensaje          int,
    primary key (id_emisor, id_receptor, id_mensaje),
    foreign key (id_emisor) references Mensaje (id),
    foreign key (id_receptor) references Mensaje (id),
    foreign key (id_mensaje) references Mensaje (id)
);

Drop table if exists Amigo cascade;
Create table Amigo
(
    id_jugador_1            int,
    id_jugador_2            int,
    primary key (id_jugador_1, id_jugador_2),
    foreign key (id_jugador_1) references Jugador (id),
    foreign key (id_jugador_2) references Jugador (id)
);

Drop table if exists Tarjeta cascade;
Create table Tarjeta
(
    id                      int,
    foreign key (id) references Jugador (id)
);

Drop table if exists Posee cascade;
Create table Posee
(
    id_jugador              int,
    id_tarjeta              int,
    primary key (id_jugador, id_tarjeta),
    foreign key (id_jugador) references Jugador (id),
    foreign key (id_tarjeta) references Tarjeta (id)
);

Drop table if exists Compra cascade;
Create table Compra
(
    id_jugador              int,
    id_tarjeta              int,
    id_articulo             int,
    descuento               int,    /*TODO: tipo*/
    fecha               Date,    /*TODO: tipo*/
    primary key (id_jugador, id_tarjeta, id_articulo),
    foreign key (id_jugador) references Jugador (id),
    foreign key (id_tarjeta) references Tarjeta (id),
    foreign key (id_articulo) references Articulo (id)
);

Drop table if exists Articulo cascade;
Create table Articulo
(
    id                      int,
    coste_real              int,    /*TODO: validar tipo*/
    veces_compra            int,    /*TODO: validar tipo*/
    primary key (id)
);

Drop table if exists Cofre cascade;
Create table Cofre
(
    id_cofre              int,
    oro_contenido         int,    /*TODO: validar tipo*/
    gemas_contenido       int,    /*TODO: validar tipo*/
    id_mision              int,
    primary key (id_cofre),
    foreign key (id_cofre) references Articulo (id) -- TODO:
    foreign key (id_mision) references Mision (id) -- TODO:
);

Drop table if exists Paquete_Arena cascade;
Create table Paquete_Arena
(
    id_p_arena              int,
    oro_contenido              int,    /*TODO: validar tipo*/
    titulo_arena            varchar(255),    /*TODO: validar tipo*/
    primary key (id_p_arena),
    foreign key (titulo_arena) references Articulo (id) -- TODO:
);

Drop table if exists Paquete_Oferta cascade;
Create table Paquete_Oferta
(
    id_p_oferta              int,
    oro_contenido              int,          /*TODO: validar tipo*/
    gemas_contenido            int,    /*TODO: validar tipo*/
    primary key (id_p_oferta),
    foreign key (id_p_oferta) references Articulo (id)
);*/

/* CSV */
Drop table if exists players_quests cascade;
Create table players_quests
(
    player_tag        varchar(255),
    quest_id          int,
    quest_title       varchar(255),
    quest_description varchar(255),
    quest_requirement int,
    quest_depends     varchar(255),
    unlock            Date

);

Drop table if exists players cascade;
Create table players
(
    tag        varchar(255),
    name       varchar(255),
    experience int,
    trophies   int,
    cardnumber int,
    cardexpiry Date

);

Drop table if exists players_achievements cascade;
Create table players_achievements
(
    player      varchar(255),
    name        varchar(255),
    description varchar(255),
    arena       int,
    date        Date,
    gems        int
);

Drop table if exists players_badge cascade;
Create table players_badge
(
    player varchar(255),
    name   varchar(255),
    arena  int,
    date   Date,
    img    varchar(255)
);

Drop table if exists players_cards cascade;
Create table players_cards
(
    player varchar(255),
    id     int,
    name   varchar(255),
    level  int,
    amount int,
    date   Date
);

Drop table if exists players_clans cascade;
Create table players_clans
(
    player varchar(255),
    clan   varchar(255),
    role   varchar(255),
    date   Date
);
