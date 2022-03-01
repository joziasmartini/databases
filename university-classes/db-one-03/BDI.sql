drop table if exists evento;
drop table if exists local;
drop table if exists tipoev;
drop table if exists bairro;
drop table if exists cidade;
--
create table cidade (
 sigc varchar(5) not null constraint pk_cidade primary key,
 nomec varchar(30) not null,
 uf   varchar(2)  not null
);
create table bairro (
 sigc varchar(5) not null,
 sigb varchar(5) not null,
 nomeb varchar(30) not null,
 constraint pk_bairro primary key (sigc,sigb),
 constraint fk_baicid foreign key (sigc) references cidade(sigc)
);
create table tipoev (
  code  integer not null constraint pk_tipoev primary key,
  descr varchar(15) not null
);
create table local (
  sigc  varchar(5) not null,
  sigb  varchar(5) not null,
  sigl  varchar(5) not null,
  nomel varchar(20) not null,
  capac integer not null,
  constraint pk_local primary key (sigc,sigb,sigl),
  constraint fk_locbai foreign key (sigc,sigb) references bairro(sigc,sigb)
);
create table evento (
  sigc  varchar(5) not null,
  sigb  varchar(5) not null,
  sigl  varchar(5) not null,
  code  integer not null,
  dthora timestamp not null,
  nomee varchar(20) not null,
  medaval real,
  constraint pk_evento primary key (sigc,sigb,sigl,dthora),
  constraint fk_eveloc foreign key (sigc,sigb,sigl) references local(sigc,sigb,sigl),
  constraint fk_evetipo foreign key (code) references tipoev(code)
);
---
insert into cidade (sigc,nomec,uf) values ('ITA','Itajaí','SC'),('JOI','Joiville','SC'),('XAP','Chapecó','SC'),
                                          ('ERE','Erechim','RS'),('CWB','Curitiba','PR'),('ITU','Itu','SP'),
                                          ('SPO','São Paulo','SP'),('CAI','Caibi','SC'),('BLU','Blumeau','SC');
--
insert into bairro (sigc,sigb,nomeb) values ('ITA','CEN','Centro'),('ITA','VLO','Vila Operária'),
                                            ('XAP','CEN','Centro'),('XAP','STM','Santa Maria'),
                                            ('JOI','CEN','Centro'),('JOI','IRI','Irirui'),
                                            ('ERE','CEN','Centro'),('ERE','SEM','Seminário'),
                                            ('CWB','CEN','Centro'),('CWB','CHA','Champagnat'),
                                            ('ITU','CEN','Centro'),('ITU','LAP','Lapa'),
                                            ('SPO','CEN','Centro'),('SPO','VMA','Vila Mariana'),
                                            ('CAI','CEN','Centro'),('CAI','COL','Colatto'),
                                            ('XAP','SEM','Seminário'),('BLU','VEL','Velha'),
                                            ('ITA','CAB','Cabeçudas'),('JOI','VNO','Vila Nova'),
                                            ('BLU','AVE','Água Verde'),('CWB','BOQ','Boqueirão'),
                                            ('SPO','JAR','Jardins'),('ITA','SJO','São João'),
                                            ('ERE','ATL','Atlântico'),('CWB','MOS','Mossunguê'),
                                            ('BLU','CEN','Centro'),('XAP','VLN','Vila Nova');
--
insert into tipoev (code, descr) values (1,'Show Musical'), (2,'Teatro'), (3, 'Cinema'), (4, 'Feira'), 
                                        (5,'Opera'),(6,'Ballet');
--
insert into local (sigc,sigb,sigl,nomel,capac) values ('ITA','CEN','TMU','Teatro Municipal',200),
                                                      ('XAP','CEN','CEV','Centro Eventos',300),
                                                      ('XAP','SEM','SUN','Salão Nobre Unoesc',500),
                                                      ('JOI','VNO','TSE','Teatro Sesc',250),
                                                      ('ERE','ATL','TMU','Teatro Municipal',1000),
                                                      ('ITA','CAB','TBV','Teatro Praia Brava',300),
                                                      ('JOI','CEN','CEV','Centro Eventos',500),
                                                      ('JOI','IRI','TEM','Teatro Municipal',250),
                                                      ('ERE','SEM','PAV','Pavilhão Shows',1000),
                                                      ('CWB','CEN','TEM','Teatro Municipal',320);
--
insert into evento values ('ITA','CEN','TMU',2,'12-12-2013 21:00','Noivas de Copacabana'),
                          ('XAP','CEN','CEV',5,'21-12-2013 21:00','Barbeiro de Sevilha'),
                          ('ITA','CAB','TBV',1,'29-09-2018 21:00','Os Replicantes'),
                          ('XAP','CEN','CEV',2,'30-10-2018 20:00','Pretinho Básico'),
                          ('XAP','CEN','CEV',1,'15-11-2013 22:00','Humberto Gessinger'),
                          ('ERE','ATL','TMU',2,'15-09-2018 19:00','Noivas de Copacabana'),
                          ('JOI','IRI','TEM',4,'12-12-2018 08:00','XV Feira do Livro'),
                          ('CWB','CEN','TEM',1,'10-10-2018 19:00','Circo Mágico'),
                          ('XAP','SEM','SUN',3,'15-12-2018 16:00','Where is Robin?'),
                          ('JOI','IRI','TEM',6,'01-10-2013 20:00','Bolshoi');
--
/*
Atividades:
1. Listar todas as cidades cadastradas: sigla e nome
2. Listar todas as cidades (todos os atributos) do estado de Santa Catarina (SC)
3. Listar todos os eventos cadastrados: apenas a descrição
4. Listar todas as cidades com seus bairros cadastradas
5. Listar todos os nomes de bairros das cidades de Itajaí e Chapecó.
6. Listar todos os eventos do tipo Teatro que ocorreram a partir de Julho/2013: nome da cidade, bairro, no do local e nome do evento
7. Listar todos os eventos que ocorreram/ocorrerão em Joinville.
8. Vai ocorrer a 4a. Feiras de Noivos e Noivas no Centro de Eventos de Caibi (localizado no centro da cidade). O evento ocorrerá no dia 10/10/2018 iniciando às 08:00h
*/




