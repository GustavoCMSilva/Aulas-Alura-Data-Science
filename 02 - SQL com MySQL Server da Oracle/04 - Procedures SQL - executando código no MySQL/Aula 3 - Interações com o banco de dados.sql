use sucos_vendas;

#comando baixado da aula.
INSERT INTO tabela_de_produtos (CODIGO_DO_PRODUTO,NOME_DO_PRODUTO,SABOR,TAMANHO,EMBALAGEM,PRECO_DE_LISTA)
    VALUES ('2001001','Sabor da Serra 700 ml - Manga','Manga','700 ml','Garrafa',7.50),
    ('2001000','Sabor da Serra  700 ml - Melão','Melão','700 ml','Garrafa',7.50),
    ('2001002','Sabor da Serra  700 ml - Graviola','Graviola','700 ml','Garrafa',7.50),
    ('2001003','Sabor da Serra  700 ml - Tangerina','Tangerina','700 ml','Garrafa',7.50),
    ('2001004','Sabor da Serra  700 ml - Abacate','Abacate','700 ml','Garrafa',7.50),
    ('2001005','Sabor da Serra  700 ml - Açai','Açai','700 ml','Garrafa',7.50),
    ('2001006','Sabor da Serra  1 Litro - Manga','Manga','1 Litro','Garrafa',7.50),
    ('2001007','Sabor da Serra  1 Litro - Melão','Melão','1 Litro','Garrafa',7.50),
    ('2001008','Sabor da Serra  1 Litro - Graviola','Graviola','1 Litro','Garrafa',7.50),
    ('2001009','Sabor da Serra  1 Litro - Tangerina','Tangerina','1 Litro','Garrafa',7.50),
    ('2001010','Sabor da Serra  1 Litro - Abacate','Abacate','1 Litro','Garrafa',7.50),
    ('2001011','Sabor da Serra  1 Litro - Açai','Açai','1 Litro','Garrafa',7.50);

    SELECT * FROM tabela_de_produtos WHERE NOME_DO_PRODUTO LIKE 'Sabor da Serra%';

    UPDATE tabela_de_produtos SET PRECO_DE_LISTA = 8 WHERE NOME_DO_PRODUTO LIKE 'Sabor da Serra%';

    SELECT * FROM tabela_de_produtos WHERE NOME_DO_PRODUTO LIKE 'Sabor da Serra%';

    DELETE FROM tabela_de_produtos WHERE NOME_DO_PRODUTO LIKE 'Sabor da Serra%';

    SELECT * FROM tabela_de_produtos WHERE NOME_DO_PRODUTO LIKE 'Sabor da Serra%';
    #porem dá para adicionar em uma procedure
    
call manipula_dados; 
#esta procedure vai rodar o comando acima e vai mostrar todos os selects utilizados na ordem.

/*Crie uma Stored procedure que atualize a idade dos clientes. 
Lembrando que o comando para calcular a idade, na tabela Tabela_de_Clientes é: */
/* 
CREATE PROCEDURE `Calcula_Idade`()
BEGIN
UPDATE tabela_de_clientes set idade =  TIMESTAMPDIFF(YEAR, data_de_nascimento, CURDATE());
END
*/ 
call Calcula_Idade;

/*
CREATE PROCEDURE `cadastro_vendedor`(vMatricula varchar(50), vNome varchar(100),
vComissao float, vAdmissao date, vFerias bit(1), vBairro varchar(50))
BEGIN
#procedure para cadastrar novos vendedores
	insert into tabela_de_vendedores
    (matricula, nome, percentual_comissao, data_admissao, de_ferias, bairro)
    values (vMatricula, vNome, vComissao, vAdmissao, vFerias, vBairro);

	select * from tabela_de_vendedores;
END
*/
#procedure para cadastrar novos vendedores
call cadastro_vendedor ('1690', 'Gustavo Silva', 0.30, '2022-09-12', 0, 'Nova Iguaçu');
#é possivel criar procedures para alterar e excluir dados tambem.

/*Crie uma Stored procedure para reajustar o % de comissão dos vendedores. 
Inclua como parâmetro da SP o %, expresso em valor (Ex: 0,90).

CREATE PROCEDURE `Reajuste_Comissao`(vPercent FLOAT)
BEGIN
UPDATE tabela_de_vendedores SET percentual_comissao = percentual_comissao * (1 + vPercent);
SELECT nome, percentual_comissao FROM tabela_de_vendedores;
END
*/
call Reajuste_comissao (-0.5);

#adicionando mensagem de erro na procedure (para dados duplicados ou incluidos com sucesso)
#foi incluido na procedure de cadastro de vendedores
/*
CREATE PROCEDURE `cadastro_vendedor`(vMatricula varchar(50), vNome varchar(100),
vComissao float, vAdmissao date, vFerias bit(1), vBairro varchar(50))
BEGIN
	declare mensagem varchar (150);
    
    #caso o cadastro seja repetido, irá aparecer esta mensagem
    #COMANDO
	declare exit handler for 1062 #1062 é o erro de dados na PK cuplicado
		begin
			set mensagem = concat('Erro - ', vMatricula, ' - ', vNome, ' -> Cadastro Existente');
			select mensagem;			
        end;

#procedure para cadastrar novos vendedores
	insert into tabela_de_vendedores
    (matricula, nome, percentual_comissao, data_admissao, de_ferias, bairro)
    values (vMatricula, vNome, vComissao, vAdmissao, vFerias, vBairro);
    
    #caso seja cadastrado um novo vendedor irá aparecer esta mensagem
    set mensagem = concat(vMatricula, ' - ', vNome, ' -> Cadastrado');
    select mensagem;
END
*/
call cadastro_vendedor ('01686', 'Nayara Souza', 0.50, '2022-01-12', 1, 'Embu das Artes');

select * from tabela_de_produtos;
#Utilizando procedure para encontrar dados
/*
CREATE PROCEDURE `acha_sabor`(vSaborProduto varchar (50))
BEGIN
	declare vCodProduto varchar (10);
    select codigo_do_produto INTO vCodProduto 
    from tabela_de_produtos
    where sabor = vSaborProduto;
    
    select vCodProduto;
END
*/
call acha_sabor ('Uva');
#neste caso encontra somente 1 dado, sendo ideal fazer uma procedure para pesquisar o codigo e mostrar o resultado

/*Crie uma variável chamada NUMNOTAS e atribua a ela o número de notas fiscais do dia 01/01/2017. 
Mostre na saída do script o valor da variável. (Chame esta Stored Procedure de Quantidade_Notas).

CREATE PROCEDURE `Quantidade_Notas`()
BEGIN
DECLARE NUMNOTAS INT;
SELECT COUNT(*) INTO NUMNOTAS  FROM NOTAS_FISCAIS WHERE DATA_VENDA = '20170101';
SELECT NUMNOTAS;
END
*/
Call Quantidade_Notas;