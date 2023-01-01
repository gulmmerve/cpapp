const cds = require('@sap/cds')

/* 
* Implementation for Risk Management service defined in ./risk-service.cds
*/

/*
* This file has to be in the same name with the cds file
* To investigate in detail see Cap Node.js Events
*/

module.exports = cds.service.impl(async function() {
// after event carried out after the Risks entity READ was carried out
    this.after('READ', 'Risks', risksData => {
        const risks = Array.isArray(risksData) ? risksData : [risksData];
/* Looping into the returned Risk data, for each
* We have changed the criticality value according to the intensity of the impact
* The new values for the criticality are then become a part of the response to the read request.
* Within this we have changed the application's response, Fiori Elements app framework translates them into icons and colors. */
        risks.forEach(risk => {
            if (risk.impact >= 100000) {
                risk.criticality = 1;
            } else {
                risk.criticality = 2;
            }
        })    
    });
});