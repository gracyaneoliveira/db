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

-- Visualizar todos os usuários do banco;
SELECT Host,User,Password FROM mysql.user;

-- CRIANDO UM BANCO DE DADOS;
CREATE DATABASE comercial;

-- VERIFICANDO SE O BANCO FOI CRIADO;
SHOW DATABASES;


-- continue capitulo 3 [pag. 37]
