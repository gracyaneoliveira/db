-- CAPITULO 1
-- configurando o mysql
    
-- CAPITULO 2
-- Criando um Novo Usuario:
-- nome: usermysql
-- senha: cursomysql
CREATE USER usermysql@'%' identified by 'cursomysql';
CREATE USER usermysql@'localhost' identified by 'cursomysql';

-- Quando utilizamos o % em nosso código, estamos dizendo que
-- este usuário poderá acessar o nosso banco a partir de qualquer host. 
-- Poderíamos ter limitado ao acesso do local apenas, substituindo o % por localhost . 
-- Com o comando acima ele já está criado, porém não tem nenhuma permissão. 
-- Como não precisamos limitá-lo, vamos conceder direito total a ele. 
-- Faremos isso com o seguinte comando:
GRANT ALL PRIVILEGES ON *.* TO usermysql@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO usermysql@'localhost' WITH GRANT OPTION;

-- Utilizamos grant para conceder o acesso de usuários. 
-- Porém, se quiséssemos revogá-lo, faríamos da seguinte maneira:
revoke all on *.* from usermysql;

-- Concedendo privilegios a somente um banco de dados:
GRANT ALL PRIVILEGES ON comercial.* to 'usermysql'@'localhost';

-- Criando um usuário e dando permissão
GRANT ALL PRIVILEGES ON comercial.* TO 'usermysql'@'localhost' identified by 'cursomysql';

-- Visualizar todos os usuários do banco;
SELECT Host,User,Password FROM mysql.user;

-- CRIANDO UM BANCO DE DADOS;
CREATE DATABASE comercial;

-- VERIFICANDO SE O BANCO FOI CRIADO;
SHOW DATABASES;

-- continue capitulo 3 [pag. 37]

-- CRIANDO AS TABELAS DO PROJETO

CREATE TABLE comclien(
	n_numeclien int NOT null AUTO_INCREMENT,
	c_codiclien varchar(10),
	c_nomeclien varchar(100),
	c_razaclien varchar(100),
	d_dataclien datetime,
	c_cnpjclien varchar(20),
	c_foneclien varchar(20),
	PRIMARY KEY (n_numeclien)
);

-- Por padrão, o auto_increment inicia-se do 1. 
-- Porém, se houver a necessidade de iniciar por outro valor você pode alterá-lo, fazendo:
ALTER TABLE comclien AUTO_INCREMENT=100;

CREATE TABLE comforne(
    n_numeforne int NOT null AUTO_INCREMENT,
    c_codiforne varchar(10),
    c_nomeforne varchar(100),
    c_razaforne varchar(100),
    c_foneforne varchar(20),
    PRIMARY KEY(n_numeforne)
);

CREATE TABLE comvende(
    n_numevende int NOT null AUTO_INCREMENT,
    c_codivende varchar(10),
    c_nomevende varchar(100),
    c_razavende varchar(100),
    c_fonevende varchar(20),
    n_porcvende float(10,2),
    PRIMARY KEY(n_numevende)
);

CREATE TABLE comprodu(
    n_numeprodu int NOT null AUTO_INCREMENT,
    c_codiprodu varchar(20),
    c_descprodu varchar(100),
    n_valoprodu float(10,2),
    c_situprodu varchar(1),
    n_numeforne int,
    PRIMARY KEY(n_numeprodu)
);

CREATE TABLE comvenda(
    n_numevenda int NOT null AUTO_INCREMENT,
    c_codivenda varchar(10),
    n_numeclien int NOT null,
    n_numeforne int NOT null,
    n_numevende int NOT null,
    n_valovenda float(10,2),
    n_descvenda float(10,2),
    n_totavenda float(10,2),
    d_datavenda date,
    PRIMARY KEY(n_numevenda)
);

CREATE TABLE comivenda(
    n_numeivenda int NOT null AUTO_INCREMENT,
    n_numevenda int NOT null,
    n_numeprodu int NOT null,
    n_valoivenda float(10,2),
    n_qtdeivenda int,
    n_descivenda float(10,2),
    PRIMARY KEY(n_numeivenda)
);

-- CUIDANDO DA INTEGRIDADE DO BANCO DE DADOS

-- Quando criamos a tabela comvenda , nós incluímos colunas de outras tabelas, como:
-- n_numeclien , n_numeforne e n_numeprodu. 
-- Essas colunas estão referenciando um registro em sua tabela de origem. 
-- Porém, como apenas criamos o campo, mas nada que informe o banco sobre essa referência, 
-- devemos fazer isso, passando uma instrução ao nosso SGBD por meio das constraints , 
-- como mostram os códigos na sequência.

ALTER TABLE comvenda ADD CONSTRAINT fk_comvenda_comforne
    foreign key(n_numeforne)
    references comforne(n_numeforne)
on delete no action
on update no action;

ALTER TABLE comvenda ADD CONSTRAINT fk_comvenda_comvende
    foreign key(n_numevende)
    references comvende(n_numevende)
on delete no action
on update no action;

ALTER TABLE comvenda ADD CONSTRAINT fk_comvenda_comclien
    foreign key(n_numeclien)
    references comclien(n_numeclien)
