select * from tabela_de_vendedores;
select * from notas_fiscais;

select * from tabela_de_vendedores A
inner join notas_fiscais B
on A.matricula = B.matricula;
#integrando tabelas diferentes que possuam alguma paridade.

SELECT A.MATRICULA, A.NOME, COUNT(*) FROM
tabela_de_vendedores A
INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA
GROUP BY A.MATRICULA, A.NOME;

SELECT YEAR(DATA_VENDA), SUM(QUANTIDADE * PRECO) AS FATURAMENTO
FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF 
ON NF.NUMERO = INF.NUMERO
GROUP BY YEAR(DATA_VENDA);
#faturamento anual da empresa.

select count(*) from tabela_de_clientes;
#contagem do total de clientes

select cpf, count(*) from notas_fiscais group by cpf;
/* todos clientes que emitiram nota fiscal perceba que temos 15 clientes na tabela 
porem apenas 14 cosumiram algo. */

select distinct A.CPF, A.NOME, B.CPF from tabela_de_clientes A
left join notas_fiscais B on A.CPF = B.CPF
order by nome;
/* aqui será mostrado o cliente que nao consumiu mas foi cadastrado
left join compila a tabela da "direita' com a 'esquerda' e o que não contem na direita, retorna NULL */

select distinct A.CPF, A.NOME, B.CPF from tabela_de_clientes A
left join notas_fiscais B on A.CPF = B.CPF
where b.cpf is null
order by nome;
#vai mesclar as colunas solicitadas e vai retornar os nulos (nesse caso, quem tem cadastro mas nao gastou)

#ambas as tabelas possuem a coluna bairro
select * from tabela_de_vendedores;
select * from tabela_de_clientes;

select * from tabela_de_vendedores inner join tabela_de_clientes
on tabela_de_vendedores.bairro = tabela_de_clientes.bairro;
/* vai mostrar somente clientes que ficam nos mesmos bairros que os vendedores
existe 8 clientes que estao em bairros diferentes dos vendedores */

select tabela_de_vendedores.bairro, 
tabela_de_vendedores.nome as Vendedor,
tabela_de_vendedores.de_ferias,
tabela_de_clientes.bairro,
tabela_de_clientes.nome as Cliente from tabela_de_vendedores inner join tabela_de_clientes
on tabela_de_vendedores.bairro = tabela_de_clientes.bairro;
#vai mostrar somente clientes que ficam nos mesmos bairros que os vendedores

#mesmo comando mas com LEFT JOIN
select tabela_de_vendedores.bairro, 
tabela_de_vendedores.nome as Vendedor,
tabela_de_vendedores.de_ferias,
tabela_de_clientes.bairro,
tabela_de_clientes.nome as Cliente from tabela_de_vendedores left join tabela_de_clientes
on tabela_de_vendedores.bairro = tabela_de_clientes.bairro;
/* vai mostrar somente clientes que ficam nos mesmos bairros que os vendedores
a ROberta martins tem escritorio em copacabana, porem nao existe nenhum cliente em copacabana */

#mesmo comando mas com RIGHT JOIN
select tabela_de_vendedores.bairro, 
tabela_de_vendedores.nome as Vendedor,
tabela_de_vendedores.de_ferias,
tabela_de_clientes.bairro,
tabela_de_clientes.nome as Cliente from tabela_de_vendedores right join tabela_de_clientes
on tabela_de_vendedores.bairro = tabela_de_clientes.bairro
order by tabela_de_vendedores.bairro desc;
#Vai mostrar todos os clientes e concatenar com os vendedores

#mesmo comando mas com CROSS JOIN
select tabela_de_vendedores.bairro, 
tabela_de_vendedores.nome as Vendedor,
tabela_de_vendedores.de_ferias,
tabela_de_clientes.bairro,
tabela_de_clientes.nome as Cliente from tabela_de_vendedores, tabela_de_clientes #muda aqui
order by tabela_de_vendedores.bairro desc;
#Vai combinar as tabelas e mostrar todos os clientes de cada vendedor

#comando UNION
select distinct bairro from tabela_de_vendedores;
select distinct bairro from tabela_de_clientes;
#cada pesquisa aqui ira retornar todos os bairros de cada tabela

