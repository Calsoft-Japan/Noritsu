pageextension 50016 "Posted Purchase Receipts Ext" extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Location Code")
        {
            field("B/L Date"; Rec."B/L Date")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
