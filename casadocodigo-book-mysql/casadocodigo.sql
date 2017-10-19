-- https://github.com/viniciuscdes/mysqlbook
-- CAPITULO 1
    -- configurando o mysql
    
-- CAPITULO 2
-- Criando um Novo Usuario:
    -- nome: usermysql
    -- senha: cursomysql
mysql > CREATE USER usermysql@'%' identified by 'cursomysql';
mysql > CREATE USER usermysql@'localhost' identified by 'cursomysql';

-- Quando utilizamos o % em nosso código, estamos dizendo que
-- este usuário poderá acessar o nosso banco a partir de qualquer host. 
-- Poderíamos ter limitado ao acesso do local apenas, substituindo o % por localhost . 
-- Com o comando acima ele já está criado, porém não tem nenhuma permissão. 
-- Como não precisamos limitá-lo, vamos conceder direito total a ele. 
-- Faremos isso com o seguinte comando:
mysql> GRANT ALL PRIVILEGES ON *.* TO usermysql@'%' WITH GRANT OPTION;
mysql> GRANT ALL PRIVILEGES ON *.* TO usermysql@'localhost' WITH GRANT OPTION;

-- Utilizamos grant para conceder o acesso de usuários. 
-- Porém, se quiséssemos revogá-lo, faríamos da seguinte maneira:
mysql> revoke all on *.* from usermysql;

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
mysql > ALTER TABLE comclien AUTO_INCREMENT=100;

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
mysql > UPDATE comclien SET 
            c_nomeclien = 'AARONSON FURNITURE', 
            c_cidaclien = 'LONDRINA', 
            c_estaclien = 'PR'
        WHERE n_numeclien = 1;

mysql > commit;

-- Utilizei o commit para dizer para o SGBD que ele pode realmente 
-- salvar a alteração do registro. Se, por engano, fizermos o update 
-- incorreto, antes do commit , podemos reverter a situação usando a 
-- instrução SQL rollback , da seguinte maneira:
mysql > UPDATE comclien SET c_nomeclien = 'AARONSON'
        WHERE n_numeclien = 1;
mysql > rollback;

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

mysql > DELETE FROM comclien WHERE n_numeclien = 1;
mysql > commit;

-- Deletar todos os registros da tabela de clientes.
mysql > DELETE FROM comclien;
mysql > commit;

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
mysql> truncate table comclien;

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

+-------------+-------------+------------------------+
| n_numeclien |  c_codiclien |           c_razaclien |
+-------------+-------------+------------------------+
|           2 |         0002 |          LITTLER LTDA |
|           3 |         0003 |  KELSEY NEIGHBOURHOOD |
|           4 |         0004 |  GREAT AMERICAN MUSIC |
|           5 |         0005 | LIFE PLAN COUNSELLING |
|           6 |         0006 |      PRACTI-PLAN LTDA |
|           7 |         0007 |       SPORTSWEST LTDA |
|           8 |         0008 |   HUGHES MARKETS LTDA |
|           9 |         0009 |       AUTO WORKS LTDA |
|          10 |        00010 |       DAHLKEMPER LTDA |
+-------------+-------------+------------------------+
9 rows in set (0.00 sec)
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

+-------------+------------------------+
| c_codiclien | c_razaclien            |
+-------------+------------------------+
| 0001        | AARONSON FURNITURE LTD |
| 0002        | LITTLER LTDA           |
+-------------+------------------------+
2 rows in set (0.63 sec)

-- Ou podíamos consultar clientes que possuem o n_numeclien
-- diferente de 1 e 2. Nesta ocasião, devemos utilizar o NOT IN . Vamos ao código.
SELECT c_codiclien, c_razaclien
    FROM comclien
WHERE n_numeclien NOT IN (1,2);

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
+-------------+-----------------------+
8 rows in set (0.00 sec)

-- Nas duas últimas consultas, nós sabíamos os números dos
-- clientes que queríamos ou não consultar. 
-- Entretanto, em nosso projeto, surgiu a necessidade de criar uma consulta para retornar a razão
-- social dos clientes que possuem registro na tabela comvenda . 
-- Para esta situação, vamos utilizar uma subconsulta.
SELECT c_razaclien
    FROM comclien
WHERE n_numeclien IN (SELECT DISTINCT n_numeclien FROM comvenda);

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
+------------------------+
9 rows in set (0.00 sec)

-- Utilizando a mesma situação, vamos buscar os clientes que
-- ainda não fizeram nenhuma venda. 
-- Para isso, utilizaremos o NOT IN . 
-- Você verá que o único cliente que ainda não possui registro de
-- venda retornará, pois a consulta principal vai consultar todos os
-- registros que não possuem o n_numeclien na tabela comvenda .
SELECT c_razaclien
    FROM comclien
WHERE n_numeclien NOT IN (SELECT n_numeclien FROM comvenda);

+------------------+
| c_razaclien      |
+------------------+
| DAHLKEMPER LTDA  |
+------------------+
1 row in set (0.01 sec)

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
        
        +-------------+------------------------+
        | Cod_Venda | Nome_Cliente             |
        +-------------+------------------------+
        | 1         | AARONSON FURNITURE LTD   |
        | 2         | LITTLER LTDA             |
        | 3         | KELSEY NEIGHBOURHOOD     |
        | 4         | GREAT AMERICAN MUSIC     |
        | 5         | LIFE PLAN COUNSELLING    |
        ...
        
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
+-------------+-----------------------+
| CODIGO      |      CLIENTE          |
+-------------+-----------------------+
| 0005        | LIFE PLAN COUNSELLING |
| 0006        | PRACTI-PLAN           |
| 0007        | SPORTSWEST            |
| 0008        | HUGHES MARKETS        |
| 0009        | AUTO WORKS            |
| 00010       | DAHLKEMPER            |
+-------------+-----------------------+
6 rows in set (0.00 sec)

-- 5.3 TRAGA INFORMAÇÃO DE VÁRIAS TABELAS COM JOINS

-- continue [pag. 65]