create table persons(
	id serial primary key,
	first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address TEXT
);

comment on table persons is 'Физические лица в системе университета';
comment on column persons.id is 'Уникальный идентификатор ФЛ';
comment on column persons.first_name is 'Имя';
comment on column persons.last_name is 'Фамилия';
comment on column persons.date_of_birth is 'Дата рождения';
comment on column persons.email is 'Контактный адрес электронной почты';
comment on column persons.phone_number is 'Контактный номер телефона';
comment on column persons.address is 'Контактный почтовый адрес';

create table teachers (
    id serial primary key,
	person_id INT,
	position_name VARCHAR(500),
	date_start DATE,
	date_end DATE,
	foreign key (person_id) references persons(id)
);

comment on table teachers is 'Преподаватели';
comment on column teachers.id is 'Уникальный идентификатор преподавателя';
comment on column teachers.person_id is 'Ссылка на идентификатор ФЛ';
comment on column teachers.position_name is 'Должность';
comment on column teachers.date_start is 'Дата начала работы';
comment on column teachers.date_end is 'Дата окончания работы';

create table student_groups(
	id serial primary key,
	group_name VARCHAR(500),
	date_start DATE,
	date_end DATE
);

comment on table student_groups is 'Группы обучения';
comment on column student_groups.id is 'Уникальный идентификатор группы обучения';
comment on column student_groups.date_start is 'Дата старта группы';
comment on column student_groups.date_end is 'Дата выпуска группы';

create table students (
    id serial primary key,
    person_id INT,
    group_id INT,
    date_start DATE,
    date_end DATE,
    foreign key (person_id) references persons(id),
    foreign key (group_id) references student_groups(id)
);

comment on table students is 'Студенты';
comment on column students.id is 'Уникальный идентификатор студента';
comment on column students.person_id is 'Ссылка на идентификатор ФЛ';
comment on column students.group_id is 'Ссылка на группу обучения';
comment on column students.date_start is 'Дата начала обучения';
comment on column students.date_end is 'Дата окончания обучения';

create table subjects (
    id serial primary key,
    subject_name VARCHAR(100),
    description TEXT
);

comment on table subjects is 'Преподаваемые предметы';
comment on column subjects.id is 'Уникальный идентификатор преподаваемого предмета';
comment on column subjects.subject_name is 'Наименование предмета';
comment on column subjects.description is 'Описание преподаваемого предмета';

create table courses (
    id serial primary key,
    teacher_id INT,
    subject_id INT,
    course_semester INT CHECK (course_semester BETWEEN 1 AND 2),
    course_year INT,
    foreign key (teacher_id) references teachers(id),
    foreign key (subject_id) references subjects(id)
);

comment on table courses is 'Запланированные для обучения курсы';
comment on column courses.id is 'Уникальный идентификатор запланированного курса';
comment on column courses.teacher_id is 'Ссылка на идентификатор преподавателя';
comment on column courses.subject_id is 'Ссылка на идентификатор предмета';
comment on column courses.course_semester is 'Ссылка на группу обучения';
comment on column courses.course_year is 'Дата начала обучения';

create table student_courses (
    student_id INT,
    course_id INT,
    primary key (student_id, course_id),
    foreign key (student_id) references students(id),
    foreign key (course_id) references courses(id)
);

comment on table student_courses is 'Курсы студентов';
comment on column student_courses.student_id is 'Ссылка на идентификатор студента';
comment on column student_courses.course_id is 'Ссылка на идентификатор курса';

create table grades (
    grade_id serial primary key,
    student_id INT,
    course_id INT,
    grade DECIMAL(3, 1) CHECK (grade BETWEEN 1 AND 5),
    grade_date DATE,
    foreign key (student_id) references students(id),
    foreign key (course_id) references courses(id)
);

comment on table grades is 'Оценки студентов по курсам';
comment on column grades.id is 'Уникальный идентификатор оценки студента';
comment on column grades.student_id is 'Ссылка на идентификатор студента';
comment on column grades.course_id is 'Ссылка на идентификатор курса';
comment on column grades.grade is 'Оценка';
comment on column grades.grade_date is 'Дата оценки';