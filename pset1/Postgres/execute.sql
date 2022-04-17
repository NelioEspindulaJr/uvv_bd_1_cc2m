/*
______________________________________________________________
|                         _________                           |
|                        | ATENÇÃO |                          |
|                         ‾‾‾‾‾‾‾‾‾                           |
| * O ARQUIVO DEVE SER EXECUTADO USANDO O TERMINAL POSTGRES   |
| psql PARA FUNCIONAR.                                        |
|                                                             |
| * ESSE ARQUIVO É RESPONSÁVEL POR EXECUTAR TODOS OS SCRIPTS  |
| NECESSÁRIOS PARA QUE O PROJETO DO BANCO DE DADOS SEJA       |
| FINALIZADO.                                                 |
|                                                             |
| PS.: OS COMANDOS ESTÃO TODOS COMENTADOS PARA FACILITAR O    |
| ENTENDIMENTO DO USUÁRIO!                                    |
| :)                                                          |
|_____________________________________________________________|
| Aluno: Nélio Espíndula Junior                               |
| Turma: CC2M                                                 |
| Professor: Abrantes Araújo Silva Filho                      |                                                          
 ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
*/

-- Comando utilzado para receber do usuário o diretório onde se encontram os arquivos sql para que o projeto seja criado
\echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
\echo DEFINA O DIRETORIO DA PASTA ONDE ESTAO OS ARQUIVOS "create_role_and_database.sql" e "create_schema_and_tables.sql":
\prompt path

-- Chama o script de criação de usuário e criação de banco de dados. 
\echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
\echo Criando o Banco de dados "UVV" e o Usuario Administrador "nelio".
\i :path/create_role_and_database.sql

/*
Nessa seção, defini que o operador do terminal (O usuário) deveria inserir uma senha de sua escolha para o Usuário Administrador.
Julguei melhor fazer dessa maneira do que apenas deixar uma senha padrão. Dessa forma o usuário escolherá sua própria senha garantindo segurança para o BD.
*/
\echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
\echo A senha padrao para o Usuario "nelio" recebe: 123456.
\echo Defina uma nova senha para o usuario
\password nelio

-- Comando para se conectar ao Banco de dados UVV criado no comando acima. 
\echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
\echo Conectando ao banco de dados.
\c uvv nelio localhost 5432

--Chama o Script de criação do esquema elmasri e tabelas com suas relações.
\echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
\echo Criando Schema Elmasri e suas Tabelas.
\i :path/create_schema_and_tables.sql

-- Chama o Script de inserção dos dados da tabela, segundo o modelo.
\echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
\echo Esquema Elmasri Criado. Inserindo dados:
\i :path/insert_data.sql