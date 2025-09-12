pageextension 50011 "Posted Purch. Receipt Ext" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Expected Receipt Date")
        {
            field("B/L Date"; Rec."B/L Date")
            {
                ApplicationArea = Suite;
                Editable = false;
                Importance = Promoted;
            }
        }
    }
}
