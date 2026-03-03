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
	dni_persona varchar(10) not null,
	id_curso smallint not null,
	fecha_matriculacion date not null
);

alter table matricula add constraint fk_persona_matricula foreign key (dni_persona) references persona(dni);
alter table matricula add constraint fk_curso_matricula foreign key (id_curso) references curso(id);