on delete no action
on update no action;

ALTER TABLE comivenda ADD CONSTRAINT fk_comivenda_comprodu
    foreign key(n_numeprodu)
    references comprodu(n_numeprodu)
on delete no action
on update no action;

ALTER TABLE comivenda ADD CONSTRAINT fk_comivenda_comvenda
    foreign key(n_numevenda)
    references comvenda(n_numevenda)
on delete no action
on update no action;

-- Se tivéssemos criado uma constraint errada, poderíamos
-- deletá-la utilizando a instrução irreversível:
ALTER TABLE comivenda drop foreign key fk_comivenda_comprodu;

-- ALTERANDO AS TABELAS

-- Se você reparar em nossa tabela de clientes, não criamos campos para cidade ou para estados. 
-- Para não precisar excluí-la e criá-la novamente, fazemos uma alteração nela com o comando alter table
ALTER TABLE comclien add column c_cidaclien varchar(50);

-- E um campo para informar o estado.
ALTER TABLE comclien add column c_estaclien varchar(50);

-- DELETAR COLUNA
ALTER TABLE comclien drop column c_estaclien;

-- MODIFICAR TIPO DO CAMPO (usar o modify)
ALTER TABLE comclien modify column c_estaclien int;
ALTER TABLE comclien modify column c_estaclien varchar(100);

-- DELETAR TABELAS
drop table comvendas;

-- continua [pag. 46]

-- CAPITULO 4 MANIPULANDO REGISTROS

-- INSERINDO REGISTROS
INSERT INTO comclien VALUES (
1,
'0001',
'AARONSON',
'AARONSON FURNITURE LTDA',
'2015-02-17',
'17.807.928/0001-85',
'(21) 8167-6584',
'QUEIMADOS',
'RJ');

insert into comclien(n_numeclien,
                    c_codiclien,
                    c_nomeclien,
                    c_razaclien,
                    d_dataclien,
                    c_cnpjclien,
                    c_foneclien,
                    c_cidaclien,
                    c_estaclien)
values (1,
        '0001',
        'AARONSON',
        'AARONSON FURNITURE LTDA',
        '2015-02-17',
        '17.807.928/0001-85',
        '(21) 8167-6584',
        'QUEIMADOS',
        'RJ');
        
-- ALTERANDO REGISTROS : COMMAND UPDATE
UPDATE comclien SET c_nomeclien = 'AARONSON FURNITURE' WHERE n_numeclien = 1;

-- Podemos atualizar mais de um campo de uma vez só, separando com ',' :
UPDATE comclien SET 
            c_nomeclien = 'AARONSON FURNITURE', 
            c_cidaclien = 'LONDRINA', 
            c_estaclien = 'PR'
        WHERE n_numeclien = 1;

commit;

-- Utilizei o commit para dizer para o SGBD que ele pode realmente 
-- salvar a alteração do registro. Se, por engano, fizermos o update 
-- incorreto, antes do commit , podemos reverter a situação usando a 
-- instrução SQL rollback , da seguinte maneira:
UPDATE comclien SET c_nomeclien = 'AARONSON'
        WHERE n_numeclien = 1;
rollback;

-- Com isso, o nosso SGBD vai reverter a última instrução.

-- Porém, se tiver a intenção de utilizar o rollback , faça-o antes de
-- aplicar o commit , pois se você aplicar o update ou qualquer
-- outro comando que necessite do commit , não será possível
-- reverter.

-- EXCLUINDO REGISTROS
-- Para isso, devemos utilizar uma outra instrução SQL: o delete . 
-- Diferente do drop , ele deleta os registros das colunas do banco de dados. 
-- O drop é usado para excluir objetos do banco, como tabelas, colunas, views, procedures etc.); 
-- enquanto, o delete deletará os registros das tabelas, podendo excluir apenas
-- uma linha ou todos os registros, como você desejar.

DELETE FROM comclien WHERE n_numeclien = 1;
commit;

-- Deletar todos os registros da tabela de clientes.
DELETE FROM comclien;
commit;

-- CLAUSULA : TRUNCATE
-- Além do delete , podemos fazer a deleção de dados usando
-- uma instrução SQL chamada de truncate . 
-- Este é um comando que não necessita de commit e não é possível a utilização de cláusulas where . 
-- Logo, só o use se você tem certeza do que estiver querendo excluir, uma vez que ele é irreversível. 
-- Nem o rollback pode reverter a operação. Isso ocorre porque, quando você utiliza o delete , 
-- o SGBD salva os seus dados em uma tabela temporária e, quando aplicamos o rollback , 
-- ele retorna a consulta e restaura os dados. 
-- Já o truncate não a utiliza, o SGBD faz a deleção direta. 
-- Para usar esse comando, faça do seguinte modo:
truncate table comclien;

-- continue [pag. 53]

-- CAPITULO 5 TEMOS REGISTROS: VAMOS CONSULTAR?

-- Estrutura básica da consulta
SELECT * FROM comclien;

