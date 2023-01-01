using { sap.ui.riskmanagement as my } from '../db/schema';

@path: 'service/risk'
/* Creating a new service RiskService 
which exposes two entities : Risks and Mitigations 
which exposes the entities from the database schame */

/* With only these two documents risk-service & schema we have a running OData Service*/
service RiskService {
    entity Risks @(restrict : [
        {
            grant : [ 'READ' ],
            to : [ 'RiskViewer' ]
        },
        {
            grant : [ '*' ],
            to : [ 'RiskManager' ]
        }
    ]) as projection on my.Risks;
    
    annotate Risks with @odata.draft.enabled;
    entity Mitigations @(restrict : [
        {
            grant : [ 'READ' ],
            to : [ 'RiskViewer' ]
        },
        {
            grant : [ '*' ],
            to : [ 'RiskManager' ]
        }
    ])
    as projection on my.Mitigations;
        annotate Mitigations with @odata.draft.enabled;
}