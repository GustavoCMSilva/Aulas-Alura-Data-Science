SELECT LTRIM("     SQL Tutorial") AS LeftTrimmedString;
#remove espaço em branco

SELECT RTRIM("SQL Tutorial     ") AS RightTrimmedString;
#remove espaço em branco

SELECT TRIM('    SQL Tutorial    ') AS TrimmedString;
#remove espaço em branco

select upper('ola tudo bem') as resultado;
#converter em maiusculo

select lower('OLA TUDO BEM') as resultado;
#converte para minusculo
 
select substring('ola tudo bem', 6) as resultado;
#a partir da 6 string

SELECT SUBSTRING('OLÁ, TUDO BEM?', 6, 4) AS RESULTADO;
#6 a partir da letra O e 4 a partir da letra T

select CONCAT(nome, ' (', cpf, ') ') as resultado from tabela_de_clientes;
#concatenar strings

SELECT NOME, CONCAT(ENDERECO_1, ' - ', BAIRRO, ' - ', CIDADE, ' / ', ESTADO) AS COMPLETO
FROM tabela_de_clientes;
#listando o nome do cliente e o endereço completo

#manipulaçao de data
# ADDTIME - soma intervalo de data e tempo
SELECT ADDTIME("2017-06-15 09:34:21", "2");
# DATEDIFF - verifica o tempo entre as datas
SELECT DATEDIFF("2017-06-25", "2017-06-15");
# DATE_ADD - somando intervalo na data
SELECT ADDDATE("2017-06-15", INTERVAL 10 DAY);
# DAYNAME - retorna o dia da semana
SELECT DAYNAME("2017-06-15");
SELECT MONTHNAME("2017-06-15");
# CURDATE - data de hoje
SELECT CURDATE();
# CURRENT_TIME - hora atual
SELECT CURRENT_TIMESTAMP();

#variaçoes para datas
SELECT YEAR(CURRENT_TIMESTAMP());
SELECT MONTH(CURRENT_TIMESTAMP());
SELECT DAY(CURRENT_TIMESTAMP());
SELECT MONTHNAME(CURRENT_TIMESTAMP());
SELECT DATEDIFF(CURRENT_TIMESTAMP(), '2019-01-01') AS RESULTADO;
SELECT DATEDIFF(CURRENT_TIMESTAMP(), '1991-06-12') AS RESULTADO; #dias passados
SELECT CURRENT_TIMESTAMP() AS DIA_HOJE, DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 5 DAY) AS RESULTADO;

SELECT DISTINCT DATA_VENDA,
DAYNAME(DATA_VENDA) AS DIA, MONTHNAME(DATA_VENDA) AS MES, YEAR(DATA_VENDA) AS ANO FROM NOTAS_FISCAIS;

SELECT NOME, TIMESTAMPDIFF (YEAR, DATA_DE_NASCIMENTO, CURDATE()) AS    IDADE
FROM  tabela_de_clientes;
#consulta que mostre o nome e a idade atual dos clientes.

# FUNÇOES MATEMATICAS
#da para fazer, SEN, COS, TANG, SQRT, AVG, RADIANS, LOG, SUM,
#CEILING - Mostra o maior inteiro (arredonda para cima sempre)
#ROUND - arredonda correto
#FLOOR - arredonda o menor inteiro (arredonda para baixo)
#RAND - numeros aleatorios

 SELECT NUMERO, QUANTIDADE, PRECO, ROUND(QUANTIDADE * PRECO, 2) AS FATURAMENTO
 FROM ITENS_NOTAS_FISCAIS;
#utilizando round

SELECT YEAR(DATA_VENDA) as ano, FLOOR(SUM(IMPOSTO * (QUANTIDADE * PRECO))) as preco 
FROM notas_fiscais NF
INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY YEAR(DATA_VENDA);
#valor do imposto pago no ano de 2016 arredondando para o menor inteiro.

#https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_date-format
#site com comandos para formatar datas
SELECT CONCAT('O dia de hoje é: ', 
DATE_FORMAT(CURRENT_TIMESTAMP(),'%W, %d/%m/%Y - Semana %U') ) AS RESULTADO;

SELECT SUBSTRING(CONVERT(23.3, CHAR),1,1) AS RESULTADO;

select concat('O cliente ', tc.nome, ' faturou - ', cast(sum(inf.quantidade * inf.preco) as char (10)),
' no ano', cast(year(nf.data_venda) as char (5))) as sentenca 
from notas_fiscais nf
inner join itens_notas_fiscais as inf on nf.numero = inf.numero
inner join tabela_de_clientes tc on nf.cpf = tc.cpf
where year(data_venda) = 2016
group by tc.nome, year(data_venda);
/*SQL cujo resultado seja, para cada cliente: “O cliente João da Silva faturou 120000 no ano de 2016”.
Somente para o ano de 2016. */