-- Se quiséssemos selecionar apenas o código e a razão social do
-- cliente, no lugar do * , colocaríamos os campos n_numeclien ,
-- c_codiclien e c_razaclien .
SELECT n_numeclien, c_codivenda, c_razaclien FROM comclien;

-- Vamos selecionar o cliente com uma cláusula que deve ter c_codiclien = '00001'
SELECT n_numeclien, c_codiclien, c_razaclien
    FROM comclien
WHERE c_codiclien = '0001';

-- E se quiséssemos o contrário? 
-- Todos os clientes que sejam diferentes de '0001' ? 
-- Faríamos uma consulta utilizando o operador do MySQL que significa diferente: <> . 
-- Ficaria assim:
SELECT n_numeclien, c_codiclien, c_razaclien
    FROM comclien
WHERE c_codiclien <> '0001';

-- +-------------+-------------+------------------------+
-- | n_numeclien |  c_codiclien |           c_razaclien |
-- +-------------+-------------+------------------------+
-- |           2 |         0002 |          LITTLER LTDA |
-- |           3 |         0003 |  KELSEY NEIGHBOURHOOD |
-- |           4 |         0004 |  GREAT AMERICAN MUSIC |
-- |           5 |         0005 | LIFE PLAN COUNSELLING |
-- |           6 |         0006 |      PRACTI-PLAN LTDA |
-- |           7 |         0007 |       SPORTSWEST LTDA |
-- |           8 |         0008 |   HUGHES MARKETS LTDA |
-- |           9 |         0009 |       AUTO WORKS LTDA |
-- |          10 |        00010 |       DAHLKEMPER LTDA |
-- +-------------+-------------+------------------------+
-- Observe que ele trouxe todos os clientes, exceto aquele cujo
-- c_codiclien é igual a '0001'.

-- LIKE
-- Se quisermos retornar todos os clientes que se iniciam com a letra L, montaríamos nossa
-- consulta da seguinte maneira:
SELECT n_numeclien, c_codiclien, c_razaclien
    FROM comclien
WHERE c_razaclien LIKE 'L%';

-- O símbolo de % (porcento) é um curinga no SQL. 
-- Quando não sabemos uma parte da string, podemos utilizá-lo no início, no
-- meio ou no fim dela.

-- DISTINCT
-- Peguemos uma lista de todos os clientes que compraram algo? 
-- Se fosse apenas a consulta:
SELECT n_numeclien FROM comvenda;

-- Isso retornaria lista de clientes e de vendas e, se o cliente
-- possuir mais de uma venda, apareceria repetido no resultado.

-- Para não selecionar um registro igual ao outro, utilizamos o DISTINCT .
-- Com o seguinte código, teremos a lista de clientes que fizeram ao
-- menos uma compra e sem nenhuma repetição.
SELECT DISTINCT n_numeclien FROM comvenda;

-- 5.2 SUBQUERY OU SUBCONSULTA
-- As subconsultas são alternativas para as joins , que vamos
-- ver logo a seguir. Utilizando-as, conseguimos ter um select
-- dentro de outro select para nos ajudar a recuperar registros que
-- estão referenciados em outras tabelas.

-- Antes de demonstrar o uso da subquery, vamos aprender a
-- utilização das cláusulas IN , NOT IN , EXISTS e NOT EXISTS

-- Cláusulas IN e NOT IN
-- As cláusulas IN e NOT IN surgem para fornecer apoio quando queremos testar um ou mais.

-- Para exemplificarmos, vamos escrever uma consulta para retornar simultaneamente 
-- os clientes que possuem n_numeclien igual a 1 e 2.
SELECT c_codiclien, c_razaclien
    FROM comclien
WHERE n_numeclien IN (1,2);

/*
+-------------+------------------------+
| c_codiclien | c_razaclien            |
+-------------+------------------------+
| 0001        | AARONSON FURNITURE LTD |
| 0002        | LITTLER LTDA           |
+-------------+------------------------+ */
-- Ou podíamos consultar clientes que possuem o n_numeclien
-- diferente de 1 e 2. Nesta ocasião, devemos utilizar o NOT IN . Vamos ao código.
SELECT c_codiclien, c_razaclien
    FROM comclien
WHERE n_numeclien NOT IN (1,2);
/*
+-------------+-----------------------+
| c_codiclien | c_razaclien           |
+-------------+-----------------------+
| 0003        | KELSEY NEIGHBOURHOOD  | 
| 0004        | GREAT AMERICAN MUSIC  |
| 0005        | LIFE PLAN COUNSELLING |
| 0006        | PRACTI-PLAN LTDA      |
| 0007        | SPORTSWEST LTDA       |
| 0008        | HUGHES MARKETS LTDA   |
| 0009        | AUTO WORKS LTDA       |
| 00010       | DAHLKEMPER LTDA       |
+-------------+-----------------------+*/

-- Nas duas últimas consultas, nós sabíamos os números dos
-- clientes que queríamos ou não consultar. 
-- Entretanto, em nosso projeto, surgiu a necessidade de criar uma consulta para retornar a razão
-- social dos clientes que possuem registro na tabela comvenda . 
-- Para esta situação, vamos utilizar uma subconsulta.
SELECT c_razaclien
    FROM comclien
