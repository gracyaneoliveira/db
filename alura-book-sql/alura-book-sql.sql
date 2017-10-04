-- comments
-- review sql
-- book alura cursos

-- access terminal
-- msql -u root -p

-- import
-- mysql -u root -p escola_alura < escola.sql

-- criando um banco
CREATE DATABASE controledegastos;

-- usar um determinado banco
USE controledegastos;

-- criar tabela
CREATE TABLE compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(18,2),
    datas DATE,
    observacoes VARCHAR(255),
    recebida TINYINT);
    
-- conferindo a existencia de uma tabela
desc compras;

-- inserindo registros
INSERT INTO compras VALUES (20,'2016-01-05','Lanchonete',1);
INSERT INTO compras VALUES (15, '2016-01-06', 'Lanchonete', 1);
INSERT INTO compras VALUES (915.5, '2016-01-06', 'Guarda-roupa', 0);

-- explicitando a orden das colunas na inserção
INSERT INTO compras (datas, observacoes, valor, recebida)
VALUES ('2016-01-10', 'Smartphone', 949.99, 0);

-- select
SELECT * FROM compras;

-- alterando tabela
ALTER TABLE compras ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

-- apagando tabela com todos os dados
DROP TABLE compras;

-- importando dados de um arquivo .sql para nosso banco
-- colocar arquivo no diretório mysql.exe
mysql -u root -p controledegastos < compras.sql

-- select: CLAUSULA WHERE
SELECT * FROM compras WHERE valor < 500;
SELECT * FROM compras WHERE valor > 1500 AND recebida = 0;
SELECT * FROM compras WHERE valor < 500 OR valor > 1500;
SELECT * FROM compras WHERE valor = 3500;
SELECT * FROM compras WHERE observacoes = 'Lanchonete';
SELECT * FROM compras WHERE observacoes LIKE 'Parcela%';
SELECT * FROM compras WHERE observacoes LIKE '%de%';

-- exercicios
-- 1. Selecione valor e observacoes de todas as compras cuja data seja maior-ou-igual que 15/12/2012.
SELECT valor,observacoes FROM controledegastos.compras WHERE datas >= '2012-12-15';

-- 2. Qual o comando SQL para juntar duas condições diferentes? Por exemplo, SELECT * FROM TABELA WHERE campo > 1000 campo < 5000.
SELECT * FROM compras WHERE valor > 1000 OR valor < 5000.

-- 4. Selecione todas as compras cuja data seja maior-ou-igual que 15/12/2012 e menor do que 15/12/2014.
SELECT * FROM controledegastos.compras WHERE datas >= '2012-12-15' AND datas <= '2014-12-15';

-- 5. Selecione todas as compras cujo valor esteja entre R$15,00 e R$35,00 e a observação comece com a palavra 'Lanchonete'.
SELECT * FROM controledegastos.compras WHERE valor > 15.00 AND valor < 35.00 AND observacoes LIKE 'Lanchonete%';

-- 6. Selecione todas as compras que já foram recebidas.
SELECT * FROM controledegastos.compras WHERE recebida = 1; 

-- 6. Selecione todas as compras que ainda não foram recebidas.
SELECT * FROM controledegastos.compras WHERE recebida = 0; 

-- 7. Colocando TRUE no INSERT do campo recebida também funciona
INSERT INTO compras (valor, datas, observacoes, recebida) VALUES (100.0, '2015-09-08', 'COMIDA', TRUE);

-- 8. Selecione todas as compras com valor maior que 5.000,00 ou que já foram recebidas. 
SELECT * FROM compras WHERE valor > 5000 OR recebida = 1;

-- 9. Selecione todas as compras que o valor esteja entre 1.000,00 e 3.000,00 ou seja maior que 5.000,00.
SELECT * FROM controledegastos.compras WHERE valor > 1000 AND valor < 3000 OR valor > 5000;


-- # continua inicio capitulo 3 - ebook alura

-- Em SQL, quando queremos filtrar um intervalo, podemos utilizar o operador BETWEEN :
SELECT valor, observacoes FROM compras WHERE valor BETWEEN 1000 AND 2000;
SELECT id, valor, observacoes 
	FROM compras 
WHERE valor BETWEEN 1000 AND 2000
AND datas BETWEEN '2013-01-01' AND '2013-12-31';

-- Para alterar/atualizar valores em SQL utilizamos a instrução UPDATE
UPDATE compras SET valor = 1500 WHERE id = 11;
UPDATE compras SET observacoes = 'Reforma de quartos' WHERE id = 11;

-- Atualizando várias colunas ao mesmo tempo
UPDATE compras SET valor = 1500, observacoes= 'Reforma de quartos cara' WHERE id=11;
UPDATE compras SET valor = 1650, observacoes = 'Reforma de quartos novos' WHERE id = 11;

-- Fazer um único UPDATE em que digo que quero alterar o valor para o valor dele mesmo, 
-- vezes os meus 1.1 que já queria antes
UPDATE compras SET valor = valor*1.1 WHERE id >= 11 AND id <= 14; 
-- Nessa query fica claro que eu posso usar o valor de um campo (qualquer) para atualizar um campo
-- da mesma linha. No nosso caso usamos o valor original para calcular o novo valor.

SELECT valor FROM compras WHERE id > 11 AND id <= 14;

-- Em SQL, quando queremos excluir algum registro, utilizamos a instrução DELETE
DELETE FROM compras WHERE id=11;

-- exercicios capitulo 3
-- 1. Altere as compras, colocando a observação 'preparando o natal' para todas as que foram efetuadas no dia 20/12/2014.
UPDATE compras SET observacoes='preparando o natal' WHERE datas = '2014-12-20';

-- 2. Altere o VALOR das compras feitas antes de 01/06/2013. Some R$10,00 ao valor atual.
UPDATE compras SET valor = valor + 10 WHERE datas < '2013-06-01'; 

-- 3. Atualize todas as compras feitas entre 01/07/2013 e 01/07/2014 para que elas tenham a observação'entregue antes de 2014' e a coluna recebida com o valor TRUE.
UPDATE compras SET observacoes = 'entregue antes de 2014',recebida=true WHERE datas BETWEEN '2013-07-01' AND '2014-07-01'; 

-- 6. Exclua as compras realizadas entre 05 e 20 março de 2013.
DELETE FROM compras WHERE datas BETWEEN '2013-03-05' AND '2013-03-20';

-- 7. Use o operador NOT e monte um SELECT que retorna todas as compras com valor diferente de R$108,00.
SELECT * FROM compras WHERE NOT valor=108;


-- capitulo 4 [pag 29]
-- Para fazer alterações na estrutura da tabela, podemos utilizar a instrução ALTER TABLE que vimos antes:
-- 1.Configure o valor padrão para a coluna recebida . 
ALTER TABLE compras MODIFY COLUMN recebida TINYINT(1) DEFAULT 0;

-- 2. Configure a coluna observacoes para não aceitar valores nulos.
ALTER TABLE compras MODIFY COLUMN observacoes VARCHAR(255) NOT NULL;

-- 4. NOT NULL e DEFAULT podem ser usados também no CREATE TABLE ? Crie uma tabela nova e adicione Constraints e valores DAFAULT . 
CREATE TABLE aluno (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno VARCHAR (255) NOT NULL,
    novato TINYINT(1) DEFAULT 1    
);

-- 5. Reescreva o CREATE TABLE do começo do curso, marcando observacoes como nulo e valor padrão do recebida como 1.
CREATE TABLE compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(18,2),
    datas DATE,
    observacoes VARCHAR(255),
    recebida TINYINT DEFAULT 1);
    
    
-- capitulo 5 [pag 35]

-- O MySQL fornece a função SUM() que soma todos dos valores de uma coluna:
SELECT SUM(valor) FROM compras;
SELECT SUM(valor) FROM compras WHERE recebida = 1;
SELECT recebida, SUM(valor) FROM compras;

-- Podemos também, contar.
SELECT COUNT(*) FROM compras WHERE recebida = 1;

-- Podemos utilizar a instrução GROUP BY que indica como a soma precisa ser agrupada, ou seja, some todas as compras recebidas e agrupe em uma linha, some todas as compras não recebidas e agrupe em outra linha
SELECT recebida, SUM(valor) FROM compras GROUP BY recebida;

-- Podemos nomear as colunas por meio da instrução AS :
SELECT recebida, SUM(valor) AS soma FROM compras GROUP BY recebida;

+----------+----------+
| recebida | soma     |
+----------+----------+
| 0        | 12281.16 |
| 1        | 31686.75 |
+----------+----------+
2 rows in set (0,00 sec)

-- Podemos aplicar filtros em queries que utilizam funções de agregação
SELECT recebida, SUM(valor) AS soma FROM compras WHERE valor < 1000 GROUP BY recebida;

-- Suponhamos uma query mais robusta, onde podemos verificar em qual mês e ano a compra foi entregue ou não e o valor da soma. Podemos retornar a informação de ano utilizando a função YEAR() e a informação de mês utilizando a função MONTH()
SELECT MONTH(datas) as mes, YEAR(datas) as ano, recebida, SUM(valor) as soma FROM compras GROUP BY recebida,mes,ano;

-- ORDER BY
SELECT MONTH(datas) as mes, YEAR(datas) as ano, recebida, SUM(valor) as soma 
    FROM compras 
GROUP BY recebida,mes,ano
ORDER BY mes, ano;

-- AVG()
SELECT MONTH(data) as mes, YEAR(data) as ano, recebida,
AVG(valor) AS media FROM compras
GROUP BY recebida, mes, ano
ORDER BY ano, mes;

-- exercícios
-- 1. Calcule a média de todas as compras com datas inferiores a 12/05/2013.
SELECT AVG(valor) As media FROM compras WHERE datas < '2013-05-12';

-- 2. Calcule a quantidade de compras com datas inferiores a 12/05/2013 e que já foram recebidas.
SELECT COUNT(*) AS qtd FROM compras WHERE datas < '2013-05-12' AND recebida = 1;

-- 3. Calcule a soma de todas as compras, agrupadas se a compra recebida ou não.
SELECT SUM(valor) AS soma, recebida FROM compras GROUP BY recebida;


-- capitulo 6 [pag. 42]

CREATE TABLE compradores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200),
    endereco VARCHAR(200),
    telefone VARCHAR (30)
);

INSERT INTO compradores (nome, endereco, telefone) VALUES
('Alex Felipe', 'Rua Vergueiro, 3185', '5571-2751');

INSERT INTO compradores (nome, endereco, telefone) VALUES
('João da Silva', 'Av. Paulista, 6544', '2220-4156');

-- Se para adicionar uma coluna utilizamos a instrução ADD COLUMN , logo, para excluir uma tabela, utilizaremos a instrução DROP COLUMN
ALTER TABLE compras DROP COLUMN comprador;
ALTER TABLE compras DROP COLUMN telefone;
ALTER TABLE compras ADD COLUMN id_compradores int;
UPDATE compras SET id_compradores = 1 WHERE id < 22;
UPDATE compras SET id_compradores = 2 WHERE id > 22;
DELETE FROM compras WHERE id_compradores = 100;

-- Quando adicionamos uma FOREIGN KEY em uma tabela, estamos adicionando uma Constraints,
-- então precisaremos alterar a estrutura da tabela compras utilizando a instrução ALTER TABLE :
ALTER TABLE compras 
	ADD CONSTRAINT fk_compradores FOREIGN KEY (id_compradores)
