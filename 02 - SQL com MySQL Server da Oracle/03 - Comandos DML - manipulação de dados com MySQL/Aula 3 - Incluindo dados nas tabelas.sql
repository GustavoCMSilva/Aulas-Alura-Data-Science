use vendas_sucos;

#inserindo dados nos campos
insert into produtos (codigo, descritor, sabor, tamanho, embalagem, preco_lista)
values ('1040107', 'light - 350 ml - melancia', 'melancia', '350 ml', 'lata', 4.50);

select * from produtos;

#outra maneira de inserir, quando a ordem das insersoes forem as mesmas das colunas
insert into produtos
values ('1040109', 'light - 350 ml - açai', 'graviola', '350 ml', 'lata', 5.60);

#corrigindo itens das tabela
update produtos set sabor = 'açai' #estava escrito errado
where codigo = '1040109';

#inserindo mais de uma linha de uma vez
insert into produtos
values ('1040110', 'light - 350 ml - jaca', 'jaca', '350 ml', 'lata', 6.00),
('1040111', 'light - 350 ml - manga', 'manga', '350 ml', 'lata', 3.50)
;

/* Inclua os seguintes registros na tabela de clientes: */
insert into clientes
values ('1471156710', 'Érica Carvalho', 'R. Iriquitia', 'Jardins', 'São Paulo', 'SP', '80012212', '19900901', 27, 'f', 170000, 2500, 0),
('19290992743', 'Fernando Cavalcante', 'R. Dois de Fevereiro', 'Água Santa', 'Rio de Janeiro', 'RJ', '22000000', '20000212', 18, 'm', 100000, 20000, 1),
('2600586709', 'César Teixeira', 'R. Conde de Bonfim', 'Tijuca', 'Rio de Janeiro', 'RJ', '22020001', '20000312', 18, 'm', 120000, 22000, 0);
;

select * from clientes;

/* INSERÇÃO EM LOTES */
#importando dados de outro banco de dados
select * from sucos_vendas.tabela_de_produtos;
#perceba que embora os campos sejam os mesmos, os nomes estão alterados
select codigo_do_produto as codigo, #renomeando para adequar a nova tabela
nome_do_produto as descritor, #renomeando para adequar a nova tabela
embalagem,
tamanho,
sabor,
preco_de_lista as preco_lista #renomeando para adequar a nova tabela
from sucos_vendas.tabela_de_produtos
where CODIGO_DO_PRODUTO not in (select codigo from produtos); #para não repetir produtos
#porem só rodar este codigo nao ira inserir na nova tabela

#basta adicionar este codigo neste comando abaixo
insert into produtos
#perceba que embora os campos sejam os mesmos, os nomes estão alterados
select codigo_do_produto as codigo, #renomeando para adequar a nova tabela
nome_do_produto as descritor, #renomeando para adequar a nova tabela
sabor, #respeitando a ordem
tamanho, #respeitando a ordem
embalagem, #respeitando a ordem
preco_de_lista as preco_lista #renomeando para adequar a nova tabela
from sucos_vendas.tabela_de_produtos
where codigo_do_produto not in (select codigo from produtos); #para não repetir produtos

select * from produtos;

/*Inclua todos os clientes na tabela CLIENTES baseados nos registros da tabela 
TABELA_DE_CLIENTES da base SUCOS_VENDAS. */
INSERT INTO clientes
(CPF,NOME,ENDERECO,BAIRRO,CIDADE,ESTADO,CEP, NASCIMENTO,IDADE,SEXO,LIMITE_CREDITO,
VOLUME_COMPRA,PRIMEIRA_COMPRA)
SELECT CPF, NOME, ENDERECO_1 AS ENDERECO, BAIRRO, CIDADE, ESTADO, CEP,
DATA_DE_NASCIMENTO AS  NASCIMENTO, IDADE, SEXO,LIMITE_DE_CREDITO AS LIMITE_CREDITO, 
VOLUME_DE_COMPRA AS VOLUME_COMPRA,PRIMEIRA_COMPRA 
 FROM sucos_vendas.tabela_de_clientes 
 WHERE CPF NOT IN (SELECT CPF FROM clientes);
 select * from clientes;
 
 /* LENDO DADOS A PARTTIR DE UM ARQUIVO EXTERNO*/
 # Clique com direito em vendedores >> Table data import wizard
 select * from vendedores;