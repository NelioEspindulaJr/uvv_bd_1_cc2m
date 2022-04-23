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