pageextension 50018 "Posted Warehouse Receipts Ext" extends "Posted Whse. Receipt List"
{
    layout
    {
        addafter("Location Code")
        {
            field("B/L Date"; Rec."B/L Date")
            {
                ApplicationArea = Warehouse;
            }
        }
    }
}
