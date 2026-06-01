sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"realtorio/reqreport/test/integration/pages/RequisicoesList",
	"realtorio/reqreport/test/integration/pages/RequisicoesObjectPage"
], function (JourneyRunner, RequisicoesList, RequisicoesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('realtorio/reqreport') + '/test/flpSandbox.html#realtorioreqreport-tile',
        pages: {
			onTheRequisicoesList: RequisicoesList,
			onTheRequisicoesObjectPage: RequisicoesObjectPage
        },
        async: true
    });

    return runner;
});

