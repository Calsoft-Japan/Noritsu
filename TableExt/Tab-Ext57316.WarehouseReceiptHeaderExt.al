tableextension 50152 "Warehouse Receipt Header Ext" extends "Warehouse Receipt Header"
{
    fields
    {
        field(50000; "B/L Date"; Date)
        {

            trigger OnValidate()
            begin
                //UpdateWhseRcptLinesBLDate;
            end;
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

