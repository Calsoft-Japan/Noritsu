tableextension 50027 "Item Ext" extends "Item"
{

    fields
    {
        field(50000; "Latest Item No."; Code[30])
        {
        }
        field(50001; "Price Group"; Code[4])
        {
        }
        field(50002; "Pricing Structure"; Code[1])
        {
        }
        field(50003; "HQ Unit Price"; Decimal)
        {
        }
        field(50004; "Part Type"; Option)
        {
            OptionMembers = " ",Parts,Option,Consumables,Material;
        }
        field(50005; "Process Type"; Option)
        {
            OptionMembers = " ","Wet Process","Dry Process","Dry & Wet";
        }
        field(50006; "Model Type"; Option)
        {
            OptionMembers = " ",QSS,"dDP (dDP)","MYTIS (Other)";
        }
        field(50007; "HS Code"; Code[15])
        {
        }
        field(50008; "HS Sub Code"; Code[3])
        {
        }
        field(50009; Specification; Text[60])
        {
        }
        field(50010; Material; Text[40])
        {
        }
        field(50011; "Production Type"; Option)
        {
            OptionMembers = " ",FP,PP,NOUS,Peripheral,Large;
        }
        field(50012; "Major Group"; Code[10])
        {
        }
        field(50013; "Product Group"; Code[10])
        {
        }
        field(50015; "Production Name"; Text[50])
        {
        }
        field(50016; QA; Boolean)
        {
        }
        field(50017; "Serialized Parts"; Boolean)
        {
            Caption = 'Serialized Parts';
        }
        field(50018; "With Serial No."; Boolean)
        {
        }
        field(50020; "Product Type"; Text[10])
        {
        }

        field(50019; "Country of Origin Code"; Code[10])
        {
            Caption = 'Country of Origin Code';//'Country Code';
        }
        field(50022; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
        }
        field(50021; "Revision Date"; Date)
        {
            Caption = 'Revision Date';
        }
        field(50051; "QSS System Code"; Code[30])
        {
            TableRelation = "QSS System";
        }
        field(50052; "Used Item"; Boolean)
        {
        }
        field(50100; "Standard Cost (Manufacturing)"; Decimal)
        {
            AutoFormatType = 2;
            MinValue = 0;
        }
        field(58888; III; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(58889; OOO; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item No." = FIELD("No."),
                                                                          "Document No." = FILTER(<> 'MGIV000002')));
            FieldClass = FlowField;
        }
    }
}

