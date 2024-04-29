DROP DATABASE IF EXISTS pruebas8;
DROP ROLE IF EXISTS pruebas;
DROP ROLE IF EXISTS pruebas;
CREATE ROLE pruebas WITH LOGIN ENCRYPTED PASSWORD 'pruebas';
DROP ROLE IF EXISTS pruebas_admin;
DROP ROLE IF EXISTS pruebas_admin;
CREATE ROLE pruebas_admin WITH LOGIN ENCRYPTED PASSWORD 'admin';
DROP ROLE IF EXISTS pruebas_client;
DROP ROLE IF EXISTS pruebas_client;
CREATE ROLE pruebas_client WITH LOGIN ENCRYPTED PASSWORD 'pruebas_client';
DROP ROLE IF EXISTS pruebas_guest;
DROP ROLE IF EXISTS pruebas_guest;
CREATE ROLE pruebas_guest WITH LOGIN ENCRYPTED PASSWORD 'pruebas_guest';
DROP DATABASE IF EXISTS pruebas8;
CREATE DATABASE pruebas8 WITH OWNER = pruebas ENCODING = 'UTF8' TABLESPACE = pg_default CONNECTION LIMIT = -1;
CREATE TABLE state (
id serial,
name character varying (100),
 CONSTRAINT state_pkey PRIMARY KEY (id))
WITH (
OIDS=FALSE
);
ALTER TABLE public.state
 OWNER TO pruebas;

 grant insert, select, update, delete on state to pruebas_admin;

 grant select on state to pruebas_client;
CREATE TABLE role (
id serial,
name character varying (100),
state int,
 CONSTRAINT role_pkey PRIMARY KEY (id),
 CONSTRAINT role_state_id_fkey FOREIGN KEY (id)
 REFERENCES public.state (id) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.role
 OWNER TO pruebas;

 grant insert, select, update, delete on role to pruebas_admin;

 grant select on role to pruebas_client;
