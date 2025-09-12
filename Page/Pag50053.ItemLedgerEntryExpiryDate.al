page 50053 "Item Ledger Entry Expiry Date"
{
    ApplicationArea = All;
    Caption = 'Item Ledger Entries (Expiry Date)';
    PageType = List;
    SourceTable = "Item Ledger Entry";
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = History;
    SourceTableView = SORTING("Posting Date") ORDER(Descending) WHERE("Remaining Quantity" = filter(> 0));
    Permissions = tabledata "Item Ledger Entry" = M;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = false;
                }
                field("Quantity"; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    Editable = false;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
            }
        }
    }
}