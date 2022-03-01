CREATE TABLE cliente(
	email varchar(50) NOT NULL constraint pk_cliente primary key,
	nomec varchar(50) NOT NULL,
	telefone varchar(20) NOT NULL,
	ender varchar(50) NOT NULL
);


CREATE TABLE grupo(
	sigg varchar(10) NOT NULL constraint pk_grupo primary key,
	nomeg varchar(30) NOT NULL
);


CREATE TABLE tarefa(
	sigt varchar(10) NOT NULL constraint pk_tarefa primary key,
	nome varchar(30) NOT NULL,
	prc numeric NOT NULL
);


CREATE TABLE medic(
	nome varchar(30) NOT NULL constraint pk_medic primary key,
	prc numeric NOT NULL,
	efeito varchar(30) NOT NULL,
	pativo varchar(30) NOT NULL
);
 

CREATE TABLE raca(
	sigr varchar(10) NOT NULL constraint pk_raca primary key,
	nomer varchar(30) NOT NULL,
	sigg varchar(10) NOT NULL,
	constraint fk_grupo_raca foreign key(sigg) references grupo(sigg)
);


CREATE TABLE animal(
	email varchar(30) NOT NULL,
	nome varchar(30) NOT NULL,
	sigr varchar(10) NOT NULL,
	constraint pk_animal primary key(email, nome),
	constraint fk_cliente_animal foreign key(email) references cliente(email),
	constraint fk_raca_animal foreign key(sigr) references raca(sigr)
);


CREATE TABLE medida(
	email varchar(30) NOT NULL,
	nome varchar(30) NOT NULL,
	data date NOT NULL,
	peso numeric NOT NULL,
	alt numeric NOT NULL,
	comp varchar(30) NOT NULL,
	constraint pk_medida primary key(email, nome, data),
	constraint fk_animal_medida foreign key(email,nome) references animal(email,nome)
);

CREATE TABLE aplica_med(
	email varchar(30) NOT NULL,
	nome varchar(30) NOT NULL,
	nomem varchar(30) NOT NULL,
	data date NOT NULL,
	datapronto date NOT NULL,
	dosagem numeric NOT NULL,
	constraint pk_aplica_med primary key(email, nome,nomem, data),
	constraint fk_animal_aplica_med foreign key(email,nome) references animal(email,nome),
	constraint fk_medic_aplica_med foreign key(nomem) references medic(nome)
);

	
CREATE TABLE animal_tar(
	email varchar(30) NOT NULL,
	nome varchar(30) NOT NULL,
	sigt varchar(10) NOT NULL,
	data date NOT NULL,
	datapronto date NOT NULL,
	constraint pk_animal_tar primary key(email, nome,sigt, data),
	constraint fk_animal_animal_tar foreign key(email,nome) references animal(email,nome),
	constraint fk_tarefa_animal_tar foreign key(sigt) references tarefa(sigt)
);

================
Banco de Dados PetShop

1. Encontre os medicamentos que são mais caros que a média de preço dos medicamentos.
2. Encontre os animais que nunca tomaram um medicamento com o princípio ativo dipirona.
3. Encontre os dados dos remédios prescritos para os animais da Angelina Jolie.
4. Encontre o nome dos animails e dos donos para os animais que tiveram a prescrição de paracetamol ou dipirona.
5. Retorne o nome do animal que fez Tosa e Corte de Unha (pode haver mais de 1).
6. Retorne o nome do animail que já fez Tosa mas não Banho.
7. Retorne o nome do cliente que tem pelo menos dois animais.
8. Retorne o nome do animal que teve a prescrição de, pelo menos, 2 medicamentos diferentes.
9. Retorne o nome do animal do grupo DOG que nunca teve prescrição de medicamentos.

RESPOSTAS

1)
select m.nomem 
from   medic m
where m.prcm > (select avg(md.prcm) from medic md);

2)
%%% versão exists
select distinct a.nomea
from animal a
where not exists (select m.nomem
                  from medic m natural join aplica_med am
                  where am.email=a.email
                  and   am.nomea=a.nomea
                  and   m.pativo=’dipirona’);
