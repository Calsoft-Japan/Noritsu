tableextension 50004 "Sales Cr.Memo Line Ext" extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50051; "QSS System Code"; Code[30])
        {
            Caption = 'QSS System Code';
            DataClassification = ToBeClassified;
        }
        field(50052; "Set Quantity"; Decimal)
        {
            Caption = 'Set Quantity';
            DataClassification = ToBeClassified;
        }
        field(50053; "QSS Package Code"; Code[30])
        {
            Caption = 'QSS Package Code';
            DataClassification = ToBeClassified;
        }
        field(50060; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
        }
    }
}