select distinct bairro from tabela_de_vendedores
union
select distinct bairro from tabela_de_clientes;
#aqui ira concatenar os bairros e ignorar os repetidos

select distinct bairro from tabela_de_vendedores
union all
select distinct bairro from tabela_de_clientes
order by bairro;
#aqui ira concatenar os bairros e mostrar inclusive os repetidos

select distinct bairro, nome from tabela_de_vendedores
union
select distinct bairro, nome from tabela_de_clientes
order by bairro;
#aqui ira concatenar os bairros e só vai mostrar ignorar os repetidos

SELECT DISTINCT BAIRRO, NOME, 'CLIENTE' as TIPO FROM tabela_de_clientes
UNION
SELECT DISTINCT BAIRRO, NOME, 'VENDEDOR' as TIPO FROM tabela_de_vendedores;
#concatena as tabelas, porem identifica quem é quem na nova coluna tipo

#FULL JOIN
SELECT tabela_de_vendedores.BAIRRO,
tabela_de_vendedores.NOME as VENDEDOR, DE_FERIAS,
tabela_de_clientes.BAIRRO,
tabela_de_clientes.NOME as CLIENTE  FROM tabela_de_vendedores LEFT JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO
UNION
SELECT tabela_de_vendedores.BAIRRO,
tabela_de_vendedores.NOME as VENDEDOR, DE_FERIAS,
tabela_de_clientes.BAIRRO,
tabela_de_clientes.NOME as CLIENTE  FROM tabela_de_vendedores RIGHT JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;
/* para utilizar o FULL JOIN, basta concatenar o LEFT com o RIGHT através do UNION
assim mostrara neste caso todos os vendedores com todos os clientes */

select * from tabela_de_clientes where bairro in ('Tijuca', 'Jardins', 'Copacabana');
#selecionando clintes por bairro, porem não é pratico pois os dados podem se alterar.

select * from tabela_de_clientes where bairro 
in (select distinct bairro from tabela_de_vendedores);
#outra maneira de pesquisar, porem sempre vai retornar atualizada a consulta
#Retorna os bairros onde tem vendedores e clientes no mesmo bairro

select x.embalagem, x.preco_maximo from
(select embalagem, max(preco_de_lista) as preco_maximo from tabela_de_produtos
group by embalagem) x 
where x.preco_maximo >=10;
#o que estiver dentro do parenteses vira um tabela e esta tabela é definida como sendo X
#Retorna o maximo que conter dentro da tabela X

SELECT X.CPF, X.CONTADOR FROM 
(SELECT CPF, COUNT(*) AS CONTADOR FROM notas_fiscais
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY CPF) X WHERE X.CONTADOR > 2000;
#consulta usando subconsulta

#mesma consulta de cima, porem de outra maneira
SELECT CPF, COUNT(*) FROM notas_fiscais
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY CPF
HAVING COUNT(*) > 2000;
#esta foi mais rapida que a de cima

#comando VIEW
select x.embalagem, x.preco_maximo from
(select embalagem, max(preco_de_lista) as preco_maximo from tabela_de_produtos
group by embalagem) x 
where x.preco_maximo >=10;
#utilizando o comando anterior, será criado uma view com o comando que esta dentro das ()
#a view esta nomeada como vw_maiores_embalagens

select x.embalagem, x.preco_maximo from
vw_maiores_embalages x where x.preco_maximo >=10;
#mesmo comando de cima, porem utilizando a view

select a.nome_do_produto, a.embalagem, a.preco_de_lista, x.preco_maximo
from tabela_de_produtos a inner join vw_maiores_embalages x
on a.embalagem = x.embalagem;
#compara o preço que os produtos  tem na lista e o preço mais caro (tudo por embalagem)

select a.nome_do_produto, a.embalagem, a.preco_de_lista, x.preco_maximo,
((a.preco_de_lista / x.preco_maximo)-1) * 100 as percentual
from tabela_de_produtos a inner join vw_maiores_embalages x
on a.embalagem = x.embalagem
/* compara os produtos e cria a tabela percentual
onde mostra o quao mais barato esta um item se comparado ao outro */