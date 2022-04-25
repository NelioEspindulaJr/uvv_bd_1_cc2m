# uvv_bd_1_cc2m
Repositório da matéria de Design e Desenvolvimentode Banco de Dados na Universidade de Vila Velha - UVV, Espírito Santo.

# Cabeçalho
**Problem Set 1**

**Aluno:** Nélio Espíndula Junior

**Professor:** Abrantes Araújo Silva Filho

**Disciplina:** Design e Desenvolvimento de Banco de Dados

**Turma:** CC2M

# Informações
Vale lembrar que dentro de cada subrepositório existe um arquivo `README.md` específico para aquele conteúdo, este nada mais é que o conjunto de todos eles, e por isso haverão, de fato, informações repetidas nos arquivos.

# Sumário
1. [PostgreSQL](#1-postgresql)
   
   1.1 [O que é?](#11-o-que-é)
   
   1.2 [O que o projeto faz?](#12-o-que-o-projeto-faz)

   1.3 [Como este projeto funciona?](#13-como-este-projeto-funciona)

   1.4 [Como utilizar esse projeto?](#14-como-utilizar-esse-projeto)
    * 1.4.1 [Baixar os Arquivos](#141-baixar-os-arquivos)
    * 1.4.2 [Abrir o Terminal PSQL na sua Máquina](#142-abrir-o-terminal-psql-na-sua-máquina)
    * 1.4.3 [Acesse o Servidor Localhost da sua Máquina através do PSQL](#143-acesse-o-servidor-localhost-da-sua-máquina-através-do-psql)
    * 1.4.4 [Localizando o diretório dos arquivos](#144-localizando-o-diretório-dos-arquivos)
    * 1.4.5 [Execução do projeto](#145-execução-do-projeto)
      - 1.4.5.1 [Comando \i](#1451-comando-i)
      - 1.4.5.2 [Diretório dos arquivos](#1452-diretório-dos-arquivos)
      - 1.4.5.3 [Scripts de Construção](#1453-scripts-de-construção)
    * 1.5 [Pronto!](#15-pronto)

2. [MariaDB/MySQL](#2-MariaDB/MySQL)
   
   2.1 [O que é?](#21-o-que-é)
   
   2.2 [O que o projeto faz?](#22-o-que-o-projeto-faz)

   2.3 [Como este projeto funciona?](#23-como-este-projeto-funciona)

   2.4 [Como utilizar esse projeto?](#24-como-utilizar-esse-projeto)
    * 1.4.1 [Baixar os Arquivos](#241-baixar-os-arquivos)
    * 1.4.2 [Abrir terminal MariaDB/MySQL](#242-abrir-terminal-mariadbmysql)
    * 1.4.3 [Antes de Executar](#243-antes-de-executar)
    * 2.4.4 [Executando o Script](#244-executando-o-script)

    2.5 [Ver os Dados](#25-ver-os-dados)

# **1. PostgreSQL**
Referente à pasta [Postgres](/Postgres).
> 🔵 Esta seção fala sobre e ensina como executar o projeto proposto para o pset1 no banco de dados PostgreSQL.

## **1.1 O que é?**

Este trabalho é uma aplicação prática e teórica do que foi ensinado pelo professor Abrantes e pela leitura do livro *Sistema de Banco de Dados, de Elmasri e Navathe*, para a criação de um banco de dados usando a linguagem SQL.

## **1.2 O que o projeto faz?**

Os arquivos quando executados corretamente, criam um banco de dados composto por um esquema, 6 tabelas e os dados a serem inseridos em cada uma dessas tabelas.

## **1.3 Como este projeto funciona?**
Antes de executar o projeto, é necessário preparar a sua máquina.

>Para o funcionamento do projeto é necessário que seu computador tenha o PostgreSQL instalado. Caso já tenha, ótimo! Podemos seguir, caso contrário, basta acessar a [Página de Download oficial do PostgreSQL](https://www.postgresql.org/download/) e instalar da forma como preferir; 

![postgres-logo](https://www.benlcollins.com/wp-content/uploads/2018/11/postgresql-logo.png)

O projeto foi dividido em 2 partes que denominei como: Script de execução e os Scripts de Construção. Sendo eles:
1. Script de execução:
   - [execute.sql](Postgres/execute.sql)
2. Scripts de Construção
   - [create_role_and_database.sql](Postgres/create_role_and_database.sql)
   - [create_schema_and_tables.sql](Postgres/create_schema_and_tables.sql)
   - [insert_data.sql](Postgres/insert_data.sql)

O scripts de construção contêm os comandos em SQL para, *de fato*, construir o Banco de dados. Neles estão os `CREATE ROLE`, `CREATE DATABASE`, `CREATE TABLE`, `ALTER TABLE` e `INSERT INTO`.

O script de execução age como o **Sistema Nervoso** do projeto: Ele conecta e executa todos os comandos de construção na ordem e maneira correta.

## **1.4. Como utilizar esse projeto?**
Com sua máquina configurada e sabendo a diferença entre os arquivos do projeto, chegamos à parte interessante: **A execução.**

### **1.4.1 Baixar os arquivos:**
> Baixe os arquivos do repositório em seu computador e, preferencialmente, coloque-os em um diretório de fácil acesso (Como a pasta Download ou a Área de Trabalho).

### **1.4.2. Abrir o terminal psql na sua máquina**
> Caso você tenha seguido as instruções descritas em [1.3. Como este projeto funciona?](#13-como-este-projeto-funciona) você tem instalado em sua máquina o terminal psql.

![open-psql](https://s7.gifyu.com/images/STEP-1.md.gif)

### **1.4.3 Acesse o servidor localhost da sua máquina através do psql**

> Utilizando o usuário padrão postgres e a senha de administrador cadastrada por você na instalação do PostgreSQL, acesse o servidor localhost da sua máquina.

![login-database-locahost](https://s7.gifyu.com/images/step2.md.gif)

### **1.4.4 Localizando o diretório dos arquivos**

> Após conectado ao banco de dados como o usuário padrão postgres, precisamos direcionar a pasta onde os arquivos do projeto foram baixados (Por isso a dica de deixá-los facilmente localizados na sua máquina)

1º) Para localizar o diretório dos arquivos, basta selecionar o endereço de destino da pasta, segue exemplo:

![locate-dir](https://s7.gifyu.com/images/step3.md.gif)

2º) Com o destino encontrado ```C:\Users\trade\Desktop\uvv_bd_1_cc2m-main\pset1\Postgres``` troque as barras invertidas "`\`" pela barra normal "`/`".

> O terminal psql não lê em caminhos de diretório barras invertidas, por isso a troca.

Por fim, deve-se ter algo semelhante a isso: ```C:/Users/trade/Desktop/uvv_bd_1_cc2m-main/pset1/Postgres```.

> Lembrando, é claro, que seu caminho será diferente do que está escrito, pois depende do Usuário em que você está conectado, do Sistema operacional e em qual pasta você guardou os arquivos.

Agora que já definimos o diretório, podemos rodar nosso **__Script de Execução__**!

### **1.4.5 Execução do Projeto.**

Com o terminal PSQL aberto e o diretório dos arquivos copiado, executaremos um comando extremamente simples para rodarmos o [Script de Execução](Postgres/execute.sql):

#### **1.4.5.1 Comando `\i`**

O comando `\i` ou `\include`, segundo a [Documentação do PostgreSQL](https://www.postgresql.org/docs/current/app-psql.html), ele lê do usuário o caminho de destino de um arquivo e o executa.

Portanto, escreveremos da seguinte forma:

```sql
\i C:/Users/trade/Desktop/uvv_bd_1_cc2m-main/pset1/Postgres/execute.sql
```
![exec-command](https://i.imgur.com/Bs5Y1zc.png)

Apertamos `enter` e seguimos.

#### **1.4.5.2 Diretório dos arquivos**

Após executarmos o comando a cima, o terminal pede para o usuário inserir o **diretório** no qual estão os arquivos, que é o mesmo diretório que usamos para o Script de Execução: ```C:/Users/trade/Desktop/uvv_bd_1_cc2m-main/pset1/Postgres```

> ⚠ Dessa vez inserimos apenas o diretório da pasta e não do arquivo, com o detalhe muito importante que o final do caminho de destino não pode possuir barra. Caso contrário, o script não vai funcionar.

![dir](https://i.imgur.com/Kpj8EG4.png)

#### **1.4.5.3 Scripts de Construção**

Após inserido o diretório, os Scripts serão rodados e automaticamente serão construídos o esquema e as tabelas e inseridos os dados.

![final-exec](https://s7.gifyu.com/images/step4.gif)

> Algumas Observações:
> - Durante a execução dos Scripts de Construção, o terminal pede para inserir uma nova senha para o Usuário criado `nelio`. É uma maneira de ter controle do banco de dados sem depender da senha padrão `123456`.
> 
> - Após inserir a nova senha, o terminal se conecta ao database `uvv`, e para isso, pede a senha de acesso do usuário `nelio`, a qual acabou de ser criada.


## **1.5 Pronto!**

**Finalizado!** Nosso banco de dados PostgreSQL está pronto e já pode ser utilizado, caso queira inserir novos dados ou obter novas relações dos que já estão inseridos.

> Caso queira, também está disponibilizado na pasta dos arquivos um Script extra que exibe todas as tabelas e seus dados no terminal psql.
> O arquivo é o [see_all.sql](Postgres/see_all.sql)
> Basta executá-lo da mesma forma que [Script de Execução](Postgres/execute.sql).

# **2. MariaDB/MySQL**
Referente à pasta [MariaDB or MySQL](/MariaDBorMySql).
> 🟢 Esta seção fala sobre e ensina como executar o projeto proposto para o pset1 nos bancos de dados MariaDB e MySQL.

## **2.1 O que é?**

Este trabalho é uma aplicação prática e teórica do que foi ensinado pelo professor Abrantes e pela leitura do livro *Sistema de Banco de Dados, de Elmasri e Navathe*, para a criação de um banco de dados usando a linguagem SQL.

## **2.2 O que o projeto faz?**

O arquivo quando executado corretamente, cria um banco de dados MariaDB/MySQL composto por 6 tabelas preenchidas por seus respectivos dados.

## **2.3 Como este projeto funciona?**
Antes de executar o projeto, é necessário preparar a sua máquina.

>Para o funcionamento do projeto é necessário que seu computador tenha o MariaDB ou o MySQL instalado. Caso já tenha, ótimo! Podemos seguir, caso contrário, basta acessar a [Página oficial de Download do MySQL](https://dev.mysql.com/downloads/installer/) ou a [Página oficial de Download do MariaDB](https://mariadb.org/download/) e instalar da forma como preferir; 

![Mysql-logo](https://i.imgur.com/p2imdNC.png)

![mariadb-logo](https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/MariaDB_colour_logo.svg/2560px-MariaDB_colour_logo.svg.png)

O projeto conta com apenas um arquivo `.sql` que ao ser executado, cria todo o banco de dados automaticamente.

## **2.4. Como utilizar esse projeto?**
Com sua máquina configurada e sabendo a diferença entre os arquivos do projeto, chegamos à parte interessante: **A execução.**

### **2.4.1 Baixar os arquivos:**
> Baixe os arquivos do repositório em seu computador e, preferencialmente, coloque-os em um diretório de fácil acesso (Como a pasta Download ou a Área de Trabalho).

### **2.4.2 Abrir terminal MariaDB/MySQL**
Após baixar o arquivo, acesse o terminal MariaDB já instalado no seu computador e acesse o Banco De Dados com a senha que você cadastrou quando fez a configuração incial do programa.

![step1](https://s7.gifyu.com/images/mdb-1.gif)

### **2.4.3 Antes de executar**

Para executarmos o Script, precisamos de saber o diretório em que se encontra o arquivo `.sql`, e substituir as barras invertidas '`\`' por barras normais '`/`'. Por exemplo:

![step2](https://s7.gifyu.com/images/mdbstep2.gif)

Utilizando o bloco de notas do Windows e o atalho `CTRL + H`, conseguimos trocar todas as barras invertidas pelas normais.

### **2.4.4 Executando o Script**

Para executarmos o Script, é bem simples, precisamos apenas de abrir o terminal MariaDB e inserir o seguinte comando:

```
MariaDB [(none)]> source 'diretório do arquivo na sua máquina'/create_database.sql
```

![step3](https://s7.gifyu.com/images/mdbstep3.gif)

Após isso, está pronto! O Script já fez tudo automaticamente!

### **2.5 Ver os dados**

Caso queira ver os dados que foram inseridos nas tabelas, existe um Script auxiliar extra que retorna ao usuário todas as tabelas pelo terminal MariaDB: [see_all.sql](see_all.sql). Sua execução se dá da mesma maneira que o Script do Banco de Dados, porém com o nome do arquivo alterado:

```
MariaDB [(none)]> source 'diretório do arquivo na sua máquina'/see_all.sql
```

![step4](https://s7.gifyu.com/images/mdbstep4.gif)