WHERE n_numeclien IN (SELECT DISTINCT n_numeclien FROM comvenda);
/*
+------------------------+
| c_razaclien            |
+------------------------+
| AARONSON FURNITURE LTD |
| AUTO WORKS LTDA        |
| GREAT AMERICAN MUSIC   |
| HUGHES MARKETS LTDA    |
| KELSEY NEIGHBOURHOOD   |
| LIFE PLAN COUNSELLING  |
| LITTLER LTDA           |
| PRACTI-PLAN LTDA       |
| SPORTSWEST LTDA        |
+------------------------+*/

-- Utilizando a mesma situação, vamos buscar os clientes que
-- ainda não fizeram nenhuma venda. 
-- Para isso, utilizaremos o NOT IN . 
-- Você verá que o único cliente que ainda não possui registro de
-- venda retornará, pois a consulta principal vai consultar todos os
-- registros que não possuem o n_numeclien na tabela comvenda .
SELECT c_razaclien
    FROM comclien
WHERE n_numeclien NOT IN (SELECT n_numeclien FROM comvenda);

-- +------------------+
-- | c_razaclien      |
-- +------------------+
-- | DAHLKEMPER LTDA  |
-- +------------------+

-- vamos supor que, em nosso sistema, surgiu a necessidade de desenvolver uma
-- consulta para retornar o código das vendas e a razão social dos
-- respectivos clientes que as fizeram.
    -- A consulta principal será um select na tabela comvenda
    -- junto com uma subconsulta. Esta terá uma vírgula separando-a do
    -- primeiro campo e o n_numeclien sendo passado da consulta
    -- principal, para realizar a comparação e buscar a razão social do
    -- respectivo cliente. 
    -- Vamos ao código.
        SELECT c_codivenda Cod_Venda,
                                    (SELECT c_razaclien
                                        FROM comclien
                                    WHERE n_numeclien = comvenda.n_numeclien) Nome_Cliente
        FROM comvenda;
        /*
        +-------------+------------------------+
        | Cod_Venda | Nome_Cliente             |
        +-------------+------------------------+
        | 1         | AARONSON FURNITURE LTD   |
        | 2         | LITTLER LTDA             |
        | 3         | KELSEY NEIGHBOURHOOD     |
        | 4         | GREAT AMERICAN MUSIC     |
        | 5         | LIFE PLAN COUNSELLING    |
        ...*/
        
-- Essa maneira não é muito usada, porque há perda de
-- performance e o código não fica legal. 
-- Por isso, aprenderemos a fazer JOINS: a forma correta para retornamos valores de uma ou
-- mais tabelas em um único select .

-- Criação de alias (apelidos das tabelas)
-- Observe o nosso último código. No cabeçalho do resultado, em
-- vez de retornar os nomes das colunas, apareceram os que
-- colocamos na frente das que estamos consultando.
-- Dizemos que estamos apelidando as colunas e isso é chamado de alias.

-- Para exemplificar, vamos consultar a c_codiclien e a
-- c_nomeclien , colocando os alias CODIGO e CLIENTE
-- respectivamente. 
-- Vamos ao código:
SELECT c_codiclien CODIGO, c_nomeclien CLIENTE
    FROM comclien
WHERE n_numeclien NOT IN (1,2,3,4);
/*
+-------------+-----------------------+
| CODIGO      |      CLIENTE          |
+-------------+-----------------------+
| 0005        | LIFE PLAN COUNSELLING |
| 0006        | PRACTI-PLAN           |
| 0007        | SPORTSWEST            |
| 0008        | HUGHES MARKETS        |
| 0009        | AUTO WORKS            |
| 00010       | DAHLKEMPER            |
+-------------+-----------------------+*/

-- 5.3 TRAGA INFORMAÇÃO DE VÁRIAS TABELAS COM JOINS

-- continue [pag. 65]

-- Para fazer um consulta em mais de uma tabela, nós utilizamos os
-- chamados JOINs.
-- No SQL, também temos um comando para ordenar as consultas.
-- Para isso, temos o order by . Ordenando pela razão social do
-- cliente, o nosso código ficará da seguinte maneira:
SELECT c_codiclien, c_razaclien, c_codivenda Cod_Venda
    FROM comvenda, comclien  -- join entre comvenda e comclien
WHERE comvenda.n_numeclien = comclien.n_numeclien
    ORDER BY c_razaclien;
    
-- A maneira mais formal de escrever uma consulta com JOIN
-- é como está apresentado a seguir. Porém, não é a mais
-- comum e utilizada no dia a dia, pois o código fica um pouco
-- mais complexo.
SELECT c_codiclien, c_razaclien, c_codivenda Cod_Venda
    FROM comvenda
        JOIN comclien 
    ON comvenda.n_numeclien = comclien.n_numeclien
ORDER BY c_razaclien;

-- 5.4 SELECT EM: CREATE TABLE, INSERT, UPDATE E DELETE
-- Criando tabelas por meio de select

