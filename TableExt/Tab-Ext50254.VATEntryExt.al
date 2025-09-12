tableextension 50254 "VAT Entry Ext" extends "VAT Entry"
{


    fields
    {

        field(50000; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
        }
    }

    keys
    {
        key(FDD010; Type, "Country/Region Code", "Posting Date", "Document Type", "Document No.") { }
        key(FDD010_1; "VAT Identifier") { }
        //key(FDD010; Type, "Country/Region Code", "VAT Identifier", "Posting Date", "Document Type", "Document No.") { }
    }

}

