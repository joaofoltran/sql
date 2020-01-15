# SCRIPTS

Scripts foram criados com o intuito de agilizar operações que realizo diariamente, desta forma não preciso criar todo meu SQL do zero, apenas preciso lembrar do nome do script!!
Lembrando que são utilizados para bancos **ORACLE**, pois ninguém gosta de sql server. 
Abraços.

## DESCRIÇÃO

- **DUT.sql**
    - Lista jobs rodando na dut (processo da Souza Cruz) no momento.

- **FILADUT.sql**
    - Lista filas da dut e quantidade de jobs em cada.

- **EXEC.sql**
    - Consulta nas views globais gv$session e gv$process para coletar sessões ativas e que possuem eventos que não estão com status idle.

- **TBFILES.sql**
    - Retorna os datafiles da tablespace informada.
    	> sqlplus> @tbfiles tablespace_name

- **TEMPFILES.sql**
	- Retorna os datafiles da tablespace temporária informada.
		> sqlplus> @tempfiles tablespace_name

- **LASTDUT.sql**
    - Consulta jobs que rodaram e finalizaram na dut nos últimos 5 minutos.

- **DESC.sql**
    - Lista as colunas e índices da tabela informada.
    	> sqlplus> @desc table_name

- **RUNNING_JOBS.sql**
	- Lista jobs rodando no momento.

- **TBS_USE.sql**
	- Lista tamanho máximo e utilização das tablespaces.

- **USER_PRIVS.sql**
	- Lista permissões do usuário informado.
		> sqlplus> @user_privs username

- **USER_DBLINKS.sql**
	- Lista dblinks do usuário.
		> sqlplus> @user_dblinks username