-- Surgiu a necessidade de criarmos uma tabela chamada
-- comclien_bkp com a mesma estrutura e dados da comclien ,
-- onde o c_estaclien seja igual a 'SP' . Podemos realizar
-- algumas operações com esses registros e, por segurança, não
-- usaremos os dados da tabela original.
CREATE TABLE comclien_bkp AS( SELECT *
                                FROM comclien
                              WHERE c_estaclien = 'SP');

-- Inserindo registros por meio de select
-- Constantemente, surge a necessidade de inserir registros em
-- alguma tabela, a fim de realizar algum processo no banco de dados.
-- Às vezes, já temos esses dados em outra tabela e, com isso, em vez
-- de criarmos scripts para inseri-los, nós podemos utilizar um
-- select para buscar o que temos e colocar em nossa nova tabela.

-- Em nosso projeto, apareceu a necessidade da criação uma
-- tabela para agenda telefônica. Ela terá como base alguns campos da
-- tabela de clientes e todos eles serão cadastrados nela também.
CREATE TABLE comcontato(
    n_numecontato int NOT null AUTO_INCREMENT,
    c_nomecontato varchar(200),
    c_fonecontato varchar(30),
    c_cidacontato varchar(200),
    c_estacontato varchar(2),
    n_numeclien int,
    PRIMARY KEY(n_numecontato)
);

-- Agora vamos popular as colunas da nossa tabela comcontato
-- com essas informações que temos da tabela comclien .
INSERT INTO comcontato(
    SELECT n_numeclien,
        c_nomeclien,
        c_foneclien,
        c_cidaclien,
        c_estaclien,
        n_numeclien
    FROM comclien
);

-- Para visualizar os registros da nossa tabela, faça um select simples para listá-los.
SELECT * FROM comcontato;

-- Alterando registros por meio de select

-- Neste momento, descobrimos que os contatos dos cliente que
-- estão na tabela comclien_bkp , na verdade, possuem o contato
-- em outra cidade e estado, diferente dos dados que estão na comclien . 
-- Ainda utilizando um select , faremos um update
-- nos campos c_cidacontato e c_estacontato , buscando os registros 
-- da tabela comclien_bkp e alterando a comcontato .

UPDATE comcontato SET c_cidacontato = 'LONDRINA', c_estacontato = 'PR'
    WHERE n_numeclien IN (SELECT n_numeclien
                            FROM comclien_bkp);

-- Deletando registros por meio de select

-- Agora temos a necessidade de deletar todos os registros da tabela
-- comcontato que não possuem registros na tabela
-- comvenda ; ou seja, aqueles que não possuem nenhuma venda.
DELETE FROM comcontato
    WHERE n_numeclien NOT IN (SELECT n_numeclien
                                FROM comvenda);

-- Agora, se consultarmos a tabela comcontato , não veremos o
-- contato que não possuía nenhum registro na comvenda .

-- continue [pag.75]

-- CAPÍTULO 6 CONSULTAS COM FUNÇÕES

-- 6.1 FUNÇÕES

-- Elas estão divididas nos seguintes tipos: numéricas, lógica, manipulação de string e
-- funções de data e hora.

-- 6.2 FUNÇÕES DE AGREGAÇÃO

-- As funções de agregação são responsáveis por agrupar vários
-- valores e retornar somente um único para um determinado grupo.
-- Por exemplo, se fizermos um select em todos registros da tabela
-- de vendas com join com a tabela de clientes, vamos ter como
-- resultado clientes repetidos.
/*
+-------------+------------------------+
| c_codiclien | c_razaclien            |
+-------------+------------------------+
| 0001        | AARONSON FURNITURE LTD |
| 0001        | AARONSON FURNITURE LTD |
| 0001        | AARONSON FURNITURE LTD |
| 0009        | AUTO WORKS LTDA        |
...*/

-- Alguns clientes repetem-se, pois existem aqueles que possuem
-- mais de uma venda. Desta maneira, poderíamos utilizar uma
-- função de agregação para retorná-los, evitando a repetição.

-- Group by

-- O comando SQL para fazer essa operação de agregação é o
-- group by . Ele deverá ser utilizado logo após as cláusulas de
-- condições where ou and , e antes do order by , se a sua
-- consulta possuí-lo.

SELECT c_codiclien, c_razaclien
    FROM comclien, comvenda
WHERE comvenda.n_numeclien = comclien.n_numeclien
    GROUP BY c_codiclien, c_razaclien
    ORDER BY c_razaclien;
/*
+-------------+------------------------+
| c_codiclien | c_razaclien            |
+-------------+------------------------+
| 0001        | AARONSON FURNITURE LTD |
| 0009        | AUTO WORKS LTDA        |
| 0004        | GREAT AMERICAN MUSIC   |
| 0008        | HUGHES MARKETS LTDA    |
| 0003        | KELSEY NEIGHBOURHOOD   |
| 0005        | LIFE PLAN COUNSELLING  |
| 0002        | LITTLER LTDA           |
| 0006        | PRACTI-PLAN LTDA       |
| 0007        | SPORTSWEST LTDA        |
+-------------+------------------------+*/