REFERENCES compradores (id);

CREATE TABLE compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_compradores int,
    valor DECIMAL(18,2),
    datas DATE,
    observacoes VARCHAR(255),
    recebida TINYINT,
    FOREIGN KEY (id_compradores) REFERENCES compradores (id);
);

-- continua [pag. 58]

-- No MySQL, existe o tipo de dado ENUM que permite que informemos quais serão os dados que ele pode aceitar.
ALTER TABLE compras ADD COLUMN forma_pagto ENUM('BOLETO', 'CREDITO');
INSERT INTO compras (valor, data, observacoes, id_compradores, forma_pagto)
            VALUES (400, '2016-01-06', 'SSD 128GB', 1, 'BOLETO');
            
-- SERVER SQL MODES

-- O servidor do MySQL opera em diferentes SQL modes e
-- dentre esses modos, existe o strict mode que tem a finalidade de tratar valores inválidos que
-- configuramos em nossas tabelas para instruções de INSERT e UPDATE , como por exemplo, o nosso
-- ENUM . Para habilitar o strict mode precisamos alterar o SQL mode da nossa sessão. Nesse caso usaremos
-- o modo "STRICT_ALL_TABLES"

SET SESSION sql_mode = 'STRICT_ALL_TABLES';
SELECT @@SESSION.sql_mode;
+--------------------+
| @@SESSION.sql_mode |
+--------------------+
| STRICT_ALL_TABLES |
+--------------------+
1 row in set (0,00 sec)

-- O SQL mode é uma configuração do servidor e nós alteramos apenas a sessão que estávamos logado
-- Mas além da sessão, podemos fazer a configuração global do SQL mode.
SET GLOBAL sql_mode = 'STRICT_ALL_TABLES';
SELECT @@GLOBAL.sql_mode;

-- exercicios
-- 1. Crie a tabela compradores com id , nome , endereco e telefone .
-- 2. Insira os compradores, Guilherme e João da Silva.
INSERT INTO compradores (nome, endereco, telefone) VALUES
('Guilherme', 'Rua Fernando Tintas, 30', '9951-2830');
INSERT INTO compradores (nome, endereco, telefone) VALUES
('João Silva', 'Rua Vest Ra, 3', '8851-5478');
-- 3. Adicione a coluna id_compradores na tabela compras e defina a chave estrangeira (FOREIGN KEY) referenciando o id da tabela compradores .
-- 4. Atualize a tabela compras e insira o id dos compradores na coluna id_compradores .
-- 5. Exiba o NOME do comprador e o VALOR de todas as compras feitas antes de 09/08/2014.
SELECT nome, valor FROM compras JOIN compradores ON compras.id_compradores = compradores.id AND datas < '2014-08-09';

-- 6. Exiba todas as compras do comprador que possui ID igual a 2.
SELECT * FROM  compras JOIN compradores ON compras.id_compradores = compradores.id WHERE compradores.id = 2;

-- 7. Exiba todas as compras (mas sem os dados do comprador), cujo comprador tenha nome que começa com 'GUILHERME'.
SELECT compras.id, valor,datas,observacoes,recebida,forma_pagto FROM compras JOIN compradores ON compras.id_compradores = compradores.id WHERE compradores.nome LIKE '%Guilherme';

-- 8. Exiba o nome do comprador e a soma de todas as suas compras.
SELECT nome,SUM(valor) FROM compras JOIN compradores ON compras.id_compradores = compradores.id group by nome;

-- 14. Adicione as formas de pagamento para todas as compras por meio da instrução UPDATE .
UPDATE compras SET forma_pagto = 'CREDITO' WHERE id_compradores = 1;
UPDATE compras SET forma_pagto = 'CREDITO' WHERE id_compradores = 2;

-- 15. Faça a configuração global do MySQL para que ele sempre entre no strict mode.
SET GLOBAL sql_mode = 'STRICT_ALL_TABLES';
SELECT @@GLOBAL.sql_mode; -- visualizar alteracao


-- capitulo 7 - Alunos sem matricula e o EXISTS
-- continua [62]

-- import
-- mysql -u root -p escola_alura < escola.sql

-- SHOW TABLES; [VER TABELAS]

-- Verificar quais são todos os cursos de um aluno.
SELECT aluno.nome, curso.nome as curso 
	FROM matricula 
		JOIN aluno ON aluno.id = matricula.aluno_id
        JOIN curso ON curso.id = matricula.curso_id;

SELECT a.nome, c.nome 
    FROM aluno a
        JOIN matricula m ON m.aluno_id = a.id
        JOIN curso c ON m.curso_id = c.id;

-- contar quantos alunos existem;
SELECT COUNT(*) FROM aluno;

-- Retornar todos os alunos que possuem uma matrícula,
SELECT a.nome 
    FROM aluno a
        JOIN matricula m ON m.aluno_id = a.id;

-- EXISTS    
-- Como podemos verificar quais são os alunos que não estão matriculados? No MySQL, 
-- podemos utilizar a função EXISTS() para verificar se existe algum registro de acordo com uma determinada query:
SELECT a.nome FROM aluno a 
    WHERE EXISTS (select m.id FROM matricula m WHERE m.aluno_id = a.id);
    
SELECT a.nome FROM aluno a 
    WHERE NOT EXISTS (SELECT m.id FROM matricula m WHERE m.aluno_id = a.id);
    
-- Vamos pegar todos os exercícios que não foram respondidos utilizando novamente o NOT EXISTS
SELECT e.id, e.pergunta FROM exercicio e
    WHERE NOT EXISTS (SELECT r.id FROM resposta r WHERE r.exercicio_id = e.id);
    
-- Da mesma forma que retornamos todos os exercícios que não tinha respostas, podemos retornar todos os cursos que não possuem matrícula:
SELECT c.nome FROM curso c 
    WHERE NOT EXISTS (SELECT m.id FROM matricula m WHERE m.curso_id = c.id);

-- Há vários exercícios que não foram respondidos pelos alunos nos cursos que foram realizados recentemente. 
-- Vamos verificar quem foram esses alunos;
   -- Vamos tentar fazer essa query. Começaremos retornando o aluno juntando a tabela aluno com a tabela matricula .
         SELECT a.nome FROM aluno a 
            JOIN matricula m ON m.aluno_id = a.id;
   -- Agora vamos juntar também a tabela curso e retornar os cursos também:
        SELECT a.nome, c.nome FROM aluno a 
            JOIN matricula m ON m.aluno_id = a.id
            JOIN curso c ON m.curso_id = c.id;
   -- Porém ainda precisamos informar que queremos apenas os alunos que NÃO responderam os exercícios de algum desses cursos. Então adicionaremos agora o NOT EXISTS() :
       SELECT a.nome, c.nome FROM aluno a 
            JOIN matricula m ON m.aluno_id = a.id
            JOIN curso c ON m.curso_id = c.id
       WHERE NOT EXISTS (SELECT r.aluno_id FROM resposta r WHERE r.aluno_id = a.id);
 
-- Há uma regra no sistema em que não pode permitir que alunos que não estejam matriculados
-- respodam os exercícios, ou seja, não pode existir uma resposta na tabela resposta com um id de um
-- aluno ( aluno_id ) que não esteja matriculado. 
-- Vamos primeiro verificar todos os alunos matriculados que responderam os exercícios:
    SELECT m.aluno_id, a.nome FROM aluno a
        JOIN matricula m ON m.aluno_id = a.id
        WHERE EXISTS (SELECT r.aluno_id FROM resposta r WHERE r.aluno_id = a.id);

    SELECT r.id, a.nome FROM aluno a
        JOIN resposta r ON r.aluno_id = a.id
        WHERE EXISTS (SELECT m.aluno_id FROM matricula m WHERE m.aluno_id = a.id);

-- exercicios [70] capitulo 7
-- 1. Busque todos os alunos que NÃO tenham nenhuma matrícula nos cursos.
SELECT a.nome FROM aluno a 
    WHERE NOT EXISTS (SELECT m.id FROM matricula m WHERE m.aluno_id = a.id);

-- 2. Busque todos os alunos que NÃO tiveram nenhuma matrícula nos últimos 45 dias, usando a instrução EXISTS .
SELECT a.id, a.nome FROM aluno a 
	WHERE NOT EXISTS (SELECT m.id FROM matricula m WHERE m.aluno_id = a.id AND data > now() - interval 45 day);

-- 3. É possível fazer a mesma consulta sem usar EXISTS ? Quais são?
-- NAO SEI

-- continua [pag. 72]

-- CAPITULO 8 - AGRUPANDO DADOS COM GROUP BY

