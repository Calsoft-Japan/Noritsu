pageextension 50020 "Sales Order Subform Ext" extends "Sales Order Subform"
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
            field(QA; Rec.QA)
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("QSS System Code"; Rec."QSS System Code")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Set Quantity"; Rec."Set Quantity")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("QSS Package Code"; Rec."QSS Package Code")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
        }
    }
}