-- O MySQL agrupou o código e a razão social, trazendo apenas
-- um registro de cada. Porém, essa consulta poderia ser melhor se
-- tivéssemos a quantidade de vendas de cliente. Podemos utilizar
-- uma outra função de agregação chamada count() para contar os
-- registros que estão agrupados. Ela só pode ser utilizada na cláusula
-- select , pois contará os registros da coluna que está sendo
-- selecionada. Complementando o código anterior, teremos:

SELECT c_codiclien, c_razaclien, COUNT(n_numevenda) Qtde
    FROM comclien, comvenda
WHERE comvenda.n_numeclien = comclien.n_numeclien
    GROUP BY c_codiclien, c_razaclien
    ORDER BY c_razaclien;
/*
+-------------+------------------------+------+
| c_codiclien | c_razaclien            | Qtde |
+-------------+------------------------+------+
| 0001        | AARONSON FURNITURE LTD | 3    |
| 0009        | AUTO WORKS LTDA        | 3    |
| 0004        | GREAT AMERICAN MUSIC   | 1    |
| 0008        | HUGHES MARKETS LTDA    | 2    |
| 0003        | KELSEY NEIGHBOURHOOD   | 3    |
| 0005        | LIFE PLAN COUNSELLING  | 2    |
| 0002        | LITTLER LTDA           | 2    |
| 0006        | PRACTI-PLAN LTDA       | 2    | 
| 0007        | SPORTSWEST LTDA        | 2    |
+-------------+------------------------+------+*/


-- O count pode ser usado apenas para contar a quantidade de
-- registro em uma tabela. Vamos substituir a coluna que estava entre
-- parênteses no exemplo anterior por * (asterisco), para contar
-- todas as linhas da tabela de clientes.

select count(*) from comclien;
/*
+----------+
| count(*) |
+----------+
| 10       |
+----------+*/

-- Having count()
-- Agora, em nosso projeto, temos a necessidade de fazer um
-- relatório que traga como resultado os clientes que tiveram mais do
-- que duas vendas. Para isso, utilizaremos a função having count() , 
-- que será a condição para o seu count() .
-- Exemplificando, temos:

SELECT c_razaclien, COUNT(n_numevenda)
    FROM comclien, comvenda
WHERE comvenda.n_numeclien = comclien.n_numeclien
    GROUP BY c_razaclien
HAVING COUNT(n_numevenda) > 2;
/*
+------------------------+--------------------+
| c_razaclien            | count(n_numevenda) |
+------------------------+--------------------+
| AARONSON FURNITURE LTD | 3                  |
| AUTO WORKS LTDA        | 3                  |
| KELSEY NEIGHBOURHOOD   | 3                  |
+------------------------+--------------------+*/

-- max() e min()

-- Muitas vezes, por n motivos, surge a necessidade de retornar
-- o maior ou menor registro de uma tabela.
-- Fazemos isso com as funções MAX() e MIN() , respectivamente.
-- Nos parênteses deverá ir a coluna que você deseja recuperar. São
-- funções simples do SQL que são de grande utilidade.
-- Se quisermos recuperar o valor da maior venda, nossa consulta seria:

SELECT MAX(n_totavenda) maior_venda 
    FROM comvenda;
/*
+-------------+
| maior_venda |
+-------------+
| 25141.02    |
+-------------+*/

-- Já para a menor:
SELECT min(n_totavenda) menor_venda, 
       max(n_totavenda) maior_venda 
FROM comvenda;
/*
+-------------+-------------+
| menor_venda | maior_venda |
+-------------+-------------+
| 4650.64     | 25141.02    |
+-------------+-------------+*/

-- Sum()

-- No MySQL, podemos somar todos os valores de uma coluna utilizando a função sum() .
-- Como exemplo, vamos somar os valores individualmente das
-- colunas: n_valovenda , n_descvenda e n_totavenda no intervalo de 01/01/2015 a 31/01/2015.
SELECT SUM(n_valovenda) valor_venda,
       SUM(n_descvenda) descontos,
       SUM(n_totavenda) total_venda
FROM comvenda
      WHERE d_datavenda BETWEEN '2015-01-01' AND '2015-01-31';
/*      
+-------------+-----------+-------------+
| valor_venda | descontos | total_venda |
+-------------+-----------+-------------+
| 75830.72    | 0.00      | 75830.72    |
+-------------+-----------+-------------+*/

-- Avg()
-- No MySQL temos o avg(), que busca a coluna cuja média você deseja saber e realiza
-- o cálculo. Vamos exemplificar consultando o valor médio de todas as vendas:
SELECT format(AVG(n_totavenda),2)
    FROM comvenda;
/*
+----------------------------+
| format(avg(n_totavenda),2) |
+----------------------------+
| 12,213.96                  |
+----------------------------+*/


-- 6.3 FUNÇÕES DE STRING

-- substr() e length()

-- Agora, em nosso projeto, surgiu a necessidade de consultar os
-- produtos que iniciam seu código com '123' e que possuem uma
-- descrição com mais de 4 caracteres, pois foram cadastrados de
-- maneira errada.
-- Existem funções no SQL que podemos utilizar para
-- fazer esse filtro? 
-- São duas: a função SUBSTR() e a length() .

