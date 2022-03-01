﻿create table ttrain (
   tid integer not null constraint pk_ttrain primary key,
   tname  varchar(20) not null
   );
 create table train (
     tnumber integer not null constraint pk_train primary key,
     tname   varchar(30) not null,
     nseats  integer not null,
     tid     integer,
     constraint fk_ttrain_train foreign key (tid) references ttrain(tid)
     );
 create table station (
    sid integer not null constraint pk_station primary key,
    sname varchar(20) not null,
    sloc  varchar(10) not null
    );
 create table route (
     rnumber integer not null constraint pk_route primary key,
     fromsid integer not null,
     tosid   integer not null,
     tnumber integer not null,
     constraint ck_samefromto check (fromsid<>tosid),
     constraint fk_route_station_from foreign key (fromsid) references station(sid),
     constraint fk_route_station_to foreign key (tosid) references station(sid),
     constraint fk_route_train foreign key (tnumber) references train(tnumber)
     );
 create table schedule (
    scid integer not null constraint pk_schedule primary key,
    rnumber integer not null,
    sctime time,
    constraint fk_schedule_route foreign key (rnumber) references route(rnumber)
   );
 create table ticket (
    tknumber integer not null constraint pk_ticket primary key,
    scid  integer not null,
    dbuy date not null,
    constraint fk_ticket_schedule foreign key (scid) references schedule(scid)
    );

insert into ttrain (tid, tname) values (1,'Lux'),(2,'Conventional'),(3,'Steel Lux'),
                                       (4,'Modern'),(5,'Old'),(6,'New'),(7,'Vapor');

 insert into train (tnumber,tname,nseats,tid) values (1,'Red Express',120,1), (2,'NY Arrow',190,3),
                                                     (3,'Trans Sea',100,4), (4,'Middle Age',90,7),
                                                     (5,'Fancy',110,3), (6,'Sea Gate',130,3),
                                                     (7,'Seven 0',145,1), (8,'Last Stop',110,3);
 insert into station (sid,sname,sloc) values (1,'Massachusets','MA'), (2,'New York City','NY'),
                                             (3,'Los Angeles','CA'),(11,'Connecticut','CO'),(4,'New Jersey','NJ'),                    
                                             (5,'Baltimore','NY'),(6,'Miami','FO'),(7,'Tampa','FO'),                    
                                             (8,'Houston','TX'),(9,'Detroit','CH'),(10,'San Francisco','CA');  
 insert into route (rnumber,fromsid,tosid,tnumber) values (1,1,2,2), (2,1,5,2), (3,3,10,5),(4,11,6,1),
                                                          (5,6,7,6),(6,8,9,3),(7,4,8,4),(8,2,3,3),(9,7,8,7),                                                              
                                                          (10,10,5,3),(11,11,4,8),(12,9,1,1),(13,8,2,8),(14,5,10,7), (15,8,1,2);
 insert into schedule (scid,rnumber,sctime) values  (1,1,'10:00'),(2,1,'10:30'),(3,1,'15:15'),(4,1,'19:00'),(5,1,'22:00'),   
                                                    (6,2,'7:20'),(7,2,'9:10'),(8,2,'12:12'),(9,2,'19:30'),(10,2,'21:00'),
                                                    (11,3,'10:10'),(12,3,'12:50'),(13,3,'12:55'),(14,3,'18:30'),(15,3,'18:45'),                                                   
                                                    (16,4,'11:40'),(17,4,'12:35'),(18,4,'16:00'),(19,4,'19:30'),(20,4,'23:00'),
                                                    (21,5,'5:10'),(22,5,'18:10'),(23,5,'19:12'),(24,5,'21:30'),(25,5,'22:00'),
                                                    (26,6,'4:20'),(27,6,'9:10'),(28,6,'12:16'),(29,6,'19:35'),(30,6,'21:40'),
                                                    (31,7,'5:20'),(32,7,'14:10'),(33,8,'6:20'),(34,8,'15:10'),
                                                    (35,9,'7:20'),(36,9,'16:10'),(37,10,'8:20'),(38,10,'17:10'),
                                                    (39,11,'9:20'),(40,11,'18:10'), (41,12,'10:20'),(42,12,'19:10'),
                                                    (43,13,'11:20'),(44,13,'20:10'),(45,14,'12:20'),(46,14,'21:10'),
                                                    (47,15,'13:20'),(48,15,'22:10');

 insert into  ticket (tknumber,scid,dbuy) values (1,3,'10/04/2014'),(11,3,'11/04/2014'),(12,3,'06/04/2014'),(13,3,'30/03/2014'),
                                                 (2,9,'01/01/2014'),(14,9,'01/01/2014'),(15,9,'03/01/2014'),(16,9,'04/01/2014'),
                                                 (3,13,'05/02/2014'),(17,13,'03/02/2014'),(18,13,'18/02/2014'),(19,13,'06/02/2014'),
                                                 (4,16,'20/05/2014'),(20,16,'22/05/2014'),(21,16,'21/05/2014'),(22,16,'22/05/2014'),
                                                 (5,24,'22/03/2014'),(23,24,'01/04/2014'),(24,24,'23/03/2014'),(25,24,'27/03/2014'),
                                                 (6,28,'07/04/2014'),(26,28,'06/04/2014'),(27,28,'07/05/2014'),(28,28,'28/04/2014'),
                                                 (7,31,'09/02/2014'),(29,31,'25/02/2014'),(30,31,'19/02/2014'),(31,31,'21/02/2014'),
                                                 (8,41,'12/12/2013'),(32,41,'22/12/2013'),(33,41,'21/12/2013'),(34,41,'23/12/2013'),
                                                 (9,44,'07/01/2014'),(35,44,'08/01/2014'),(36,44,'09/01/2014'),(37,44,'10/01/2014'),
                                                 (10,48,'13/01/2014'),(38,48,'12/01/2014'),(39,48,'11/01/2014'),(40,48,'31/01/2014');
                                                   
