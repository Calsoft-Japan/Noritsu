tableextension 50001 "Sales Invoice Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Latest Item No."; Code[30])
        {
        }
        field(50001; QA; Boolean)
        {
        }
        field(50051; "QSS System Code"; Code[30])
        {
            Caption = 'QSS System Code';
            Editable = false;
        }
        field(50052; "Set Quantity"; Decimal)
        {
            Caption = 'Set Quantity';
            Editable = false;
        }
        field(50053; "QSS Package Code"; Code[30])
        {
            Caption = 'QSS Package Code';
            Editable = false;
        }
    }
}
