/* GERENTE PEDIU RELATORIO, DENTRO DE TODAS AS VENDAS, QUAIS SÃO VALIDAS E QUAIS NÃO SÃO */

select * from itens_notas_fiscais;
#quantidade de itens de NF

select * from notas_fiscais;
#nesta tabela tem clientes no campo CPF

#juntando o campo comum INNER JOIN
select * from notas_fiscais nf
inner join itens_notas_fiscais inf
on nf.numero = inf.numero;
#vai mostrar cada compra de cada cpf, a quantidade, data...

select nf.cpf, nf.data_venda, inf.quantidade from notas_fiscais nf
inner join itens_notas_fiscais inf
on nf.numero = inf.numero;
#filtrando a tabela por cpf, data e quantia

select nf.cpf, nf.data_venda, sum(inf.quantidade) from notas_fiscais nf
inner join itens_notas_fiscais inf
on nf.numero = inf.numero
group by cpf;
#somando as quantidade e separando por cpf

select 
nf.cpf, #seleciona o campo cpf da tabela notas_fiscais 
date_format(nf.data_venda, '%m - %Y') as mes_ano, #modifica para mostrar como ANO e mes
sum(inf.quantidade) as 'quantia_vendas (Litros)' #soma todas as vendas 
from notas_fiscais nf #a partir do banco notas_fiscais e nomeada como nf
inner join itens_notas_fiscais inf #junta com a tabela itens_notas_fiscais chamada de inf
on nf.numero = inf.numero #onde serão relacionadas pelas colunas numero.
group by nf.cpf, date_format(nf.data_venda, '%y - %m') #agrupa por cpf e pela data
order by nf.cpf; #alinha por cpf
#vai mostrar todas as vendas de cada dia para cada cpf

#limite de compra por cpf
select tc.cpf, tc.nome, tc.volume_de_compra as quant_limite
from tabela_de_clientes tc;

#comparar as 2 tabelas acima (tabela de consulta de vendas por cpf com a tabela de limite de compra)
select 
nf.cpf, #seleciona o campo cpf da tabela notas_fiscais 
tc.nome,
date_format(nf.data_venda, '%m - %Y') as mes_ano, #modifica para mostrar como ANO e mes
sum(inf.quantidade) as 'quantia_vendas (Litros)', #soma todas as vendas 
tc.volume_de_compra as quant_limite #ADICIONA A COLUNA DE LIMITE
from notas_fiscais nf #a partir do banco notas_fiscais e nomeada como nf
inner join itens_notas_fiscais inf #junta com a tabela itens_notas_fiscais chamada de inf
on nf.numero = inf.numero #onde serão relacionadas pelas colunas numero.
inner join tabela_de_clientes tc #JUNTA COM A TABELA DE CLIENTES CHAMADA DE TC
on tc.cpf = nf.cpf #JUNTANDO PELO CAMPO EM COMUM - CPF
group by nf.cpf, date_format(nf.data_venda, '%y - %m'), tc.nome #agrupa por cpf e pela data e nome
order by nf.cpf; #alinha por cpf
#combinado as tabelas e visualisado as compras por mes de cada cpf

#utilizando subquery
select x.cpf, x.nome, x.mes_ano, x.quantia_vendas, x.quant_limite,
# retirado esta coluna pq nao precisa aparecer, pois embaixo já defini --> #x.quant_limite - x.quantia_vendas as diferença, #diferença entre o limite de compra e o adquirido
case when (x.quant_limite - x.quantia_vendas) < 0 then 'Invalida' else 'Valida' end as status_venda
#comando acima, Logica para analisar a coluna diferença e ver a validade da compra
from
#este select acima são as colunas geradas pela consulta abaixo, que é o codigo feito anteriormente.
(select 
nf.cpf,
tc.nome,
date_format(nf.data_venda, '%m - %Y') as mes_ano,
sum(inf.quantidade) as quantia_vendas, 
tc.volume_de_compra as quant_limite 
from notas_fiscais nf 
inner join itens_notas_fiscais inf 
on nf.numero = inf.numero 
inner join tabela_de_clientes tc 
on tc.cpf = nf.cpf 
group by nf.cpf, date_format(nf.data_venda, '%y - %m'), tc.nome 
order by nf.cpf) 
x; #definido o codigo acima sendo nomeado como X

