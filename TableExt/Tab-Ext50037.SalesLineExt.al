tableextension 50037 "Sales Line Ext" extends "Sales Line"
{


    fields
    {

        field(50000; "Latest Item No."; Code[30])
        {
        }
        field(50001; QA; Boolean)
        {
        }
        field(50051; "QSS System Code"; Code[30])
        {
            //Editable = false;
        }
        field(50052; "Set Quantity"; Decimal)
        {
            //Editable = false;
        }
        field(50053; "QSS Package Code"; Code[30])
        {
            Description = '//SAS';
            //Editable = false;
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

                    updateLineDiscount();
                end;
                //PBC Modification END
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                updateLineDiscount();
            end;
        }
    }

    procedure updateLineDiscount()
    var
        itm: Record Item;
        SvcMgtSetup: Record "Service Mgt. Setup";
        SvcContractHdr: Record "Service Contract Header";
        SalesHeader: Record "Sales Header";
    begin
        if Rec.Type = Rec.Type::Item then begin
            //TestField(Rec."No.");
            itm.Get(Rec."No.");

            if (Rec."Line Discount %" = 0) and (UpperCase(itm."Item Category Code") = 'PARTS')
            and ((UpperCase(itm."Product Group") = 'PART') or (UpperCase(itm."Product Group") = 'CNSMB_PART'))
            then begin
                //SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Document No.");
                SalesHeader.Get(Rec."Document Type", Rec."Document No.");

                SvcContractHdr.Reset();
                SvcContractHdr.SetRange(Status, SvcContractHdr.Status::Signed);
                SvcContractHdr.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");
                SvcContractHdr.SetRange("Starting Date", 0D, SalesHeader."Order Date");
                SvcContractHdr.SetRange("Expiration Date", SalesHeader."Order Date", 99991231D);
                //SvcContractHdr.SetFilter("Starting Date", '<=%1', SalesHeader."Posting Date");
                //SvcContractHdr.SetFilter("Expiration Date", '>=%1', SalesHeader."Posting Date");
                if SvcContractHdr.Find('-') then begin
                    SvcMgtSetup.Get();
                    Rec.Validate("Line Discount %", SvcMgtSetup."Discount % for Parts Sale");
                end;
            end;
        end;
    end;
}


