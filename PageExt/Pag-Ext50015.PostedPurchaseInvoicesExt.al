pageextension 50015 "Posted Purchase Invoices Ext" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Location Code")
        {
            field("B/L Date"; Rec."B/L Date")
            {
                ApplicationArea = Suite;
            }
        }
    }
}
