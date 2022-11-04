/* Gravar variavel em um vetor para percorrer mais resultados */

/*
CREATE PROCEDURE `cursor1`()
BEGIN
	declare vnome varchar(50);
    declare c cursor for select nome from tabela_de_clientes limit 4;
   
   open c;
  		fetch c into vnome;
		select vnome;
    	fetch c into vnome;
		select vnome;
   		fetch c into vnome;
		select vnome;
   		fetch c into vnome;
		select vnome;
    close c;
END
*/
call cursor1; #vai mostrar 4 resultados, pois é o tamanho do limit

/* Looping CURSOR */
/*
#vai fazer a mesma coisa que o de cima.
CREATE PROCEDURE `cursor_loop`()
BEGIN
	declare fim_cursor int default 0;
    declare vnome varchar(50);
    declare c cursor for select nome from tabela_de_clientes limit 4;
	declare continue handler for not found set fim_cursor = 1; #definindo para continuar mesmo com erro
    
    open c;
	while fim_cursor = 0
	do
  		fetch c into vnome;
        if fim_cursor = 0 then
		select vnome;
        end if;
	end while;
	close c;
END
*/
call cursor_loop; #vai mostrar 4 resultados, pois é o tamanho do LIMIT

/*
Crie uma Stored Procedure usando um cursor para achar o valor total de todos os créditos de todos os clientes.
Chame esta SP de Limite_Creditos.
Declare duas variáveis: Uma que recebe o limite de crédito do cursor e outra o limite de crédito total; 
Faça um loop no cursor e vá somando na variável limite de crédito total o valor do limite de cada cliente; 
Exiba o valor total do limite.

CREATE PROCEDURE `Limite_creditos`()
BEGIN
DECLARE LIMITECREDITO FLOAT;
DECLARE LIMITECREDITOACUM FLOAT;
DECLARE fim_do_cursor INT;
DECLARE c CURSOR FOR SELECT LIMITE_DE_CREDITO FROM Tabela_de_Clientes;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_do_cursor = 1;
SET fim_do_cursor = 0;
SET LIMITECREDITOACUM = 0;
SET LIMITECREDITO = 0;
OPEN c;
WHILE fim_do_cursor = 0
DO
FETCH c INTO LIMITECREDITO;
    IF fim_do_cursor = 0 THEN
        SET LIMITECREDITOACUM = LIMITECREDITOACUM + LIMITECREDITO;
    END IF;
END WHILE;
SELECT LIMITECREDITOACUM;
CLOSE c;
END
*/
call Limite_creditos;

/*
CREATE PROCEDURE `cursor_colunas`()
BEGIN
	declare fim_cursor int default 0;
    declare vcidade, vestado, vcep varchar(50);
    declare vnome, vendereco varchar (150);
    
    declare c cursor for select 
    nome, endereco_1, cidade, estado, cep from tabela_de_clientes limit 4;
	declare continue handler for not found set fim_cursor = 1; #definindo para continuar mesmo com erro
    
    open c;
	while fim_cursor = 0
	do
  		fetch c into vnome, vendereco, vcidade, vestado, vcep;
        if fim_cursor = 0 then
		select concat(vnome, 'End: ', vendereco, ' - ',  vcidade, '/', vestado, '(',vcep,')');
        end if;
	end while;
	close c;
END
*/
call cursor_colunas;

/*Crie uma Stored Procedure usando um cursor para achar o valor total do faturamento para um mês e um ano.
Declare três variáveis: Uma que recebe a quantidade, outra o preço e uma terceira que irá acumular o 
faturamento; Faça um loop no cursor e vá somando o faturamento de cada nota; Exiba o valor total do limite; 
Lembrando a consulta que obter o faturamento dentro de um mês e ano.

CREATE PROCEDURE `mais_um_campo`()
BEGIN
DECLARE QUANTIDADE INT;
DECLARE PRECO FLOAT;
DECLARE FATURAMENTOACUM FLOAT;
DECLARE fim_do_cursor INT;
DECLARE c CURSOR FOR
SELECT INF.QUANTIDADE, INF.PRECO FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN NOTAS_FISCAIS  NF ON NF.NUMERO = INF.NUMERO
WHERE MONTH(NF.DATA_VENDA) = 1 AND YEAR(NF.DATA_VENDA) = 2017;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_do_cursor = 1;
OPEN c;
SET fim_do_cursor = 0;
SET FATURAMENTOACUM = 0;
WHILE fim_do_cursor = 0
DO
FETCH c INTO QUANTIDADE, PRECO;
IF fim_do_cursor = 0 THEN
SET FATURAMENTOACUM = FATURAMENTOACUM + (QUANTIDADE * PRECO);
END IF;
END WHILE;
CLOSE c;
SELECT FATURAMENTOACUM;
END
*/
call mais_um_campo;

/* CRIANDO FUNÇÕES */
#Rodar o comando
SET GLOBAL LOG_BIN_TRUST_FUNCTION_CREATORS = 1
#para nao dar erro

/*
CREATE FUNCTION `f_acha_tipo_sabor`(vSabor VARCHAR(50)) 
RETURNS varchar(20)
BEGIN
  DECLARE vRetorno VARCHAR(20) default "";
  CASE vSabor
  WHEN 'Lima/Limão' THEN SET vRetorno = 'Cítrico';
  WHEN 'Laranja' THEN SET vRetorno = 'Cítrico';
  WHEN 'Morango/Limão' THEN SET vRetorno = 'Cítrico';
  WHEN 'Uva' THEN SET vRetorno = 'Neutro';
  WHEN 'Morango' THEN SET vRetorno = 'Neutro';
  ELSE SET vRetorno = 'Ácidos';
  END CASE;
  RETURN vRetorno;
END
*/
#pesquisa com a funçao criada
SELECT f_acha_tipo_sabor ("Laranja"); #informa o tipo pesquisado
# OU
SELECT NOME_DO_PRODUTO, SABOR, f_acha_tipo_sabor (SABOR) as TIPO
FROM tabela_de_produtos; #retorna todos os sabores com seus tipos
#ou
SELECT NOME_DO_PRODUTO, SABOR FROM tabela_de_produtos
where f_acha_tipo_sabor (SABOR) = 'Citríco'; #retorna somente os que forem do tipo pesquisado.


/*
Transforme esta SP em uma função onde passamos como parâmetro da data e retornamos o número de notas. 
Chame esta função de NumeroNotas. Após a criação da função teste seu uso com um SELECT.

CREATE FUNCTION `numero_notas` (DATA DATE)
RETURNS INTEGER
BEGIN
DECLARE NUMNOTAS INT;
SELECT COUNT(*) INTO NUMNOTAS FROM notas_fiscais WHERE DATA_VENDA = DATA;
RETURN NUMNOTAS;
END
*/
select numero_notas ('2000-06-21');