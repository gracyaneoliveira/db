-- CAPITULO 7: 
-- DEIXAR O BANCO PROCESSAR: PROCEDURES E FUNCTIONS

-- Stored procedures são rotinas definidas no banco de dados, identificadas por um nome
-- pelo qual podem ser invocadas. Este procedimento pode receber
-- parâmetros, retornar valores e executar uma sequência de
-- instruções, por exemplo: fazer update em uma tabela e, em
-- sequência, inserir em outra e retornar um resultado de uma conta
-- para sua aplicação.

-- 7.1 DEIXANDO O BANCO PROCESSAR COM STORED PROCEDURES

-- Vamos criar a stored procedure que deverá buscar o valor da porcentagem de cada vendedor,
-- realizar o processamento e, na sequência, fazer um update na
-- coluna de valor da comissão na tabela de vendas.