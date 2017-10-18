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