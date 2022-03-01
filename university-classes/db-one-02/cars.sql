create database cars;

\c cars

--definição da estrutura das tabelas
create table fabricante (
		fcod varchar(10) not null, 
		fnome varchar(20) not null, 
		PRIMARY KEY (fcod)
);

create table modelo (
		mcod integer not null, 
		mnome varchar(20) not null, 
		fcod varchar(10) not null, 
		PRIMARY KEY (mcod), 
		FOREIGN KEY (fcod) REFERENCES fabricante (fcod)
);

create table carro (
		rnbr char(3) not null, 
		km integer not null, 
		ano integer not null, 
		mcod integer not null, 
		motor real not null, 
		PRIMARY KEY (rnbr), 
		FOREIGN KEY (mcod) REFERENCES modelo(mcod)
);

create table proprietario (
		pcod integer not null,
		pnome varchar(20) not null, 
		pemail varchar(20),    --email é opcional
		PRIMARY KEY (pcod)
);

create table carro_prop(
		pcod integer not null, 
		rnbr char(3) not null, 
		dtcompra date not null, 
		propatual char(1) not null default 'S', 
		PRIMARY KEY(pcod, rnbr), 
		FOREIGN KEY (pcod) REFERENCES proprietario(pcod), 
		FOREIGN KEY (rnbr) REFERENCES carro(rnbr)
);

--popula as tabelas

insert into fabricante (fcod, fnome) values 
			('VW', 'Volkswagen'),
			('Ford', 'Ford'),
			('GM', 'General Motors'),
			('Honda', 'Honda Motors');

insert into modelo (mcod, mnome, fcod) values
		        (1, 'Up!', 'VW'),
			(2, 'Gol', 'VW'),
			(3, 'Cruze', 'GM'),
		        (4, 'Track', 'GM'),
		        (5, 'Civic', 'Honda'),
			(6, 'City', 'Honda'),
			(7, 'Fiesta', 'Ford');

insert into carro (rnbr, km, ano, mcod, motor) values 
			('C10', 12000, 2011, 2, 1.0),
			('B40', 23340, 2011, 5, 2.0),
			('C11', 43120, 2008, 7, 1.4),
			('D20', 5450, 2013, 6, 1.5),
			('C14', 34560, 2012, 4, 2.5),
			('C20', 4567, 2013, 5, 1.8),
			('B18', 27800, 2012, 2, 1.0);

insert into proprietario (pcod, pnome, pemail) values 
				(111, 'João', 'one@x'),
				(222, 'Luís', 'two@x'),
				(333, 'Marta', 'three@x'),
				(444, 'Ana', 'four@x');

insert into carro_prop (pcod, rnbr, dtcompra, propatual) values 
				(111, 'C11', '2009-03-01', 'N'),
				(111, 'C20', '2014-02-10', 'S'),
				(333, 'B18', '2011-12-08', 'S'),
				(444, 'C11', '2011-08-30', 'S'),
				(222, 'B40', '2010-12-05', 'N'),
				(333, 'B40', '2012-03-23', 'S'),
				(111, 'C10', '2011-10-20', 'S'),
				(111, 'C14', '2012-01-18', 'N'),
				(222, 'D20', '2013-07-03', 'S');

