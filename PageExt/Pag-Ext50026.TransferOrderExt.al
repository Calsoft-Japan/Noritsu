pageextension 50026 "Transfer Order Ext" extends "Transfer Order"
{
    layout
    {
        addafter("Transfer-to Contact")
        {
            field("Transfer-to Customer Code"; Rec."Transfer-to Customer Code")
            {
                ApplicationArea = Location;
                Caption = 'Transfer-to Customer';
                Importance = Additional;
            }
        }
    }
}
