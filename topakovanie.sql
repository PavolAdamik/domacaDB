Create table p_ZTP (
	id_ZTP Char (6) NOT NULL ,
	rod_cislo Char (11) NOT NULL ,
	dat_od Date NOT NULL ,
	dat_do Date,
	id_postihnutia Number NOT NULL ,
primary key (id_ZTP) 
) 
/

Create table t1 (
    kpk Char (5) not null,
    pocet Number,
    id Number Not null,
PRIMARY KEY (id)
    );
    
create table t2 (
    id Number not null,
    jablko char (6) not null,
    primary key (id, jablko)
);

alter table t2
    add (foreign key (id) references t1 (id));
    
alter table t2
    add (poznamka char (6) not null);
    
desc t2;
--popici

alter table t2
    add (datum Date not null);
    
create index ind_datum on t2 (datum);

create unique index ind_kpk on t1(kpk);

drop table t2;

drop table t1;

--menny zoznam zien
select meno, priezvisko from p_osoba
 where substr (rod_cislo, 3,1) between 5 and 6;    --01(07)16/4444
 
select count(*) from p_osoba
 where substr (rod_cislo, 3,1) between 5 and 6; -- 925
                    
 select count (*) from p_osoba; --5776
 
 select count(*) from p_osoba 
    where substr(rod_cislo, 3,1)between 0 and 1; --4520
    
--narodeniny minuly mesiac
select meno, priezvisko from p_osoba
    where (add_months(sysdate, -1) from dual);
    
select add_months(sysdate, -1) from dual;

select sysdate, extract(month from sysdate) -1 from dual ; -- toto mi da krasnu dvojku .. ale jak to dat do selectu.. to nvm

select meno, priezvisko from p_osoba
    where substr(rod_cislo, 3,2) = extract(month from sysdate) -1 or substr(rod_cislo, 3,2) = extract(month from sysdate) + 50;
    
--nemaju platny ztp
select distinct meno, priezvisko, rod_cislo from p_osoba
 join p_ZTP using (rod_cislo)
  where dat_do < sysdate;--1616
  
select meno, priezvisko, rod_cislo from p_osoba
 --join p_ZTP using (rod_cislo)
  where rod_cislo in(select rod_cislo
                            from p_ZTP 
                                where dat_do < sysdate); --1616
                                
--nikdy nemali ziaden ztp preukaz .. cize not in mnozina(ti co maju)
select meno, priezvisko from p_osoba o
 where o.rod_cislo not in (select rod_cislo from p_ZTP);
 
select count (*) from p_osoba o
 where o.rod_cislo not in (select rod_cislo from p_ZTP);--2865 
 
select count (*) from p_ZTP;--5364

--okruhliny .. + 0
select meno, priezvisko, rod_cislo from p_osoba
 where substr(rod_cislo, 2,1) = to_char(sysdate, 'y'); 
 
 select count(*) from p_osoba
 where substr(rod_cislo, 2,1) = to_char(sysdate, 'y');--438
 
 select meno, priezvisko, to_char(sysdate, 'YY') + 100 - substr(rod_cislo, 1,2) "rok", rod_cislo
    from p_osoba
        where mod (to_char(sysdate, 'YY') + 100 - substr(rod_cislo, 1,2), 5 )= 0; -- kkcina .. 45 nie su okruhliny
 
select to_char(sysdate, 'Y') from dual; -- vreti koncovu cifru
--vytiahnem poslednu cifru z roku = 2

--pocet zamestnancov za ktorych plati poistenie zamestnavatel tesco
select rod_cislo from p_zamestnanec
 join p_zamestnavatel on (id_zamestnavatela = ICO)
  join p_poistenie  using (id_poistenca)
   where nazov = 'Tesco'; -- napicu
   
select count(*) from p_zamestnanec
 join p_zamestnavatel on (id_zamestnavatela = ICO)
  where nazov = 'Tesco'; --dvaja
  
select meno, priezvisko, rod_cislo from p_zamestnanec
 join p_osoba using (rod_cislo)
  join p_zamestnavatel on (ICO = id_zamestnavatela)
   where nazov = 'Tesco';

select id_platitela from p_poistenie;
select nazov from p_zamestnavatel; --11 zamestnavatelov

select * from p_zamestnanec; -- 14 ludi 

--nikdy nepoberali prispevok v nezamestnanosti

select * from p_prispevky;
select * from p_typ_prispevku; -- ztp, na dieta, nezamestn, dochodok

id typu = 3

select meno, priezvisko, rod_cislo from p_osoba
 --join p_poberatel using(rod_cislo)
  where rod_cislo  in (select rod_cislo from p_poberatel join p_typ_prispevku using (id_typu)
                             where id_typu != 3) or rod_cislo not in (select rod_cislo from p_poberatel);
                             
select count(*) from p_osoba--4561
  where rod_cislo  in (select rod_cislo from p_poberatel join p_typ_prispevku using (id_typu)
                             where id_typu != 3) or rod_cislo not in (select rod_cislo from p_poberatel);
                             
--nejaky prispevok okrem nezamestnanosti

select meno, priezvisko, rod_cislo from p_osoba
    where rod_cislo in (select rod_cislo from p_poberatel join p_typ_prispevku using (id_typu)
                         where id_typu != 3);
                         
select count(*) from p_osoba
    where rod_cislo in (select rod_cislo from p_poberatel join p_typ_prispevku using (id_typu)
                         where dat_do > sysdate) ;--4561
                         
select count(*)
    from p_poberatel join p_prispevky prisp using (id_poberatela) join p_typ_prispevku typ on (prisp.id_typu = typ.id_typu)
        where popis <> 'nezamest' 
            and dat_do is null ;
        