-- Queremos a média de todos os cursos para fazer uma comparação de notas
-- Existem muitas tabelas que podemos selecionar em nossa query, então vamos montar a nossa query por partes
    -- Começaremos pela tabela nota;
        SELECT n.nota FROM nota n;
    -- Agora precisamos resolver a nossa primeira associação, nesse caso, juntar a tabela resposta com a tabela nota
        SELECT n.nota FROM nota n
            JOIN resposta r ON n.resposta_id= r.id; 
    -- Agora vamos para o próximo JOIN entre a tabela resposta e a tabela exercicio :
        SELECT n.nota FROM nota n
            JOIN resposta r ON n.resposta_id = r.id
            JOIN exercicio e ON r.exercicio_id = e.id;
    -- Agora faremos a associação entre a tabela exercicio e a tabela secao
        SELECT n.nota FROM nota n
            JOIN resposta r ON n.resposta_id = r.id
            JOIN exercicio e ON r.exercicio_id = e.id
            JOIN secao s ON e.secao_id = s.id;
    -- Por fim, faremos a última associação entre a tabela secao e a tabela curso .
        SELECT n.nota FROM nota n
            JOIN resposta r ON n.resposta_id = r.id
            JOIN exercicio e ON r.exercicio_id = e.id
            JOIN secao s ON e.secao_id = s.id
            JOIN curso c ON s.curso_id = c.id;
    -- No MySQL, podemos utilizar a função AVG() para tirar a média:
        SELECT AVG(n.nota) FROM nota n
            JOIN resposta r ON n.resposta_id = r.id
            JOIN exercicio e ON r.exercicio_id = e.id
            JOIN secao s ON e.secao_id = s.id
            JOIN curso c ON s.curso_id = c.id;
    -- Observe que foi retornado apenas um valor, será que essa média é igual para todos os cursos? 
    -- Vamos tentar retornar os cursos e verificarmos:
        SELECT c.nome, AVG(n.nota) FROM nota n
            JOIN resposta r ON n.resposta_id = r.id
            JOIN exercicio e ON r.exercicio_id = e.id
            JOIN secao s ON e.secao_id = s.id
            JOIN curso c ON s.curso_id = c.id;            
        +----------------------+-------------+
        | nome                 | AVG(n.nota) |
        +----------------------+-------------+
        | SQL e banco de dados | 5.740741    |
        +----------------------+-------------+
    -- Apenas 1 curso? Não era esse o resultado que esperávamos!
    -- Quando utilizamos a função AVG() ela calcula todos os valores existentes da query e retorna a média, porém em apenas uma linha!
    -- Para que a função AVG() calcule a média de cada curso, precisamos informar que queremos agrupar a média para uma determinada coluna, nesse caso, a coluna c.nome , ou seja, para cada curso diferente queremos que calcule a média.
    -- Para agruparmos uma coluna utilizamos a instrução GROUP BY , informando a coluna que queremos agrupar:
        SELECT c.nome, AVG(n.nota) FROM nota n
            JOIN resposta r ON n.resposta_id = r.id
            JOIN exercicio e ON r.exercicio_id = e.id
            JOIN secao s ON e.secao_id = s.id
            JOIN curso c ON s.curso_id = c.id
        GROUP BY c.nome;
        +---------------------------------+-------------+
        | nome                            | AVG(n.nota) |
        +---------------------------------+-------------+
        | Csharp e orientação a objetos   | 4.857143    |
        | Desenvolvimento web com VRaptor | 8.000000    |
        | Scrum e métodos ágeis           | 5.777778    |
        | SQL e banco de dados            | 6.100000    |
        +---------------------------------+-------------+
        
   -- Vamos verificar quantos exercícios existem para cada curso. 
   -- Primeiro vamos verificar quantos exercícios existem no banco usando a função COUNT() :
        SELECT COUNT(*) FROM exercicio;
        +----------+
        | COUNT(*) |
        +----------+
        |       31 |
        +----------+
   -- Retormos a quantidade de todos os exercícios, porém nós precisamos saber o total de exercícios para cada curso, ou seja, precisamos juntar a tabela curso.
   -- Porém, para juntar a tabela curso , teremos que juntar a tabela secao :
       SELECT COUNT(*) FROM exercicio e 
            JOIN secao s ON e.secao_id = s.id;
   -- Agora podemos juntar a tabela curso e retornar o nome do curso também e informar que queremos agrupar a contagem pelo nome do curso. Então vamos adicionar o GROUP BY :
       SELECT c.nome, COUNT(*) FROM exercicio e
            JOIN secao s ON e.secao_id = s.id
            JOIN curso c ON s.curso_id = c.id 
        GROUP BY c.nome;
        +---------------------------------+----------+
        | nome                            | COUNT(*) |
        +---------------------------------+----------+
        | Csharp e orientação a objetos   |        7 |
        | Desenvolvimento web com VRaptor |        7 |
        | Scrum e métodos ágeis           |        9 |
        | SQL e banco de dados            |        8 |
        +---------------------------------+----------+
   -- Note que o nome da coluna que conta todos os exercícios está um pouco estranha,
   -- Vamos adicionar um alias para melhorar o resultado:
       SELECT c.nome, COUNT(*) AS contagem FROM exercicio e
            JOIN secao s ON e.secao_id = s.id
            JOIN curso c ON s.curso_id = c.id
       GROUP BY c.nome;
        +---------------------------------+----------+
        | nome                            | contagem |
        +---------------------------------+----------+
        | Csharp e orientação a objetos   |        7 |
        | Desenvolvimento web com VRaptor |        7 |
        | Scrum e métodos ágeis           |        9 |
        | SQL e banco de dados            |        8 |
        +---------------------------------+----------+
    -- Todo final de semestre nós precisamos enviar um relatório informando quantos alunos estão matriculados em cada curso da instituição;
    -- Faremos novamente a nossa query por partes, vamos retornar primeiro todos os cursos:
        SELECT c.nome FROM  curso c;
    -- Vamos juntar a tabela matricula :
        SELECT c.nome FROM  curso c
            JOIN matricula m ON m.curso_id = c.id;
    -- Agora vamos juntar os alunos também:
        SELECT c.nome FROM  curso c
            JOIN matricula m ON m.curso_id = c.id
            JOIN aluno a ON m.aluno_id = a.id;
    -- Precisamos agora contar a quantidade de alunos e agrupar a contagem pelo nome do curso:
        SELECT c.nome, COUNT(a.id) AS quantidade FROM curso c
            JOIN matricula m ON m.curso_id = c.id
            JOIN aluno a ON m.aluno_id = a.id
        GROUP BY c.nome;
        +------------------------------------+------------+
        | nome                               | quantidade |
        +------------------------------------+------------+
        | Csharp e orientação a objetos      |          4 |
        | Desenvolvimento mobile com Android |          2 |
        | Desenvolvimento web com VRaptor    |          2 |
        | Scrum e métodos ágeis              |          2 |
        | SQL e banco de dados               |          4 |
        +------------------------------------+------------+
        
-- exercicio
-- 1. Exiba a média das notas por curso.
SELECT c.nome, AVG(n.nota) FROM nota n
    JOIN resposta r ON n.resposta_id = r.id
    JOIN exercicio e ON r.exercicio_id = e.id
    JOIN secao s ON e.secao_id = s.id
    JOIN curso c ON s.curso_id = c.id
GROUP BY c.nome;

-- 2. Devolva o curso e as médias de notas, levando em conta somente alunos que tenham "Silva" ou "Santos" no sobrenome.
SELECT c.nome, AVG(n.nota) FROM nota n
    JOIN resposta r ON n.resposta_id = r.id
    JOIN exercicio e ON r.exercicio_id = e.id
    JOIN secao s ON e.secao_id = s.id
    JOIN curso c ON s.curso_id = c.id
    JOIN aluno a ON a.id = r.aluno_id
    JOIN matricula m ON m.aluno_id = r.aluno_id
		WHERE a.nome LIKE '%Silva' OR a.nome LIKE  '%Santos'
GROUP BY c.nome;
-- tambem
SELECT c.nome, c.id, a.nome FROM nota n
    JOIN resposta r ON n.resposta_id = r.id
    JOIN exercicio e ON r.exercicio_id = e.id
    JOIN secao s ON e.secao_id = s.id
    JOIN curso c ON s.curso_id = c.id
	JOIN matricula m ON m.curso_id = c.id
    JOIN aluno a ON a.id = r.aluno_id
		WHERE a.nome LIKE '%Silva' OR a.nome LIKE  '%Santos'
group by c.nome;
-- também. agora esse com um JOIN a menos.
SELECT c.nome, AVG(n.nota) FROM nota n
    JOIN resposta r ON n.resposta_id = r.id
    JOIN exercicio e ON r.exercicio_id = e.id
    JOIN secao s ON e.secao_id = s.id
    JOIN curso c ON s.curso_id = c.id
    JOIN aluno a ON a.id = r.aluno_id
		WHERE a.nome LIKE '%Silva' OR a.nome LIKE  '%Santos'
GROUP BY c.nome;

-- 3. Conte a quantidade de respostas por exercício. Exiba a pergunta e o número de respostas.
SELECT e.pergunta, r.id, COUNT(r.resposta_dada) as quantidade FROM resposta r
    JOIN exercicio e ON r.exercicio_id = e.id
GROUP BY e.id;

-- 4. Você pode ordenar pelo COUNT também. Basta colocar ORDER BY COUNT(coluna). Pegue a resposta do exercício anterior, e ordene por número de respostas, em ordem decrescente.
SELECT e.pergunta, r.id, COUNT(r.resposta_dada) as quantidade FROM resposta r
    JOIN exercicio e ON r.exercicio_id = e.id
GROUP BY e.id ORDER BY COUNT(r.resposta_dada) DESC;

-- Podemos agrupar por mais de um campo de uma só vez. 
-- Por exemplo, se quisermos a média de notas por aluno por curso, podemos fazer GROUP BY aluno.id, curso.id.
SELECT c.nome, a.nome, AVG(n.nota) as media FROM nota n
    JOIN resposta r ON n.resposta_id = r.id
    JOIN exercicio e ON r.exercicio_id = e.id
    JOIN secao s ON e.secao_id = s.id
    JOIN curso c ON s.curso_id = c.id
    JOIN aluno a ON r.aluno_id = a.id
GROUP BY a.id, c.id;

-- continua [pag. 81]

-- capitulo 9 FILTRANDO AGREGACOES E O HAVING

-- Todo o fim de semestre, a instituição de ensino precisa montar os boletins dos alunos. 
-- Então vamos montar a query que retornará todas as informações para montar o boletim. 
-- Começaremos retornando todas as notas dos alunos:
    SELECT n.nota FROM notas n;
-- Agora vamos associar com as respostas com as notas:
    SELECT n.nota FROM notas n
        JOIN resposta r ON r.id = n.resposta_id;
-- Associaremos agora com os exercícios com as respostas:
    SELECT n.nota FROM nota n
        JOIN resposta r ON r.id = n.resposta_id
        JOIN exercicio e ON e.id = r.exercicio_id;
-- Agora associaremos a seção com os exercícios:
    SELECT n.nota FROM nota n
        JOIN resposta r ON r.id = n.resposta_id
        JOIN exercicio e ON e.id = r.exercicio_id
        JOIN secao s ON s.id = e.secao_id;
-- Agora o curso com a seção:
    SELECT n.nota FROM nota n
        JOIN resposta r ON r.id = n.resposta_id
        JOIN exercicio e ON e.id = r.exercicio_id
        JOIN secao s ON s.id = e.secao_id
        JOIN curso c ON c.id = s.curso_id;
-- Por fim, a resposta com o aluno:
    SELECT n.nota FROM nota n
        JOIN resposta r ON r.id = n.resposta_id
        JOIN exercicio e ON e.id = r.exercicio_id
        JOIN secao s ON s.id = e.secao_id
        JOIN curso c ON c.id = s.curso_id
        JOIN aluno a ON a.id = r.aluno_id;
-- Vamos tirar a média com a função de agregação AVG() que é capaz de tirar médias;
-- Também dos alunos e dos cursos. Então vamos adicioná-los:
    SELECT a.nome, c.nome, AVG(n.nota) FROM nota n
        JOIN resposta r ON r.id = n.resposta_id
        JOIN exercicio e ON e.id = r.exercicio_id
        JOIN secao s ON s.id = e.secao_id
        JOIN curso c ON c.id = s.curso_id
        JOIN aluno a ON a.id = r.aluno_id
    GROUP BY a.nome, c.nome;
    
-- CONDIÇÕES COM O HAVING
-- Retornamos todas as médias dos alunos, porém a instituição precisa de um relatório separado para
-- todos os alunos que reprovaram, ou seja, que tiraram nota baixa, nesse caso médias menores que 5. De
-- acordo com o que vimos até agora bastaria adicionarmos um WHERE :
    SELECT a.nome, c.nome, AVG(n.nota) FROM nota n
        JOIN resposta r ON r.id = n.resposta_id
        JOIN exercicio e ON e.id = r.exercicio_id
        JOIN secao s ON s.id = e.secao_id
        JOIN curso c ON c.id = s.curso_id
        JOIN aluno a ON a.id = r.aluno_id
        WHERE AVG(n.nota) < 5
    GROUP BY a.nome, c.nome;
    
ERROR 1111 (HY000): Invalid use of group function

-- Nesse caso, estamos tentando adicionar condições para uma função de agregação, porém, quando
-- queremos adicionar condições para funções de agregação precisamos utilizar o HAVING ao invés de
-- WHERE :
    SELECT a.nome, c.nome, AVG(n.nota) FROM nota n
        JOIN resposta r ON r.id = n.resposta_id
        JOIN exercicio e ON e.id = r.exercicio_id
        JOIN secao s ON s.id = e.secao_id
        JOIN curso c ON c.id = s.curso_id
        JOIN aluno a ON a.id = r.aluno_id
        HAVING AVG(n.nota) < 5
    GROUP BY a.nome, c.nome;
    
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your M
ySQL server version for the right syntax to use near 'GROUP BY a.nome, c.nome' at line 8

