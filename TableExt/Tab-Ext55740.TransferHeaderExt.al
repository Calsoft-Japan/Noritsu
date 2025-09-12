tableextension 50156 "Transfer Header Ext" extends "Transfer Header"
{
    fields
    {
        field(50000; "Transfer-to Customer Code"; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer1: Record Customer;
            begin

                if "Transfer-to Customer Code" <> '' then begin
                    Customer1.Get("Transfer-to Customer Code");
                    "Transfer-to Name" := Customer1.Name;
                    "Transfer-to Name 2" := Customer1."Name 2";
                    "Transfer-to Address" := Customer1.Address;
                    "Transfer-to Address 2" := Customer1."Address 2";
                    "Transfer-to Post Code" := Customer1."Post Code";
                    "Transfer-to City" := Customer1.City;
                    "Transfer-to County" := Customer1.County;
                    "Trsf.-to Country/Region Code" := Customer1."Country/Region Code";
                    "Transfer-to Contact" := Customer1.Contact;
                end else begin
                    "Transfer-to Name" := '';
                    "Transfer-to Name 2" := '';
                    "Transfer-to Address" := '';
                    "Transfer-to Address 2" := '';
                    "Transfer-to Post Code" := '';
                    "Transfer-to City" := '';
                    "Transfer-to County" := '';
                    "Trsf.-to Country/Region Code" := '';
                    "Transfer-to Contact" := '';
                end;
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

