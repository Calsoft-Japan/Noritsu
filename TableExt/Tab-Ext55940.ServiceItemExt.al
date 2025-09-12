tableextension 50151 "Service Item Ext" extends "Service Item"
{
    fields
    {
        field(50000; "Service Item Status Code"; Option)
        {
            Caption = 'Status';
            OptionMembers = " ","Resale/Disposal",BY,"Rental/Click";

            trigger OnValidate()
            begin

                if "Service Item Status Code" <> xRec."Service Item Status Code" then begin
                    //  IF CONFIRM(Text50000,FALSE) THEN BEGIN
                    //    "Status Last Modification Date" := TODAY();
                    //  END ELSE
                    //    "Service Item Status Code" := xRec."Service Item Status Code";
                end;
            end;
        }
        field(50001; "Status Last Modification Date"; Date)
        {
            Caption = 'Date Status Changed';
        }
        field(50051; "QSS System Code"; Code[30])
        {
            Editable = true;
            TableRelation = "QSS System";
        }
        field(50052; "Sales Order Document No."; Code[20])
        {
        }
        field(50053; "Sales Order Line No."; Integer)
        {
        }
        field(50054; "Lot No."; Code[20])
        {
        }
    }
}

