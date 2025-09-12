tableextension 50039 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {

        field(50000; "Latest Item No."; Code[30])
        {
            //FieldClass = FlowField;
            //CalcFormula = lookup(Item."Latest Item No." where("No." = field("No.")));
        }
        field(50001; QA; Boolean)
        {
            //FieldClass = FlowField;
            //CalcFormula = lookup(Item.QA where("No." = field("No.")));
        }
        field(50002; "B/L Date"; Date)
        {
        }
        field(50051; "Send Status"; Boolean)
        {
            Editable = true;
        }

        field(50060; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                itm: Record Item;
            begin
                //PBC Modification BEGIN
                if Rec.Type = Rec.Type::Item then begin
                    //TestField(Rec."No.");
                    itm.Get(Rec."No.");
                    Rec.QA := itm.QA;
                    Rec."Latest Item No." := itm."Latest Item No.";
                end;
                //PBC Modification END
            end;
        }
    }
}

