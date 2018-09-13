SET Serveroutput On
DECLARE
 
EXP_SEM_DADOS EXCEPTION;
-- Declara√ß√£o de cursores
CURSOR cs_func(pMenor NUMBER, pMaior NUMBER) is
SELECT a.EMPLOYEE_ID,a.FIRST_NAME,a.SALARY
FROM HR.EMPLOYEES a
WHERE a.SALARY BETWEEN pMenor AND pMaior order by a.SALARY desc ;
 
BEGIN
    --Verificando se o cursor existe , caso nao aplicar execption
    IF cs_func%isopen THEN
        -- Abre cursor para Funcionarios com Salario entre 1000 e 9999
        dbms_output.put_line('Funcionarios com mÈdia entre 1000 e 9999');
        FOR rFunc in cs_func(1,999) LOOP
        dbms_output.put_line('Teste'||rFunc.EMPLOYEE_ID);
         
        /* Imprime na tela os Funcionarios com Salario no intervalo de 1000 e 9999
        */
        dbms_output.put_line(rFunc.EMPLOYEE_ID||' - '||rFunc.FIRST_NAME||' - '||rFunc.SALARY);
         
        END LOOP;
     
        -- Abre cursor para Funcionarios com Salario entre 10000 e 19000
        dbms_output.put_line('Funcionarios com m√©dia entre 10000 e 19000');
        FOR rFunc in cs_func(25000,30000) LOOP
        /* Imprime na tela os Funcionarios com Salario entre 10000 e 19000
        Est√° no intervalo de 10000 e 19000
        */
        dbms_output.put_line(rFunc.EMPLOYEE_ID||' - '||rFunc.FIRST_NAME||' - '||rFunc.SALARY);
         
        END LOOP;
        --else do IF de validaÁ„o do cursor
    ELSE
        RAISE EXP_SEM_DADOS;
    END IF;
    --fim if
     
    EXCEPTION
        WHEN EXP_SEM_DADOS THEN 
             DBMS_OUTPUT.PUT_LINE('N√O TEM REGISTROS EXCEP');
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('N√O TEM REGISTROS');
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/