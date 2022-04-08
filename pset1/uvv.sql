CREATE ROLE "d_test" WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '123456';
COMMENT ON ROLE "d_test" IS 'Usuário "Dono" do banco de dados. Pode criar, editar e apagar quaisquer tabelas, schemas e até o próprio banco de dados.';

CREATE USER d_owner WITH ROLE d_test;

CREATE DATABASE testing
    WITH 
    OWNER = "d_owner"
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
	LC_CTYPE = 'pt_BR.UTF-8'
    CONNECTION LIMIT = -1;

CREATE SCHEMA elmasri AUTHORIZATION "d_owner";

ALTER USER "d_owner"
SET SEARCH_PATH TO elmasri, "\user", public;

CREATE TABLE table_nome (
    nome VARCHAR(15) NOT NULL,
    PRIMARY KEY (nome)

)

