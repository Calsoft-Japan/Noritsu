tableextension 50121 "Purch. Rcpt. Line Ext" extends "Purch. Rcpt. Line"
{

    fields
    {

        field(50002; "B/L Date"; Date)
        {
        }
        field(50100; "NR Vendor Shipment No."; Code[20])
        {
            Caption = 'Vendor Shipment No.';
        }
        field(50060; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
        }
    }
}

