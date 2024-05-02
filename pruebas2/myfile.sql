DROP DATABASE IF EXISTS pruebas1;
DROP ROLE IF EXISTS pruebas1;
CREATE ROLE pruebas1 WITH LOGIN ENCRYPTED PASSWORD 'pruebas1';
DROP ROLE IF EXISTS pruebas_admin;
CREATE ROLE pruebas_admin WITH LOGIN ENCRYPTED PASSWORD 'pruebas_admin';
DROP ROLE IF EXISTS pruebas_client;
CREATE ROLE pruebas_client WITH LOGIN ENCRYPTED PASSWORD 'pruebas_client';
DROP ROLE IF EXISTS pruebas_guest;
CREATE ROLE pruebas_guest WITH LOGIN ENCRYPTED PASSWORD 'pruebas_guest';
DROP DATABASE IF EXISTS pruebas1;
CREATE DATABASE pruebas1
 WITH
 OWNER = pruebas1
 ENCODING = 'UTF8'
 TABLESPACE = pg_default
 CONNECTION LIMIT = -1;
CREATE TABLE pais (
id serial,
nombre character varying (25),
codigo int,
acronimo character varying (3),
CONSTRAINT pais_pkey PRIMARY KEY (id)
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.pais
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON pais TO pruebas_admin;
GRANT select ON pais TO pruebas_client;
CREATE TABLE departamento (
id serial,
nombre character varying (25),
pais int,
codigo int,
acronimo character varying (3),
CONSTRAINT departamento_pkey PRIMARY KEY (id),
CONSTRAINT departamento_pais_fkey FOREIGN KEY (pais)
	REFERENCES public.pais (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.departamento
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON departamento TO pruebas_admin;
GRANT select ON departamento TO pruebas_client;
CREATE TABLE municipio (
id serial,
nombre character varying (25),
departamento int,
codigo character varying (10),
acronimo character varying (3),
CONSTRAINT municipio_pkey PRIMARY KEY (id),
CONSTRAINT municipio_departamento_fkey FOREIGN KEY (departamento)
	REFERENCES public.departamento (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.municipio
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON municipio TO pruebas_admin;
GRANT select ON municipio TO pruebas_client;
CREATE TABLE tipoentidad (
id serial,
nombre character varying (50),
estado int,
CONSTRAINT tipoentidad_pkey PRIMARY KEY (id),
CONSTRAINT tipoentidad_estado_fkey FOREIGN KEY (estado)
	REFERENCES public.estado (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.tipoentidad
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON tipoentidad TO pruebas_admin;
GRANT select ON tipoentidad TO pruebas_client;
CREATE TABLE entidad (
id serial,
nombre character varying (50),
municipio int,
codigo character varying (10),
tipoentidad int,
estado int,
comuna character varying (50),
geolocalizacion character varying (100),
CONSTRAINT entidad_pkey PRIMARY KEY (id),
CONSTRAINT entidad_municipio_fkey FOREIGN KEY (municipio)
	REFERENCES public.municipio (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
CONSTRAINT entidad_tipoentidad_fkey FOREIGN KEY (tipoentidad)
	REFERENCES public.tipoentidad (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
CONSTRAINT entidad_estado_fkey FOREIGN KEY (estado)
	REFERENCES public.estado (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.entidad
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON entidad TO pruebas_admin;
GRANT select ON entidad TO pruebas_client;
CREATE TABLE perfil (
id serial,
nombre character varying (100),
descripcion character varying (255),
estado int,
codigo character varying (20),
CONSTRAINT perfil_pkey PRIMARY KEY (id),
CONSTRAINT perfil_estado_fkey FOREIGN KEY (estado)
	REFERENCES public.estado (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.perfil
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON perfil TO pruebas_admin;
GRANT select ON perfil TO pruebas_client;
CREATE TABLE tipo_identificacion (
id serial,
nombre character varying (100),
CONSTRAINT tipo_identificacion_pkey PRIMARY KEY (id)
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.tipo_identificacion
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON tipo_identificacion TO pruebas_admin;
GRANT select ON tipo_identificacion TO pruebas_client;
CREATE TABLE persona (
id serial,
nombre character varying (50),
apellido character varying (50),
tipo_identificacion int,
num_identificacion character varying (20),
genero character,
fecha_nacimiento date,
email character varying (255),
direccion character varying (255),
celular character varying (10),
estado int,
CONSTRAINT persona_pkey PRIMARY KEY (id),
CONSTRAINT persona_tipo_identificacion_fkey FOREIGN KEY (tipo_identificacion)
	REFERENCES public.tipo_identificacion (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
CONSTRAINT persona_estado_fkey FOREIGN KEY (estado)
	REFERENCES public.estado (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.persona
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON persona TO pruebas_admin;
GRANT select ON persona TO pruebas_client;
CREATE TABLE usuario (
id serial,
login_username character varying (50),
persona int,
estado int,
CONSTRAINT usuario_pkey PRIMARY KEY (id),
CONSTRAINT usuario_persona_fkey FOREIGN KEY (persona)
	REFERENCES public.persona (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
CONSTRAINT usuario_estado_fkey FOREIGN KEY (estado)
	REFERENCES public.estado (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.usuario
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON usuario TO pruebas_admin;
GRANT select ON usuario TO pruebas_client;
CREATE TABLE usuario_perfil (
id serial,
usuario int,
perfil int,
estado int,
CONSTRAINT usuario_perfil_pkey PRIMARY KEY (id),
CONSTRAINT usuario_perfil_usuario_fkey FOREIGN KEY (usuario)
	REFERENCES public.usuario (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
CONSTRAINT usuario_perfil_perfil_fkey FOREIGN KEY (perfil)
	REFERENCES public.perfil (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
CONSTRAINT usuario_perfil_estado_fkey FOREIGN KEY (estado)
	REFERENCES public.estado (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.usuario_perfil
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON usuario_perfil TO pruebas_admin;
GRANT select ON usuario_perfil TO pruebas_client;
CREATE TABLE estado (
id serial,
nombre character varying (100),
descripcion character varying (255),
CONSTRAINT estado_pkey PRIMARY KEY (id)
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.estado
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON estado TO pruebas_admin;
GRANT select ON estado TO pruebas_client;
CREATE TABLE sesion (
id serial,
usuario int,
fecha_hora_start timestamp,
fecha_hora_end timestamp,
ip character varying (100),
CONSTRAINT sesion_pkey PRIMARY KEY (id),
CONSTRAINT sesion_usuario_fkey FOREIGN KEY (usuario)
	REFERENCES public.usuario (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.sesion
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON sesion TO pruebas_admin;
GRANT select ON sesion TO pruebas_client;
CREATE TABLE modulo (
id serial,
nombre character varying (50),
descripcion character varying (100),
estado int,
url character varying (255),
CONSTRAINT modulo_pkey PRIMARY KEY (id),
CONSTRAINT modulo_estado_fkey FOREIGN KEY (estado)
	REFERENCES public.estado (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.modulo
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON modulo TO pruebas_admin;
GRANT select ON modulo TO pruebas_client;
CREATE TABLE tipo_permiso (
id serial,
nombre character varying (10),
CONSTRAINT tipo_permiso_pkey PRIMARY KEY (id)
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.tipo_permiso
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON tipo_permiso TO pruebas_admin;
GRANT select ON tipo_permiso TO pruebas_client;
CREATE TABLE permisos (
id serial,
perfil int,
modulo int,
tipo_permiso int,
CONSTRAINT permisos_pkey PRIMARY KEY (id),
CONSTRAINT permisos_perfil_fkey FOREIGN KEY (perfil)
	REFERENCES public.perfil (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
CONSTRAINT permisos_modulo_fkey FOREIGN KEY (modulo)
	REFERENCES public.modulo (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
CONSTRAINT permisos_tipo_permiso_fkey FOREIGN KEY (tipo_permiso)
	REFERENCES public.tipo_permiso (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.permisos
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON permisos TO pruebas_admin;
GRANT select ON permisos TO pruebas_client;
CREATE TABLE panelcontrol (
id serial,
nombre character varying (100),
descripcion character varying (255),
estado int,
CONSTRAINT panelcontrol_pkey PRIMARY KEY (id),
CONSTRAINT panelcontrol_estado_fkey FOREIGN KEY (estado)
	REFERENCES public.estado (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.panelcontrol
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON panelcontrol TO pruebas_admin;
GRANT select ON panelcontrol TO pruebas_client;
CREATE TABLE panelcontrol_menu (
id serial,
nombre character varying (100),
CONSTRAINT panelcontrol_menu_pkey PRIMARY KEY (id)
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.panelcontrol_menu
 OWNER TO pruebas1;
GRANT insert, select, update, delete ON panelcontrol_menu TO pruebas_admin;
GRANT select ON panelcontrol_menu TO pruebas_client;
