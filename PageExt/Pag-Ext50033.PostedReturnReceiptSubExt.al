pageextension 50033 "Posted Return Receipt Sub Ext." extends "Posted Return Receipt Subform"
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
