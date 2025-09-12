tableextension 50112 "Sales Invoice Header" extends "Sales Invoice Header"
{

    fields
    {
        field(50000;"Paid Before Invoice";Boolean)
        {
            Caption = 'Paid Before Invoice';
        }
        field(50500;"Creator ID";Code[20])
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
        field(50501;"Posting ID";Code[20])
        {
        }
    }

 
}

