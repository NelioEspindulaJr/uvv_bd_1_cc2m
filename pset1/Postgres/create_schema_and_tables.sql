-- CRIAÇÃO DO ESQUEMA ELMASRI
CREATE SCHEMA elmasri
    AUTHORIZATION "nelio";

-- CRIAÇÃO DO USUÁRIO ADMINISTRADOR DO BANCO DE DADOS
ALTER USER "nelio"
SET SEARCH_PATH TO elmasri, "\user", public; -- PARA QUE AS TABELAS SEJAM CRIADOS DENTRO DO ESQUEMA ELMASRI, PRECISAMOS ALTERAR O SEARCH_PATH. 

/*
A PARTIR DESSE PONTO, SÃO CRIADAS TODAS AS TABELAS E RELAÇÕES, SEGUINDO O PROJETO DE MODELO CONCEITUAL;
CASO EXISTA ALGUM DETALHE IMPORTANTE A SER DESTACADO, HAVERÁ UM COMENTÁRIO INDICANDO O QUE FOI FEITO E PORQUE.
*/
CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                PRIMARY KEY (numero_departamento)
);
COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazena as informaçoẽs dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';


CREATE UNIQUE INDEX departamento_idx -- CRIAÇÃO DA ALTERNATIVE KEY 'nome_departamento' DA TABELA DEPARTAMENTO
 ON elmasri.departamento
 ( nome_departamento );

CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);
COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';


CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                PRIMARY KEY (numero_projeto)
);
COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'Número do departamento. É uma FK para a tabela departamento.';


CREATE UNIQUE INDEX projeto_idx -- CRIAÇÃO DA ALTERNATIVE KEY 'nome_projeto DA TABELA PROJETO
 ON elmasri.projeto
 ( nome_projeto );

CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1) CHECK (sexo = 'F' OR sexo = 'M'), -- A CONSTRAINT CHECK AQUI, AGE IMPEDINDO QUE QUALQUER OUTRO VALOR, EXCETO 'M' ou 'F' SEJA INSERIDO.
                salario NUMERIC(10,2) CHECK (salario > 0), -- A CONSTRAINT CHECK AQUI, IMPEDE QUE O SALARIO SEJA NEGATIVO.
                cpf_supervisor CHAR(11), -- PODE SER NULO POIS O FUNCIONÁRIO 'JORGE' RECEBE VALOR 'NULL' NESSE CAMPO
                numero_departamento INTEGER DEFAULT 1 NOT NULL, -- 1 É O Nº DEPARTAMENTO PADRAO POR CONTA DE SER A MATRIZ, E PARA QUE SEJA POSSÍVEL INSERIR OS DADOS INICIAIS DE DEPARTAMENTO E FUNCIONÁRIO.
                PRIMARY KEY (cpf)
);
COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereço do funcionário';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Número do departamento do funcionário. Valor padrão é "0".';


CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) CHECK (horas > 0), -- DEVE SER MAIOR QUE 0 (constraint check) E PODE SER NULO POIS O FUNCIONARIO 'JORGE' RECEBE 'NULL' NESTE CAMPO.
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);
COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';


CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1) CHECK (sexo = 'F' OR sexo = 'M'), -- A CONSTRAINT CHECK AQUI, AGE IMPEDINDO QUE QUALQUER OUTRO VALOR, EXCETO 'M' ou 'F' SEJA INSERIDO.
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);
COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';

/*
CRIAÇÃO DOS RELACIONAMENTOS DE FOREIGN KEYS ENTRE AS TABELAS;
*/

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT departamento_funcionario_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;