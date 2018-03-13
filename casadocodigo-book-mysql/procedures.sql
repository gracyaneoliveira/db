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

mysql>delimiter $$
mysql>create procedure processa_comissionamento(
		in  data_inicial     date,
        in  data_final       date  ,
		out total_processado int )
		begin
			
			declare total_venda    float(10,2) default 0;
			declare venda          int         default 0;
			declare vendedor       int         default 0;
			declare comissao       float(10,2) default 0;
			declare valor_comissao float(10,2) default 0;
			declare aux            int         default 0;
			declare fimloop        int default 0;
			
			## cursor para buscar os registros a serem 
			## processados entre a data inicial e data final
			## e valor total de venda é maior que zero
			declare busca_pedido cursor for 
				select n_numevenda,
				       n_totavenda,
					   n_numevende
				  from comvenda
				 where d_datavenda between data_inicial 
				 	and data_final
				  	and n_totavenda > 0 ;
			
            ## Faço aqui um tratamento para o banco não 
			## executar o loop quando ele terminar
			## evitando que retorne qualquer erro
			declare 
			continue handler 
			for sqlstate '02000' 
			set fimloop  = 1;

			
            ## abro o cursor				
			open busca_pedido;
				
				## inicio do loop
				vendas: LOOP
				
				##Aqui verifico que se o loop terminou
				##e saio do loop
				if fimloop  = 1 then 
				  leave  vendas;
				end if;
				
				##recebo o resultado da consulta em cada variável
				fetch busca_pedido into venda, total_venda, 
				vendedor;
				
				## busco o valor do percentual de cada vendedor
				select n_porcvende 
			      into comissao 
			      from comvende
			     where n_numevende = vendedor;
				
				## verifico se o percentual do vendedor é maior
				## que zero logo após a condição deve ter o then
				if (comissao > 0 ) then 
				    ## calculo o valor da comissao
					set valor_comissao  = 
						((total_venda * comissao)  / 100);
					
					## faço o update na tabela comvenda com o 
					## valor da comissão
					update comvenda set 
					n_vcomvenda = valor_comissao
					where n_numevenda = venda;
					commit; 
				
				## verifico se o percentual do vendedor é igual 
				## zero na regra do nosso sistema se o vendedor 
				## tem 0 ele ganha 0 porcento de comissão
                elseif(comissao = 0) then
				    
					update comvenda set n_vcomvenda = 0
					where n_numevenda = venda;
					commit;
				
				## se ele não possuir registro no percentual de
                ## comissão ele irá ganhar 1 de comissão
				## isso pela regra de negócio do nosso sistema
				else 
					set comissao = 1;
					set valor_comissao = 
						((total_venda * comissao)  / 100);
					
					update 
						comvenda set n_vcomvenda = valor_comissao
					where n_numevenda = venda;
					commit;  
				## fecho o if	 
				end if;
				
				set comissao = 0;
				##utilizo a variável aux para contar a quantidade
				set  aux      = aux +1 ;
			end loop vendas;
				## atribuo o total de vendas para a variável de
				## saída
			set total_processado = aux;
			## fecho o cursor
			close busca_pedido;
		
			##retorno o total de vendas processadas
			
			
			end$$
			
mysql>delimiter ;	


mysql> call processa_comissionamento('2015-01-01','2015-05-30' ,@a);
mysql> select @a;


-- 7.2 PROCESSANDO E RETORNANDO COM FUNCTIONS

-- Se você quiser criar algo para ter algum retorno, aconselho a
-- utilização de uma function , pois poderemos utilizá-las no meio
-- de uma consulta, ao contrário da procedure , que temos que
-- executar com um comando específico.

-- Vamos criar uma function para retornar o nome do cliente.

mysql>delimiter $$
mysql>create function rt_nome_cliente(vn_numeclien int)
        returns varchar(50) 

        begin
            declare nome varchar(50);
            
            select c_nomeclien into nome
                from comclien
            where n_numeclien = vn_numeclien;
            
            return nome;
        end $$

mysql> delimiter ;

mysql> ## estou passando como parâmetro o id do cliente igual a 1
mysql> select rt_nome_cliente(1);


mysql> ##irei retornar o código da venda, nome do cliente e a
mysql> ##data da venda ordenando pelo nome e em seguida pela data
mysql> select c_codivenda,
              rt_nome_cliente(n_numeclien),
              d_datavenda
            from comvenda
        order by 2,3;
        
-- 7.4 AUTOMATIZANDO O PROCESSO ATRAVÉS DE EVENT SCHEDULER

-- Vamos programar a procedure processa_comissionamento para executar uma vez por semana.
-- Por isso, utilizaremos on schedule every 1 week , que vai
-- executar a primeira vez no dia '2015-03-01' ás 23:00 horas.
-- Primeiro, devemos habilitar o event_scheduler em nosso
-- SGBD, pois, por padrão, ele fica desabilitado. 

-- Abra o prompt e digite o comando:

mysql> set global event_scheduler = on;

mysql> delimiter $$
mysql> create event processa_comissao
       on schedule every 1 week starts '2015-03-01 23:38:00'
       do
        begin
            call processa_comissionamento(
                current_date() - interval 7 day,
                current_date(), @a );
        end
mysql> $$
mysql> delimiter ;

-- Para vermos o resultado, vamos consultar as vendas desse período.
mysql> select c_codivenda Codigo,
              n_totavenda Total,
              n_vcomvenda Comissao
         from comvenda
        where
            d_datavenda between current_date() - interval 60 day
            and current_date();
            
+--------+----------+----------+
| Codigo |    Total | Comissao |
+--------+----------+----------+
|      2 | 12476.58 |  1743.99 |
|      3 | 16257.32 |     0.00 |
|      4 |  8704.55 |     0.00 |
|      6 |  6079.19 |     0.00 |
|      7 |  7451.26 |     0.00 |
...

-- Eventos com outras periodicidades, entre elas:
on schedule every 1 year: uma vez por ano;
on schedule every 1 month: uma vez por mês;
on schedule every 1 day: uma vez ao dia;
on schedule every 1 hour: uma vez por hora;
on schedule every 1 minute: uma vez por minuto;
on schedule every 1 second: uma vez por segundo.


-- Além de escolher quando ela começará, você também pode decidir quando parará de executar. 
-- Para exemplificar, vamos criar um evento para iniciar a nossa procedure a cada 10 minutos e
-- parar depois de uma hora.

mysql> delimiter $$
mysql> create event processa_comissao_event
        on schedule every 10 minute
        starts current_timestamp
        ends current_timestamp + interval 30 minute
        do
            begin
                call processa_comissionamento(
                     current_date() - interval 7 day,
                     current_date(),
                     @a);
            end
mysql> $$
mysql> delimiter ;

-- Ao criar um evento, ele fica habilitado automaticamente. Pode
-- acontecer que, depois de um período, você não queira mais que o
-- processo execute maquinalmente. Em vez de excluí-lo, você pode
-- apenas desabilitá-lo com o seguinte comando:

mysql> alter event processa_comissao_event disable;

-- E para habilitá-lo novamente:

mysql> alter event processa_comissao_event enable;