-- Além de utilizarmos o HAVING existe um pequeno detalhe, precisamos sempre agrupar antes as
-- colunas pelo GROUP BY para depois utilizarmos o HAVING :
    SELECT a.nome, c.nome, AVG(n.nota) FROM nota n
        JOIN resposta r ON r.id = n.resposta_id
        JOIN exercicio e ON e.id = r.exercicio_id
        JOIN secao s ON s.id = e.secao_id
        JOIN curso c ON c.id = s.curso_id
        JOIN aluno a ON a.id = r.aluno_id
        GROUP BY a.nome, c.nome
    HAVING AVG(n.nota) < 5;
    
+---------------+-----------------------------+-------------+
| nome          | nome                         | AVG(n.nota)|
+---------------+-----------------------------+-------------+
| Renata Alonso | Csharp e orientação a objetos|  4.857143  |
+---------------+-----------------------------+-------------+

-- Agora conseguimos retornar o aluno que teve a média abaixo de 5. 
-- E se quiséssemos pegar todos os alunos que aprovaram? 
-- É simples, bastaria alterar o sinal para >= :
    SELECT a.nome, c.nome, AVG(n.nota) FROM nota n
        JOIN resposta r ON r.id = n.resposta_id
        JOIN exercicio e ON e.id = r.exercicio_id
        JOIN secao s ON s.id = e.secao_id
        JOIN curso c ON c.id = s.curso_id
        JOIN aluno a ON a.id = r.aluno_id
    GROUP BY a.nome, c.nome
    HAVING AVG(n.nota) >= 5;
    
+-----------------+---------------------------------+-------------+
| nome           |nome                              | AVG(n.nota) |
+-----------------+---------------------------------+-------------+
| Alberto Santos | Scrum e métodos ágeis            |    5.777778 |
| Frederico José | Desenvolvimento web com VRaptor  |    8.000000 |
| Frederico José | SQL e banco de dados             |   5.666667  |
| João da Silva  | SQL e banco de dados             |   6.285714  |
+-----------------+---------------------------------+-------------+

-- A instuição enviou mais uma solicitação de um relatório informando quais cursos tem poucos
-- alunos para tomar uma decisão se vai manter os cursos ou se irá cancelá-los. 
-- Então vamos novamente fazer a nossa query por passos, primeiro vamos começar selecionando os cursos:
    SELECT c.nome FROM curso c
-- Agora vamos juntar o curso com a matrícula e a matrícula com o aluno e verificar o resultado:
    SELECT c.nome FROM curso c
        JOIN matricula m ON m.curso_id = c.id
        JOIN aluno a ON m.aluno_id = a.id;
-- Então vamos contar a quantidade de alunos com a função COUNT() :
    SELECT c.nome, COUNT(a.id) FROM curso c
        JOIN matricula m ON m.curso_id = c.id
        JOIN aluno a ON m.aluno_id = a.id;
-- Há um detalhe nessa query, pois queremos contar todos os alunos de cada curso, ou seja, 
-- precisamos agrupar os cursos!
    SELECT c.nome, COUNT(a.id) FROM curso c
        JOIN matricula m ON m.curso_id = c.id
        JOIN aluno a ON m.aluno_id = a.id
    GROUP BY c.nome;
+------------------------------------+-------------+
| nome                               | COUNT(a.id) |
+------------------------------------+-------------+
| Csharp e orientação a objetos      |           4 |
| Desenvolvimento mobile com Android |           2 |
| Desenvolvimento web com VRaptor    |           2 |
| Scrum e métodos ágeis              |           2 |
| SQL e banco de dados               |           4 |
+------------------------------------+-------------+
-- A query funcionou, porém precisamos saber apenas os cursos que tem poucos alunos, 
-- nesse caso, cursos que tenham menos de 10 alunos:
    SELECT c.nome, COUNT(a.id) FROM curso c
        JOIN matricula m ON m.curso_id = c.id
        JOIN aluno a ON m.aluno_id = a.id
        GROUP BY c.nome
    HAVING COUNT(a.id) < 10;  
+------------------------------------+-------------+
| nome                               | COUNT(a.id) |
+------------------------------------+-------------+
| Csharp e orientação a objetos      |           4 |
| Desenvolvimento mobile com Android |           2 |
| Desenvolvimento web com VRaptor    |           2 |
| Scrum e métodos ágeis              |           2 |
| SQL e banco de dados               |           4 |
+------------------------------------+-------------+

-- RESUMINDO
-- Sabemos que para adicionarmos filtros apenas para colunas utilizamos a instrução WHERE e
-- indicamos todas as peculiaridades necessárias, porém quando precisamos adicionar filtros para funções
-- de agregação, como por exemplo o AVG() , precisamos utilizar a instrução HAVING . Além disso, é
-- sempre bom lembrar que, quando estamos desenvolvendo queries grandes, é recomendado que faça
-- passa-a-passo queries menores, ou seja, resolva os menores problemas juntando cada tabela por vez e
-- teste para verificar se está funcionando, pois isso ajuda a verificar aonde está o problema da query.

-- exercicios

-- 2. Devolva todos os alunos, cursos e a média de suas notas. Lembre-se de agrupar por aluno e por
-- curso. [Filtre também pela nota: só mostre alunos com nota média menor do que 5.]
SELECT a.nome, c.nome, AVG(n.nota) FROM nota n
    JOIN resposta r ON n.resposta_id = r.id
    JOIN exercicio e ON r.exercicio_id = e.id
    JOIN secao s ON e.secao_id = s.id
    JOIN curso c ON s.curso_id = c.id
    JOIN aluno a ON r.aluno_id = a.id
GROUP BY a.nome, c.nome
HAVING AVG(n.nota) < 5;

-- 3. Exiba todos os cursos e a sua quantidade de matrículas. Mas, exiba somente cursos que tenham mais
-- de 1 matrícula.
SELECT c.nome, COUNT(m.id) FROM curso c
    JOIN matricula m ON m.curso_id = c.id
GROUP BY c.nome
HAVING COUNT(m.id) > 1;

-- 4. Exiba o nome do curso e a quantidade de seções que existe nele. Mostre só cursos com mais de 3 seções.
SELECT c.nome, COUNT(s.id) FROM secao s 
    JOIN curso c ON s.curso_id = c.id
GROUP BY c.nome
HAVING COUNT(s.id) > 3;

-- continua [pag.87]

-- capitulo 10 MÚLTIPLOS VALORES NA CONDIÇÃO E O (IN)

-- Para retornamos os valores distintos de uma coluna podemos utilizar a instrução DISTINCT :
SELECT DISTINCT m.tipo FROM matricula m;

-- Foi solicitado que enviasse um relatório com os cursos e a quantidade de alunos que possuem o tipo de pagamento PJ. Vamos verificar o exemplo em uma planilha:
-- Sabemos que o relatório é sobre a quantidade de matrículas que foram pagas como PJ, precisamos contar, ou seja, usaremos a função COUNT() . Vamos começar a contar a quantidade de matrículas:
    SELECT COUNT(m.id) FROM matricula m;
-- Agora vamos juntar com a tabela curso e exibir o nome do curso:
    SELECT c.nome, COUNT(m.id) FROM matricula m
        JOIN curso c ON m.curso_id = c.id;
+----------------------+-------------+
| nome                 | COUNT(m.id) |
+----------------------+-------------+
| SQL e banco de dados |          14 |
+----------------------+-------------+

-- Observe que foi retornado apenas uma linha! 
-- Isso significa que a função COUNT() também é uma função de agregação, ou seja, se queremos adicionar mais colunas na nossa query, precisamos agrupá-las. Então vamos agrupar o nome do curso:
    SELECT c.nome, COUNT(m.id) FROM matricula m
        JOIN curso c ON m.curso_id = c.id
    GROUP BY c.nome;
+------------------------------------+-------------+
| nome                               | COUNT(m.id) |
+------------------------------------+-------------+
| Csharp e orientação a objetos      |           4 |
| Desenvolvimento mobile com Android |           2 |
| Desenvolvimento web com VRaptor    |           2 |
| Scrum e métodos ágeis              |           2 |
| SQL e banco de dados               |           4 |
+------------------------------------+-------------+

-- Conseguimos retornar todas os cursos e a quantidade de matrículas, porém precisamos filtrar por tipo de pagamento PJ. Então vamos adicionar um WHERE :
    SELECT c.nome, COUNT(m.id) FROM matricula m
        JOIN curso c ON m.curso_id = c.id
    WHERE m.tipo = 'PAGA_PJ'
    GROUP BY c.nome;
+------------------------------------+-------------+
| nome                               | COUNT(m.id) |
+------------------------------------+-------------+
| Csharp e orientação a objetos      |           1 |
| Desenvolvimento mobile com Android |           2 |
| Desenvolvimento web com VRaptor    |           1 |
| Scrum e métodos ágeis              |           1 |
| SQL e banco de dados               |           1 |
+------------------------------------+-------------+

-- FILTROS UTILIZANDO O IN

-- O setor financeiro da instituição precisa de mais detalhes sobre os tipos de pagamento de cada curso,
-- eles precisam de um relatório similar ao que fizemos, porém para todos que sejam pagamento PJ e PF.
-- Para diferenciar o tipo de pagamento, precisaremos adicionar a coluna do m.tipo :
SELECT c.nome, COUNT(m.id), m.tipo
    FROM matricula m
JOIN curso c ON m.curso_id = c.id
    WHERE m.tipo = 'PAGA_PJ' OR m.tipo = 'PAGA_PF'
GROUP BY c.nome, m.tipo;
+------------------------------------+-------------+---------+
| nome                                  |COUNT(m.id)|   tipo |
+------------------------------------+-------------+---------+
| Csharp e orientação a objetos         |        1 | PAGA_PF |
| Csharp e orientação a objetos         |        1 | PAGA_PJ |
| Desenvolvimento mobile com Android    |        2 | PAGA_PJ |
| Desenvolvimento web com VRaptor       |        1 | PAGA_PF |
| Desenvolvimento web com VRaptor       |        1 | PAGA_PJ |
| Scrum e métodos ágeis                 |        1 | PAGA_PF |
| Scrum e métodos ágeis                 |        1 | PAGA_PJ |
| SQL e banco de dados                  |        1 | PAGA_PF |
| SQL e banco de dados                  |        1 | PAGA_PJ |
+------------------------------------+-------------+---------+

-- Suponhamos que agora precisamos retornar também os que foram pagos em boleto ou cheque. O que poderíamos adicionar na query? Mais OR s?
    SELECT c.nome, COUNT(m.id), m.tipo
        FROM matricula m
    JOIN curso c ON m.curso_id = c.id
    WHERE m.tipo = 'PAGA_PJ'
    OR m.tipo = 'PAGA_PF'
    OR m.tipo = 'PAGA_BOLETO'
    OR m.tipo = 'PAGA_CHEQUE'
    OR m.tipo = '...'
    OR m.tipo = '...'
    GROUP BY c.nome, m.tipo;
-- Resolveria, mas perceba que a nossa query a cada novo tipo de pagamento a nossa query tende a crescer, dificultando a leitura... 
-- Em SQL, existe a instrução IN que permite especificarmos mais de um valor que precisamos filtrar ao mesmo tempo para uma determinada coluna:
SELECT c.nome, COUNT(m.id), m.tipo
    FROM matricula m
