pageextension 50030 "Sales Cr. Memo Subform Ext." extends "Sales Cr. Memo Subform"
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
