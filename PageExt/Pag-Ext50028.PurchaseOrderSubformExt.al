pageextension 50028 "Purchase Order Subform Ext." extends "Purchase Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Latest Item No."; Rec."Latest Item No.")
            {
                ApplicationArea = All;
                Editable = false;

            }
            field("QA"; Rec.QA)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Expiry Date"; Rec."Expiry Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
