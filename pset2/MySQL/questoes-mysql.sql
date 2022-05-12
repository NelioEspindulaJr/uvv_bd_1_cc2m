/*
QUESTÃO 01: prepare um relatório que mostre a média salarial dos funcionários
de cada departamento.
*/ 

SELECT 
d.numero_departamento AS "Nº Departamento",
d.nome_departamento AS "Departamento",
CONCAT('R$ ', ROUND((SUM(f.salario) / COUNT(*)),2)) AS "Média Salarial"

FROM uvv.funcionario AS f
INNER JOIN uvv.departamento AS d ON f.numero_departamento = d.numero_departamento
GROUP BY d.nome_departamento, d.numero_departamento;

/*
QUESTÃO 02: prepare um relatório que mostre a média salarial dos homens e das
mulheres.
*/

SELECT 
f.sexo AS "Sexo",
CONCAT('R$ ', ROUND((SUM(f.salario) / COUNT(*)),2)) AS "Média Salarial"

FROM uvv.funcionario AS f

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
TIMESTAMPDIFF(YEAR, f.data_nascimento, NOW()) AS "Idade",
CONCAT('R$ ', ROUND((f.salario),2)) as "Salário"


FROM uvv.departamento AS d
INNER JOIN uvv.funcionario AS f ON f.numero_departamento = d.numero_departamento
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
TIMESTAMPDIFF(YEAR, f.data_nascimento, NOW()) AS "Idade",
f.salario AS "Salário Atual",

    CASE
        WHEN f.salario < 35000 THEN ROUND((f.salario * 0.8),2)
    ELSE
        ROUND((f.salario * 0.85),2)
    END AS "Salário Reajuste"

FROM uvv.funcionario AS f;

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
TIMESTAMPDIFF(YEAR, dp.data_nascimento, NOW()) AS "Idade",

CASE
    WHEN dp.sexo = 'M' THEN 'Masculino'
    WHEN dp.sexo = 'F' THEN 'Feminino'
    END AS "Sexo do dependente"

FROM uvv.dependente AS dp
INNER JOIN uvv.funcionario AS f ON f.cpf = dp.cpf_funcionario;

/*
QUESTÃO 07: prepare um relatório que mostre, para cada funcionário que NÃO
TEM dependente, seu nome completo, departamento e salário.
*/

SELECT 
CONCAT(f.primeiro_nome, ' ',f.nome_meio, '.', ' ', f.ultimo_nome) AS "Nome Completo",
d.nome_departamento AS "Departamento",
CONCAT('R$ ',ROUND((f.salario),2)) AS "Salário"

