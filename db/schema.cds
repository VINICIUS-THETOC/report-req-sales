/**
 * Modelo de domínio do protótipo "Relatório de Requisições de Pagamento".
 *
 * Domínio: Requisição de Pagamentos (app integrado ao COUPA e ao S/4 HANA).
 * Este é apenas um protótipo local com SQLite em memória — sem HANA ainda.
 *
 * Estrutura:
 *   Cabecalho (1) ──── (1) Pagamento
 *             (1) ──── (1) StatusProcesso
 *             (1) ──── (N) Rateio
 *             (1) ──── (N) Anexo
 */
namespace realtorio.reqpag;

using { cuid } from '@sap/cds/common';

/**
 * Cabeçalho da requisição de pagamento.
 * A chave de negócio é o número da requisição.
 */
entity Cabecalho {
  key requisicao    : String(20);      // Nº da requisição (chave de negócio)
  requisicaoCoupa   : String(20);      // Nº da requisição no COUPA
  requisitante      : String(80);      // Usuário/pessoa que requisitou
  textoCabecalho    : String(200);     // Texto livre do cabeçalho
  centroCusto       : String(20);      // Centro de custo
  empresa           : String(10);      // Código da empresa (Bukrs)
  dataEmissao       : Date;            // Data de emissão da requisição
  politica          : String(60);      // Política de compra aplicada
  localNegocio      : String(60);      // Local de negócio / business unit

  // Associações de composição lógica (1:1 e 1:N)
  pagamento         : Association to Pagamento      on pagamento.cabecalho = $self;
  statusProcesso    : Association to StatusProcesso on statusProcesso.cabecalho = $self;
  rateios           : Association to many Rateio    on rateios.cabecalho = $self;
  anexos            : Association to many Anexo      on anexos.cabecalho = $self;
}

/**
 * Dados de pagamento — relação 1:1 com o cabeçalho.
 */
entity Pagamento : cuid {
  cabecalho     : Association to Cabecalho;   // FK para o cabeçalho (1:1)
  descricao     : String(200);                // Descrição do pagamento
  fornecedor    : String(100);                // Nome do fornecedor
  primeiroNome  : String(60);                 // Primeiro nome (contato)
  segundoNome   : String(60);                 // Segundo nome (contato)
  formaPagamento: String(40);                 // Forma de pagamento
  dataEmissao   : Date;                       // Data de emissão do pagamento
  dataVencimento: Date;                       // Data de vencimento
  documento     : String(40);                 // Nº do documento (nota/fatura)
  moeda         : String(5);                  // Moeda (ex.: BRL, USD)
  valor         : Decimal(15,2);              // Valor do pagamento
  tipoDocumento : String(20);                 // Tipo de documento
}

/**
 * Status de processo / integração — relação 1:1 com o cabeçalho.
 */
entity StatusProcesso : cuid {
  cabecalho       : Association to Cabecalho;  // FK para o cabeçalho (1:1)
  statusCoupa     : String(40);                // Status no COUPA (Aprovado, Rascunho, etc.)
  documentoSap    : String(10);                // Nº do documento SAP (BELNR)
  statusIntegracao: String(40);                // Status da integração com o S/4 HANA
}

/**
 * Rateio contábil — relação 1:N a partir do cabeçalho.
 */
entity Rateio : cuid {
  cabecalho     : Association to Cabecalho;    // FK para o cabeçalho (1:N)
  empresa       : String(10);                  // Código da empresa
  ordemInterna  : String(20);                  // Ordem interna (AUFNR)
  projeto       : String(30);                  // Projeto
  elementoPep   : String(30);                  // Elemento PEP (WBS)
  contaContabil : String(20);                  // Conta contábil (HKONT)
  centroCusto   : String(20);                  // Centro de custo
  montante      : Decimal(15,2);               // Montante rateado
}

/**
 * Anexos da requisição — relação 1:N a partir do cabeçalho.
 */
entity Anexo : cuid {
  cabecalho : Association to Cabecalho;        // FK para o cabeçalho (1:N)
  fileName  : String(255);                     // Nome do arquivo anexado
}
