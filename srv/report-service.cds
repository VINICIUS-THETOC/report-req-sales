/**
 * Service do "Relatório de Requisições".
 *
 * Exposto em: /service/ReqReport
 * Entidade principal: Requisicoes (projeção @readonly juntando
 * Cabecalho + Pagamento + StatusProcesso).
 */
using realtorio.reqpag as db from '../db/schema';

@path: 'service/ReqReport'
service ReqReportService {

  /**
   * Projeção somente-leitura do relatório de requisições.
   * Junta o cabeçalho com os dados de pagamento e de status de processo.
   *
   * A ordem das colunas segue a especificação do relatório.
   */
  @readonly
  entity Requisicoes as projection on db.Cabecalho {
    // --- Identificação / cabeçalho ---
    requisicao                       as Requisicao,
    requisitante                     as Requisitante,
    centroCusto                      as CentroCusto,
    empresa                          as Empresa,

    // --- Dados de pagamento (assoc 1:1) ---
    pagamento.tipoDocumento          as TipoDocumento,
    dataEmissao                      as Emissao,
    textoCabecalho                   as Texto,
    pagamento.fornecedor             as Fornecedor,
    pagamento.dataVencimento         as Vencimento,
    pagamento.moeda                  as Moeda,
    pagamento.valor                  as Valor,

    // --- Status / integração (assoc 1:1) ---
    statusProcesso.documentoSap      as Pagamento,        // nº do documento SAP (BELNR)
    statusProcesso.statusCoupa       as Status,           // status no COUPA
    requisicaoCoupa                  as RequisicaoSAP     // nº da requisição no COUPA

    // Obs.: a Object Page deste protótipo é "plana" (mesma entidade, navegada
    // pela chave). Rateios/Anexos não são expostos aqui; no BAS, se necessário,
    // basta projetar essas composições preservando a chave "requisicao".
  };
}
