### Verificar versão do dicionario do TASY
select cd_versao_atual from tasy.aplicacao_tasy where cd_aplicacao_tasy = 'Tasy';


### Verificar historico de atualizações do TASY
select CD_APLICACAO_TASY, CD_VERSAO, DT_VERSAO, DT_ATUALIZACAO, NM_USUARIO from tasy.APLICACAO_TASY_VERSAO order by DT_ATUALIZACAO;