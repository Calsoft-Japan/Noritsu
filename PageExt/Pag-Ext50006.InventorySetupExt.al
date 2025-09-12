pageextension 50006 "Inventory Setup Ext" extends "Inventory Setup"
{
    layout
    {
        addafter("Copy Item Descr. to Entries")
        {
            field("Parts Item Category"; Rec."Parts Item Category")
            {
                ApplicationArea = Basic, Suite;
            }
            field("HQ Vendor Code (Price Update)"; Rec."HQ Vendor Code (Price Update)")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Bus. Posting Group (Transfer)"; Rec."Bus. Posting Group (Transfer)")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
