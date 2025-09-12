pageextension 50003 "Vendor List Ext" extends "Vendor List"
{
    layout
    {
        addafter("Payments (LCY)")
        {
            field("NKC Buyer Code"; Rec."NKC Buyer Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("NKC Pricing Structure"; Rec."NKC Pricing Structure")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
