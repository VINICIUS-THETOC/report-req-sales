/**
 * Anotações de UI (Fiori Elements) para o Relatório de Requisições.
 *
 * - SelectionFields: filtros do List Report (Empresa, Fornecedor, Requisicao,
 *   Status, Emissao). O campo Emissao usa filtro por intervalo (Período DE/ATÉ).
 * - LineItem: as 14 colunas do relatório, na ordem da especificação, cada uma
 *   com Label em português.
 * - Navegação para a Object Page habilitada (LineItem gera a linha clicável).
 */
using ReqReportService from './report-service';

annotate ReqReportService.Requisicoes with @(

  // ----- Filtros do cabeçalho do List Report -----
  UI.SelectionFields: [
    Empresa,
    Fornecedor,
    Requisicao,
    Status,
    Emissao            // filtro por intervalo (Período DE/ATÉ) — ver @filter abaixo
  ],

  // ----- Colunas da tabela (List Report) -----
  UI.LineItem: [
    { $Type: 'UI.DataField', Value: Requisicao,    Label: 'Requisição' },
    { $Type: 'UI.DataField', Value: Requisitante,  Label: 'Requisitante' },
    { $Type: 'UI.DataField', Value: CentroCusto,   Label: 'Centro de Custo' },
    { $Type: 'UI.DataField', Value: Empresa,       Label: 'Empresa' },
    { $Type: 'UI.DataField', Value: TipoDocumento, Label: 'Tipo de Documento' },
    { $Type: 'UI.DataField', Value: Emissao,       Label: 'Emissão' },
    { $Type: 'UI.DataField', Value: Texto,         Label: 'Texto' },
    { $Type: 'UI.DataField', Value: Fornecedor,    Label: 'Fornecedor' },
    { $Type: 'UI.DataField', Value: Vencimento,    Label: 'Vencimento' },
    { $Type: 'UI.DataField', Value: Moeda,         Label: 'Moeda' },
    { $Type: 'UI.DataField', Value: Valor,         Label: 'Valor' },
    { $Type: 'UI.DataField', Value: Pagamento,     Label: 'Pagamento' },        // documentoSap (BELNR)
    { $Type: 'UI.DataField', Value: Status,        Label: 'Status' },           // statusCoupa
    { $Type: 'UI.DataField', Value: RequisicaoSAP, Label: 'Requisição SAP' }    // requisicaoCoupa
  ],

  // ----- Cabeçalho da Object Page -----
  UI.HeaderInfo: {
    TypeName      : 'Requisição',
    TypeNamePlural: 'Requisições',
    Title         : { $Type: 'UI.DataField', Value: Requisicao },
    Description   : { $Type: 'UI.DataField', Value: Texto }
  },

  // ----- Layout da Object Page: campos identificadores + seção de detalhes -----
  UI.Identification: [
    { $Type: 'UI.DataField', Value: Requisicao,    Label: 'Requisição' },
    { $Type: 'UI.DataField', Value: Requisitante,  Label: 'Requisitante' },
    { $Type: 'UI.DataField', Value: Status,        Label: 'Status' },
    { $Type: 'UI.DataField', Value: RequisicaoSAP, Label: 'Requisição SAP' }
  ],

  UI.FieldGroup #Detalhes: {
    Data: [
      { $Type: 'UI.DataField', Value: Empresa,       Label: 'Empresa' },
      { $Type: 'UI.DataField', Value: CentroCusto,   Label: 'Centro de Custo' },
      { $Type: 'UI.DataField', Value: TipoDocumento, Label: 'Tipo de Documento' },
      { $Type: 'UI.DataField', Value: Fornecedor,    Label: 'Fornecedor' },
      { $Type: 'UI.DataField', Value: Emissao,       Label: 'Emissão' },
      { $Type: 'UI.DataField', Value: Vencimento,    Label: 'Vencimento' },
      { $Type: 'UI.DataField', Value: Moeda,         Label: 'Moeda' },
      { $Type: 'UI.DataField', Value: Valor,         Label: 'Valor' },
      { $Type: 'UI.DataField', Value: Pagamento,     Label: 'Documento SAP' }
    ]
  },

  UI.Facets: [
    {
      $Type : 'UI.ReferenceFacet',
      ID    : 'DetalhesFacet',
      Label : 'Detalhes da Requisição',
      Target: '@UI.FieldGroup#Detalhes'
    }
  ]
);

// ----- Filtro por intervalo no campo Emissao (Período DE/ATÉ) -----
annotate ReqReportService.Requisicoes with {
  Emissao @Common.FilterDefaultValue: null;
};
annotate ReqReportService.Requisicoes with @(
  Capabilities.FilterRestrictions: {
    FilterExpressionRestrictions: [
      { Property: Emissao, AllowedExpressions: 'SingleRange' }
    ]
  }
);

// ----- Labels (rótulos) dos campos, reutilizados pela Object Page e filtros -----
annotate ReqReportService.Requisicoes with {
  Requisicao    @title: 'Requisição';
  Requisitante  @title: 'Requisitante';
  CentroCusto   @title: 'Centro de Custo';
  Empresa       @title: 'Empresa';
  TipoDocumento @title: 'Tipo de Documento';
  Emissao       @title: 'Emissão';
  Texto         @title: 'Texto';
  Fornecedor    @title: 'Fornecedor';
  Vencimento    @title: 'Vencimento';
  Moeda         @title: 'Moeda';
  Valor         @title: 'Valor';
  Pagamento     @title: 'Pagamento';
  Status        @title: 'Status';
  RequisicaoSAP @title: 'Requisição SAP';
};
