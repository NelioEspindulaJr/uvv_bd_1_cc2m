/*
No banco de dados MySQL não existem Schemas e Databases, pois eles agem como um só.
Por isso, decidi criar o banco de dados `elmasri`, ao invés de `uvv`
*/


-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- create_user.sql
CREATE USER 'Nelio'@'localhost' IDENTIFIED BY '123456';
GRANT ALL ON elmasri.* TO 'Nelio'@'localhost';


-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- create_database.sql
CREATE DATABASE `elmasri` 
COLLATE 'latin1_general_ci'


-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- create_tables.sql
CREATE TABLE elmasri.departamento(
    numero_departamento INTEGER NOT NULL DEFAULT 1,
    cpf_gerente CHAR(11),
    nome_departamento VARCHAR(15) NOT NULL,
    data_inicio_gerente DATE,
    PRIMARY KEY (numero_departamento)
); 
-- Alternative Key da relacao departamento no atributo nome_departamento
CREATE UNIQUE INDEX nome_departamento_idx ON elmasri.departamento (nome_departamento);

CREATE TABLE elmasri.funcionario(
    cpf CHAR(11) NOT NULL,
    primeiro_nome VARCHAR(15) NOT NULL,
    nome_meio CHAR(1),
    ultimo_nome VARCHAR(15) NOT NULL,
    data_nascimento DATE,
    endereco VARCHAR(50),
    sexo CHAR(1) CHECK (sexo IN ('M', 'F')), -- sexo tem valores apenas como: M ou F
    salario DECIMAL(10, 2) CHECK (salario > 0), -- salario apenas positivo
    cpf_supervisor CHAR(11) REFERENCES elmasri.funcionario(cpf),
    numero_departamento INTEGER NOT NULL REFERENCES elmasri.departamento(numero_departamento),
    PRIMARY KEY (cpf)
);

CREATE TABLE elmasri.projeto(
    numero_projeto INTEGER NOT NULL,
    nome_projeto VARCHAR(15) NOT NULL,
    local_projeto VARCHAR(15),
    numero_departamento INTEGER NOT NULL REFERENCES elmasri.departamento(numero_departamento),
    PRIMARY KEY (numero_projeto)
);
CREATE UNIQUE INDEX nome_projeto_idx ON elmasri.projeto (nome_projeto);

CREATE TABLE elmasri.trabalha_em(
    cpf_funcionario CHAR(11) NOT NULL REFERENCES elmasri.funcionario(cpf),
    numero_projeto INTEGER NOT NULL REFERENCES elmasri.projeto(numero_projeto),
    horas DECIMAL (3,1) CHECK (horas > 0), -- numero horas de trabalho apenas positivo
    PRIMARY KEY (cpf_funcionario, numero_projeto)
);

CREATE TABLE elmasri.dependente(
    cpf_funcionario CHAR(11) NOT NULL REFERENCES elmasri.funcionario(cpf),
    nome_dependente VARCHAR(15) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('M', 'F')),
    data_nascimento DATE,
    parentesco VARCHAR(15),
    PRIMARY KEY (cpf_funcionario, nome_dependente)
);

CREATE TABLE elmasri.localizacoes_departamento(
    numero_departamento INTEGER NOT NULL REFERENCES elmasri.departamento(numero_departamento),
    local VARCHAR(15) NOT NULL,
    PRIMARY KEY (numero_departamento, local)
);

-- Inseri as informacoes de departamento primeiro, pois, sao necessarias para inserir o restante dos dados 
INSERT INTO elmasri.departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES
('Matriz', 1, '88866555576', '1981-06-19'),
('Pesquisa', 5, '98765432168', '1998-05-22'),
('Administracao', 4, '33344555587', '1995-01-01');

-- SECAO DOS COMENTARIOS PARA OS METADADOS DO SGBD
ALTER TABLE elmasri.funcionario COMMENT 'Tabela que armazena as informações dos funcionários.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'CPF do funcionário. Será a PK da tabela.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'Primeiro nome do funcionário.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Sobrenome do funcionário.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN endereco VARCHAR(30) COMMENT 'Endereço do funcionário';

ALTER TABLE elmasri.funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do funcionário.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN cpf_supervisor CHAR(11) COMMENT 'o-relacionamento).';

ALTER TABLE elmasri.funcionario MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento do funcionário. Valor padrão é "0".';

ALTER TABLE elmasri.departamento COMMENT 'Tabela que armazena as informaçoẽs dos departamentos.';

ALTER TABLE elmasri.departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É a PK desta tabela.';

ALTER TABLE elmasri.departamento MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'Nome do departamento. Deve ser único.';

ALTER TABLE elmasri.departamento MODIFY COLUMN data_inicio_gerente DATE COMMENT 'Data do início do gerente no departamento.';

ALTER TABLE elmasri.localizacoes_departamento COMMENT 'Tabela que armazena as possíveis localizações dos departamentos.';

ALTER TABLE elmasri.localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'm é uma FK para a tabela departamento.';

ALTER TABLE elmasri.localizacoes_departamento MODIFY COLUMN local VARCHAR(15) COMMENT 'Localização do departamento. Faz parte da PK desta tabela.';

