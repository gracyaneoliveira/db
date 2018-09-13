 -- TRIGGER PARA SEQUENCIAS 
  -- PARA TABELA EMPRESA
    
CREATE OR REPLACE TRIGGER TRG_EMPRESA1 
    BEFORE INSERT ON EMPRESA 
    FOR EACH ROW  
        BEGIN 
        IF :NEW.COD_EMPRESA IS NULL THEN 
            SELECT SEQ_EMP.NEXTVAL INTO :NEW.COD_EMPRESA FROM DUAL; 
        END IF; 
    END; 


 -- PARA TABELA APONTAMENTO
    
CREATE OR REPLACE TRIGGER TRG_APONT 
    BEFORE INSERT ON APONTAMENTOS
    FOR EACH ROW  
        BEGIN 
        IF :NEW.ID_APON IS NULL THEN 
            SELECT SEQ_APON.NEXTVAL INTO :NEW.ID_APON FROM DUAL; 
        END IF; 
    END; 


 -- PARA TABELA CONTAS A PAGAR
    
CREATE OR REPLACE TRIGGER TRG_CAP 
    BEFORE INSERT ON CONTAS_PAGAR
    FOR EACH ROW  
        BEGIN 
        IF :NEW.ID_DOC IS NULL THEN 
            SELECT SEQ_CAP.NEXTVAL INTO :NEW.ID_DOC FROM DUAL; 
        END IF; 
    END; 



-- PARA TABELA CLIENTES
--SEQ_CLI        CAMPO ID_CLIENTE    
CREATE OR REPLACE TRIGGER TRG_CLIENTE 
    BEFORE INSERT ON CLIENTES
    FOR EACH ROW  
        BEGIN 
        IF :NEW.ID_CLIENTE IS NULL THEN 
            SELECT SEQ_CLI.NEXTVAL INTO :NEW.ID_CLIENTE FROM DUAL; 
        END IF; 
    END; 



-- PARA TABELA CONTAS RECEBER
--SEQ_CRE        CAMPO ID_DOC  
CREATE OR REPLACE TRIGGER TRG_CRE 
    BEFORE INSERT ON CONTAS_RECEBER
    FOR EACH ROW  
        BEGIN 
        IF :NEW.ID_DOC IS NULL THEN 
            SELECT SEQ_CRE.NEXTVAL INTO :NEW.ID_DOC FROM DUAL; 
        END IF; 
    END; 

--SEQUENCIA PARA TABELAS FORNECEDOR
--SEQ_FOR        CAMPO ID_FOR
CREATE OR REPLACE TRIGGER TRG_FOR 
    BEFORE INSERT ON FORNECEDORES
    FOR EACH ROW  
        BEGIN 
        IF :NEW.ID_FOR IS NULL THEN 
            SELECT SEQ_FOR.NEXTVAL INTO :NEW.ID_FOR FROM DUAL; 
        END IF; 
    END; 

--SEQUENCIA PARA TABELA GERENTES
--SEQ_GERENTES   CAMPO ID_GER
CREATE OR REPLACE TRIGGER TRG_GER 
    BEFORE INSERT ON GERENTES
    FOR EACH ROW  
        BEGIN 
        IF :NEW.ID_GER IS NULL THEN 
            SELECT SEQ_GERENTES.NEXTVAL INTO :NEW.ID_GER FROM DUAL; 
        END IF; 
    END; 

-- SEQUENCIA PARA TABELA ESTOQUE MOV
--SEQ_MOVEST     CAMPO ID_MOV
CREATE OR REPLACE TRIGGER TRG_MOVEST 
    BEFORE INSERT ON ESTOQUE_MOV
    FOR EACH ROW  
        BEGIN 
        IF :NEW.ID_MOV IS NULL THEN 
            SELECT SEQ_MOVEST.NEXTVAL INTO :NEW.ID_MOV FROM DUAL; 
        END IF; 
    END; 

--SEQUENCIA PARA ORDEM DE PRODUCAO
--SEQ_OP         CAMPO ID_ORDEM
CREATE OR REPLACE TRIGGER TRG_OP 
    BEFORE INSERT ON ORDEM_PROD
    FOR EACH ROW  
        BEGIN 
        IF :NEW.ID_ORDEM IS NULL THEN 
            SELECT SEQ_OP.NEXTVAL INTO :NEW.ID_ORDEM FROM DUAL; 
        END IF; 
    END; 

