use vendas_sucos;

#criando tabela de auto incremento, sempre tem que ter primary key
create table tab_identidade (id int auto_increment, descritor varchar(20), primary key(id));

#inserindo um iten na tabela, na coluna ID será acrescentado um valor novo
insert into tab_identidade (descritor) values ('cliente1');
#serve para cadastro, pois vai incluir os numeros de forma automatica
select * from tab_identidade;

insert into tab_identidade (descritor) values ('cliente2');
select * from tab_identidade;

/*mesmo se deletar algum dado, o proximo incremento será uma sequencia ignorando o que foi apagado.*/
#gerado o id 3 para este incremento
insert into tab_identidade (descritor) values ('cliente3');
select * from tab_identidade;
#deletado o ID 3 do item
delete from tab_identidade where id = 3;
select * from tab_identidade;
#gerado o ID 4 neste incremento.
insert into tab_identidade (descritor) values ('cliente4');
select * from tab_identidade;

#PULANDO SEQUENCIA
#ignorando a sequencia e colocando a partir de qual numero que quero iniciar
insert into tab_identidade (id, descritor) values (100, 'cliente5');
select * from tab_identidade;
#os proximos irão continuar a sequencia nova
insert into tab_identidade (descritor) values ('cliente6');
select * from tab_identidade;


create table tab_identidade2 (id int auto_increment, 
descritor varchar(20), #sem padrão, sendo necessario sempre ser adicionado
endereco varchar (100) null, # se não mencionar nada, será nulo
cidade varchar(50) default 'rio de janeiro', #vem setado como rio de janeiro por padrao
data_criaçao timestamp default current_timestamp(), #setado a hora atual do pc
 primary key(id));

insert into tab_identidade2 (descritor, endereco, data_criaçao)
values
('cliente x', 'rua das acacias', '2019-01-01');
select * from tab_identidade2;

insert into tab_identidade2 (descritor) values ('cliente Y');
select * from tab_identidade2;

/* TRIGGER */
#comando que dispara após algo acontecer
#menciona será irá acontecer antes ou depois de um INSERT / UPDATE / DELETE
create table tab_faturamento (data_venda date null, total_venda float);
select * from tab_faturamento;

select * from notas;
select * from itens_notas;
select * from tab_faturamento;

insert into notas (numero, data_venda, cpf, matricula, imposto)
values('100', '2019-05-08', '1471156710', '235', 0.10);
insert into itens_notas (numero, codigo, quantidade, preco)
values('100', '1002334', 100, 10);
insert into itens_notas (numero, codigo, quantidade, preco)
values('100', '1000889', 100, 10);
insert into notas (numero, data_venda, cpf, matricula, imposto)
values('101', '2019-05-08', '1471156710', '235', 0.10);
insert into itens_notas (numero, codigo, quantidade, preco)
values('101', '1002334', 100, 10);
insert into itens_notas (numero, codigo, quantidade, preco)
values('101', '1000889', 100, 10);

insert into notas (numero, data_venda, cpf, matricula, imposto)
values('102', '2019-05-08', '1471156710', '235', 0.10);
insert into itens_notas (numero, codigo, quantidade, preco)
values('102', '1002334', 100, 10);
insert into itens_notas (numero, codigo, quantidade, preco)
values('102', '1000889', 100, 10);

#TRIGGER
DELIMITER //
create trigger tg_fat_insert after insert on itens_notas
for each row begin
	delete from tab_faturamento;
    insert into tab_faturamento
    select a.data_venda, sum(b.quantidade * b.preco) as total_venda from
    notas a inner join itens_notas b
    on a.numero = b.numero
    group by a.data_venda;
end //
#toda vez que tiver inclusao em notas e itens_notas, automaticamento a tab_faturamento será preenchida
#porem este trigger é somente para o insert, sendo necessario um criar um para update e delete
DELIMITER //
create trigger tg_fat_update after update on itens_notas
for each row begin
	delete from tab_faturamento;
    insert into tab_faturamento
    select a.data_venda, sum(b.quantidade * b.preco) as total_venda from
    notas a inner join itens_notas b
    on a.numero = b.numero
    group by a.data_venda;
end //
DELIMITER //
create trigger tg_fat_delete after delete on itens_notas
for each row begin
	delete from tab_faturamento;
    insert into tab_faturamento
    select a.data_venda, sum(b.quantidade * b.preco) as total_venda from
    notas a inner join itens_notas b
    on a.numero = b.numero
    group by a.data_venda;
end //

insert into notas (numero, data_venda, cpf, matricula, imposto)
values('103', '2019-05-08', '1471156710', '235', 0.10);
insert into itens_notas (numero, codigo, quantidade, preco)
values('103', '1002334', 100, 10);
insert into itens_notas (numero, codigo, quantidade, preco)
values('103', '1000889', 100, 10);

select*from tab_faturamento;

#a partir dos triggers criados, tudo que for adicionado, alterado e deletado, será computado em tab_faturamento
update itens_notas set quantidade = 400
where numero = 103 and codigo = '1000889';
select * from tab_faturamento;