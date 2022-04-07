      
create table zam(
   id_zam number not null,
    veduci number,
    meno Varchar2 (30) not null,
    priezvisko Varchar2 (30) not null,
    primary key (id_zam),
   foreign key (veduci) references zam(id_zam));
    
insert into zam (id_zam, veduci, meno, priezvisko) values (1, null, 'Fero', 'Kahat');

insert into zam (id_zam, veduci, meno, priezvisko) values (2, 1, 'Jogo', 'Svrho');
insert into zam (id_zam, veduci, meno, priezvisko) values (3, 1, 'Filip', 'Hrasko');
insert into zam (id_zam, veduci, meno, priezvisko) values (4, 2, 'Matus', 'Bielik');
insert into zam (id_zam, veduci, meno, priezvisko) values (5, null, 'Fero', 'Kahat'); -- vola sa rovnako XD
insert into zam (id_zam, veduci, meno, priezvisko) values (6, 2, 'Jano', 'Kah');
insert into zam (id_zam, veduci, meno, priezvisko) values (7, null, 'Ja', 'Adamik');
insert into zam (id_zam, veduci, meno, priezvisko) values (8, null, 'Meno', 'Priezviskovy');
insert into zam (id_zam, veduci, meno, priezvisko) values (9, null, 'Fero', 'Kahat');   -- tiez Ferdo
insert into zam (id_zam, veduci, meno, priezvisko) values (10, null, 'Lojzo', 'Kratky');
insert into zam (id_zam, veduci, meno, priezvisko) values (11, 3, 'Tomas', 'Dlhy');
insert into zam (id_zam, veduci, meno, priezvisko) values (12, 3, 'Simona', 'Mala');
insert into zam (id_zam, veduci, meno, priezvisko) values (13, 4, 'Jana', 'Velka');
insert into zam (id_zam, veduci, meno, priezvisko) values (14, 2, 'Hermina', 'Grendzerova');
insert into zam (id_zam, veduci, meno, priezvisko) values (15, 1, 'Hery', 'Poter');
insert into zam (id_zam, veduci, meno, priezvisko) values (16, 10, 'Ron', 'Vizly');
insert into zam (id_zam, veduci, meno, priezvisko) values (17, 12, 'Fred', 'Vizly');
insert into zam (id_zam, veduci, meno, priezvisko) values (18, 14, 'Igor', 'Hrustinec');
insert into zam (id_zam, veduci, meno, priezvisko) values (19, 16, 'Marek', 'Uricek');
insert into zam (id_zam, veduci, meno, priezvisko) values (20, 18, 'Pata', 'Urickova');
insert into zam (id_zam, veduci, meno, priezvisko) values (21, 18, 'Zuzka', 'Kubicova');
insert into zam (id_zam, veduci, meno, priezvisko) values (22, 16, 'Kubo', 'Kubica');
insert into zam (id_zam, veduci, meno, priezvisko) values (23, 14, 'Alex', 'Kastan');
insert into zam (id_zam, veduci, meno, priezvisko) values (24, 12, 'Marek', 'Kubica');
insert into zam (id_zam, veduci, meno, priezvisko) values (25, 1, 'Julia', 'Romeova');
insert into zam (id_zam, veduci, meno, priezvisko) values (26, 4, 'Romeo', 'Julin');
insert into zam (id_zam, veduci, meno, priezvisko) values (27, 3, 'Percy', 'Jackson');
insert into zam (id_zam, veduci, meno, priezvisko) values (28, 24, 'Mohamed', 'Ahmad');
insert into zam (id_zam, veduci, meno, priezvisko) values (29, 28, 'Vilo', 'Rozboril');
insert into zam (id_zam, veduci, meno, priezvisko) values (30, 20, 'Iveta', 'Malachovska');
insert into zam (id_zam, veduci, meno, priezvisko) values (31, 6, 'Stevko', 'Skrucany');
insert into zam (id_zam, veduci, meno, priezvisko) values (32, 31, 'Laco', 'Bulo');

--zamestnanci ktori nemaju veduceho
select * from zam
    where veduci is null; 

--zamestnanci ktori nemaju podriadeneho
--zamestnanci ktori nie su veduci nikomu
select * from zam 
 where id_zam not in (select v.id_zam from  zam v
                        where exists (select 'x' from zam p
                                        where v.id_zam = p.veduci)); -- toto su ti ktori su veduci.. exist lebo duplicity
                                            --vazobna je toto..
select v.id_zam, v.meno, v.priezvisko from  zam v
 where exists (select 'x' from zam p
                where v.id_zam = p.veduci);

                
--kolegovia na rovnakej urovni
--ti ktori su u rovnakeho veduceho
select z.id_zam, z.meno, z.priezvisko, k.id_zam, k.meno, k.priezvisko from zam z left join zam k
    on (z.veduci = k.veduci and z.id_zam != k.id_zam)
        --where z.id_zam != k.id_zam 
            order by (1);
        --ten co je sam tak nema kolegov

 --ku kazdemu zamestnancovi jeho priameho nadriadeneho.. ked ku kazdemmu tak aj ku tomu co ho nema ? ci ?
 select z.id_zam, z.meno, z.priezvisko, n.id_zam, n.meno, n.priezvisko from  zam z left join zam n
 on (n.id_zam = z.veduci) 
    order by (z.id_zam);
    
    
    
    




