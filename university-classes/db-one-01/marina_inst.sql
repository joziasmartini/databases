insert into tpboat (tbid,tbdsc) values (10,'Schooner'),(20,'Laser'),(30,'Catboat'),(40,'Scuna'),
                                      (50,'WindSurf'),(60,'Class 10');
insert into boat (bid,bname,blen,bhorses,byear,bweight,bnsail,tbid)
       values (10,'Black Shark',30,120,2010,80,3,10), (20,'Arrow',20,90,2012,60,1,20),
              (30,'White Swan',150,140,2008,120,6,40), (40,'Small',10,0,2014,20,1,20);
              
insert into tplevel (lid,ldsc) values (10,'Amateur'),(20,'Junior'),(30,'Master'),(40,'Senior');

insert into sailor (sid, sname, semail, dbirth,slevel)
            values (10,'João da Silva','joao@gmail.com','10/10/1990',20),
                   (20,'Maria da Silva','maria@gmail.com','10/08/1987',10),
                   (30,'Pedro Antonio','pedro@gmail.com','20/11/1977',30),
                   (40,'Alberto Dumont','alberto@gmail.com','5/01/1969',40),
                   (50,'Roberto Silva','roberto@gmail.com','13/01/1981',20),
                   (60,'Carla Carl','carla@gmail.com','22/09/1988',20);                   

insert into reserve (sid,bid,dtimep,dtimer) 
            values (10,10,'10/09/2015 08:00','10/09/2015 18:00'),
                   (10,30,'14/07/2015 08:00','14/07/2015 21:00'),
                   (20,30,'11/12/2014 12:00','12/12/2014 12:00'),
                   (20,40,'06/02/2015 08:00','06/02/2015 19:00'),                   
                   (30,20,'03/08/2011 08:00','05/08/2011 18:00'),
                   (60,30,'05/10/2016 08:00',NULL),
                   (50,20,'05/10/2016 08:30',NULL);

insert into tstatus (tid,tdsc) values (10,'Novo'),(20,'Arranhão na proa'),(30,'Popa descascada'),
                                      (50,'Pintura velha'),(60,'Vela rasgada'),(70,'Descolorido'),                   
                                      (80,'Mastro torto'),(90,'Arranhões'),(100,'Leme avariado');

insert into boat_status values (10,10),(20,20),(20,90),(30,50),(40,80),(40,100);


