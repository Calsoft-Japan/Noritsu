pageextension 50010 "Posted Pur. Invoice Ext" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Creditor No.")
        {
            field("B/L Date"; Rec."B/L Date")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                Importance = Promoted;
            }
        }
    }
}
