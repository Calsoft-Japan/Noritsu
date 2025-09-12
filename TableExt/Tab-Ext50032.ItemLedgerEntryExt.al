tableextension 50032 "Item Ledger Entry Ext" extends "Item Ledger Entry"
{

    fields
    {
        field(50051; "QSS System Code"; Code[30])
        {
            Editable = false;
            TableRelation = "QSS System";
        }
        field(50052; "Shipment Creation Date"; Date)
        {
            Description = '//SAS';
            Editable = false;
        }

        field(50060; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
        }
    }

    keys
    {
        key(CSExt; "Completely Invoiced", "Last Invoice Date")
        { }
    }
}


