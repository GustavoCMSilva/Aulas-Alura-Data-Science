use sucos_vendas;

/* 
Crie uma Stored Procedure que, baseado em uma data, contamos o número de notas fiscais. 
Se houverem mais que 70 notas exibimos a mensagem: ‘Muita nota’. Ou então exibimos a mensagem ‘Pouca nota’. 
Também exibir o número de notas. Chame esta Stored Procedure de Testa_Numero_Notas.

CREATE PROCEDURE `Testa_Numero_Notas` (DATANOTA date)
BEGIN
    DECLARE NUMNOTAS INT;
    SELECT COUNT(*) INTO NUMNOTAS FROM NOTAS_FISCAIS WHERE DATA_VENDA = DATANOTA;
    IF NUMNOTAS > 70 THEN
        SELECT 'Muita Nota', NUMNOTAS;
    ELSE
        SELECT 'Pouca Nota', NUMNOTAS;
    END IF;
END
*/


/* 
comando IF THEN, ELSEIF e ELSE
CREATE PROCEDURE `acha_preco`()
BEGIN
	declare vPreco float;
    declare vMensagem varchar(30);
    select preco_de_lista into vPreco from tabela_de_produtos
    where codigo_do_produto = vProduto;
    if vPreco >= 12 then
		set vMensagem = 'produto caro';
    elseif vPreco >= 7 and vPreco <12 then
		set vMensagem = 'Produto no preço';
	else
		set vMensagem = 'Produto barato';
	end if;
    select vMensagem;
END
*/
select * from tabela_de_produtos;
call acha_preco ('1000889');

/*
Construa uma Stored Procedure chamada Comparativo_Vendas que compara as vendas em 
duas datas (Estas duas datas serão parâmetros da SP). Se a variação percentual destas vendas for maior 
que 10% a resposta deve ser ‘Verde’. Se for entre -10% e 10% deve retornar ‘Amarela1. Se o retorno form 
menor que -10% deve retornar ‘Vermelho’.

CREATE PROCEDURE `Comparativo_Vendas`(DataInicial DATE, DataFinal DATE)
BEGIN
DECLARE FaturamentoInicial FLOAT;
DECLARE FaturamentoFinal FLOAT;
DECLARE Variacao float;
SELECT SUM(B.QUANTIDADE * B.PRECO) INTO FaturamentoInicial FROM 
NOTAS_FISCAIS A INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE A.DATA_VENDA = DataInicial;
SELECT SUM(B.QUANTIDADE * B.PRECO) INTO FaturamentoFinal FROM 
NOTAS_FISCAIS A INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE A.DATA_VENDA = DataFinal ;
SET Variacao = ((FaturamentoFinal / FaturamentoInicial) -1) * 100;
IF Variacao > 10 THEN
SELECT 'Verde';
ELSEIF Variacao >= -10 AND Variacao <= 10 THEN
SELECT 'Amarelo';
ELSE
SELECT 'Vermelho';
END IF;   

END
*/

/*comando CASE*/

/* Classificar sabores com sua acidez

CREATE PROCEDURE `sabor_achar`(vProduto varchar (20))
BEGIN
declare vSabor varchar (20);

select sabor into vSabor from tabela_de_produtos
where codigo_do_produto = vProduto;

case vSabor 

when 'Lima/Limão' then select 'Cítrico';
when 'Laranja' then select 'Cítrico';
when 'Morango/Limão' then select 'Cítrico';
when 'uva' then select 'neutro';
when 'morango' then select 'neutro';
    
else select 'ácidos';
end case;
END
*/
call sabor_achar ('1000889');

/*
Implemente a Stored Procedure do exercício do vídeo 2, agora usando CASE CONDICIONAL. 
Chame de Comparativo_Vendas_Case_Cond.

CREATE PROCEDURE `Comparativo_Vendas_Case_Cond`(DataInicial DATE, DataFinal DATE)
BEGIN
DECLARE FaturamentoInicial FLOAT;
DECLARE FaturamentoFinal FLOAT;
DECLARE Variacao float;
SELECT SUM(B.QUANTIDADE * B.PRECO) INTO FaturamentoInicial FROM 
NOTAS_FISCAIS A INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE A.DATA_VENDA = DataInicial;
SELECT SUM(B.QUANTIDADE * B.PRECO) INTO FaturamentoFinal FROM 
NOTAS_FISCAIS A INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE A.DATA_VENDA = DataFinal ;
SET Variacao = ((FaturamentoFinal / FaturamentoInicial) -1) * 100; 
CASE
WHEN Variacao > 10 THEN SELECT 'Verde';
WHEN Variacao > -10 AND Variacao < 10 THEN  SELECT 'Amarelo';
WHEN Variacao <= -10 THEN SELECT 'Vermelho';
END CASE;
END
*/

/* LOOPING */
#WHILE condiçao DO status END WHILE
create table tab_loop (id int);
/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `looping`(vInicial int, vFinal int)
BEGIN
	declare vConta int;
    delete from tab_loop;
    set vConta = vInicial;
    while vConta <= vFinal
	do
		insert into tab_loop (id) values (vConta);
        set vConta = vConta + 1;
	end while;
    select * from tab_loop;
END
*/
call looping (1,10); #Incrementador + 1 até x


/*Sabendo que a função abaixo soma de 1 dia uma data:
SELECT ADDDATE(DATA_VENDA, INTERVAL 1 DAY);
Faça uma Stored Procedure que,a partir do dia 01/01/2017, iremos contar o número de notas fiscais 
até o dia 10/01/2017. Devemos imprimir a data e o número de notas fiscais dia a dia. 
Chame esta Stored Procedure de Soma_Dias_Notas.
Declare variáveis do tipo DATE: Data inicial e final; Faça um loop testando se 
Data inicial < Data final; Imprima na saída do MYSQL a data e o número de notas. 
Não esquecer de converter as variáveis para VARCHAR; Some a data em 1 dia.

CREATE PROCEDURE `Soma_Dias_Notas`()
BEGIN
DECLARE DATAINICIAL DATE;
DECLARE DATAFINAL DATE;
DECLARE NUMNOTAS INT;
SET DATAINICIAL = '20170101';
SET DATAFINAL = '20170110';
WHILE DATAINICIAL <= DATAFINAL
DO
SELECT COUNT(*) INTO NUMNOTAS  FROM notas_fiscais WHERE DATA_VENDA = DATAINICIAL;
SELECT concat(DATE_FORMAT(DATAINICIAL, '%d/%m/%Y'), '-' , CAST(NUMNOTAS as CHAR(50)));
SELECT ADDDATE(DATAINICIAL, INTERVAL 1 DAY) INTO DATAINICIAL;
END WHILE;

END
*/