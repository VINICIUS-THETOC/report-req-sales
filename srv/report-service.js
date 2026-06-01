const cds = require('@sap/cds');

/**
 * Handler do ReqReportService.
 *
 * PROTÓTIPO: neste momento NÃO há controle de acesso nem autenticação real.
 * A autenticação está em modo "mocked" (ver package.json > cds.requires.auth)
 * para permitir visualizar todos os dados localmente.
 *
 * ┌────────────────────────────────────────────────────────────────────────┐
 * │ TODO (ligar no BAS / migração para HANA): CONTROLE DE ACESSO POR PERFIL  │
 * │                                                                          │
 * │ Regra de negócio futura:                                                 │
 * │   - Usuário do perfil FINANCEIRO (autorização ZBTPAP) => vê TODAS as     │
 * │     requisições.                                                         │
 * │   - Usuário nominal (sem ZBTPAP) => vê SOMENTE as requisições em que     │
 * │     ele é o "requisitante".                                              │
 * │                                                                          │
 * │ Onde implementar: no handler "before READ" abaixo, adicionando um filtro │
 * │ dinâmico ao req.query quando o usuário NÃO tiver o papel ZBTPAP.         │
 * │ Algo como:                                                               │
 * │                                                                          │
 * │   if (!req.user.is('ZBTPAP')) {                                          │
 * │     req.query.where({ requisitante: req.user.id });                     │
 * │   }                                                                      │
 * │                                                                          │
 * │ Também será necessário declarar @requires/@restrict no report-service.cds│
 * │ e configurar a estratégia de auth (XSUAA/IAS) no package.json/mta.       │
 * └────────────────────────────────────────────────────────────────────────┘
 */
module.exports = class ReqReportService extends cds.ApplicationService {
  init() {
    const { Requisicoes } = this.entities;

    // Ponto de extensão para o futuro filtro por perfil (ZBTPAP vs. nominal).
    // No protótipo este handler não restringe nada — apenas marca o local.
    this.before('READ', Requisicoes, (req) => {
      // TODO (BAS): aplicar regra ZBTPAP aqui. Ver comentário acima.
      // Ex.: if (!req.user.is('ZBTPAP')) req.query.where({ requisitante: req.user.id });
    });

    return super.init();
  }
};
