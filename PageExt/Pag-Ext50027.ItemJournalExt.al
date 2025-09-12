pageextension 50027 "Item Journal Ext." extends "Item Journal"
{
    layout
    {
        addafter("Item No.")
        {
            field("Expiry Date"; Rec."Expiry Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
