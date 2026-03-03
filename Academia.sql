-- Añado la instrucción de creación de schema.
create schema if not exists academia;

set schema 'academia';

create table if not exists persona (
	dni varchar(10) primary key,
	nombre varchar(20) not null,
	apellidos varchar(50) not null,
	fecha_nacimiento date,
	email varchar(50) not null,
	telefono int,
	movil int
);

create table if not exists curso (
	id smallserial primary key,
	nombre varchar(50) not null
);

/*
 * Ejemplo de creación con claves foráneas
 * 
create table if not exists matricula (
	id smallserial primary key,
	dni_persona varchar(10) not null,
	id_curso smallint not null,
	fecha_matriculacion date not null,
	constraint fk_persona_matricula foreign key (dni_persona) references persona(dni),
	constraint fk_curso_matricula foreign key (id_curso) references curso(id)
);
*/

create table if not exists matricula (
	id smallserial primary key,
	dni_alumno varchar(10) not null,
	id_curso smallint not null,
	fecha_matriculacion date not null
);

create table if not exists datos_postales (
	dni varchar(10) primary key,
	direccion varchar(100) not null,
	id_poblacion int not null
);

create table if not exists provincia (
	id smallserial primary key,
	provincia varchar(30) not null
);

create table if not exists poblacion (
	id serial primary key,
	poblacion varchar(30) not null,
	id_provincia smallint not null
);

create table if not exists calificacion (
	id serial primary key,
	dni_alumno varchar(10) not null,
	id_asignatura smallint not null,
	calificacion smallint not null
);

create table if not exists asignatura (
	id serial primary key,
	dni_profesor varchar(10) not null,
	nombre varchar(30) not null
);

create table if not exists asignatura_por_curso (
	id serial primary key,
	id_asignatura smallint not null,
	id_curso smallint not null
);

alter table matricula add constraint fk_persona_matricula foreign key (dni_alumno) references persona(dni);
alter table matricula add constraint fk_curso_matricula foreign key (id_curso) references curso(id);

alter table asignatura_por_curso add constraint fk_asignatura_asignatura_por_curso foreign key (id_asignatura) references asignatura(id);
alter table asignatura_por_curso add constraint fk_curso_asignatura_por_curso foreign key (id_curso) references curso(id);

alter table calificacion add constraint fk_persona_calificacion foreign key (dni_alumno) references persona(dni);
alter table calificacion add constraint fk_asignatura_calificacion foreign key (id_asignatura) references  asignatura(id);

alter table datos_postales add constraint fk_persona_datos_postales foreign key (dni) references persona(dni);
alter table datos_postales add constraint fk_poblacion_datos_postales foreign key (id_poblacion) references poblacion(id);

alter table poblacion add constraint fk_provincia_poblacion foreign key (id_provincia) references provincia(id);

alter table asignatura add constraint fk_persona_asignatura foreign key (dni_profesor) references persona(dni);


/*
 * Para evitar valores duplicados de tipo varchar en una tabla, sin importar mayúsculas y minúsculas,
 * no sirve con una constraint de tipo unique. Hay que crear un índice (index) de tipo unique,
 * porque nos permite hacer una comparación transformando la información:
 */

create unique index unique_provincia on provincia (lower(provincia)); 
create unique index unique_asignatura on asignatura (lower(nombre));

/*
 * Lo que está pasando aquí es que convierte el contenido existente y el que se va a insertar 
 * con INSERT INTO a minúsculas con lower. Por tanto, si tengo "Murcia" y quiero insertar "murCIA",
 * convierte ambas a minúsculas primero y luego hace la comparación, quedando que "murcia" es igual a "murcia",
 * violando la restricción e impidiendo el guardado 👍🏻
 */

/* 
 * También podemos restringir valores en función a una expresión booleana, como si fuera un where:
 */
alter table calificacion add constraint check_calificacion check (calificacion between 0 and 10);

/*
 * Esto está comprobando que la columna calificación no pueda tener valores que NO estén entre 0 y 10.
 * Una alternativa sería:
 * 
 * alter table calificacion add constraint check_calificacion check (calificacion >= 0 and calificacion <= 10);
 * 
 */

/*
 * También se pueden restrigir combinaciones de columnas con una constraint unique:
 */

alter table calificacion add constraint unique_calificacion_alumno_asignatura unique (dni_alumno, id_asignatura);


/*
 * Esto impide que pueda tener dos calificaciones para el mismo alumno en la misma asignatura, lo cual no tendría sentido.
 * Si podría tener calificaciones para ese alumno en otras asignaturas o calificaciones de esa asignatura para otros alumnos.
 */


