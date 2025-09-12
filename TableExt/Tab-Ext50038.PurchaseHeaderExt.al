tableextension 50038 "Purchase Header Ext" extends "Purchase Header"
{


    fields
    {

        field(50000; "B/L Date"; Date)
        {
            trigger OnValidate()
            begin
                //UpdatePurchLines(FIELDCAPTION("B/L Date"));
                UpdatePurchLinesByFieldNo(FieldNo("B/L Date"), CurrFieldNo <> 0);
            end;
        }
        field(50051; Completed; Boolean)
        {
            Caption = 'Complete Shipment';
        }
        field(50052; "Send Status"; Boolean)
        {
            Editable = false;
        }
        field(50053; "Transport Method Code"; Code[4])
        {
            TableRelation = "Transport Method Code".Code;
        }
        field(50500; "Creator ID"; Code[20])
        {
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
    }

}