/* EXERCICIO - Complemente este relatório listando somente os que tiveram vendas inválidas e calculando
 a diferença entre o limite de venda máximo e o realizado, em percentuais. */
select x.cpf, x.nome, x.mes_ano, x.quantia_vendas, x.quant_limite,
case when (x.quant_limite - x.quantia_vendas) < 0 then 'Invalida' else 'Valida' end as status_venda,
round(1 - (X.QUANT_LIMITE/X.QUANTIA_VENDAS) * 100, 2) AS PERCENTUAL #COLUNA PARA PERCENTUAL DA DIFERENÇA
from
(select nf.cpf, tc.nome, date_format(nf.data_venda, '%m - %Y') as mes_ano, 
sum(inf.quantidade) as quantia_vendas, 
tc.volume_de_compra as quant_limite from notas_fiscais nf 
inner join itens_notas_fiscais inf on nf.numero = inf.numero 
inner join tabela_de_clientes tc on tc.cpf = nf.cpf 
group by nf.cpf, date_format(nf.data_venda, '%y - %m'), tc.nome order by nf.cpf) x
WHERE (x.quant_limite - x.quantia_vendas) < 0 ; #VAI MOSTRAR SOMENTE O QUE FOR <0 DA COLUNA DIFERENÇA.


/* ACOMPANHAMENTO DAS VENDAS NO ANO 2016 DOS SABORES VENDIDOS */

#Quantidade esta na tabela itens_notas_fiscais
#Sabor esta na tabela_de_produos
#Ano esta na tabela notas_fiscais

#A coluna codigo_do_produto são comuns em itens_notas_fiscais E tabela_de_produos

select * from
#mesclando as tabelas que tem codigo_do_produto em comum e definindo um nome
tabela_de_produtos tp inner join itens_notas_fiscais inf on tp.codigo_do_produto = inf.codigo_do_produto
#agora é preciso mesclar a tabela itens_notas_fiscais COM notas_fiscais por causa da data
inner join  notas_fiscais nf on nf.numero = inf.numero;

#este código é o de cima, porem agora selecionaremos as colunas que desejo visualizar
select tp.sabor, nf.data_venda, inf.quantidade from
#mesclando as tabelas que tem codigo_do_produto em comum e definindo um nome
tabela_de_produtos tp inner join itens_notas_fiscais inf on tp.codigo_do_produto = inf.codigo_do_produto
#agora é preciso mesclar a tabela itens_notas_fiscais COM notas_fiscais por causa da data
inner join  notas_fiscais nf on nf.numero = inf.numero;

#este código é o de cima, porem agora selecionaremos as colunas que desejo visualizar
select tp.sabor, year(nf.data_venda) as ano, sum(inf.quantidade) as quantidade from
#mesclando as tabelas que tem codigo_do_produto em comum e definindo um nome
tabela_de_produtos tp inner join itens_notas_fiscais inf on tp.codigo_do_produto = inf.codigo_do_produto
#agora é preciso mesclar a tabela itens_notas_fiscais COM notas_fiscais por causa da data
inner join  notas_fiscais nf on nf.numero = inf.numero
where year(nf.data_venda) = 2016
group by tp.sabor, year(nf.data_venda)
order by quantidade desc;
#Retorna os sabores vendidos no ano de 2016 de acordo com a quantidade total

select year(nf.data_venda) as ano, sum(inf.quantidade) as quantidade from
#mesclando as tabelas que tem codigo_do_produto em comum e definindo um nome
tabela_de_produtos tp inner join itens_notas_fiscais inf on tp.codigo_do_produto = inf.codigo_do_produto
#agora é preciso mesclar a tabela itens_notas_fiscais COM notas_fiscais por causa da data
inner join  notas_fiscais nf on nf.numero = inf.numero
where year(nf.data_venda) = 2016
group by year(nf.data_venda)
order by quantidade desc;
# Retorna o total da quantidade vendida no ano de 2016

