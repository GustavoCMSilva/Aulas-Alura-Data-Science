use vendas_sucos;

#alterando dados de itens
update produtos set preco_lista = 5 where codigo = '1000889';

update produtos set embalagem = 'pet', tamanho = '1 litro', descritor = 'sabor da montanha - 1 litro - uva' 
where codigo = '1000889';

select * from produtos;

#aumentando 10% em varios os produtos
update produtos set preco_lista = preco_lista * 1.10 where sabor = 'maracuja';


/* Atualize o endereço do cliente com cpf 19290992743 para R. Jorge Emílio 23 o bairro para Santo Amaro, 
a cidade para São Paulo, o estado para SP e o CEP para 8833223. */
update clientes set endereco = 'R. Jorge Emílio 23', bairro = 'Santo Amaro', cidade = 'São Paulo', 
estado = 'SP', cep = '8833223' where cpf = 19290992743;

#alterando valores com valores de outra tabela
#nesse colocar os mesmos dados da coluna ferias do banco sucos_vendas no banco vendas_sucos
select * from vendedores A #defini vendedores como A
inner join sucos_vendas.tabela_de_vendedores B #defini tabela_vendedores do banco sucos_vendas como B
on A.matricula = #no campo matricula do A
substring(B.matricula,3,3); #com o campo matricula, porem somente a partir do terceiro digito e 3 apos ele, exempo 00235 vai pegar apenas 235

#aplicando a consulta acima
update vendedores A #defini vendedores como A
inner join sucos_vendas.tabela_de_vendedores B #defini tabela_vendedores do banco sucos_vendas como B
on A.matricula = #no campo matricula do A
substring(B.matricula,3,3) #com o campo matricula, porem somente a partir do terceiro digito e 3 apos ele, exempo 00235 vai pegar apenas 235
set A.ferias = B.de_ferias;
#alterado o campo de ferias A com os dados de_ferias B

/*Podemos observar que os vendedores possuem bairro associados a eles. 
Vamos aumentar em 30% o volume de compra dos clientes que possuem, em seus endereços bairros 
onde os vendedores possuam escritórios.*/
UPDATE CLIENTES A INNER JOIN VENDEDORES B
ON A.BAIRRO = B.BAIRRO
SET A.VOLUME_COMPRA = A.VOLUME_COMPRA * 1.30;
#consulta do exercicio
SELECT * from clientes;

#COMANDO DELETE
delete from produtos where codigo ='xxxxx';

/* Desafio: Vamos excluir as notas fiscais (Apenas o cabeçalho) cujos clientes tenham a idade
 menor ou igual a 18 anos. */
DELETE A FROM NOTAS A
INNER JOIN CLIENTES B ON A.CPF = B.CPF
WHERE B.IDADE <= 18;

#quando clico com o direito em produtos >> Send to SQL editor >> Create statement
CREATE TABLE `produtos2` (
  `codigo` varchar(10) NOT NULL,
  `descritor` varchar(100) DEFAULT NULL,
  `sabor` varchar(50) DEFAULT NULL,
  `tamanho` varchar(50) DEFAULT NULL,
  `embalagem` varchar(50) DEFAULT NULL,
  `preco_lista` float DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

#no comando acima criei uma nova tabela, porem esta vazia
#agora sera copiado os campos entre as tabelas
insert into  produtos2
select * from produtos;

select * from produtos2;

#apagar todos itens da tabela
delete from produtos2;

/*Apague todos os dados da tabela NOTAS e ITENS_NOTAS. */
delete from notas itens_notas;
select * from itens_notas;

/*PRESERVANDO A INTEGRIDADE E CONSISTENCIA DOS DADOS */
start transaction; #cria um ponto de restauraçao
#tudo a partir daqui pode ser restaurado

select * from vendedores;

update vendedores set comissao = comissao * 3; #aumentando em 3x a comissao

rollback; #desconsidero o que foi alterado e volto ao ponto de restauraçao, sem mostrar o que foi alterado
#isso tambem finaliza o START TRANSACTION, se quiser tenho que iniciar novamente

select * from vendedores;
----------------------------------------------------------------------------------
start transaction; #cria um ponto de restauraçao

select * from vendedores;

update vendedores set comissao = comissao * 3; #aumentando em 3x a comissao

commit; #confirma a alteraçao e finaliza o START TRANSACTION

select * from vendedores;

