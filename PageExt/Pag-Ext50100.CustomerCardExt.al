pageextension 50100 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        //#if not CLEAN22
        modify("Name 2")
        {
            Visible = true;
        }
        //#ENDIF

        addafter("Disable Search by Name")
        {
            field("Customer Group 1"; Rec."Customer Group Code")
            {
                ApplicationArea = Basic, Suite;
                Importance = Additional;
            }
            field("Customer Group 2"; Rec."Customer Group 2 Code")
            {
                ApplicationArea = Basic, Suite;
                Importance = Additional;
            }
        }
        addafter("Invoice Disc. Code")
        {
            field("Receiving Bank Account"; Rec."Receiving Bank Account")
            {
                ApplicationArea = Basic, Suite;
                Importance = Additional;
            }

            field("Totals in Local Currency"; Rec."Totals in Local Currency")
            {
                ApplicationArea = Basic, Suite;
                Importance = Additional;
            }
        }
    }
}
