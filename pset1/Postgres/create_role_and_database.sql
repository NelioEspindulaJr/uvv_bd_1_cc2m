CREATE ROLE "nelio" WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD '123456';
COMMENT ON ROLE "nelio" IS 'Usuário "Dono" do banco de dados. Pode criar, editar e apagar quaisquer tabelas, schemas e até o próprio banco de dados.';

CREATE DATABASE uvv
    WITH 
    OWNER = "nelio"
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
	LC_CTYPE = 'pt_BR.UTF-8'
    CONNECTION LIMIT = -1;