JOIN curso c ON m.curso_id = c.id
    WHERE m.tipo IN ('PAGA_PJ', 'PAGA_PF', 'PAGA_CHEQUE', 'PAGA_BOLETO')
GROUP BY c.nome, m.tipo;
+------------------------------------+-------------+-------------+
| nome                               | COUNT(m.id) |        tipo |
+------------------------------------+-------------+-------------+
| Csharp e orientação a objetos      |           1 | PAGA_BOLETO |
| Csharp e orientação a objetos      |           1 | PAGA_CHEQUE |
| Csharp e orientação a objetos      |           1 |     PAGA_PF |
| Csharp e orientação a objetos      |           1 |     PAGA_PJ |
| Desenvolvimento mobile com Android |           2 |     PAGA_PJ |
| Desenvolvimento web com VRaptor    |           1 |     PAGA_PF |
| Desenvolvimento web com VRaptor    |           1 |     PAGA_PJ |
| Scrum e métodos ágeis              |           1 |     PAGA_PF |
| Scrum e métodos ágeis              |           1 |     PAGA_PJ |
| SQL e banco de dados               |           1 | PAGA_BOLETO |
| SQL e banco de dados               |           1 | PAGA_CHEQUE |
| SQL e banco de dados               |           1 |     PAGA_PF |
| SQL e banco de dados               |           1 |     PAGA_PJ |
+------------------------------------+-------------+-------------+
-- Se um novo tipo de pagamento for adicionado, basta adicionarmos dentro do IN e a nossa query funcionará corretamente.
-- A instituição nomeou 3 alunos como os mais destacados nos últimos cursos realizamos e gostaria de
-- saber quais foram todos os cursos que eles fizeram. Os 3 alunos que se destacaram foram: João da Silva,
-- Alberto Santos e a Renata Alonso. Vamos verificar quais são os id s desses alunos:
SELECT * FROM aluno;

-- O aluno João da Silva é 1, Alberto Santos 3 e Renata Alonso 4. Agora que sabemos os ids podemos
-- verificar os seus cursos. 
-- Então vamos começar a nossa query retornando todos os cursos:
    SELECT c.name FROM curso c;
-- Agora vamos juntar o curso com a matrícula:
    SELECT c.name FROM curso c 
        JOIN matricula m ON m.curso_id = c.id;
-- Por fim, vamos juntar a matricula com o aluno e retornar o nome do aluno:
    SELECT c.name, a.nome FROM curso c 
        JOIN matricula m ON m.curso_id = c.id
        JOIN aluno ON m.aluno_id = a.id;
-- Fizemos todas as junções, agora só precisamos do filtro. 
-- Precisamos retornar os cursos dos 3 alunos ao mesmo tempo, podemos utilizar a instrução IN :
    SELECT a.nome, c.nome FROM curso c
        JOIN matricula m ON m.curso_id = c.id
        JOIN aluno a ON m.aluno_id = a.id
    WHERE a.id IN (1,3,4);
+----------------+------------------------------------+
| nome           |                               nome |
+----------------+------------------------------------+
| João da Silva  |               SQL e banco de dados |
| Alberto Santos |              Scrum e métodos ágeis |
| Renata Alonso  |      Csharp e orientação a objetos |
| Renata Alonso  | Desenvolvimento mobile com Android |
| João da Silva  |      Csharp e orientação a objetos |
| Alberto Santos |      Csharp e orientação a objetos |
+----------------+------------------------------------+

-- Retornamos todos os cursos dos 3 alunos, porém ainda tá um pouco desorganizado, então vamos
-- ordenar pelo nome dos alunos utilizando o ORDER BY :
    SELECT a.nome, c.nome FROM curso c
        JOIN matricula m ON m.curso_id = c.id
        JOIN aluno a ON m.aluno_id = a.id
    WHERE a.id IN (1,3,4)
    ORDER BY a.nome;
    
-- Na instituição, serão lançados alguns cursos novos de .NET e o pessoal do comercial precisa divulgar
-- esses cursos para os ex-alunos, porém apenas para os ex-alunos que já fizeram os cursos de C# e de SQL.
-- Inicialmente vamos verificar os ids desses cursos:
    SELECT * FROM curso;
-- Curso de SQL é 1 e o curso de C# é 4. Construindo a nossa query, começaremos retornando o aluno:
    SELECT a.nome FROM aluno a;
-- Então juntamos com a matricula e o curso e vamos retornar quais foram os cursos realizados:
    SELECT a.nome, c.nome FROM aluno a
        JOIN matricula m ON m.aluno_id = a.id
        JOIN curso c ON m.curso_id = c.id;
-- Agora utilizaremos o filtro para retornar tanto o curso de SQL(1), quanto o curso de C#(4):
    SELECT a.nome, c.nome FROM aluno a
        JOIN matricula m ON m.aluno_id = a.id
        JOIN curso c ON m.curso_id = c.id
    WHERE c.id IN (1, 4);
-- Novamente o resultado está desordenado, vamos ordenar pelo nome do aluno:
    SELECT a.nome, c.nome FROM aluno a
        JOIN matricula m ON m.aluno_id = a.id
        JOIN curso c ON m.curso_id = c.id
        WHERE c.id IN (1, 4)
    ORDER BY a.nome;
+-----------------+-----------------------------+
| nome           |                         nome |
+-----------------+-----------------------------+
| Alberto Santos |Csharp e orientação a objetos |
| Frederico José |         SQL e banco de dados |
| Frederico José |Csharp e orientação a objetos |
| João da Silva  |         SQL e banco de dados |
| João da Silva  |Csharp e orientação a objetos |
| Manoel Santos  |         SQL e banco de dados |
| Paulo José     |         SQL e banco de dados |
| Renata Alonso  |Csharp e orientação a objetos |
+-----------------+-----------------------------+

-- exercicios
-- 1. Exiba todos os TIPOS de matrícula que existem na tabela. Use DISTINCT para que não haja repetição.
    SELECT DISTINCT m.tipo FROM  matricula m;
-- 2. Exiba todos os cursos e a sua quantidade de matrículas. Mas filtre por matrículas dos tipos PF ou PJ.
    SELECT c.nome, COUNT(m.id) FROM curso c
        JOIN matricula m ON m.curso_id = c.id
        WHERE m.tipo IN ('PAGA_PF','PAGA_PJ')
    GROUP BY c.nome;
-- 3. Traga todas as perguntas e a quantidade de respostas de cada uma. Mas dessa vez, somente dos cursos com ID 1 e 3.
    SELECT e.pergunta, COUNT(r.id) FROM exercicio e
        JOIN resposta r ON r.exercicio_id = e.id
        JOIN secao s ON e.secao_id = s.id
        JOIN curso c ON s.curso_id = c.id
        WHERE c.id IN (1,3)
    GROUP BY e.pergunta;

-- continua [pag. 94]

-- CAPITULO 11 SUB-QUERIES

-- A instituição precisa de um relatório mais robusto, com as seguintes informações: 
-- Precisa do nome do aluno e curso, a média do aluno em relação ao curso e 
-- a diferença entre a média do aluno e a média geral do curso.

-- Começaremos pela tabela nota :
SELECT n.nota FROM nota n;
-- Agora vamos juntar as tabelas resposta e exercicio e vamos verificar o resultado:
SELECT n.nota FROM nota n 
    JOIN resposta r ON n.reposta_id = r.id
    JOIN exercicio e ON r.exercicio_id = e.id;
-- Vamos adicionar as tabelas de secao e curso, porém, dessa vez vamos adicionar o nome do curso: 
SELECT c.nome, n.nota FROM nota n 
    JOIN resposta r ON n.resposta_id = r.id
    JOIN exercicio e ON r.exercicio_id = e.id
    JOIN secao s ON e.secao_id = s.id
    JOIN curso c ON s.curso_id = c.id;
-- Por fim, juntaremos a tabela aluno com a tabela resposta e retornaremos o nome do aluno:
SELECT a.nome, c.nome, n.nota FROM nota n 
    JOIN resposta r ON n.resposta_id = r.id
    JOIN exercicio e ON r.exercicio_id = e.id
    JOIN secao s ON e.secao_id = s.id
    JOIN curso c ON s.curso_id = c.id
    JOIN aluno a ON r.aluno_id = a.id;
-- Conseguimos retornar todas as notas do aluno e os cursos, porém nós precisamos das médias e não de todas as notas. 
-- Então vamos utilizar a função AVG() para retornar a média do aluno. 
-- Lembre-se que a função AVG() é uma função de agregação, ou seja, precisamos agrupar o aluno e o curso também:
SELECT a.nome, c.nome, AVG(n.nota) FROM nota n
JOIN resposta r ON n.resposta_id = r.id
JOIN exercicio e ON r.exercicio_id = e.id
JOIN secao s ON e.secao_id = s.id
JOIN curso c ON s.curso_id = c.id
JOIN aluno a ON r.aluno_id = a.id
GROUP BY a.nome, c.nome;
+-----------------+---------------------------------+-------------+
| nome           | nome                             | AVG(n.nota) |
+-----------------+---------------------------------+-------------+
| Alberto Santos | Scrum e métodos ágeis            |    5.777778 |
| Frederico José | Desenvolvimento web com VRaptor  |    8.000000 |
| Frederico José | SQL e banco de dados             |    5.666667 |
| João da Silva  | SQL e banco de dados             |    6.285714 |
| Renata Alonso  | Csharp e orientação a objetos    |    4.857143 |
+-----------------+---------------------------------+-------------+

-- Agora nós temos a média do aluno e seu respectivo curso, mas ainda falta a coluna da diferença que
-- calcula a diferença entre a média do aluno em um determinado curso e subtrai pela média geral. Porém
-- ainda não temos a média geral, então como podemos pegar a média geral? Vamos verificar a tabela nota :
SELECT * FROM nota;
+----+-------------+-------+
| id |  resposta_id | nota |
+----+-------------+-------+
|  1 |            1 | 8.00 |
|  2 |            2 | 0.00 |
|  3 |            3 | 7.00 |
|  4 |            4 | 6.00 |
|  5 |            5 | 9.00 |

...

-- Perceba que temos todas as notas, teoricamente as notas de todos os cursos, ou seja, para pegarmos a
-- média geral usaremos o AVG() :
SELECT AVG(n.nota) FROM nota n;
-- Conseguimos a média geral, agora vamos adicionar a coluna diferença. Antes de começar a fazer a
-- coluna diferença vamos nomear a coluna de média do aluno para melhorar a visualização:
SELECT a.nome, c.nome, AVG(n.nota) as media_aluno FROM nota...
-- A coluna diferença precisa da informação da media_aluno - media geral, porém, nós não temos
-- nenhuma coluna para a média geral, e o resultado que precisamos está em uma query diferente... 
-- Como podemos resolver isso? 
-- Adicionando essa outra query dentro da query principal, ou seja, fazer uma subquery.
SELECT a.nome, c.nome, AVG(n.nota) as media_aluno,
    AVG(n.nota) - (SELECT AVG(n.nota) FROM nota n) as diferenca 
