use vendas_sucos;

#Criando novas tabelas
create table produtos
(
codigo varchar(10) not null, #chave primaria,
descritor varchar(100) null,
sabor varchar(50) null,
tamanho varchar(50) null,
embalagem varchar(50) null,
preco_lista float null,
primary key (codigo)
);

create table vendedores
(
matricula varchar(5) not null,
nome varchar(100) null,
bairro varchar(50) null,
comissao float null,
data_admissao date null,
ferias bit(1) null, #tipo booleano 1 ou 0
primary key (matricula)
);

#Alterando nome de coluna quando não for primary key
alter table vendedores rename column data_admissao to data_adm; #pode ignorar esse erro
#alterando o nome da tabela
alter table vendas rename notas;

#ligando as tabelas em outras tabelas
alter table vendas add constraint fk_clientes
foreign key (cpf) 
references clientes(cpf);

alter table vendas add constraint fk_vendedores
foreign key (matricula) 
references vendedores(matricula);

/*Crie, por linha de comando, a chave estrangeira ligando a tabela de PRODUTOS com a 
tabela de ITENS_NOTAS através do campo CODIGO e outra ligação entre a tabela VENDAS e ITENS_NOTAS 
através do campo NUMERO.*/
alter table itens_notas add constraint fk_produtos
foreign key (codigo) 
references produtos(codigo);

alter table itens_notas add constraint fk_vendas
foreign key (numero) 
references vendas(numero);
/**/

#corrigindo pois vendas se tornou notas
alter table itens_notas add constraint fk_notas
foreign key (numero) 
references notas(numero);

/* OLHANDO O DIAGRAMA
aba Database >> Reverse Engineer