-- Diferente das outras funções para as quais apenas passamos a
-- coluna, para esta devemos também passar qual o intervalo de
-- caracteres que queremos de um determinado campo.

-- Por exemplo, substr(c_codiprodu,1,3) = '123' . 
-- Com este comando, falamos para o SGBD que queremos os registros
-- que possuem o código da posição 1 até a posição 3 com a
-- sequência de caracteres 123 . 
-- Com a função LENGTH() , vamos contar quantos caracteres a descrição do produto tem.

SELECT c_codiprodu, c_descprodu
    FROM comprodu
WHERE substr(c_codiprodu,1,3) = '123'
    AND length(c_descprodu) > 4;
/*
+-------------+-------------+
| c_codiprodu | c_descprodu |
+-------------+-------------+
| 123131      | NOTEBOOK    |
| 123223      | SMARTPHONE  |
| 1234        | DESKTOP     |
+-------------+-------------+*/

-- Utilizamos, no exemplo, o substr() e o length() para
-- fazermos uma validação. Poderíamos ter utilizado para apresentar
-- os valores. 
-- Vamos selecionar apenas os cinco primeiros caracteres
-- do campo c_razaclien e contar quantos deles temos no código
-- do cliente = 1. Vamos ao código:
SELECT substr(c_razaclien,1,5) Razao_Social,
       length(c_codiprodu) Tamanho_Cod
    FROM comclien
WHERE n_numeclien = 1;
/*
+-------------+--------------+
| Razao_Social | Tamanho_Cod |
+-------------+--------------+
| AARON        | 6           |
+-------------+--------------+*/

-- Concat() e concat_ws()

-- Queremos agora listar os clientes concatenando a razão social e o telefone. 
-- Temos a função concat() que concatena dois ou mais campos. 
-- Deve-se apenas colocá-los entre parênteses, separados por vírgula.

SELECT concat(c_razaforne,' - fone: ', c_foneforne)
    FROM comforne
ORDER BY c_razaforne;
/*
+-------------------------------------------------------+
| concat(c_razaforne,' - fone: ', c_foneforne)          |
+-------------------------------------------------------+
| DUN RITE LAWN MAINTENANCE LTDA - fone: (85) 7886-8837 |
| SEWFRO FABRICS LTDA - fone: (91) 5171-8483            |
| WISE SOLUTIONS LTDA - fone: (11) 5347-5838            |
+-------------------------------------------------------+*/

-- Por alguma necessidade, precisamos fazer consultas e
-- concatenar mais de um campo. 
-- O MySQl nos permite fazer isso através das funções concat() e concat_ws() . 

-- Com o concat() será para concatenar todos os campos da consulta sem
-- especificar um separador entre os campos; 
-- Com o concat_ws() devemos dizer qual será o separador entre eles. 
-- Vamos aos exemplos:

SELECT
    concat(c_codiclien,' ',c_razaclien, ' ', c_nomeclien)
FROM comclien
    WHERE c_razaclien LIKE 'GREA%';
/*    
+---------------------------------------------------------+
| concat(c_codiclien,' ',c_razaclien, ' ', c_nomeclien)   |
+---------------------------------------------------------+
| 0004 GREAT AMERICAN MUSIC GREAT AMERICAN MUSIC          |
+---------------------------------------------------------+*/

-- Olhando para o resultado, observe que nós separamos os
-- campos com duplo espaço. 
-- Poderíamos fazer isso utilizando algum caractere especial, como com ponto e vírgula ( ; ):

SELECT
    concat_ws(';',c_codiclien, c_razaclien, c_nomeclien)
FROM comclien
    WHERE c_razaclien LIKE 'GREA%';
/*
+------------------------------------------------------+
| concat_ws(';',c_codiclien, c_razaclien, c_nomeclien) |
+------------------------------------------------------+
| 0004;GREAT AMERICAN MUSIC;GREAT AMERICAN MUSIC       |
+------------------------------------------------------+*/

-- Observe que agora apenas declaramos qual o separador
-- queríamos e o SGBD colocou-o entre os campos.

-- Lcase() e lower()
-- Se você fizer uma consulta em nosso banco, vai perceber que
-- alguns registros estão em letras maiúsculas. Se você necessitar, em
-- algum lugar de sua aplicação, dos registros em letras minúsculas, o
-- MySQL também tem uma função para auxiliá-lo. 
-- Utilize o lcase ou o lower da seguinte maneira:

SELECT lcase(c_razaclien)
    FROM comclien;
/*
+------------------------+
| lcase(c_razaclien)     |
+------------------------+
| aaronson furniture ltd |
| auto works ltda        |
| dahlkemper ltda        |
...*/

-- Ucase()

-- Da mesma maneira que podemos retornar os registros de
-- forma minúscula, podemos também de forma maiúscula. Utilize a
-- função ucase .
SELECT ucase('banco de dados mysql')
    FROM DUAL;
/*
+-------------------------------+
| ucase('banco de dados mysql') |
+-------------------------------+
| BANCO DE DADOS MYSQL          |
+-------------------------------+*/


-- continue [pag. 86]

-- 6.4 FUNÇÕES DE CÁLCULOS E OPERADORES ARITMÉTICOS

