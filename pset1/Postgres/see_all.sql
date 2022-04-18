/*
 
                          __________ 
                         | ATENÇÃO |
                         ‾‾‾‾‾‾‾‾‾‾          
Este é um SCRIPT extra, feito apenas para exibir os dados das tabelas criadas nos demais arquivos.
*/

\echo TABELA: funcionario
SELECT * FROM elmasri.funcionario;

\echo  

\echo TABELA: dependente
SELECT * FROM elmasri.dependente;

\echo  

\echo TABELA: departamento
SELECT * FROM elmasri.departamento;

\echo  

\echo TABELA: trabalha_em
SELECT * FROM elmasri.trabalha_em;

\echo  

\echo TABELA: projeto
SELECT * FROM elmasri.projeto;

\echo  

\echo TABELA: localizacoes_departamento
SELECT * FROM elmasri.localizacoes_departamento;