--SEQUENCIA PARA CONDI��O DE PAGAMENTO
--SEQ_PAGTO      CAMPO COD_PAGTO
CREATE OR REPLACE TRIGGER TRG_COD_PAGTO 
    BEFORE INSERT ON COND_PAGTO
    FOR EACH ROW  
        BEGIN 
        IF :NEW.COD_PAGTO IS NULL THEN 
            SELECT SEQ_PAGTO.NEXTVAL INTO :NEW.COD_PAGTO FROM DUAL; 
        END IF; 
    END; 

--SEQUENCIA PARA TIPO DE MATERIAL
--SEQ_TIP_MAT    CAMPO COD_TIP_MAT
CREATE OR REPLACE TRIGGER TRG_COD_TIP_MAT 
    BEFORE INSERT ON TIPO_MAT
    FOR EACH ROW  
        BEGIN 
        IF :NEW.COD_TIP_MAT IS NULL THEN 
            SELECT SEQ_TIP_MAT.NEXTVAL INTO :NEW.COD_TIP_MAT FROM DUAL; 
        END IF; 
    END; 

--SEQ_VENDEDORES CAMPO ID_VEND
CREATE OR REPLACE TRIGGER TRG_VENDEDOR 
    BEFORE INSERT ON VENDEDORES
    FOR EACH ROW  
        BEGIN 
        IF :NEW.ID_VEND IS NULL THEN 
            SELECT SEQ_VENDEDORES.NEXTVAL INTO :NEW.ID_VEND FROM DUAL; 
        END IF; 
    END; 


-- CRIAR TRIGGER PARA NUMERACAO DE NFE
    
CREATE OR REPLACE TRIGGER TRG_NUM_NFE 
    BEFORE INSERT ON NOTA_FISCAL 
    FOR EACH ROW 
     BEGIN 
         UPDATE PARAM_NFE SET NUM_NFE=NUM_NFE+1 WHERE COD_EMPRESA=:NEW.COD_EMPRESA;
         SELECT NUM_NFE INTO :NEW.NUM_NF  FROM PARAM_NFE WHERE COD_EMPRESA=:NEW.COD_EMPRESA; 
    END; 

-- CRIAR TRIGGER PARA PARAMETROS PEDIDO DE COMPRAS

CREATE OR REPLACE TRIGGER TRG_NUM_PED_COMPRAS 
    BEFORE INSERT ON PED_COMPRAS 
    FOR EACH ROW 
     BEGIN 
         UPDATE PARAM_PED_COMPRAS SET NUM_PED=NUM_PED+1 WHERE COD_EMPRESA=:NEW.COD_EMPRESA;
         SELECT NUM_PED INTO :NEW.NUM_PEDIDO  FROM PARAM_PED_COMPRAS WHERE COD_EMPRESA=:NEW.COD_EMPRESA; 
    END; 
    
-- CRIAR TRIGGER PARA PARAMETROS PEDIDO DE VENDAS
--DROP TRIGGER TRG_NUM_PED_VENDAS
CREATE OR REPLACE TRIGGER TRG_NUM_PED_VENDAS 
    BEFORE INSERT ON PED_VENDAS 
    FOR EACH ROW 
     BEGIN 
         UPDATE PARAM_PED_VENDAS SET NUM_PED=NUM_PED+1 WHERE COD_EMPRESA=:NEW.COD_EMPRESA;
         SELECT NUM_PED INTO :NEW.NUM_PEDIDO  FROM PARAM_PED_VENDAS WHERE COD_EMPRESA=:NEW.COD_EMPRESA; 
    END; 

-- CRIAR TRIGGER PARA PARAMETROS MATRICULA FUNCIONARIOS
CREATE OR REPLACE TRIGGER TRG_MAT_FUNC 
    BEFORE INSERT ON FUNCIONARIO
    FOR EACH ROW 
     BEGIN 
         UPDATE PARAM_MATRICULA SET MATRICULA=MATRICULA+1 WHERE COD_EMPRESA=:NEW.COD_EMPRESA;
         SELECT MATRICULA INTO :NEW.MATRICULA  FROM PARAM_MATRICULA WHERE COD_EMPRESA=:NEW.COD_EMPRESA; 
    END; 