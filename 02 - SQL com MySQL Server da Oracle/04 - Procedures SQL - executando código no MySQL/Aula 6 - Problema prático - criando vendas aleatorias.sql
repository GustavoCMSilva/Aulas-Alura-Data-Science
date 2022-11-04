use sucos_vendas;
SET GLOBAL log_bin_trust_function_creators = 1;

select rand();

#Para selecionar um numero entre um intervalo estabelecido
#(aleatorio () * (max - min)) + min
#onde min = 15, max=30
#FLOOR para arredondar para baixo
select floor((rand() * (300-15+1)) + 15) as Numeros_aleatorios_entre_15_e_300;

#utilizando a funçao criada
/*
CREATE FUNCTION `Aleatorio_entre`(min int, max int) RETURNS int
BEGIN
	declare vretorno int;
    select floor((rand() * (300-15+1)) + 15) into vretorno;
RETURN vretorno;
END
*/
select Aleatorio_entre (15,300);

/*
-Crie uma tabela chamada TABELA_ALEATORIOS. O comando para cria-la é mostrado abaixo:
			CREATE TABLE TABELA_ALEATORIOS(NUMERO INT);
-Faça uma SP (Chame-a de Tabela_Numeros) que use um loop para gravar nesta tabela 100 números 
aleatórios entre 0 e 1000. Depois liste numa consulta esta tabela.

CREATE DEFINER=`root`@`localhost` PROCEDURE `Tabela_Numeros`()
BEGIN
DECLARE CONTADOR INT;
DECLARE CONTMAXIMO INT;
SET CONTADOR = 1;
SET CONTMAXIMO = 100;
DELETE FROM TABELA_ALEATORIOS;
WHILE CONTADOR <= CONTMAXIMO
DO
INSERT INTO TABELA_ALEATORIOS (NUMERO) VALUES (f_numero_aleatorio(0,1000));
SET CONTADOR = CONTADOR + 1;
END WHILE;
SELECT * FROM TABELA_ALEATORIOS;
END
*/
select Tabela_Numeros;

#FUNÇAO QUE MOSTRE CLIENTE DE MANEIRA ALEATORIA
/*
CREATE FUNCTION `Cliente_aleatorio` ()
RETURNS varchar(11)
BEGIN
	declare vretorno varchar(11);
    declare num_max_tabela int; #declara todas as linhas da tabela
    declare num_aleatorio int; #para procurar uma linha aleatoria
    select count(*) into num_max_tabela from tabela_de_clientes; #calculando o numero total de linhas
	set num_aleatorio = Aleatorio_entre(1, num_max_tabela); #utiliza a funçao Aleatorio_entre e o numero maximo de linhas para pegar uma linha aleatoria
	set num_aleatorio = num_aleatorio -1; #Esta linha vai corrigir o comando LIMIT que esta mais abaixo, que retira o erro de ignorar o primeiro e o ultimo numero da tabela
    select cpf into vretorno from tabela_de_clientes
    limit num_aleatorio, 1;
RETURN vretorno; #o que mostra no fim
END
*/
select Cliente_aleatorio();

/*
Neste exercício crie outra função para obter o produto também usando a função aleatório.

CREATE FUNCTION `f_produto_aleatorio`() RETURNS varchar(10) BEGIN
DECLARE vRetorno VARCHAR(10);
DECLARE num_max_tabela INT;
DECLARE num_aleatorio INT;
SELECT COUNT(*) INTO num_max_tabela FROM tabela_de_produtos;
SET num_aleatorio = f_numero_aleatorio(1, num_max_tabela);
SET num_aleatorio = num_aleatorio - 1;
SELECT CODIGO_DO_PRODUTO INTO vRetorno FROM tabela_de_produtos
LIMIT num_aleatorio, 1;
RETURN vRetorno;
END
*/
select f_produto_aleatorio();

/*
Neste exercício crie outra função para obter o vendedor também usando a função aleatório.
CREATE FUNCTION `f_vendedor_aleatorio`() RETURNS varchar(5) BEGIN
DECLARE vRetorno VARCHAR(5);
DECLARE num_max_tabela INT;
DECLARE num_aleatorio INT;
SELECT COUNT(*) INTO num_max_tabela FROM tabela_de_vendedores;
SET num_aleatorio = f_numero_aleatorio(1, num_max_tabela);
SET num_aleatorio = num_aleatorio - 1;
SELECT MATRICULA INTO vRetorno FROM tabela_de_vendedores
LIMIT num_aleatorio, 1;
RETURN vRetorno;
END
*/
select f_vendedor_aleatorio();

/*CRIANDO NF COM ITENS E VALORES DE VENDAS
CREATE PROCEDURE `InserirVenda`(vdata date, max_item int, max_compra int)
BEGIN
	declare vcliente varchar(11);
    declare vproduto varchar (10);
    declare vvendedor varchar (5);
    declare vquantidade int;
    declare vpreco float;
    declare vitem int;
    declare vnumnota int;
    declare vcontador int default 1;
    declare vnumitem int;
    
    select max(numero) + 1 into vnumnota from notas_fiscais; #novo numero de NF
    set vcliente = Cliente_aleatorio();
    set vvendedor = f_vendedor_aleatorio();
    insert into notas_fiscais (cpf, matricula, data_venda, numero, imposto)
    values (vcliente, vvendedor, vdata, vnumnota, 0.18);
    set vitem = Aleatorio_entre(1, max_item);
    
    while vcontador <= vitem
    do
		set vproduto = f_produto_aleatorio();
        select count(*) into vnumitem from itens_notas_fiscais
        where numero = vnumitem and codigo_do_produto = vproduto;
        if vnumitem = 0 then
			set vquantidade = Aleatorio_entre(10, max_compra);
			select preco_de_lista into vpreco from tabela_de_produtos 
			where codigo_do_produto = vproduto;
			insert into itens_notas_fiscais (numero, codigo_do_produto, quantidade, preco)
			values (vnumnota, vproduto, vquantidade, vpreco);
		end if;
        set vcontador = vcontador + 1;
    end while;
END
*/
CALL InserirVenda('20221103', 3, 100);

select a.numero, count(*) as numero_itens, sum(b.quantidade * b.preco) as faturado
from notas_fiscais a inner join itens_notas_fiscais b
on a.numero = b.numero where a.data_venda = '20221103'
group by a.numero;

