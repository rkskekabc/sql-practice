-- outter join

insert into department values(null, '총무팀');
insert into department values(null, '개발팀');
insert into department values(null, '인사팀');
insert into department values(null, '영업팀');

select * from department;

insert into employee values(null, '둘리', 1);
insert into employee values(null, '마이콜', 5);
insert into employee values(null, '또치', 4);
insert into employee values(null, '길동', null);

select * from employee;

-- join ~ on (inner join)
select * from employee a join department b on a.department_no = b.no;

-- left join (outter join)
select a.name, b.name, ifnull(b.name, '없음') from employee a left join department b on a.department_no = b.no;

-- right join (outter join)
select ifnull(a.name, '없음'), b.name from employee a right join department b on a.department_no = b.no;

-- full join (outter join, mysql/mariadb 지원 안함)
select a.name, b.name from employee a -- full join department b on a.department_no = b.no;