tableextension 50018 "Customer Ext" extends "Customer"
{

    fields
    {

        field(50000; "Customer Group Code"; Code[20])
        {
            Caption = 'Customer Group 1';
            TableRelation = "Customer Group".Code;
        }
        field(50001; "Customer Group 2 Code"; Code[20])
        {
            Caption = 'Customer Group 2';
            TableRelation = "Customer Group 2".Code;
        }
        field(50002; "SFA Customer No."; Code[20])
        {

            trigger OnValidate()
            var
                locCustomer1: Record Customer;
                locText001: Label 'SFA Customer No. must be unique throughout the system.';
            begin

                if "SFA Customer No." <> '' then begin
                    locCustomer1.Reset;
                    locCustomer1.SetCurrentKey(locCustomer1."SFA Customer No.");
                    locCustomer1.SetRange(locCustomer1."SFA Customer No.", "SFA Customer No.");
                    if locCustomer1.Find('-') then
                        Error(locText001);
                end;
            end;
        }
        field(50003; "EZiS Customer No."; Code[30])
        {
        }

        field(50100; "Receiving Bank Account"; Code[20])
        {
            Caption = 'Receiving Bank Account';
            TableRelation = "Bank Account"."No.";
        }
        field(50101; "Totals in Local Currency"; Boolean)
        {
            Caption = 'Totals in Local Currency';
        }

    }


}

