pageextension 50032 "Sales Return Order Subform Ext" extends "Sales Return Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Expiry Date"; Rec."Expiry Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
