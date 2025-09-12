tableextension 50154 "Posted Whse Rcpt Header Ext" extends "Posted Whse. Receipt Header"
{
    fields
    {
        field(50000; "B/L Date"; Date)
        {
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
        field(50501; "Posting ID"; Code[20])
        {
        }
    }
}

