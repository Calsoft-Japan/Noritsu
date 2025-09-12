pageextension 50013 "Posted Warehouse Receipt Ext" extends "Posted Whse. Receipt"
{
    layout
    {
        addafter("Assignment Time")
        {
            field("B/L Date"; Rec."B/L Date")
            {
                ApplicationArea = Warehouse;
                Editable = false;
                Importance = Promoted;
            }
        }
    }
}
