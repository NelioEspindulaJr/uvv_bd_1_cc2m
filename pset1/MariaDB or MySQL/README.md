# Sumário
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