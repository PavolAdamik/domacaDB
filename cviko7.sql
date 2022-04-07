select * from OS_UDAJE
    where ROD_CISLO in (select ROD_CISLO from STUDENT);

select distinct OS_UDAJE.* from OS_UDAJE
    join STUDENT S on OS_UDAJE.ROD_CISLO = S.ROD_CISLO;
--tomuto musim dorobit este
--grouped by vie este potlacit duplicity

--viem urobit antijoin cez join <? nie .. cez autojoin uz hej..ale je to neefektivne


--ku kazdemu zamestnavatelovi vypis pocet zamestnancov
select nazov, id_zamestnavatela, ICO, COUNT(ID_ZAMESTNAVATELA) from P_ZAMESTNANEC
     join P_ZAMESTNAVATEL PZ on (P_ZAMESTNANEC.ID_ZAMESTNAVATELA = PZ.ICO)
    group by id_zamestnavatela, ICO, NAZOV;
--vypise to aj tych zamestnavatelov ktori nemaju ziadnych zamestnancov ? .. nie

--namiesto * v count dam idcko
-- z tej pravej tabulky beriem vsetko
select nazov, id_zamestnavatela, ICO, COUNT(ID_ZAMESTNAVATELA) from P_ZAMESTNANEC
    right join P_ZAMESTNAVATEL PZ on (P_ZAMESTNANEC.ID_ZAMESTNAVATELA = PZ.ICO)
        group by id_zamestnavatela, ICO, NAZOV;

-- v soc. poistovni left join a ten druhy inner.. vrati rovnako lebo not null\

--vypis zamestnavatela ktory ma najviac zamestnancov
select NAZOV,ICO, count(ID_ZAMESTNAVATELA) pocet from P_ZAMESTNANEC t2
    join P_ZAMESTNAVATEL t1 on (t1.ICO = t2.ID_ZAMESTNAVATELA)
        having count(ID_ZAMESTNAVATELA) >= max(count(ID_ZAMESTNAVATELA))
             group by ICO, NAZOV;
-- toto nepojde lebo to ide len v selekte

select NAZOV,ICO, count(ID_ZAMESTNAVATELA) pocet from P_ZAMESTNANEC t2
    join P_ZAMESTNAVATEL t1 on (t1.ICO = t2.ID_ZAMESTNAVATELA)
        having count(ID_ZAMESTNAVATELA) >= (select max(count(ID_ZAMESTNAVATELA)) pocet from p_zamestnanec t2
            group by ID_ZAMESTNAVATELA)
                group by ICO, NAZOV;

--vypis ku kazdej osobe ku kazdemu roku celkove odvody
--kolko dana osoba zaplatila na odvodoch ale chce to po rokoch
select ROD_CISLO, rok, sum(celkova_suma) from
    (select ROD_CISLO, trunc(DAT_PLATBY, 'YYYY') rok, -sum(SUMA) celkova_Suma from P_ODVOD_PLATBA
        join P_POISTENIE PP on (PP.ID_POISTENCA = P_ODVOD_PLATBA.ID_POISTENCA)
            group by trunc(DAT_PLATBY, 'YYYY'), ROD_CISLO
            union

            select ROD_CISLO, trunc(KEDY, 'YYYY') , sum(SUMA) from P_PRISPEVKY
                join P_POBERATEL using (id_poberatela)
                    group by trunc(KEDY, 'YYYY'), ROD_CISLO)
group by ROD_CISLO, rok;

--dolezite cviko !!
--autojoiny, group by .. atd

select ROD_CISLO from STUDENT;

select substr(ROD_CISLO, 1,6 ) from STUDENT;--jeho rok

select to_char(sysdate, 'YYmmdd') from dual; -- aktualny

select min(
    select to_char(sysdate, 'YYmmdd') from dual -
        select substr(ROD_CISLO, 1,6 )) as vek from STUDENT;

select min(substr(rod_cislo)) from STUDENT;



