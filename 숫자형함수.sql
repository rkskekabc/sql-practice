-- 숫자형 함수

select mod(234, 10), 234 % 10;

select floor(1.2345), floor(-1.2345);

select ceiling(1.2345), ceiling(-1.2345);

select round(-1.23), round(-1.58), round(1.58), round(1.298, 1), round(1.298, 0);

select pow(2, 2), power(2, -2);

select sign(-10), sign(10), sign(0);

select greatest(98, 60, 30), greatest('B', 'A', 'CB', 'CA');

select least(98, 60, 30), least('B', 'A', 'CB', 'CA');