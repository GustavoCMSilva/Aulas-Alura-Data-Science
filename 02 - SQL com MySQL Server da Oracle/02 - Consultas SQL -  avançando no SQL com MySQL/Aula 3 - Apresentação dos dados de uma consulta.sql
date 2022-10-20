use sucos_vendas;

select * from tabela_de_produtos where SABOR like '%MAÇA%'; #comando para encontrar o que conter na seleçao

select * from tabela_de_produtos where SABOR like '%MAÇA%' and embalagem = 'pet'; #mixando CMD % com AND

select * from tabela_de_clientes where nome like '%Mattos'; #pesquisa que no final contenham Mattos

select distinct embalagem, tamanho from tabela_de_produtos; #vai desconsiderar os duplicados

select distinct embalagem, tamanho, sabor from tabela_de_produtos where sabor = 'laranja';
#tudo que contenha o sabor laranja, mas nao os duplicados.

SELECT DISTINCT BAIRRO FROM tabela_de_clientes WHERE CIDADE = 'Rio de Janeiro';
#bairros da cidade do RJ que possuem clintes.

select * from tabela_de_clientes limit 2; #cmd LIMIT vem sempre ao fim da linha

select * from tabela_de_produtos limit 2,3;
#a partir da segunda linha, mostre a segunda linha e as duas proximas (total de 3 linha)

SELECT * FROM notas_fiscais  WHERE DATA_VENDA = '2017-01-01' limit 10;
#obter as 10 primeiras vendas do dia 01/01/2017.

select nome from tabela_de_clientes order by nome; #sequenciando visualmente somente a coluna nome

select * from tabela_de_clientes order by nome; #sequenciando visualmente toda tabela pela coluna nome

select nome from tabela_de_clientes order by nome desc; #sequenciado por ordem descendente (contrario)

select * from tabela_de_clientes order by cidade, nome; #sequencia composta, pela ordem solicitada
#filtrar cidades por ordem crescente e nomes por ordem em cada cidade

select * from tabela_de_clientes order by cidade desc, nome asc;
#cidade do menor para o maior e nome por ordem crescente

SELECT * FROM itens_notas_fiscais WHERE codigo_do_produto = '1101035' ORDER BY QUANTIDADE DESC;

select estado, sum(limite_de_credito) as limite_total from tabela_de_clientes group by estado;
#vai mostrar o limite de credito separado por estado
#cmd groupby para agrupar os duplicados na coluna

select embalagem, max(preco_de_lista) from tabela_de_produtos group by embalagem;
#Maior preço separado e agrupado por emblalagem

SELECT estado, BAIRRO, SUM(LIMITE_DE_CREDITO) as LIMITE FROM tabela_de_clientes 
where CIDADE = 'Rio de Janeiro' GROUP BY BAIRRO;
#Mostrando o limite de credito de cada bairro da cidade do RJ

select estado, sum(limite_de_credito) as 'soma de limite' from tabela_de_clientes
group by estado having sum(limite_de_credito);
#Da tabela de clientes soma o limite de credito dos estados
#o HAVING seria como uma condiçao where, porem utilizado apos o GROUP BY

select estado, sum(limite_de_credito) as limie_credito from tabela_de_clientes
group by estado having sum(limite_de_credito) > 900000;
#adicionando condiçoes

select embalagem, max(preco_de_lista) as maior_preço, 
min(preco_de_lista) as 'menor preço'
from tabela_de_produtos
group by embalagem having sum(preco_de_lista);
#retorna o maior e o menor preço de cada embalagem

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) as MAIOR_PRECO, 
MIN(PRECO_DE_LISTA) as MENOR_PRECO FROM tabela_de_produtos 
GROUP BY EMBALAGEM
HAVING SUM(PRECO_DE_LISTA) <= 80 AND MAX(PRECO_DE_LISTA) >= 5;
#retornando maior e menor preço de embalagem que estejam entre 5 e 80

  SELECT CPF, COUNT(*) FROM notas_fiscais
  WHERE YEAR(DATA_VENDA) = 2016
  GROUP BY CPF
  HAVING COUNT(*) > 2000;
  #clientes que fizeram mais de 2000 compras em 2016
  
select embalagem,
case
	when preco_de_lista >= 12 then 'produto caro'
	when preco_de_lista >= 7 and preco_de_lista < 12 then 'Preço justo'
	else 'produto barato'
end as status_preco, avg(preco_de_lista) as 'preço medio'
from tabela_de_produtos
group by embalagem,
case
	when preco_de_lista >= 12 then 'produto caro'
	when preco_de_lista >= 7 and preco_de_lista < 12 then 'Preço justo'
	else 'produto barato'
end
order by embalagem;
#define se é barato ou caro e tambem o preço medio de cada embalagem
#ordenadas pela embalagem


SELECT NOME,
CASE 
	WHEN YEAR(data_de_nascimento) < 1990 THEN 'Velho'
	WHEN YEAR(data_de_nascimento) >= 1990 AND YEAR(data_de_nascimento) <= 1995 THEN 'Jovem' 
	ELSE 'Crianças' 
END  AS "CLASSIFICAÇÃO POR IDADE"
FROM tabela_de_clientes;
#ano de nascimento dos clientes e classifique-os como: Nascidos antes de 1990 são velhos, 
# nascidos entre 1990 e 1995 são jovens e nascidos depois de 1995 são crianças.