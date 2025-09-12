pageextension 50002 "Vendor Card Ext" extends "Vendor Card"
{
    layout
    {
        addafter("Currency Code")
        {
            field("NKC Buyer Code"; Rec."NKC Buyer Code")
            {
                ApplicationArea = Suite;
                Importance = Promoted;
            }
            field("NKC Pricing Structure"; Rec."NKC Pricing Structure")
            {
                ApplicationArea = Suite;
                Importance = Promoted;
            }
        }
    }
}
