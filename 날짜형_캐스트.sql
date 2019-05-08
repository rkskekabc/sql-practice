-- 날짜형 함수

select curdate(), current_date;

select curtime(), current_time;

select now(), sysdate(), current_timestamp;

select now(), sleep(2), now(); -- 실행되기 전에 계산된 시간(고정)

select sysdate(), sleep(2), sysdate(); -- 현재시간(바뀜)

select date_format(now(), '%Y년 %c월 %d일 %h시 %i분 %s초');

SELECT concat(first_name, ' ', last_name) AS name, PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m'),
		DATE_FORMAT(hire_date, '%Y%m') ) FROM employees;
        
select first_name, hire_date, date_add(hire_date, interval 5 month) from employees;

select cast(now() as date);

select cast(1-2 as unsigned);

select cast(cast(1-2 as unsigned) as signed);