FROM uvv.funcionario AS f
INNER JOIN uvv.departamento AS d ON d.numero_departamento = f.numero_departamento
WHERE f.cpf NOT IN (
    
    SELECT 
    dp.cpf_funcionario
    FROM uvv.dependente AS dp


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


FROM uvv.departamento AS d 
INNER JOIN uvv.projeto AS p ON p.numero_departamento = d.numero_departamento
INNER JOIN uvv.trabalha_em AS tbm ON tbm.numero_projeto = p.numero_projeto
INNER JOIN uvv.funcionario AS f ON f.cpf = tbm.cpf_funcionario;

/*
QUESTÃO 09: prepare um relatório que mostre a soma total das horas de cada
projeto em cada departamento. Obs.: o relatório deve exibir o nome do departamento, 
o nome do projeto e a soma total das horas.
*/
SELECT

d.nome_departamento AS "Nome Departamento",
p.nome_projeto AS "Nome do Projeto",
SUM(tbm.horas) AS "Horas Trabalhadas"


FROM uvv.trabalha_em AS tbm
INNER JOIN uvv.projeto AS p ON p.numero_projeto = tbm.numero_projeto
INNER JOIN uvv.departamento AS d ON d.numero_departamento = p.numero_departamento
GROUP BY p.nome_projeto, d.nome_departamento
ORDER BY d.nome_departamento;

/*
QUESTÃO 10: prepare um relatório que mostre a média salarial dos funcionários
de cada departamento.
*/
SELECT 
CONCAT('R$ ', ROUND((AVG(f.salario)),2)) AS "Média Salarial",
d.nome_departamento AS "Departamento"

FROM uvv.funcionario AS f
INNER JOIN uvv.departamento AS d ON d.numero_departamento = f.numero_departamento
GROUP BY d.numero_departamento;
/*
QUESTÃO 11: considerando que o valor pago por hora trabalhada em um projeto
é de 50 reais, prepare um relatório que mostre o nome completo do funcionário, o
nome do projeto e o valor total que o funcionário receberá referente às horas trabalhadas naquele projeto.
*/
SELECT 
CONCAT(f.primeiro_nome, ' ',f.nome_meio, '.', ' ', f.ultimo_nome) AS "Nome Completo",
p.nome_projeto AS "Nome do Projeto",
CONCAT('R$ ', (tbm.horas * 50)) AS "A receber por horas"

FROM uvv.funcionario AS f
INNER JOIN uvv.trabalha_em AS tbm ON tbm.cpf_funcionario = f.cpf
INNER JOIN uvv.projeto AS p ON p.numero_projeto = tbm.numero_projeto
GROUP BY f.cpf, p.nome_projeto, tbm.horas;

/*
QUESTÃO 12: seu chefe está verificando as horas trabalhadas pelos funcionários
nos projetos e percebeu que alguns funcionários, mesmo estando alocadas à algum
projeto, não registraram nenhuma hora trabalhada. Sua tarefa é preparar um relatório que liste 
o nome do departamento, o nome do projeto e o nome dos funcionários
que, mesmo estando alocados a algum projeto, não registraram nenhuma hora trabalhada.
*/
SELECT 
d.nome_departamento AS "Nome Departamento",
p.nome_projeto AS "Nome do Projeto",
CONCAT(f.primeiro_nome, ' ',f.nome_meio, '.', ' ', f.ultimo_nome) AS "Nome Completo"

FROM uvv.departamento AS d
INNER JOIN uvv.projeto AS p ON p.numero_departamento = d.numero_departamento
INNER JOIN uvv.trabalha_em AS tbm ON tbm.numero_projeto = p.numero_projeto
INNER JOIN uvv.funcionario AS f ON f.cpf = tbm.cpf_funcionario

WHERE tbm.horas IS NULL;
/*
QUESTÃO 13: durante o natal deste ano a empresa irá presentear todos os funcionários e todos os 
dependentes (sim, a empresa vai dar um presente para cada
funcionário e um presente para cada dependente de cada funcionário) e pediu para
que você preparasse um relatório que listasse o nome completo das pessoas a serem
presenteadas (funcionários e dependentes), o sexo e a idade em anos completos
(para poder comprar um presente adequado). Esse relatório deve estar ordenado
pela idade em anos completos, de forma decrescente.
*/
SELECT 
CONCAT(f.primeiro_nome, ' ',f.nome_meio, '.', ' ', f.ultimo_nome) AS "Nome Completo",
TIMESTAMPDIFF(YEAR, f.data_nascimento, NOW()) AS "Idade",
CASE
    WHEN f.sexo = 'M' THEN 'Masculino'
    WHEN f.sexo = 'F' THEN 'Feminino'
    END AS "Sexo"

FROM uvv.funcionario AS f

UNION

SELECT
CONCAT(dp.nome_dependente) AS "Nome Completo",
TIMESTAMPDIFF(YEAR, dp.data_nascimento, NOW()) AS "Idade",
CASE
    WHEN dp.sexo = 'M' THEN 'Masculino'
    WHEN dp.sexo = 'F' THEN 'Feminino'
    END AS "Sexo"

FROM uvv.dependente AS dp

ORDER BY 2 DESC;

/*
QUESTÃO 14: prepare um relatório que exiba quantos funcionários cada departamento tem.
*/
SELECT
d.nome_departamento AS "Nome Departamento", 
COUNT(f.cpf) AS "Nº de Funcionários"

FROM uvv.funcionario AS f
INNER JOIN uvv.departamento AS d ON d.numero_departamento = f.numero_departamento
GROUP BY d.nome_departamento;
/*
QUESTÃO 15: como um funcionário pode estar alocado em mais de um projeto,
prepare um relatório que exiba o nome completo do funcionário, o departamento
desse funcionário e o nome dos projetos em que cada funcionário está alocado.
Atenção: se houver algum funcionário que não está alocado em nenhum projeto,
o nome completo e o departamento também devem aparecer no relatório.
*/
SELECT
CONCAT(f.primeiro_nome, ' ',f.nome_meio, '.', ' ', f.ultimo_nome) AS "Nome Completo",
d.nome_departamento AS "Nome Departamento",
p.nome_projeto AS "Nome Projeto"


FROM uvv.funcionario AS f 
INNER JOIN uvv.departamento AS d ON d.numero_departamento = f.numero_departamento
INNER JOIN uvv.projeto AS p ON p.numero_departamento = f.numero_departamento
ORDER BY f.primeiro_nome;