#Mesclando as duas ultimas consultas realizadas
#Acrescentado uma coluna onde será mostrado o percentual de vendas de cada sabor
select * from
	(select tp.sabor, year(nf.data_venda) as ano, sum(inf.quantidade) as quantidade from
	#mesclando as tabelas que tem codigo_do_produto em comum e definindo um nome
	tabela_de_produtos tp inner join itens_notas_fiscais inf on tp.codigo_do_produto = inf.codigo_do_produto
	#agora é preciso mesclar a tabela itens_notas_fiscais COM notas_fiscais por causa da data
	inner join  notas_fiscais nf on nf.numero = inf.numero
	where year(nf.data_venda) = 2016 #somente do ano 2016
	group by tp.sabor, year(nf.data_venda)) as vendas_sabor
inner join
	(select year(nf.data_venda) as ano, sum(inf.quantidade) as quantidade from
	#mesclando as tabelas que tem codigo_do_produto em comum e definindo um nome
	tabela_de_produtos tp inner join itens_notas_fiscais inf on tp.codigo_do_produto = inf.codigo_do_produto
	#agora é preciso mesclar a tabela itens_notas_fiscais COM notas_fiscais por causa da data
	inner join  notas_fiscais nf on nf.numero = inf.numero
	where year(nf.data_venda) = 2016 #somente do ano 2016
	group by year(nf.data_venda)) as venda_total
on vendas_sabor.ano = venda_total.ano; #pois a coluna ano são comuns entre elas    

#Mesclando as duas ultimas consultas realizadas
#Acrescentado uma coluna onde será mostrado o percentual de vendas de cada sabor
select vendas_sabor.sabor, vendas_sabor.ano, 
vendas_sabor.quantidade,
round((vendas_sabor.quantidade / venda_total.quantidade) * 100, 2) as percentual #arredondar em 2 casas (round)
from
	(select tp.sabor, year(nf.data_venda) as ano, sum(inf.quantidade) as quantidade from
	#mesclando as tabelas que tem codigo_do_produto em comum e definindo um nome
	tabela_de_produtos tp inner join itens_notas_fiscais inf on tp.codigo_do_produto = inf.codigo_do_produto
	#agora é preciso mesclar a tabela itens_notas_fiscais COM notas_fiscais por causa da data
	inner join  notas_fiscais nf on nf.numero = inf.numero
	where year(nf.data_venda) = 2016 #somente do ano 2016
	group by tp.sabor, year(nf.data_venda)) as vendas_sabor
inner join
	(select year(nf.data_venda) as ano, sum(inf.quantidade) as quantidade from
	#mesclando as tabelas que tem codigo_do_produto em comum e definindo um nome
	tabela_de_produtos tp inner join itens_notas_fiscais inf on tp.codigo_do_produto = inf.codigo_do_produto
	#agora é preciso mesclar a tabela itens_notas_fiscais COM notas_fiscais por causa da data
	inner join  notas_fiscais nf on nf.numero = inf.numero
	where year(nf.data_venda) = 2016 #somente do ano 2016
	group by year(nf.data_venda)) as venda_total
on vendas_sabor.ano = venda_total.ano #pois a coluna ano são comuns entre elas    
order by vendas_sabor.quantidade desc;


/* EXERCICIO - Modifique o relatório mas agora para ver o ranking das vendas por tamanho. */
SELECT VENDA_TAMANHO.TAMANHO, VENDA_TAMANHO.ANO, VENDA_TAMANHO.QUANTIDADE,
ROUND((VENDA_TAMANHO.QUANTIDADE/VENDA_TOTAL.QUANTIDADE) * 100, 2) AS PARTICIPACAO FROM 
(SELECT TP.TAMANHO, YEAR(NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE FROM 
TABELA_DE_PRODUTOS TP 
INNER JOIN ITENS_NOTAS_FISCAIS INF ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY TP.TAMANHO, YEAR(NF.DATA_VENDA)) AS VENDA_TAMANHO
INNER JOIN 
(SELECT YEAR(NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE FROM 
TABELA_DE_PRODUTOS TP 
INNER JOIN ITENS_NOTAS_FISCAIS INF ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY YEAR(NF.DATA_VENDA)) AS VENDA_TOTAL
ON VENDA_TAMANHO.ANO = VENDA_TOTAL.ANO
ORDER BY VENDA_TAMANHO.QUANTIDADE DESC