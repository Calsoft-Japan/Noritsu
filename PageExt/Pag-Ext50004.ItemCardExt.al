pageextension 50004 "Item Card Ext" extends "Item Card"
{
    layout
    {
        /*
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = Basic, Suite;
                Importance = Additional;
                //ShowMandatory = true;
                //Visible = DescriptionFieldVisible;
            }
        } 
        */
        addafter("Purchasing Code")
        {
            field("QSS System Code"; Rec."QSS System Code")
            {
                ApplicationArea = Basic, Suite;
                Importance = Promoted;
            }
            field("Latest Item No."; Rec."Latest Item No.")
            {
                ApplicationArea = Basic, Suite;
                Importance = Additional;
            }
            field("Used Item"; Rec."Used Item")
            {
                ApplicationArea = Basic, Suite;
                Importance = Additional;
            }

            field("Average Cost (LCY)"; AverageCostLCY)
            {
                ApplicationArea = Basic, Suite;
                Importance = Additional;
                AutoFormatType = 2;
                Editable = false;

                trigger OnDrillDown()
                begin
                    CODEUNIT.RUN(CODEUNIT::"Show Avg. Calc. - Item", Rec);
                end;
            }
        }
        addafter(Warehouse)
        {
            group(Properties)
            {
                field("Part Type"; Rec."Part Type")
                {
                    ApplicationArea = All;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                }
                field("Model Type"; Rec."Model Type")
                {
                    ApplicationArea = All;
                }
                field("HS Code"; Rec."HS Code")
                {
                    ApplicationArea = All;
                }
                field("HS Sub Code"; Rec."HS Sub Code")
                {
                    ApplicationArea = All;
                }
                field(Specification; Rec.Specification)
                {
                    ApplicationArea = All;
                }
                field(Material; Rec.Material)
                {
                    ApplicationArea = All;
                }
                field("Production Name"; Rec."Production Name")
                {
                    ApplicationArea = All;
                }
                field("Production Type"; Rec."Production Type")
                {
                    ApplicationArea = All;
                }
                field("Major Group"; Rec."Major Group")
                {
                    ApplicationArea = All;
                }
                field("Product Group"; Rec."Product Group")
                {
                    ApplicationArea = All;
                }
                field("Serialized Parts"; Rec."Serialized Parts")
                {
                    ApplicationArea = All;
                }
                field("With Serial No."; Rec."With Serial No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETRANGE("No.");
        ItemCostMgt.CalculateAverageCost(Rec, AverageCostLCY, AverageCostACY);
    end;

    var
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        ItemCostMgt: Codeunit ItemCostManagement;
}