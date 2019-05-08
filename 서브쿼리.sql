-- 1)
select b.dept_no from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and concat(a.first_name, ' ', a.last_name) = 'Fai Bale';

-- 2)
select * from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.dept_no = 'd004';

-- subquery
select * from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.dept_no = (select b.dept_no from employees a, dept_emp b
				where a.emp_no = b.emp_no
				and b.to_date = '9999-01-01'
				and concat(a.first_name, ' ', a.last_name) = 'Fai Bale');

-- 단일행인 경우
-- <, >, =, !=, <=, >=
-- ex1) 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여를 나타내세요.
select a.first_name, b.salary from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.salary < (select avg(salary) from salaries where to_date = '9999-01-01') 
order by b.salary desc;

-- ex2) 현재 가장적은 평균 급여를 받고 있는 직책에 대해서 평균 급여를 구하세요
-- ex2-1)
select b.title, round(avg(a.salary)) as avg_salary from salaries a, titles b where a.emp_no = b.emp_no 
and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
group by b.title
having avg_salary = (select min(avg_salary)
					from (select round(avg(a.salary)) as avg_salary from salaries a, titles b where a.emp_no = b.emp_no 
					and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
					group by b.title) a);

-- ex2-2) top-k
select b.title, avg(a.salary) as avg_salary from salaries a, titles b where a.emp_no = b.emp_no 
and a.to_date = '9999-01-01' and b.to_date = '9999-01-01'
group by b.title order by avg_salary asc limit 0, 1;

-- 다중행
-- in (not in)

-- any
-- = any(in 동일), > any, < any, <> any(!= all 동일), <= any, >= any

-- all
-- = all, > all, < all, <= all, >= all

-- 예제: 현재 급여가 50000 이상인 직원 이름 출력
-- sol1) 조인 해결
select a.first_name, b.salary from employees a, salaries b where a.emp_no = b.emp_no 
and b.to_date = '9999-01-01'
and b.salary > 50000;

-- sol2) 서브쿼리 해결
select a.first_name, b.salary from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and (a.emp_no, b.salary) = any(select emp_no, salary from salaries where to_date = '9999-01-01'
								and salary > 50000);
                                
select a.first_name, b.salary from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and (a.emp_no, b.salary) in (select emp_no, salary from salaries where to_date = '9999-01-01'
								and salary > 50000);

select a.first_name, b.salary
from employees a, (select emp_no, salary from salaries where to_date = '9999-01-01'
		and salary > 50000) b
where a.emp_no = b.emp_no;

-- 각 부서별로 최고 월급을 받는 직원의 이름과 월급을 출력
select c.dept_no, max(b.salary) as max_salary from employees a, salaries b, dept_emp c where a.emp_no = b.emp_no and b.emp_no = c.emp_no
and b.to_date = '9999-01-01' and c.to_date = '9999-01-01' group by c.dept_no;

-- sol1) where 절에 subquery를 사용
select a.first_name, c.dept_no, b.salary from employees a, salaries b, dept_emp c where a.emp_no = b.emp_no and b.emp_no = c.emp_no
and b.to_date = '9999-01-01' and c.to_date = '9999-01-01' 
and (c.dept_no, b.salary) = any(select c.dept_no, max(b.salary) as max_salary from employees a, salaries b, dept_emp c where a.emp_no = b.emp_no and b.emp_no = c.emp_no
								and b.to_date = '9999-01-01' and c.to_date = '9999-01-01' group by c.dept_no);

-- sol2) from 절에 subquery를 사용하는 방법
select a.first_name, c.dept_no, b.salary 
from employees a, salaries b, dept_emp c, 
		(select c.dept_no, max(b.salary) as max_salary from employees a, salaries b, dept_emp c where a.emp_no = b.emp_no and b.emp_no = c.emp_no
		and b.to_date = '9999-01-01' and c.to_date = '9999-01-01' group by c.dept_no) d
where a.emp_no = b.emp_no and b.emp_no = c.emp_no and c.dept_no = d.dept_no
and b.to_date = '9999-01-01' and c.to_date = '9999-01-01'
and b.salary = d.max_salary