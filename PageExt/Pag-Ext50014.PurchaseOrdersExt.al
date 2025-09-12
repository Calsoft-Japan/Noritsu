pageextension 50014 "Purchase Orders Ext" extends "Purchase Order List"
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
