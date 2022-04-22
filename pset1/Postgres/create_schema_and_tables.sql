-- CRIAÇÃO DO ESQUEMA ELMASRI
CREATE SCHEMA IF NOT EXISTS elmasri
    AUTHORIZATION "nelio";

-- CRIAÇÃO DO USUÁRIO ADMINISTRADOR DO BANCO DE DADOS
ALTER USER "nelio"
-- PARA QUE AS TABELAS SEJAM CRIADOS DENTRO DO ESQUEMA ELMASRI, PRECISAMOS ALTERAR O SEARCH_PATH. 
SET SEARCH_PATH TO elmasri, "\user", public;

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
('Matriz', 1, '', '19-06-1981'),
('Pesquisa', 5, '', '22-05-1988'),
('Administracao', 4, '', '01-01-1995');

/* 
Criacao da Fk(foreign key) da tabela departamento referenciando a tabela funcionario.
Fora criada apenas agora, para evitar problemas de relacionamento entre tais tabelas (incompatibilidade nas relacoes).
*/
ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk FOREIGN KEY (cpf_gerente) REFERENCES elmasri.funcionario (cpf) ON UPDATE NO ACTION;

-- SECAO DOS COMENTARIOS PARA OS METADADOS DO SGBD
COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazena as informaçoẽs dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';

COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereço do funcionário';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Número do departamento do funcionário. Valor padrão é "0".';

COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';

COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'Número do departamento. É uma FK para a tabela departamento.';

COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';

COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';

