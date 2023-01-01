// using the created service from the risk-service file
using RiskService from './risk-service';

// In comments, CDS ABAP syntax is given.
annotate RiskService.Risks with {
    // General purpose annotations @title : Common.Label (label for columns, text fields)
    // This information normally should be at a translatable file
    title  @title: 'Title';
    prio   @title: 'Priority';
    descr  @title: 'Description';
    miti   @title: 'Mitigation';
    impact @title: 'Impact';
}

// Below section is for the value help of the Mitigation field
annotate RiskService.Mitigations with {
    ID          @(
        // Hiding ID property from UI
        UI.Hidden,
        // Descriptive Common.Text
        Common: {Text: description}
    );
    description @title: 'Description';
    owner       @title: 'Owner';
    timeline    @title: 'Timeline';
    risks       @title: 'Risks';
}

// Below section covers the work list and object pages
annotate RiskService.Risks with @(UI: {
    // HeaderInfo defines the key information of the object
    HeaderInfo      : {
        $Type         : 'UI.HeaderInfoType',
        // Object page title @UI.headerInfo.typeName: 'Risk'
        TypeName      : 'Risk',
        // List level title @UI.headerInfo.typeNamePlural: 'Risks'
        TypeNamePlural: 'Risks',
        // The title of the object page header area @UI.HeaderInfo.title: { typpe: #STANDARD, value: 'title' }
        Title         : {
            $Type: 'UI.DataField',
            Value: title
        },
        // Subtitle at the object page header area
        Description   : {
            $Type: 'UI.DataField',
            Value: descr
        }
    },
    // To add filter fields to the filter bar @UI.SelectionField: [{ position: 10 }]
    SelectionFields : [prio],
    // To add columns to a table or a work list @UI.lineItem: [{ importance: #HIGH, position: 10, criticality: 'Criticality' }]
    LineItem        : [
        {Value: title},
        {Value: miti_ID},
        {
            Value      : prio,
            Criticality: criticality
        },
        {
            Value      : impact,
            Criticality: criticality
        }
    ],
    // Defines the content of the object page @UI.Facet: [{ targetQualifier: 'Main', type: #FIELDGROUP_REFERENCE, purpose: #FILTER }]
    Facets          : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Main',
        Target: '@UI.FieldGroup#Main'
    }],
    // Displays as a Form. The properties under Data array, determines the field list in this Form.
    FieldGroup#Main: {
        Data: [
            {Value: miti_ID},
            {
                Value      : prio,
                Criticality: criticality
            },
            {
                Value      : impact,
                Criticality: criticality
            }
    ]}
}) {};

annotate RiskService.Risks with {
    miti @(Common: {
        // Show text, not id for mitigation in the context of risks. Declares the description text from the Miti association.
        Text           : miti.description,
        TextArrangement: #TextOnly,
        // Mitigations Value Help
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Mitigations',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: miti_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                }
            ]
        },
    });
}
