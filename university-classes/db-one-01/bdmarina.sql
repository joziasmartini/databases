create table tplevel (
  lid  integer not null constraint pk_tplevel primary key,
  ldsc varchar(30) not null
);
create table sailor (
   sid  integer not null constraint pk_sailor primary key,
   sname varchar(30) not null,
   semail varchar(30) not null,
   dbirth date not null,
   slevel integer not null,
   constraint fk_sailor_tplevel foreign key (slevel) references tplevel(lid)
);
create table tpboat (
   tbid  integer not null constraint pk_tpboat primary key,
   tbdsc varchar(30) not null
);
create table tstatus (
    tid integer not null constraint pk_tstatus primary key,
    tdsc varchar(20) not null
);
create table boat (
   bid integer not null constraint pk_boat primary key,
   bname varchar(20) not null,
   blen  integer not null,
   bhorses integer not null,
   byear integer not null,
   bweight float not null,
   bnsail integer not null,
   tbid   integer not null,
   constraint fk_boat_tpboat foreign key (tbid) references tpboat(tbid)
);
create boat_status (
   bid integer not null,
   tid integer not null,
   constraint pk_boat_status primary key (bid,tid)
);
create table reserve (
   sid integer not null,
   bid integer not null,
   dtimep timestamp not null,
   dtimer timestamp,
   constraint pk_reserve primary key (sid,bid,dtimep),
   constraint fk_reserve_sailor foreign key (sid) references sailor(sid),
   constraint fk_reserve_boat foreign key (bid) references boat(bid)
);
      
   
   