FROM nota n
JOIN resposta r ON n.resposta_id = r.id
JOIN exercicio e ON r.exercicio_id = e.id
JOIN secao s ON e.secao_id = s.id
JOIN curso c ON s.curso_id = c.id
JOIN aluno a ON r.aluno_id = a.id
GROUP BY a.nome, c.nome;
+-----------------+---------------------------------+-------------+-----------+
| nome           | nome                            | media_aluno |  diferenca |
+-----------------+---------------------------------+-------------+-----------+
| Alberto Santos | Scrum e métodos ágeis           |    5.777778 |   0.037037 |
| Frederico José | Desenvolvimento web com VRaptor |    8.000000 |   2.259259 |
| Frederico José | SQL e banco de dados            |    5.666667 |  -0.074074 |
| João da Silva  | SQL e banco de dados            |    6.285714 |   0.544974 |
| Renata Alonso  | Csharp e orientação a objetos   |    4.857143 |  -0.883598 |
+-----------------+---------------------------------+-------------+-----------+

-- Observe que agora retornamos a diferença, mas será que essas informações batem? 
-- Que tal retornamos a média geral também?
SELECT a.nome, c.nome, AVG(n.nota) as media_aluno,(SELECT AVG(n.nota) FROM nota n) as media_geral,
AVG(n.nota) - (SELECT AVG(n.nota) FROM nota n) as diferenca
    FROM nota n
JOIN resposta r ON n.resposta_id = r.id
JOIN exercicio e ON r.exercicio_id = e.id
JOIN secao s ON e.secao_id = s.id
JOIN curso c ON s.curso_id = c.id
JOIN aluno a ON r.aluno_id = a.id
GROUP BY a.nome, c.nome;

+-----------------+---------------------------------+-------------+-------------+-----------+
| nome           | nome                            | media_aluno | media_geral | diferenca |
+-----------------+---------------------------------+-------------+-------------+-----------+
| Alberto Santos | Scrum e métodos ágeis           |    5.777778 |    5.740741 |  0.037037 |
| Frederico José | Desenvolvimento web com VRaptor |    8.000000 |    5.740741 |  2.259259 |
| Frederico José | SQL e banco de dados            |    5.666667 |    5.740741 | -0.074074 |
| João da Silva  | SQL e banco de dados            |    6.285714 |    5.740741 |  0.544974 |
| Renata Alonso  | Csharp e orientação a objetos   |    4.857143 |    5.740741 | -0.883598 |
+-----------------+---------------------------------+-------------+-------------+-----------+

-- Conseguimos exibir o relatório como esperado, porém existe um pequeno detalhe. Note que o
-- resultado da subquery (SELECT AVG(n.nota) FROM nota n) foi de apenas uma linha e é justamente por
-- esse motivo que conseguimos efetuar operações aritméticas como, nesse caso, a subtração. Se o resultado
-- fosse mais de uma linha, não seria possível realizar operações.

-- A instituição precisa de um relatório do aproveitamento dos alunos nos cursos, ou seja, precisamos
-- saber se eles estão respondendo todos os exercícios, então iremos buscar o número de respostas que cada
-- respondeu aluno individualmente. Vamos verificar o que é esperado do resultado em uma planilha:

-- Então primeiro começaremos retornando os alunos:
SELECT a.nome FROM aluno a;
-- Agora precisamos da quantidade de todas as respostas, então usaremos o COUNT() :
SELECT COUNT(r.id) FROM resposta r;
+-------------+
| COUNT(r.id) |
+-------------+
|          27 |
+-------------+

-- Sabemos a query que conta as respostas e sabemos a query que retornam os alunos, então vamos
-- adicionar a query que conta as respostas dentro da que retorna os alunos, ou seja, vamos fazer
-- novamente uma subquery!
SELECT a.nome, (SELECT COUNT(r.id) FROM resposta r) AS quantidade_respostas 
FROM aluno a;
+------------------+----------------------+
| nome             | quantidade_respostas |
+------------------+----------------------+
| João da Silva    |                   27 |
| Frederico José   |                   27 |
| Alberto Santos   |                   27 |
| Renata Alonso    |                   27 |
| Paulo da Silva   |                   27 |
...

-- Observe que os resultados da quantidade de respostas foram iguais para todos os alunos, pois não
-- adicionamos nenhum filtro na subquery. 
-- Para resolver o problema, basta adicionar um WHERE indicando o que precisa ser filtrado, nesse caso, o id dos alunos retornados na query principal:
SELECT a.nome, (SELECT COUNT(r.id) FROM resposta r WHERE r.aluno_id = a.id) AS quantidade_respostas 
FROM aluno a;
+------------------+----------------------+
| nome             | quantidade_respostas |
+------------------+----------------------+
| João da Silva    |                    7 |
| Frederico José   |                    4 |
| Alberto Santos   |                    9 |
| Renata Alonso    |                    7 |
| Paulo da Silva   |                    0 |
...

-- A instituição precisa de uma relatório muito parecido com a query que acabamos de fazer, ela precisa
-- saber quantas matrículas um aluno tem, ou seja, ao ínves de resposta, informaremos as matrículas. Então
-- vamos apenas substituir as informações das respostas pelas informações da matrícula:
SELECT a.nome, (SELECT COUNT(m.id) FROM matricula m WHERE m.aluno_id = a.id) AS quantidade_matricula
FROM aluno a;

+------------------+----------------------+
| nome             | quantidade_matricula |
+------------------+----------------------+
| João da Silva    |                    2 |
| Frederico José   |                    3 |
| Alberto Santos   |                    2 |
| Renata Alonso    |                    2 |
...
-- Conseguimos pegar a quantidade de resposta e matricula de um determinado aluno, porém fizemos
-- isso separadamente, porém agora precisamos juntar essas informações para montar em um único
-- relatório que mostre, o nome do aluno, a quantidade de respostas e a quantidade de matrículas. 
-- Então vamos partir do princípio, ou seja, fazer a query que retorna todos os alunos:
SELECT a.nome FROM aluno a;
-- Agora vamos pegar a quantidade de respostas:
SELECT COUNT(r.id) FROM resposta r;
-- E então vamos pegar a quantidade de matriculas:
SELECT COUNT(m.id) FROM matricula m;

-- Temos todos os SELECT s que resolvem um determinado problema, ou seja, agora precisamos juntar
-- todos eles para resolver a nova necessidade. 
-- Então vamos adicionar as duas queries que contam as matrículas e as respostas dentro da query principal, 
-- ou seja, a que retorna os alunos:
SELECT a.nome,
(SELECT COUNT(m.id) FROM matricula m WHERE m.aluno_id = a.id) AS quantidade_matricula,
(SELECT COUNT(r.id) FROM resposta r WHERE r.aluno_id = a.id) AS quantidade_respostas
FROM aluno a;

+------------------+----------------------+----------------------+
| nome             | quantidade_matricula | quantidade_respostas |
+------------------+----------------------+----------------------+
| João da Silva    |                    2 |                    7 |
| Frederico José   |                    3 |                    4 |
| Alberto Santos   |                    2 |                    9 |
| Renata Alonso    |                    2 |                    7 |
...

-- exercicios

-- 1. Exiba a média das notas por aluno, além de uma coluna com a diferença entre a média do aluno e a
-- média geral. Use sub-queries para isso.
SELECT a.nome, AVG(n.nota) as media_aluno,
AVG(n.nota) - (SELECT AVG(n.nota) FROM nota n) as diferenca_geral
FROM nota n
    JOIN resposta r ON n.resposta_id = r.id
    JOIN exercicio e ON r.exercicio_id = e.id
    JOIN aluno a ON r.aluno_id = a.id
GROUP BY a.nome;

-- 2. Qual é o problema de se usar sub-queries?
-- R. Tem que retornar uma unica linha

-- 3. Exiba a quantidade de matrículas por curso. Além disso, exiba a divisão entre matrículas naquele
-- curso e matrículas totais.
SELECT c.nome, 
(SELECT COUNT(m.id) FROM matricula m WHERE m.curso_id = c.id) as qtd_matricula,
(SELECT COUNT(m.id) FROM matricula m WHERE m.curso_id = c.id) / (SELECT COUNT(m.id) FROM matricula m) as divisao
 FROM curso c;
 
 
 -- continua [pag.103]
 
 -- ENTENDENDO LEFT JOIN

-- Os instrutores da instituição pediram um relatório com os alunos que são mais participativos na sala de
-- aula, ou seja, queremos retornar os alunos que responderam mais exercícios.
-- Então começaremos retornando o aluno:
SELECT a.nome FROM aluno a;
-- Agora vamos contar a quantidade de respostas por meio da função COUNT() e agrupando pelo nome do aluno:
SELECT a.nome, COUNT(r.id) AS respostas
    FROM aluno a
JOIN resposta r ON r.aluno_id = a.id
    GROUP BY a.nome;
    
+-----------------+-----------+
| nome           |  respostas |
+-----------------+-----------+
| Alberto Santos |          9 |
| Frederico José |          4 |
| João da Silva  |          7 |
| Renata Alonso  |          7 |
+-----------------+-----------+

-- Mas onde estão todos os meus alunos? Aparentemente essa query não está trazendo
-- exatamente o que a gente esperava... Vamos contar a quantidade de alunos existentes:

SELECT COUNT(a.id) FROM aluno a;
+-------------+
| COUNT(a.id) |
+-------------+
|          16 |
+-------------+

-- Observe que existe 16 alunos no banco de dados, porém só foram retornados 4 alunos e suas
-- respostas. Provavelmente não está sendo retornando os alunos que não possuem respostas! Vamos
-- verificar o que está acontecendo exatamente. Vamos pegar um aluno que não foi retornado, como o de
-- id 5. Quantas respostas ele tem?
SELECT r.id FROM resposta r WHERE r.aluno_id = 5;
+------------------+
|               id |
+------------------+
|                0 |
+------------------+

-- Tudo bem, ele não respondeu, mas como ele foi desaparecer daquela query nossa? Vamos pegar
-- outro aluno que desapareceu, o de id 6:
SELECT r.id FROM resposta r WHERE r.aluno_id = 6;
+------------------+
|               id |
+------------------+
|                0 |
+------------------+

-- Opa, parece que encontramos um padrão.
SELECT r.id FROM resposta r WHERE r.aluno_id = 7;
+------------------+
|               id |
+------------------+
|                0 |
+------------------+

-- Sim, encontramos um padrão. Alunos sem resposta desapareceram? 
-- Vamos procurar todos os alunos que não possuem nenhuma resposta. 
-- Isto é selecionar os alunos que não existe, resposta deste aluno:
SELECT a.nome FROM aluno a WHERE NOT EXISTS (SELECT r.id FROM resposta r WHERE r.aluno_id = a.id);
+------------------+
| nome             |
+------------------+
| Paulo da Silva   |
| Carlos Cunha     |
| Paulo José       |
| Manoel Santos    |
| Renata Ferreira  |
| Paula Soares     |
| Jose da Silva    |
| Danilo Cunha     |
| Zilmira José     |
| Cristaldo Santos |
| Osmir Ferreira   |
| Claudio Soares   |
+------------------+

-- Se verificarmos os nomes, realmente, todos os alunos que não tem respostas não estão sendo
-- retornados naquela primeira query. Porém nós queremos também que retorne os alunos sem respostas...
-- Vamos tentar de uma outra maneira, vamos retornar o nome do aluno e a resposta que ele respondeu:
SELECT a.nome, r.resposta_dada 
    FROM aluno a
