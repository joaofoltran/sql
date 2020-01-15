CREATE TABLE SUPTCADM.HIST_MONIT_APURACAO (
    DAT_MONIT DATE DEFAULT sysdate,
    STATUS NUMBER(1),
    MENSAGEM VARCHAR2(50)
);

CREATE OR REPLACE PROCEDURE TECL.MONITORAMENTO_APURACAO IS
   dia_atual varchar2(10);
   qtd_apuracao NUMBER;
   status number;
   
   BEGIN
    select to_char(sysdate,'DD') into dia_atual from dual;
      IF (dia_atual = '18') THEN
         select count(iniapu) into qtd_apuracao
         from tecl.r044cal
         where numemp = 1
         and tipcal = 11
         and iniapu > sysdate - interval '2' month;
         -- Se maior que 1 apuração (por exemplo: estamos no mês 05, aparecera a apuração do mês 04 e caso já tenha sido liberado, aparecerá a do mês 05 também) retorna 1 = OK.
         IF (qtd_apuracao > 1) THEN
            
            status := 1;
            insert into SUPTCADM.HIST_MONIT_APURACAO values (sysdate, status, 'APURACAO OK');
        -- Se igual a 1 (apenas a apuração do mês atual) retorna 1 = NOK.
         ELSIF (qtd_apuracao = 1) THEN

            status := 2;
            insert into SUPTCADM.HIST_MONIT_APURACAO values (sysdate, status, 'APURACAO NOK');
         -- Se igual a 0 indica que existem problemas na consulta, retorna 0 = DESCONHECIDO.
         ELSIF (qtd_apuracao = 0) THEN

            status := 0;
            insert into SUPTCADM.HIST_MONIT_APURACAO values (sysdate, status, 'APURACAO DESCONHECIDA');

         END IF;
      END IF;
   END;

BEGIN
dbms_scheduler.create_job(
    job_name        => 'TECL.VERIFICA_APURACAO',
    job_type        => 'STORED_PROCEDURE',
    job_action      => 'TECL.MONITORAMENTO_APURACAO',
    start_date      => '10-JUN-2019 12:00:00 AM',
    repeat_interval => 'FREQ=DAILY',
    enabled         => TRUE);
END;

grant insert on SUPTCADM.HIST_MONIT_APURACAO to TECL;
grant select on SUPTCADM.HIST_MONIT_APURACAO to TECL;
