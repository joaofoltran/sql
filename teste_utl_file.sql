

DECLARE
  V_SEPARADOR                   VARCHAR2(1):= ';';
  P_SEQ_PARM                    PARM_JOB_BATCH.NUM_SEQ_PARM%TYPE;
  V_NOM_ARQ_ORIG                VARCHAR2(200);
  P_NOM_DIR_ARQ                 VARCHAR2(200);
  P_NUM_IDENT_INTER             VARCHAR2(200);
  V_NOM_ARQ                     VARCHAR2(100);
  V_NOM_DIR                     VARCHAR2(100);
  V_NOM_DIR_ARQ                 VARCHAR2(1000);

  P_DAT_INI                     DATE;
	P_DAT_FIM                     DATE;
  P_COD_PRODOR                  PRODOR.COD_PRODOR%TYPE;
  P_NUM_RCTRIO                  RECEIT_AGRNCO.NUM_RCTRIO%TYPE;
  P_NUM_ART                     RECEIT_AGRNCO.NUM_ART%TYPE;
  P_COD_LOCALD                  ESTAB.COD_ESTAB%TYPE;
  P_NUM_ANO_SAFRA               safra.num_ano_Safra%TYPE;


BEGIN

  -- Captura os param
  p_seq_parm    :=  138323;
  p_nom_dir_arq := '/bat/br/trab/fm/ffs/tmp/suptcjhn.651207';

  P_DAT_INI           := To_Date(FDF106SK.F_RECUP_PARM_ALFA ( p_seq_parm, 'P_DAT_INI'),'dd/mm/yyyy hh24:MI:SS');
	P_DAT_FIM           := To_Date(FDF106SK.F_RECUP_PARM_ALFA ( p_seq_parm, 'P_DAT_FIM'),'dd/mm/yyyy hh24:MI:SS');
  P_COD_PRODOR        := FDF106SK.F_RECUP_PARM_NUM  ( p_seq_parm, 'P_COD_PRODOR');
  P_NUM_RCTRIO        := FDF106SK.F_RECUP_PARM_NUM  ( p_seq_parm, 'P_NUM_RCTRIO');
  P_NUM_ANO_SAFRA     := FDF106SK.F_RECUP_PARM_NUM  ( p_seq_parm, 'P_NUM_ANO_SAFRA');
  P_NUM_ART           := FDF106SK.F_RECUP_PARM_ALFA ( p_seq_parm, 'P_NUM_ART');
  P_COD_LOCALD        := To_Number(FDF106SK.F_RECUP_PARM_ALFA ( p_seq_parm, 'P_COD_LOCALD'));

  v_nom_dir_arq:= p_nom_dir_arq;

  fdv1bjsk.c_fecha_log;

  -- Retira o nome do arquivo e diretorio
  v_nom_arq := substr(v_nom_dir_arq,instr(v_nom_dir_arq,'/',-1,1)+1, length(v_nom_dir_arq)-instr(v_nom_dir_arq,'/',-1,1));
  v_nom_dir := substr(v_nom_dir_arq,1,instr(v_nom_dir_arq,'/',-1,1));

    --Next step Nasa
  p_num_ident_inter := SubStr(v_nom_arq,InStr(v_nom_arq,'.')+1,Length(v_nom_arq));

  v_nom_arq_orig := v_nom_arq;
  v_nom_arq:= REPLACE(v_nom_arq,'.','_')||'.csv';

  begin
    update log_arq_saida
       SET  NOM_ARQ_SAIDA = v_nom_dir||v_nom_arq
     WHERE NUM_IDENT_INTERN =  p_num_ident_inter;
    commit;
  end;

  dbms_output.put_line('p_num_ident_inter: '||p_num_ident_inter);
  dbms_output.put_line('v_nom_arq: '||v_nom_arq);
  dbms_output.put_line('v_nom_dir: '||v_nom_dir);

  -- Cria o arquivo de log
  fdv1bjsk.c_inicializa_arq_log(v_nom_arq_orig
                               ,v_nom_dir);
  fdv1bjsk.c_grava_log('');

  fdv1bjsk.c_fecha_log;

  fdv1bjsk.c_inicializa_arq_log(v_nom_arq
                               ,v_nom_dir);

  -- cabecalho
  fdv1bjsk.c_grava_log('Locald'
        ||v_separador||'Msg Erro' ||v_separador);

  fdv1bjsk.c_fecha_log;

END;
/
