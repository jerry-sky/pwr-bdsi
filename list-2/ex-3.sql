Create Table If not exists zwierzak
(
    name    varchar(20),
    owner   varchar(20),
    species varchar(20),
    sex     char(1),
    birth   date,
    death   date
);
Insert Into `zwierzak` (`name`, `owner`, species, sex, birth, death)
Select *
From menagerie.pet;
Insert Into Hobby.osoba (`imię`, `dataUrodzenia`, `plec`)
Select Distinct(`owner`),
               '1999-05-23',
               'm'
From menagerie.pet;