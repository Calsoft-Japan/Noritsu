pageextension 50009 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Promised Receipt Date")
        {
            field("B/L Date"; Rec."B/L Date")
            {
                ApplicationArea = OrderPromising;
                Importance = Promoted;
            }
        }
    }
}