%%%% versão in
select a.nomea
from animal a
where (a.email,a.nomea) not in 
                  (select am.email, am.nomea
                  from medic m natural join aplica_med am
                  where am.email=a.email
                  and   am.nomea=a.nomea
                  and   m.pativo=’dipirona’);
%%%%% versão conjunto (perceba que o e-mail entrou para garantir unicidade)
select a.email, a.nomea
from   animal a
except
select am.email, am.nomea
from medic m natural join aplica_med am
where  m.pativo='dipirona';

3)
Select m.*
from   cliente c natural join animal a
       natural join aplica_med am
       natural join medic m
where  c.nomec=’Angelina Jolie’;

4)
Select a.nomea, c.nomec
from   cliente c natural join animal a
       natural join aplica_med am
       natural join medic m
where  m.pativo in (‘paracetamol’,’dipirona’);




5)
%%%% com exists
select a.nomea
from   animal a natural join animal_tar at
       natural join tarefa t
where  t.nomet=’Tosa’
and    exists (select a1.email
               from   animal a1 natural join animal_tar at1
                      natural join tarefa t1
               where  t1.nomet=’Corte de Unha’
               and    a1.email=a.email
               and    a1.nomea=a.nomea);
%%% com intersecção
select a.email, a.nomea
from   animal a natural join animal_tar at
       natural join tarefa t
where  t.nomet=’Tosa’
intersec
select a.email, a.nomea
from   animal a natural join animal_tar at
       natural join tarefa t
where  t.nomet=’Corte de Unha’;


6)
%%% com exists
select a.nomea
from   animal a natural join animal_tar at natural join tarefa t
where  t.nomet=’Tosa’
and    not exists (select a1.email from animal a1 natural join animal_tar at
                                                  natural join tarefa t1
                   where  t1.nomet=’Banho’
                   and    a1.email=a.email
                   and    a1.nomea=a.nomea);
%%% com diferença
select a.email, a.nomea
from   animal a natural join animal_tar at natural join tarefa t
where  t.nomet=’Tosa’
except                            
select a.email, a.nomea
from   animal a natural join animal_tar at natural join tarefa t
where  t.nomet=’Banho’

7)
select c.nomec
from  cliente c natural join animal a
group by c.nomec
having count(*) > 1;

8)
select distinct a.nomea
from   animal a natural join aplica_med am1 natural join medic m1
                join aplica_med am2 on a.email=am2.email
                                   and a.nomea=am2.nomea
                join medic m2      on am2.nomem=m2.nomem
where  am2.nomem!=am1.nomem;
%%% com exists
select distinct a.nomea
from   animal a natural join aplica_med am
where  exists (select am1.email from aplica_med am1 
               where am1.email=am.email 
               and   am1.nomea=am.nomea
               and   am1.nomem!=am.nomem);
9)
%% com EXISTS
select a.nomea
from   animal a natural join raca r
where  r.sigg='DOG'
and    not exists (select am.email
                   from aplica_med am
                   where am.email=a.email
                   and   am.nomea=a.nomea);
%%% com IN
select a.nomea
from   animal a natural join raca r
where  r.sigg='DOG'
and    (a.email,a.nomea) not in (select am.email, am.nomea
                                 from aplica_med am);

%%% opção com o operador de conjunto diferente
%%% colocar o e-mail para retornar nomes de animais iguais mas com
%%% donos diferentes
select a.email, a.nomea
from   animal a natural join raca r
where  r.sigg='DOG'
except
select a.email, a.nomea
from   animal a natural join raca r natural join aplica_med
where  r.sigg='DOG';
%%%% para retornar apenas o nome, coloca-se a consulta acima no FROM
select nomea
from (select a.email, a.nomea
      from   animal a natural join raca r
      where  r.sigg='DOG'
      except
      select a.email, a.nomea
      from   animal a natural join raca r natural join aplica_med
      where  r.sigg='DOG') T;
	
	
