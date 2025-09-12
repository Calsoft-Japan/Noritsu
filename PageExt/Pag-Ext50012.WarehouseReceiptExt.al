pageextension 50012 "Warehouse Receipt Ext" extends "Warehouse Receipt"
{
    layout
    {
        addafter("Sorting Method")
        {
            field("B/L Date"; Rec."B/L Date")
            {
                ApplicationArea = Warehouse;
                Editable = true;
                Importance = Promoted;
            }
        }
    }
}
