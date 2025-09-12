pageextension 50025 "Item Ledger Entry Ext" extends "Item Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Item No.")
        {
            field("Expiry Date"; Rec."Expiry Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
