table 50042 "Standard Accessory"
{
    Caption = 'Standard Accessory';
    LookupPageID = 50052;

    fields
    {
        field(1; "Accessory Code"; Code[30])
        {
            Caption = 'Item Code (Parts)';
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate()
            begin

                Item.Get("Accessory Code");
                Description := Item.Description;
            end;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Quantity; Decimal)
        {
        }
        field(4; "Acc. Serial No."; Code[20])
        {
            Caption = 'Serial No. (Parts)';
        }
        field(5; "Module No."; Code[30])
        {
            Caption = 'Item Code (Machine)';
            Editable = false;
            TableRelation = Item;
        }
        field(6; "Module Serial No."; Code[20])
        {
            Caption = 'Serial No. (Machine)';
            Editable = false;
        }
        field(7; "Line No."; Integer)
        {
            //AutoIncrement = true;
            //NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Module No.", "Module Serial No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
}