ALTER TABLE elmasri.projeto COMMENT 'Tabela que armazena as informações sobre os projetos dos departamentos.';

ALTER TABLE elmasri.projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto. É a PK desta tabela.';

ALTER TABLE elmasri.projeto MODIFY COLUMN nome_projeto VARCHAR(15) COMMENT 'Nome do projeto. Deve ser único.';

ALTER TABLE elmasri.projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Localização do projeto.';

ALTER TABLE elmasri.projeto MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É uma FK para a tabela departamento.';

ALTER TABLE elmasri.trabalha_em COMMENT 'Tabela para armazenar quais funcionários trabalham em quais projetos.';

ALTER TABLE elmasri.trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'para a tabela funcionário.';

ALTER TABLE elmasri.trabalha_em MODIFY COLUMN numero_projeto INTEGER COMMENT 'ara a tabela projeto.';

ALTER TABLE elmasri.trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Horas trabalhadas pelo funcionário neste projeto.';

ALTER TABLE elmasri.dependente COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários.';

ALTER TABLE elmasri.dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'para a tabela funcionário.';

ALTER TABLE elmasri.dependente MODIFY COLUMN nome_dependente VARCHAR(15) COMMENT 'Nome do dependente. Faz parte da PK desta tabela.';

ALTER TABLE elmasri.dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do dependente.';

ALTER TABLE elmasri.dependente MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do dependente.';

ALTER TABLE elmasri.dependente MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'Descrição do parentesco do dependente com o funcionário.';


-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- insert_data.sql
INSERT INTO elmasri.funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES
    ('Jorge', 'E', 'Brito', '88866555576','1937-11-10', 'Rua do Horto, 35, Sao Paulo, SP', 'M', 55000, NULL, 1);


-- DEPOIS DE DEFINIR JORGE, INSERI OS OUTROS DOIS GERENTES UTILIZANDO O VALOR PADRÃO '1' DE numero_departamento 
INSERT INTO elmasri.funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES
    ('Fernando', 'T', 'Wong', '33344555587','1995-12-08', 'Rua da Lapa, 34, Sao Paulo, SP', 'M', 40000, '88866555576', 1),
    ('Jennifer', 'S', 'Souza', '98765432168','1941-06-20', 'Av. Arthur de Lima, 54, Santo Andre, SP', 'F', 43000, '88866555576', 1);

/* 
Criacao da Fk(foreign key) da tabela departamento referenciando a tabela funcionario.
Foi criada apenas agora, para evitar problemas de relacionamento entre tais tabelas (incompatibilidade nas relacoes).
*/
ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk FOREIGN KEY (cpf_gerente) REFERENCES elmasri.funcionario (cpf) ON UPDATE NO ACTION;

-- DADOS DOS DEMAIS FUNCIONARIOS INSERIDOS.
INSERT INTO elmasri.funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) 
VALUES
    ('Joao', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, Sao Paulo, SP', 'M', 30000, '33344555587', 5),
    ('Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, '98765432168', 4),
    ('Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Reboucas, 65, Piracicaba, SP', 'M', 38000, '33344555587', 5),
    ('Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av. Lucas Obes, 74, Sao Paulo, SP','F', 25000, '33344555587', 5),
    ('Andre', 'V', 'Pereira', '98798798733', '1969-03-29', 'Rua Timbira, 35, Sao Paulo, SP', 'M', 25000, '98765432168', 4);

-- DADOS DA TABELA DE LOCALIZACOES DE DEPARTAMENTO
INSERT INTO elmasri.localizacoes_departamento (numero_departamento, local)
VALUES
    (1, 'Sao Paulo'),
    (4, 'Maua'),
    (5, 'Santo Andre'),
    (5, 'Itu'),
    (5, 'Sao Paulo');

-- DADOS TABELA DE PROJETOS
INSERT INTO elmasri.projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
VALUES
    ('ProdutoX', 1, 'Santo Andre', 5),
    ('ProdutoY', 2, 'Itu', 5),
    ('ProdutoZ', 3, 'Sao Paulo', 5),
    ('Informatizacao', 10, 'Maua', 4),
    ('Reorganizacao', 20, 'Sao Paulo', 1),
    ('NovosBeneficios', 30, 'Maua', 4);

-- DADOS TABELA DEPENDENTE
INSERT INTO elmasri.dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES
    ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
    ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
    ('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa'),
    ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
    ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
    ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
    ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

-- DADOS TABELA TRABALHA EM
INSERT INTO elmasri.trabalha_em (cpf_funcionario, numero_projeto, horas)
VALUES
    ('12345678966', 1, 32.5),
    ('12345678966', 2, 7.5),
    ('66688444476', 3, 40.0),
    ('45345345376', 1, 20.0),
    ('45345345376', 2, 20.0),
    ('33344555587', 2, 10.0),
    ('33344555587', 3, 10.0),
    ('33344555587', 10, 10.0),
    ('33344555587', 20, 10.0),
    ('99988777767', 30, 30.0),
    ('99988777767', 10, 10.0),
    ('98798798733', 10, 10.0),
    ('98798798733', 30, 5.0),
    ('98765432168', 30, 20.0),
    ('98765432168', 20, 15.0),
    ('88866555576', 20, NULL);