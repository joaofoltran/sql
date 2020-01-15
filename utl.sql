DECLARE
    v_Arquivo UTL_FILE.file_type;
BEGIN
    v_ARQUIVO := UTL_FILE.fopen('/bat/br/trab/fm/fdv/tmp','testefdvtmp.txt','W');
    utl_file.put_line(v_ARQUIVO, 'TESTANDO');
    UTL_FILE.fclose(v_Arquivo);
END;
/
