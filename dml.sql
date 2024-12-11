-- Список студентов по определённому предмету
select p.first_name, p.last_name
from persons p
join students s on p.id = s.person_id
join student_courses sc on s.id = sc.student_id
join courses c on sc.course_id = c.id
join subjects sub on c.subject_id = sub.id
where sub.subject_name = 'Математика';

--Список предметов, которые преподаёт конкретный преподаватель
select sub.subject_name
from courses c
join subjects sub ON c.subject_id = sub.id
where c.teacher_id = 1;  -- Идентификатор преподавателя

--Средний балл студента по всем предметам
select p.first_name, p.last_name, AVG(g.grade) AS average_grade
from persons p
join students s on p.id = s.person_id
join grades g ON s.id = g.student_id
GROUP BY s.id, p.first_name, p.last_name;

--Рейтинг преподавателей по средней оценке студентов
select p.first_name, p.last_name, AVG(g.grade) AS average_grade
from persons p
join students s on p.id = s.person_id
join grades g ON s.id = g.student_id
GROUP BY s.id, p.first_name, p.last_name;

--Преподаватели, которые преподавали более 3 предметов за последний год
select p.first_name, p.last_name, AVG(g.grade) AS average_grade
from persons p
join teachers t on p.id = t.person_id
join courses c on t.id = c.teacher_id
join grades g on c.id = g.course_id
group by t.id, p.first_name, p.last_name
order by average_grade desc, p.first_name, p.last_name;

--Студенты с высоким баллом по математике и низким по гуманитарным
select p.first_name, p.last_name
from persons p
join students s on p.id = s.person_id
join student_courses sc on s.id = sc.student_id
join courses c on sc.course_id = c.id
join subjects sub on c.subject_id = sub.id
join grades g on g.student_id = s.id and g.course_id = c.id
where sub.subject_name in ('Математика', 'Гуманитарные науки')
group by s.id, p.first_name, p.last_name
having AVG(case when sub.subject_name = 'Математика' then g.grade else null end) > 4
   and AVG(case when sub.subject_name = 'Гуманитарные науки' then g.grade else null end) < 3;


--Предметы, по которым больше всего двоек в текущем семестре
select sub.subject_name, COUNT(g.grade) AS two_count
from grades g
join courses c on g.course_id = c.id
join subjects sub on c.subject_id = sub.id
where g.grade = 2 and c.course_semester = 1  -- Текущий семестр
group by sub.subject_name
order by two_count desc;

--Вставка нового студента
with new_person as (insert into persons (first_name, last_name, date_of_birth, email, phone_number, address)
values ('Иван', 'Иванов', '2000-06-01', 'ivanov@mail.com', '1234567890', 'Москва, ул. Строителей, 1') returning id)
insert into students values ((select id from new_person));

--Обновление контактной информации преподавателя
update persons
set email = 'new_email@mail.com', phone_number = '9876543210'
where id = (select t.person_id from teachers t where id = 1);

--Удаление записи о предмете
delete from subjects
where id = 1;

--Вставка новой оценки
insert into grades (student_id, course_id, grade, grade_date)
values (1, 1, 4.5, '2024-12-12');