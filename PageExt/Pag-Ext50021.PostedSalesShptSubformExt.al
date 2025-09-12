pageextension 50021 "Posted Sales Shpt. Subform Ext" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Latest Item No."; Rec."Latest Item No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field(QA; Rec.QA)
            {
                ApplicationArea = Basic, Suite;
            }
            field("QSS System Code"; Rec."QSS System Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Set Quantity"; Rec."Set Quantity")
            {
                ApplicationArea = Basic, Suite;
            }
            field("QSS Package Code"; Rec."QSS Package Code")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