JOIN resposta r ON r.aluno_id = a.id;

+-----------------+-----------------------------------------------------------------------------------+
| nome            |                                                                     resposta_dada | 
+-----------------+-----------------------------------------------------------------------------------+
| João da Silva   |                                                                       uma selecao |
| João da Silva   |                                                                      ixi, nao sei |
| João da Silva   |                                                                     alterar dados |
...

-- Agora vamos adicionar a coluna id da tabela aluno e aluno_id da tabela resposta :
SELECT a.id, a.nome, r.aluno_id, r.resposta_dada FROM aluno a
JOIN resposta r ON r.aluno_id = a.id;

+----+-----------------+----------+--------------------------------------------------------------------+
| id | nome            | aluno_id | resposta_dada                                                      |
+----+-----------------+----------+--------------------------------------------------------------------+
|  1 | João da Silva   |        1 |                                                         uma selecao|
|  1 | João da Silva   |        1 |                                                        ixi, nao sei|
|  1 | João da Silva   |        1 |                                                       alterar dados|
...

-- Perceba que separamos as informações dos alunos de um lado e a das respostas do outro lado.
-- Analisando esses dados podemos verificar que quando fizemos o JOIN entre a tabela aluno e
-- resposta estamos trazendo apenas todos os registros que possuem o id da tabela aluno e o
-- aluno_id da tabela resposta .

-- O que o SQL faz também é que todos os alunos cujo o id não esteja na coluna aluno_id não
-- serão retornados! Isto é, ele só trará para nós alguém que o JOIN tenha valor igual nas duas tabelas. Se
-- só está presente em uma das tabelas, ele ignora.

-- Em SQL, existe um JOIN diferente que permite o retorno de alunos que também não possuam o
-- id na tabela que está sendo associada. Queremos pegar todo mundo da tabela da esquerda,
-- independentemente de existir ou não um valor na tabela da direita. É um tal de join de esquerda, o LEFT
-- JOIN , ou seja, ele trará todos os registros da tabela da esquerda mesmo que não exista uma associação
-- na tabela da direita:
SELECT a.id, a.nome, r.aluno_id, r.resposta_dada 
    FROM aluno a
LEFT JOIN resposta r ON r.aluno_id = a.id;

+----+------------------+----------+-----------------------------------------------------------------+
| id | nome             | aluno_id | resposta_dada                                                   |
+----+------------------+----------+-----------------------------------------------------------------+
|  1 | João da Silva    |        1 |                                                      uma selecao|
|  1 | João da Silva    |        1 |                                                     ixi, nao sei|
|  1 | João da Silva    |        1 |                                                    alterar dados|
...
|  5 | Paulo da Silva   |     NULL |                                                             NULL|
|  6 | Carlos Cunha     |     NULL |                                                             NULL|
|  7 | Paulo José       |     NULL |                                                             NULL|
...

-- Conseguimos retornar todos os registros. Então agora vamos tentar contar novamentes as respostas, agrupando pelo nome:
SELECT a.nome, COUNT(r.id) AS respostas
FROM aluno a
LEFT JOIN resposta r ON r.aluno_id = a.id
GROUP BY a.nome;

+------------------+-----------+
| nome             | respostas |
+------------------+-----------+
| Alberto Santos   |         9 |
| Carlos Cunha     |         0 |
| Claudio Soares   |         0 |
| Cristaldo Santos |         0 |
| Danilo Cunha     |         0 |
| Frederico José   |         4 |
| João da Silva    |         7 |
| Jose da Silva    |         0 |
| Manoel Santos    |         0 |
| Osmir Ferreira   |         0 |
| Paula Soares     |         0 |
| Paulo da Silva   |         0 |
| Paulo José       |         0 |
| Renata Alonso    |         7 |
| Renata Ferreira  |         0 |
| Zilmira José     |         0 |
+------------------+-----------+
-- Agora conseguimos retornar todos os alunos e a quantidade de respostas, mesmo que o aluno não
-- tenha respondido pelo menos uma resposta.

-- 12.1 RIGHT JOIN

-- Vamos supor que ao invés de retornar todos os alunos e suas respostas, mesmo que o aluno não
-- tenha nenhuma resposta, queremos faer o contrário, ou seja, retornar todos as respostas que foram
-- respondidas e as que não foram respondidas. Vamos verificar se existe alguma resposta que não foi
-- respondida por um aluno:
SELECT r.id FROM resposta r
WHERE r.aluno_id IS NULL;

Empty set (0,00 sec)

-- Não existe exercício sem resposta, então vamos inserir uma resposta sem associar a um aluno:

INSERT INTO resposta (resposta_dada) VALUES ('x vale 15.');
Query OK, 1 row affected (0,01 sec)

-- Se verificarmos novamente se existe uma resposta que não foi respondida por um aluno:
SELECT r.id FROM resposta r
WHERE r.aluno_id IS NULL;

+----+
| id |
+----+
| 28 |
+----+

-- Agora existe uma resposta que não foi associada a um aluno. Da mesma forma que utilizamos um
-- JOIN diferente para pegar todos os dados da tabela da esquerda (LEFT) mesmo que não tenha
-- associação com a tabela que está sendo juntada, existe também o JOIN que fará o procedimento, porém
-- para a tabela da direita (RIGHT), que é o tal do RIGHT JOIN :
SELECT a.nome, r.resposta_dada
FROM aluno a
RIGHT JOIN resposta r ON r.aluno_id = a.id;

+-----------------+---------------------------------------------+
| nome            | resposta_dada                               |
+-----------------+---------------------------------------------+
| João da Silva   |                                  uma selecao|
| João da Silva   |                                 ixi, nao sei|
...
| NULL            |                                    x vale 15|
+-----------------+---------------------------------------------+

-- Observe que foi retornada a resposta em que não foi respondida por um aluno.
-- Quando utilizamos apenas o JOIN significa que queremos retornar todos os registros que tenham
-- uma associação, ou seja, que exista tanto na tabela da esquerda quanto na tabela da direita, esse JOIN
-- também é conhecido como INNER JOIN . Vamos verificar o resultado utilizando o INNER JOIN :
SELECT a.nome, COUNT(r.id) AS respostas
    FROM aluno a
INNER JOIN resposta r ON r.aluno_id = a.id
GROUP BY a.nome;
+-----------------+-----------+
| nome            | respostas |
+-----------------+-----------+
| Alberto Santos  |         9 |
| Frederico José  |         4 |
| João da Silva   |         7 |
| Renata Alonso   |         7 |
+-----------------+-----------+
-- Ele trouxe apenas os alunos que possuem ao menos uma resposta, ou seja, que exista a associação
-- entre a tabela da esquerda ( aluno ) e a tabela da direita ( resposta ).

-- 12.2 JOIN OU SUBQUERY?

-- No capítulo anterior tivemos que fazer uma query para retornar todos os alunos e a quantidade de
-- matrículas, porém utilizamos subqueries para resolver o nosso problema. 
-- Podemos também, construir essa query apenas com JOIN s. Vamos tentar:
SELECT a.nome, COUNT(m.id) AS qtd_matricula FROM aluno a
JOIN matricula m ON m.aluno_id = a.id
GROUP BY a.nome;
+-----------------+---------------+
| nome            | qtd_matricula |
+-----------------+---------------+
| Alberto Santos  |             2 |
| Frederico José  |             3 |
| João da Silva   |             2 |
| Manoel Santos   |             2 |
| Paula Soares    |             1 |
| Paulo José      |             1 |
| Renata Alonso   |             2 |
| Renata Ferreira |             1 |
+-----------------+---------------+

-- Aparentemente não retornou os alunos que não possuem matrícula, porém utilizamos apenas o
-- JOIN , ou seja, o INNER JOIN . Ao invés do INNER JOIN que retorna apenas se existir a associação
-- entre as tabelas da esquerda ( aluno ) e a da direita( matricula ), nós queremos retornar todos os
-- alunos, mesmo que não possuam matrículas, ou seja, tabela da esquerda. Então vamos tentar agora com o LEFT JOIN :
SELECT a.nome, COUNT(m.id) AS qtd_matricula FROM aluno a
LEFT JOIN matricula m ON m.aluno_id = a.id
GROUP BY a.nome;

+------------------+---------------+
| nome             | qtd_matricula |
+------------------+---------------+
| Alberto Santos   |             2 |
| Carlos Cunha     |             0 |
| Claudio Soares   |             0 |
| Cristaldo Santos |             0 |
| Danilo Cunha     |             0 |
| Frederico José   |             3 |
| João da Silva    |             2 |
| Jose da Silva    |             0 |
| Manoel Santos    |             2 |
| Osmir Ferreira   |             0 |
| Paula Soares     |             1 |
| Paulo da Silva   |             0 |
| Paulo José       |             1 |
| Renata Alonso    |             2 |
| Renata Ferreira  |             1 |
| Zilmira José     |             0 |
+------------------+---------------+

-- Da mesma forma que conseguimos pegar todos os alunos e a quantidade de respostas mesmo que o
-- aluno não tenha respondido nenhuma resposta utilizando o LEFT JOIN poderíamos também resolver
-- utilizando uma subquery parecida com qual retornava todos os alunos e a quantidade de matrículas:
SELECT a.nome,
(SELECT COUNT(r.id) FROM resposta r WHERE r.aluno_id = a.id) AS respostas
FROM aluno a;

+------------------+-----------+
| nome             | respostas |
+------------------+-----------+
| João da Silva    |         7 |
| Frederico José   |         4 |
| Alberto Santos   |         9 |
| Renata Alonso    |         7 |
| Paulo da Silva   |         0 |
| Carlos Cunha     |         0 |
| Paulo José       |         0 |
| Manoel Santos    |         0 |
| Renata Ferreira  |         0 |
| Paula Soares     |         0 |
| Jose da Silva    |         0 |
| Danilo Cunha     |         0 |
| Zilmira José     |         0 |
| Cristaldo Santos |         0 |
| Osmir Ferreira   |         0 |
| Claudio Soares   |         0 |
+------------------+-----------+

-- O resultado é o mesmo! 
-- Se o resultado é o mesmo, quando eu devo utilizar o JOIN ou as subqueries?
-- Aparentemente a subquery é mais enxuta e mais fácil de ser escrita, porém os SGBDs sempre terão um
-- desempenho melhor para JOIN em relação a subqueries, então prefira o uso de JOIN s ao invés de subquery.

-- Vamos tentar juntar as queries que fizemos agora pouco, porém em uma única query. Veja o
-- exemplo em uma planilha. |aluno|qtd_resposta|qtd_matricula|

-- Primeiro vamos fazer com subqueries. Então começaremos retornando o nome do aluno:
SELECT a.nome FROM aluno a;
-- Agora vamos contar todas as respostas e testar o resultado:
SELECT a.nome,
(SELECT COUNT(r.id) FROM resposta r WHERE r.aluno_id = a.id) AS qtd_respostas
FROM aluno a;
+------------------+---------------+
| nome             | qtd_respostas |
+------------------+---------------+
| João da Silva    |             7 |
| Frederico José   |             4 |
| Alberto Santos   |             9 |
| Renata Alonso    |             7 |
| Paulo da Silva   |             0 |
| Carlos Cunha     |             0 |
| Paulo José       |             0 |
...
-- Por fim, vamos contar as matrículas e retornar a contagem:
SELECT a.nome,
(SELECT COUNT(r.id) FROM resposta r WHERE r.aluno_id = a.id) AS qtd_respostas,
(SELECT COUNT(m.id) FROM matricula m WHERE m.aluno_id = a.id) AS qtd_matriculas
FROM aluno a;

