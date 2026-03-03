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