-- Round
SELECT ROUND('21123.142', 2) FROM DUAL;
/*
+-----------------------+
| format('21123.142',2) |
+-----------------------+
| 21123.14              |
+-----------------------+*/

-- Truncate
-- Temos a opção de utilizar uma função que vai truncar as casas decimais, ou seja, omiti-las.
SELECT 
    TRUNCATE(MAX(n_totavenda), 0) maior_venda
FROM
    comvenda;
/*
+-------------+
| maior_venda |
+-------------+
|       25141 |
+-------------+*/

-- Dependendo da situação com que você está lidando, você
-- poderá deixar alguma casa decimal. Basta substituir o número zero
-- pelo número de casas decimais que deseja truncar.

SELECT 
    TRUNCATE(min(n_totavenda),1) menor_venda
FROM 
    comvenda;
/*
+-------------+
| menor_venda |
+-------------+
|      4650.6 |
+-------------+*/

-- Sqrt()
-- raiz quadrada
select sqrt(4);
/*
+---------+
| sqrt(4) |
+---------+
|       2 |
+---------+*/

-- Funções: seno, cosseno e tangente
select pi();
select sin(pi());
select cos(pi());
select tan(pi()+1);

-- 6.5 OPERADORES ARITMÉTICOS

-- multiplicação: calculando o valor total de um item
SELECT 
    (n_qtdeivenda * n_valoivenda) multiplicação
FROM
    comivenda
where n_numeivenda = 4;
/*
+-----------------+
| multiplicação   |
+-----------------+
| 41038.72        |
+-----------------+*/

-- Somar todos os valores de produtos dos itens das vendas e dividir pelo número de itens vendidos
SELECT 
    TRUNCATE((SUM(n_valoivenda) / COUNT(n_numeivenda)),
        2) divisão
FROM
    comivenda;
    
-- 6.6 FUNÇÕES DE DATA

-- CURDATE - para retornar a data atual, somente
-- NOW - data e hora atual
-- SYSDATE -  igual ao now
-- CURTIME - para retornar somente o horário atual

SELECT curdate(); 
/*
+------------+
|  curdate() |
+------------+
| 2015-03-03 |
+------------+*/

select now();
/*
+---------------------+
|       now()         |
+---------------------+
| 2015-03-03 13:03:11 |
+---------------------+*/

select curtime();
/*
+-----------+
| curtime() |
+-----------+
| 12:56:36 |
+-----------+*/

-- Podemos também retornar o intervalo entre duas datas:
select datediff('2015-02-01 23:59:59','2015-01-01');
/*
+----------------------------------------------+
| datediff('2015-02-01 23:59:59','2015-01-01') |
+----------------------------------------------+
|                                           31 |
+----------------------------------------------+*/

-- E adicionar dias a uma data:
select date_add('2013-01-01', interval 31 day);
/*
+-----------------------------------------+
| date_add('2013-01-01', interval 31 day) |
+-----------------------------------------+
|                              2013-02-01 |
+-----------------------------------------+*/

-- A função de selecionar o nome do dia da semana é muito útil.
-- Você retornará o nome do dia da semana em vez de apenas a data
-- com números, na tela para o seu usuário.
select dayname('2015-01-01');
/*
+-----------------------+
| dayname('2015-01-01') |
+-----------------------+
|              thursday |
+-----------------------+*/

-- Para retornar o dia do mês:
select dayofmonth('2015-01-01');
/*
+--------------------------+
| dayofmonth('2015-01-01') |
+--------------------------+
|                        1 |
+--------------------------+*/

-- Extrair o ano de uma data:
select extract(year from '2015-01-01');
/*
+---------------------------------+
| extract(year from '2015-01-01') |
+---------------------------------+
|                            2015 |
+---------------------------------+*/

-- Extrair o último dia do mês:
select last_day('2015-02-01');
/*
+------------------------+
| last_day('2015-02-01') |
+------------------------+
|             2015-02-28 |
+------------------------+*/

-- Formatando datas

-- Um padrão de data que utilizaremos bastante é o EUR
-- (DD.MM.YYYY), pois ele é parecido com o nosso.
select date_format('2015-01-10',get_format(date,'EUR'));
/*
+--------------------------------------------------+
| date_format('2015-01-01',get_format(date,'EUR')) |
+--------------------------------------------------+
|                                       10.01.2015 |
+--------------------------------------------------+*/

-- Você pode deparar-se com situações nas quais, por exemplo
-- tem de fazer uma migração de dados para o seu banco MySQL,
-- mas os campos de data deste outro estão em um formato diferente
-- e como tipo texto. Com isso, você terá de converter o campo para
-- tipo data e para um formato compatível com o seu banco. Para
-- converter de texto para data, utilizaremos a função str_to_date
-- e, em seguida, passaremos para o nosso formato. Veja o exemplo:
select str_to_date('01.01.2015',get_format(date,'USA'));
/*
+--------------------------------------------------+
| str_to_date('01.01.2015',get_format(date,'USA')) |
+--------------------------------------------------+
|                                       2015-01-01 |
+--------------------------------------------------+*/

-- continue [file procedures.sql]