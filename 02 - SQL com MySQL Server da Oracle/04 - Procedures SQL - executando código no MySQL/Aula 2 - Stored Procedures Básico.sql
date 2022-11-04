use sucos_vendas;

#PROCEDURE
/*
create procedure `ola_mundo` ()
begin
 select 'Alo mundo';
end
*/
#chamando a procedure
call Alo_mundo;

#exercicio
/* 
PROCEDURE `Exerc01`()
BEGIN

DECLARE Cliente VARCHAR(10);
DECLARE Idade INT;
DECLARE DataNascimento DATE;
DECLARE Custo FLOAT;

SET Cliente = 'João';
SET Idade = 10;
SET DataNascimento = '20170110';
SET Custo = 10.23;

SELECT Cliente;
SELECT Idade;
SELECT DataNascimento;
SELECT Custo;

END
*/
call exerc01;