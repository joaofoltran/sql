-- Desativa, altera a duração para 10 horas e depois ativa a janela de sábado.
--BEGIN
--	dbms_scheduler.disable(
--		name => 'SYS.SATURDAY_WINDOW');
--	
--	dbms_scheduler.set_attribute(
--		name => 'SYS.SATURDAY_WINDOW',
--		attribute => 'DURATION',
--		value => numtodsinterval(10,'hour'));
--	
--	dbms_scheduler.enable(
--		name => 'SYS.SATURDAY_WINDOW');
--END;
--/

-- Desativa, altera a duração para 16 horas e depois ativa a janela de domingo.
--BEGIN
--	dbms_scheduler.disable(
--		name => 'SYS.SUNDAY_WINDOW');
--	
--	dbms_scheduler.set_attribute(
--		name => 'SYS.SATURDAY_WINDOW',
--		attribute => 'DURATION',
--		value => numtodsinterval(16,'hour'));
--	
--	dbms_scheduler.enable(
--		name => 'SYS.SATURDAY_WINDOW');
--END;
--/

-- Desativa, altera duração para 12 horas e ativa a janela de segunda-feira.
BEGIN
	dbms_scheduler.disable(
		name => 'SYS.MONDAY_WINDOW');
	dbms_scheduler.set_attribute(
		name => 'SYS.MONDAY_WINDOW',
		attribute => 'DURATION',
		value => numtodsinterval(12,'hour'));
		
	dbms_scheduler.enable(
		name => 'SYS.MONDAY_WINDOW');
END;
/

-- Desativa, altera duração para 12 horas e ativa a janela de terça-feira.
BEGIN
	dbms_scheduler.disable(
		name => 'SYS.TUESDAY_WINDOW');
	dbms_scheduler.set_attribute(
		name => 'SYS.TUESDAY_WINDOW',
		attribute => 'DURATION',
		value => numtodsinterval(12,'hour'));
	
	dbms_scheduler.enable(
		name => 'SYS.TUESDAY_WINDOW');
END;
/

-- Desativa, altera duração para 12 horas e ativa a janela de quarta-feira.
BEGIN
	dbms_scheduler.disable(
		name => 'SYS.WEDNESDAY_WINDOW');
	dbms_scheduler.set_attribute(
		name => 'SYS.WEDNESDAY_WINDOW',
		attribute => 'DURATION',
		value => numtodsinterval(12,'hour'));
		
	dbms_scheduler.enable(
		name => 'SYS.WEDNESDAY_WINDOW');
END;
/

-- Desativa, altera a duração para 12 horas e depois ativa a janela de quinta-feira.
BEGIN
	dbms_scheduler.disable(
		name => 'SYS.THURSDAY_WINDOW');
	
	dbms_scheduler.set_attribute(
		name => 'SYS.THURSDAY_WINDOW',
		attribute => 'DURATION',
		value => numtodsinterval(12,'hour'));
	
	dbms_scheduler.enable(
		name => 'SYS.THURSDAY_WINDOW');
END;
/

-- Desativa, altera duração para 12 horas e ativa a janela de sexta-feira.
BEGIN
	dbms_scheduler.disable(
		name => 'SYS.FRIDAY_WINDOW');
	dbms_scheduler.set_attribute(
		name => 'SYS.FRIDAY_WINDOW',
		attribute => 'DURATION',
		value => numtodsinterval(12,'hour'));
		
	dbms_scheduler.enable(
		name => 'SYS.FRIDAY_WINDOW');
END;
/








