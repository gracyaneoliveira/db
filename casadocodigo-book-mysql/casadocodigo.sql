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