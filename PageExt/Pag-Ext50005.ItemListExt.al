pageextension 50005 "Item List Ext" extends "Item List"
{
    layout
    {
        /*
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
        */
        addafter("Vendor No.")
        {
            field("QSS System Code"; Rec."QSS System Code")
            {
                ApplicationArea = Basic, Suite;
                Importance = Promoted;
            }
            field("Latest Item No."; Rec."Latest Item No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Used Item"; Rec."Used Item")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Average Cost (LCY)"; AverageCostLCY)
            {
                ApplicationArea = Basic, Suite;
                Importance = Promoted;
                AutoFormatType = 2;
                Editable = false;

                trigger OnDrillDown()
                begin
                    CODEUNIT.RUN(CODEUNIT::"Show Avg. Calc. - Item", Rec);
                end;
            }
            field("HS Code"; Rec."HS Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("HS Sub Code"; Rec."HS Sub Code")
            {
                ApplicationArea = Basic, Suite;
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
