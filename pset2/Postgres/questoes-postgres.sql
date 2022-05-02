/*
QUESTÃO 01: prepare um relatório que mostre a média salarial dos funcionários
de cada departamento.
*/ 

SELECT 
d.numero_departamento AS "Nº Departamento",
d.nome_departamento AS "Departamento",
CONCAT('R$ ', ROUND((SUM(f.salario) / COUNT(*)),2)) AS "Média Salarial"

FROM elmasri.funcionario AS f
INNER JOIN elmasri.departamento AS d ON f.numero_departamento = d.numero_departamento
GROUP BY d.nome_departamento, d.numero_departamento;

/*
QUESTÃO 02: prepare um relatório que mostre a média salarial dos homens e das
mulheres.
*/

SELECT 
f.sexo AS "Sexo",
CONCAT('R$ ', ROUND((SUM(f.salario) / COUNT(*)),2)) AS "Média Salarial"

FROM elmasri.funcionario AS f

GROUP BY f.sexo;


/*
QUESTÃO 03: prepare um relatório que liste o nome dos departamentos e, para
cada departamento, inclua as seguintes informações de seus funcionários: o nome
completo, a data de nascimento, a idade em anos completos e o salário.
*/

SELECT 
d.nome_departamento AS "Nome Departamento",
CONCAT(f.primeiro_nome, ' ',f.nome_meio, '.', ' ', f.ultimo_nome) AS "Nome Completo",
f.data_nascimento AS "Data de Nascimento", 
EXTRACT(year FROM age(f.data_nascimento)) AS "Idade",
CONCAT('R$ ', ROUND((f.salario),2)) as "Salário"


FROM elmasri.departamento AS d
INNER JOIN elmasri.funcionario AS f ON f.numero_departamento = d.numero_departamento
ORDER BY nome_departamento;

/*
QUESTÃO 04: prepare um relatório que mostre o nome completo dos funcionários, 
a idade em anos completos, o salário atual e o salário com um reajuste que 
obedece ao seguinte critério: se o salário atual do funcionário é inferior a 35.000 o
reajuste deve ser de 20%, e se o salário atual do funcionário for igual ou superior a
35.000 o reajuste deve ser de 15%.
*/

SELECT
CONCAT(f.primeiro_nome, ' ',f.nome_meio, '.', ' ', f.ultimo_nome) AS "Nome Completo",
EXTRACT(year FROM age(f.data_nascimento)) AS "Idade",
f.salario AS "Salário Atual",

    CASE
        WHEN f.salario < 35000 THEN ROUND((f.salario * 0.8),2)
    ELSE
        ROUND((f.salario * 0.85),2)
    END AS "Salário Reajuste"

FROM elmasri.funcionario AS f;

/*
QUESTÃO 06: prepare um relatório que mostre o nome completo dos funcionários que têm dependentes, 
o departamento onde eles trabalham e, para cada funcionário, 
também liste o nome completo dos dependentes, a idade em anos de cada
dependente e o sexo (o sexo NÃO DEVE aparecer como M ou F, deve aparecer
como “Masculino” ou “Feminino”).
*/

SELECT
CONCAT(f.primeiro_nome, ' ',f.nome_meio, '.', ' ', f.ultimo_nome) AS "Nome do Funcionário",
dp.nome_dependente AS "Nome do Dependente",
EXTRACT(year FROM age(dp.data_nascimento)) AS "Idade",

CASE
    WHEN dp.sexo = 'M' THEN 'Masculino'
    WHEN dp.sexo = 'F' THEN 'Feminino'
    END AS "Sexo do dependente"

FROM elmasri.dependente AS dp
INNER JOIN elmasri.funcionario AS f ON f.cpf = dp.cpf_funcionario;

/*
QUESTÃO 07: prepare um relatório que mostre, para cada funcionário que NÃO
TEM dependente, seu nome completo, departamento e salário.
*/

SELECT 
CONCAT(f.primeiro_nome, ' ',f.nome_meio, '.', ' ', f.ultimo_nome) AS "Nome Completo",
d.nome_departamento AS "Departamento",
CONCAT('R$ ',ROUND((f.salario),2)) AS "Salário"

FROM elmasri.funcionario AS f
INNER JOIN elmasri.departamento AS d ON d.numero_departamento = f.numero_departamento
WHERE f.cpf NOT IN (
    
    SELECT 
    dp.cpf_funcionario
    FROM elmasri.dependente AS dp


);

/*
QUESTÃO 08: prepare um relatório que mostre, para cada departamento, os projetos desse departamento 
e o nome completo dos funcionários que estão alocados em cada projeto. Além disso inclua o 
número de horas trabalhadas por cada funcionário, em cada projeto.
*/

SELECT
CONCAT(f.primeiro_nome, ' ',f.nome_meio, '.', ' ', f.ultimo_nome) AS "Nome Completo",
d.nome_departamento AS "Departamento",
p.nome_projeto AS "Projeto",
tbm.horas AS "Horas trabalhadas"


FROM elmasri.departamento AS d 
INNER JOIN elmasri.projeto AS p ON p.numero_departamento = d.numero_departamento
INNER JOIN elmasri.trabalha_em AS tbm ON tbm.numero_projeto = p.numero_projeto
INNER JOIN elmasri.funcionario AS f ON f.cpf = tbm.cpf_funcionario
