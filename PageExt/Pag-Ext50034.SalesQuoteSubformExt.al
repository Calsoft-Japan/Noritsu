pageextension 50034 "Sales Quote Subform Ext" extends "Sales Quote Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Latest Item No."; Rec."Latest Item No.")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
        }
    }
}
