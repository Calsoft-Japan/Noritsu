pageextension 50017 "Warehouse Receipts Ext" extends "Warehouse Receipts"
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
