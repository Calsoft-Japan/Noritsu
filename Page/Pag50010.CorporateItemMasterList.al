page 50010 "Corporate Item Master List"
{
    ApplicationArea = All;
    Caption = 'Corporate Item Master List';
    PageType = List;
    SourceTable = "Corporate Item Master";
    UsageCategory = Lists;
    CardPageID = "Corporate Item";
    Editable = false;
    //Permissions = tabledata "Sales Invoice Line" = RMD, tabledata "Sales Cr.Memo Line" = RMD;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Latest Item No."; Rec."Latest Item No.")
                {
                    ToolTip = 'Specifies the value of the Latest Item No. field.';
                }
                field("Price Group"; Rec."Price Group")
                {
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the value of the Price Group field.';
                }
                field("Pricing Structure"; Rec."Pricing Structure")
                {
                    ToolTip = 'Specifies the value of the Pricing Structure field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Part Type"; Rec."Part Type")
                {
                    ToolTip = 'Specifies the value of the Part Type field.';
                }
                field("Process Type"; Rec."Process Type")
                {
                    ToolTip = 'Specifies the value of the Process Type field.';
                }
                field("Model Type"; Rec."Model Type")
                {
                    ToolTip = 'Specifies the value of the Model Type field.';
                }
                field("HS Code"; Rec."HS Code")
                {
                    ToolTip = 'Specifies the value of the HS Code field.';
                }
                field("HS Sub Code"; Rec."HS Sub Code")
                {
                    ToolTip = 'Specifies the value of the HS Sub Code field.';
                }
                field(Specification; Rec.Specification)
                {
                    ToolTip = 'Specifies the value of the Specification field.';
                }
                field(Material; Rec.Material)
                {
                    ToolTip = 'Specifies the value of the Material field.';
                }
                field("Production Type"; Rec."Production Type")
                {
                    ToolTip = 'Specifies the value of the Production Type field.';
                }
                field("Major Group"; Rec."Major Group")
                {
                    ToolTip = 'Specifies the value of the Major Group field.';
                }
                field("Product Group"; Rec."Product Group")
                {
                    ToolTip = 'Specifies the value of the Product Group field.';
                }
                field("Series Group"; Rec."Series Group")
                {
                    ToolTip = 'Specifies the value of the Series Group field.';
                }
                field("Production Name"; Rec."Production Name")
                {
                    ToolTip = 'Specifies the value of the Production Name field.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ToolTip = 'Specifies the value of the Product Group Code field.';
                }
                field(QA; Rec.QA)
                {
                    ToolTip = 'Specifies the value of the QA field.';
                }
                field("Serialized Parts"; Rec."Serialized Parts")
                {
                    ToolTip = 'Specifies the value of the Serialized Parts field.';
                }
                field("With Serial No."; Rec."With Serial No.")
                {
                    ToolTip = 'Specifies the value of the With Serial No. field.';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ToolTip = 'Specifies the value of the Country Code field.';
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ToolTip = 'Specifies the value of the Registration Date field.';
                }
                field("Revision Date"; Rec."Revision Date")
                {
                    ToolTip = 'Specifies the value of the Revision Date field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateCorItemMaster)
            {
                Caption = 'Update Corporate Item Master';
                ApplicationArea = All;

                trigger OnAction()
                var
                    Import: Report "Update Corporate Item Master";
                begin
                    Import.Run();
                    CurrPage.Update();
                end;
            }

            action(CreateLocalItem)
            {
                Caption = 'Create as Local Item';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(CorporateItemMaster);
                    CorporateItemMaster.CreateAsLocalItem;
                end;
            }

            //Update Posting Date on Sales/Service Invoice/Cr.Memo Lines
            /*action(UpdateServiceLines)
            {
                Caption = 'Update Service';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SInvHeader: Record "Sales Invoice Header";
                    SInvLine: Record "Sales Invoice Line";
                    SCreHeader: Record "Sales Cr.Memo Header";
                    SCreLine: Record "Sales Cr.Memo Line";
                begin
                    SInvLine.Reset();
                    SInvLine.SetRange("Posting Date", 0D);
                    if SInvLine.Find('-') then begin
                        repeat
                            SInvHeader.Reset();
                            SInvHeader.Get(SInvLine."Document No.");
                            SInvLine."Posting Date" := SInvHeader."Posting Date";
                            SInvLine.Modify();
                        until SInvLine.Next() = 0;
                    end;

                    SCreLine.Reset();
                    SCreLine.SetRange("Posting Date", 0D);
                    if SCreLine.Find('-') then begin
                        repeat
                            SCreHeader.Reset();
                            SCreHeader.Get(SCreLine."Document No.");
                            SCreLine."Posting Date" := SCreHeader."Posting Date";
                            SCreLine.Modify();
                        until SCreLine.Next() = 0;
                    end;

                    Message('Sales Invoice & Credit Memo Done.');
                end;
            }*/
        }
    }

    trigger OnOpenPage()
    begin
        FilterMe();
    end;


    procedure FilterMe();
    var
        Counter1: Integer;
        Counter2: Integer;
    begin
        Rec.RESET;
        Rec.SETCURRENTKEY("Price Group", "Pricing Structure", "Item No.");

        GLsetup1.GET;
        Vendor1.RESET;
        Vendor1.SETCURRENTKEY(Vendor1."NKC Buyer Code", Vendor1."NKC Pricing Structure");

        Vendor1.SETFILTER(Vendor1."NKC Buyer Code", '<>%1', '');
        Vendor1.SETFILTER(Vendor1."NKC Pricing Structure", '<>%1', '');

        IF Vendor1.FIND('-') THEN BEGIN
            counter1 := 0;
            counter2 := 0;
            CurrencyCodeFilter := '';
            VendorCurrencyCode := '';
            PricingStructureFilter := '';

            IF GLsetup1."LCY Code" <> '' THEN BEGIN
                CurrencyCodeFilter := GLsetup1."LCY Code";
                counter1 += 1;
            END;

            REPEAT
                counter1 += 1;
                counter2 += 1;

                IF counter1 = 1 THEN BEGIN
                    IF Vendor1."Currency Code" <> '' THEN
                        VendorCurrencyCode := Vendor1."Currency Code"
                    ELSE
                        VendorCurrencyCode := GLsetup1."LCY Code";
                    CurrencyCodeFilter := VendorCurrencyCode;
                    PricingStructureFilter := Vendor1."NKC Pricing Structure";
                END ELSE BEGIN
                    IF Vendor1."Currency Code" <> '' THEN
                        VendorCurrencyCode := Vendor1."Currency Code"
                    ELSE
                        VendorCurrencyCode := GLsetup1."LCY Code";
                    CurrencyCodeFilter := CurrencyCodeFilter + '|' + VendorCurrencyCode;
                    PricingStructureFilter := PricingStructureFilter + '|' + Vendor1."NKC Pricing Structure";
                END;

                IF counter2 = 1 THEN
                    PricingStructureFilter := Vendor1."NKC Pricing Structure"
                ELSE
                    PricingStructureFilter := PricingStructureFilter + '|' + Vendor1."NKC Pricing Structure";

            UNTIL Vendor1.NEXT = 0;

            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Price Group", CurrencyCodeFilter);
            Rec.SETFILTER("Pricing Structure", PricingStructureFilter);
            Rec.FILTERGROUP(0);

        END ELSE BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Item No.", '');
            Rec.FILTERGROUP(0);
        END;

        //SETCURRENTKEY("Item No.","Price Group","Pricing Structure");
    end;

    VAR
        CorporateItemMaster: Record "Corporate Item Master";
        Vendor1: Record Vendor;
        CurrencyCodeFilter: Text[250];
        VendorCurrencyCode: Code[10];
        GLsetup1: Record "General Ledger Setup";
        PricingStructureFilter: Text[250];

}