+------------------+---------------+----------------+
| nome             | qtd_respostas | qtd_matriculas |
+------------------+---------------+----------------+
| João da Silva    |             7 |              2 |
| Frederico José   |             4 |              3 |
| Alberto Santos   |             9 |              2 |
| Paulo da Silva   |             0 |              0 |
| Carlos Cunha     |             0 |              0 |
| Paulo José       |             0 |              1 |
...

-- Conseguimos o resultado esperado utilizando as subqueries, vamos tentar com o LEFT JOIN ? 
-- Da mesma forma que fizemos anteriormente, começaremos retornando os alunos:
SELECT a.nome FROM aluno a;
-- Agora vamos juntar as tabela aluno com as tabelas resposta e matricula :
SELECT a.nome, r.id AS qtd_respostas, m.id AS qtd_matriculas
FROM aluno a
LEFT JOIN resposta r ON r.aluno_id = a.id
LEFT JOIN matricula m ON m.aluno_id = a.id;

+------------------+---------------+----------------+
| nome             | qtd_respostas | qtd_matriculas |
+------------------+---------------+----------------+
| João da Silva    |             1 |              1 |
| João da Silva    |             2 |              1 |
| João da Silva    |             3 |              1 |
...
| Cristaldo Santos |          NULL |           NULL |
| Osmir Ferreira   |          NULL |           NULL |
| Claudio Soares   |          NULL |           NULL |
+------------------+---------------+----------------+

-- Antes de contarmos as colunas de qtd_resposas e qtd_matricula, vamos analisar um pouco esse resultado. 
-- Note que o aluno João da Silva retornou 14 vezes, parece que tem alguma coisa estranha.
-- Vamos pegar o id do João da Silva e vamos verificar os registros dele na tabela resposta e na tabela matricula :
SELECT a.id FROM aluno a WHERE a.nome = 'João da Silva';
+----+
| id |
+----+
|  1 |
+----+
-- Agora vamos verificar todos os registros dele na tabela resposta :
SELECT r.id FROM resposta r
WHERE r.aluno_id = 1;
+----+
| id |
+----+
| 1 |
| 2 |
| 3 |
| 4 |
| 5 |
| 6 |
| 7 |
+----+
-- Foram retornados 7 registros, agora vamos verificar na tabela matricula :
SELECT m.id FROM matricula m
WHERE m.aluno_id = 1;
+----+
| id |
+----+
|  1 |
| 11 |
+----+
-- Foram retornados 2 registros. 
-- Se analisarmos um pouco esses três resultados chegamos aos seguintes números:
-- aluno = 1 --> respostas = 7 ; matrículas = 2
-- Vamos executar novamente a nossa query que retorna o aluno e a contagem de respostas e matrículas:
SELECT a.nome, r.id AS qtd_respostas, m.id AS qtd_matriculas
FROM aluno a
LEFT JOIN resposta r ON r.aluno_id = a.id
LEFT JOIN matricula m ON m.aluno_id = a.id;
+------------------+---------------+----------------+
| nome             | qtd_respostas | qtd_matriculas |
+------------------+---------------+----------------+
| João da Silva    |             1 |              1 |
| João da Silva    |             2 |              1 |
| João da Silva    |             3 |              1 |
...
| Cristaldo Santos |          NULL |           NULL |
| Osmir Ferreira   |          NULL |           NULL |
| Claudio Soares   |          NULL |           NULL |
+------------------+---------------+----------------+

-- Repare que a nossa query associando um aluno 1, com a resposta 1 e matrícula 1, o mesmo aluno 1,
-- com resposta 1 e matrícula 11 e assim sucessivamente... 
-- Isso significa que essa query está multiplicando o aluno(1) x respostas(7) x matrículas(2)... 
-- Com certeza essa contagem não funcionará! 
-- Precisamos de resultados distintos, ou seja, iremos utilizar o DISTINCT para evitar esse problema. 
-- Agora podemos contar as respostas e as matrículas:

SELECT a.nome, COUNT(DISTINCT r.id) AS qtd_respostas,
COUNT(DISTINCT m.id) AS qtd_matriculas
FROM aluno a
LEFT JOIN resposta r ON r.aluno_id = a.id
LEFT JOIN matricula m ON m.aluno_id = a.id
GROUP BY a.nome;

+------------------+---------------+----------------+
| nome             | qtd_respostas | qtd_matriculas |
+------------------+---------------+----------------+
| Alberto Santos   |             9 |              2 |
| Carlos Cunha     |             0 |              0 |
| Claudio Soares   |             0 |              0 |
| Cristaldo Santos |             0 |              0 |
| Danilo Cunha     |             0 |              0 |
| Frederico José   |             4 |              3 |
| João da Silva    |             7 |              2 |
| Jose da Silva    |             0 |              0 |
| Manoel Santos    |             0 |              2 |
| Osmir Ferreira   |             0 |              0 |
| Paula Soares     |             0 |              1 |
| Paulo da Silva   |             0 |              0 |
| Paulo José       |             0 |              1 |
| Renata Alonso    |             7 |              2 |
| Renata Ferreira  |             0 |              1 |
| Zilmira José     |             0 |              0 |
+------------------+---------------+----------------+

-- E se não adicionássemos a instrução DISTINCT ? O que aconteceria? Vamos testar:
SELECT a.nome, COUNT(r.id) AS qtd_respostas,
COUNT(m.id) AS qtd_matriculas
FROM aluno a
LEFT JOIN resposta r ON r.aluno_id = a.id
LEFT JOIN matricula m ON m.aluno_id = a.id
GROUP BY a.nome;

+------------------+---------------+----------------+
| nome             | qtd_respostas | qtd_matriculas |
+------------------+---------------+----------------+
| Alberto Santos   |            18 |             18 |
| Carlos Cunha     |             0 |              0 |
...

-- O resultado além de ser bem maior que o esperado, repete nas duas colunas, pois está acontecendo
-- aquele problema da multiplicação das linhas! Perceba que só conseguimos verificar de uma forma rápida
-- o problema que aconteceu, pois fizemos a query passo-a-passo, verificando cada resultado e, ao mesmo
-- tempo, corrigindo os problemas que surgiam.

-- exercicios
-- 1. Exiba todos os alunos e suas possíveis respostas. Exiba todos os alunos, mesmo que eles não tenham respondido nenhuma pergunta.
SELECT a.nome, r.resposta_dada FROM aluno a
JOIN resposta r ON r.aluno_id = a.id; 

SELECT a.nome, r.resposta_dada FROM aluno a
LEFT JOIN resposta r ON r.aluno_id = a.id; 

-- 2. Exiba agora todos os alunos e suas possíveis respostas para o exercício com ID = 1. Exiba todos os alunos mesmo que ele não tenha respondido o exercício. Lembre-se de usar a condição no JOIN.
SELECT a.nome, r.resposta_dada FROM aluno a
    LEFT JOIN resposta r ON r.aluno_id = a.id AND r.exercicio_id = 1;

-- 3. Qual a diferença entre o JOIN convencional (muitas vezes chamado também de INNER JOIN) para o LEFT JOIN?
-- resp. o primeiro retornará o resultado se e somente se houver a correpondecia das colunas, na condição dada, em ambas as tabelas. Já a segunda retornará resultado mesmo não tendo correspondencia.

-- continua [pag. 120]

-- capitulo 13 MUITOS ALUNOS E O LIMIT

-- Precisamos de um relatório que retorne todos os alunos, algo como selecionar o nome de todos eles, com um SELECT simples:
SELECT a.nome FROM aluno a;

-- Para melhorar o resultado podemos ordernar a query por ordem alfabética do nome:
SELECT a.nome FROM aluno a ORDER BY a.nome;

-- Vamos verificar agora quantos alunos estão cadastrados:
SELECT count(*) FROM aluno;
+----------+
| count(*) |
+----------+
|       16 |
+----------+

-- No MySQL, podemos limitar em 5 a quantidade de registros que desejamos retornar:
SELECT a.nome FROM aluno a
ORDER BY a.nome
LIMIT 5;
+------------------+
|             nome |
+------------------+
| Alberto Santos   |
| Carlos Cunha     |
| Claudio Soares   |
| Cristaldo Santos |
| Danilo Cunha     |
+------------------+

-- 13.1 LIMITANDO E BUSCANDO A PARTIR DE UMA QUANTIDADE ESPECÍFICA

-- Agora vamos pegar os próximos 5 alunos, isto é, ignore os 5 primeiros, e depois pegue para mim os próximos 5:
SELECT a.nome FROM aluno a
ORDER BY a.nome
LIMIT 5,5;

+-----------------+
| nome            |
+-----------------+
| Frederico José  |
| João da Silva   |
| Jose da Silva   |
| Manoel Santos   |
| Osmir Ferreira  |
+-----------------+

-- LIMIT 5 ? LIMIT 5,5 ? Parece um pouco estranho, o que será que isso significa? Quando utilizamos o LIMIT funciona da seguinte maneira: LIMIT linha_inicial,qtd_de_linhas_para_avançar , ou seja, quando fizemos LIMIT 5 , informamos ao
-- MySQL que avançe 5 linhas apenas, pois por padrão ele iniciará pela primeira linha, chamada de linha
-- 0 . Se fizéssemos LIMIT 0,5 , por exemplo:
SELECT a.nome FROM aluno a
ORDER BY a.nome
LIMIT 0,5;
+------------------+
| nome             |
+------------------+
| Alberto Santos   |
| Carlos Cunha     |
| Claudio Soares   |
| Cristaldo Santos |
| Danilo Cunha     |
+------------------+

-- Perceba que o resultado é o mesmo que LIMIT 5 ! Se pedimos LIMIT 5,10 o que ele nos trás?
SELECT a.nome FROM aluno a
ORDER BY a.nome
LIMIT 5,10;
+-----------------+
| nome            |
+-----------------+
| Frederico José  |
| João da Silva   |
| Jose da Silva   |
| Manoel Santos   |
| Osmir Ferreira  |
| Paula Soares    |
| Paulo da Silva  |
| Paulo José      |
| Renata Alonso   |
| Renata Ferreira |
+-----------------+
-- O resultado iniciará após a linha 5, ou seja, linha 6 e avançará 10 linhas. 

-- exercícios

-- 1. Escreva uma query que traga apenas os dois primeiros alunos da tabela.
SELECT a.nome FROM aluno a LIMIT 2;

-- 2. Escreva uma SQL que devolva os 3 primeiros alunos que o e-mail termine com o domínio ".com".
SELECT a.nome FROM aluno a WHERE a.email LIKE '%.com' LIMIT 3;

-- 3. Devolva os 2 primeiros alunos que o e-mail termine com ".com", ordenando por nome.
SELECT a.nome FROM aluno a WHERE a.email LIKE '%.com' ORDER BY a.nome LIMIT 2;

-- 4. Devolva todos os alunos que tenham Silva em algum lugar no seu nome.
SELECT a.nome FROM aluno a WHERE a.nome LIKE '%Silva%';