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