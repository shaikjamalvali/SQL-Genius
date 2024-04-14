create table person (
	height float unique,
	pid int,
	name char(32),
	identity char(128) unique,
	age int unique,
	primary key(pid)
);
insert into person values (1300.0, 0, "MICROSOFT", "cf0a238-814318bedbc7", 0);
insert into person values (1301.0, 1, "AMAZON", "e232784c-1b11e1", 1);
insert into person values (1302.0, 2, "ORACLE", "4d35dc33-a81a-db1d92", 2);
insert into person values (1303.0, 3, "Jp MORGAN", "6e02007b-1fba-4fd836", 3);
insert into person values (1304.0, 4, "GOLDMANSACHS", "428f0030-f953-54", 4);
insert into person values (1305.0, 5, "de SHAW", "8d6440f3-8b50ed", 5);
insert into person values (2299.0, 999, "DREAM", "34a46445-5240-43db260aaa", 999);
create index idx_height on person(height);
create index idx_identity on person(identity);
create index idx_age on person(age);
