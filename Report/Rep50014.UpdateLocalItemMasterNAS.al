report 50014 "Update Local Item Master - NAS"
{
    ApplicationArea = All;
    Caption = 'Update Local Item Master - NAS';
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Corporate Item Master"; "Corporate Item Master")
        {
            DataItemTableView = SORTING("Revision Date") ORDER(Ascending);
            RequestFilterFields = "Revision Date";

            trigger OnPreDataItem()
            begin
                //PBCS01.18<<
                blnShowErr := FALSE;
                //PBCS01.18>>
                "Corporate Item Master".SETRANGE("Corporate Item Master"."Revision Date", TODAY());
            end;

            trigger OnAfterGetRecord()
            var
                recordCount: Integer;
                ItemLedgerEntry1: Record "Item Ledger Entry";
                canUpdate: Boolean;
                currCurrencyCode: Code[10];
                PriceLineNo: Integer;
            begin
                IF LocalItem2.GET("Corporate Item Master"."Item No.") THEN BEGIN

                    canUpdate := FALSE;

                    ItemLedgerEntry1.RESET;
                    ItemLedgerEntry1.SETRANGE(ItemLedgerEntry1."Item No.", LocalItem2."No.");
                    IF ItemLedgerEntry1.COUNT = 0 THEN
                        canUpdate := TRUE;
                    //PBCS01.18<<
                    IF canUpdate = TRUE THEN BEGIN
                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE(PurchaseLine."No.", LocalItem2."No.");
                        IF PurchaseLine.COUNT > 0 THEN
                            canUpdate := FALSE;
                    END;
                    IF ((canUpdate = FALSE) AND (blnShowErr = FALSE)) THEN BEGIN
                        IF LocalItem2."Item Category Code" <> "Corporate Item Master"."Item Category Code" THEN
                            blnShowErr := TRUE;
                        //PBCS01.19<<
                        //IF LocalItem2."Product Group Code" <> "Corporate Item Master"."Product Group Code" THEN
                        //  blnShowErr := TRUE;
                        //PBCS01.19>>
                        IF (((LocalItem2."Item Tracking Code" <> 'SERIAL') AND ("With Serial No." = TRUE)) OR
                           ((LocalItem2."Item Tracking Code" <> 'NONSERIAL') AND ("With Serial No." = FALSE))) THEN BEGIN
                            blnShowErr := TRUE;
                        END;
                        IF (((LocalItem2."Service Item Group" <> 'SERIAL') AND ("With Serial No." = TRUE)) OR
                           ((LocalItem2."Service Item Group" <> 'NONSERIAL') AND ("With Serial No." = FALSE))) THEN BEGIN
                            blnShowErr := TRUE;
                        END;
                    END;
                    //PBCS01.18>>
                    IF NOT ItemCategory.GET("Corporate Item Master"."Item Category Code") THEN BEGIN
                        ItemCategory.INIT;
                        ItemCategory.Code := "Corporate Item Master"."Item Category Code";
                        ItemCategory.INSERT;
                    END;

                    /* ==Comment out by Liuyang 11/1/2023
                    IF NOT ProductGroup.GET("Corporate Item Master"."Item Category Code", "Corporate Item Master"."Product Group Code") THEN BEGIN
                        ProductGroup.INIT;
                        ProductGroup.VALIDATE(ProductGroup."Item Category Code", "Corporate Item Master"."Item Category Code");
                        ProductGroup.Code := "Corporate Item Master"."Product Group Code";
                        ProductGroup.INSERT;
                    END;
                    */

                    IF NOT Country1.GET("Corporate Item Master"."Country Code") THEN BEGIN
                        Country1.INIT;
                        Country1.Code := "Corporate Item Master"."Country Code";
                        Country1.INSERT;
                    END;

                    IF canUpdate THEN BEGIN
                        IF LocalItem2."Item Category Code" <> "Corporate Item Master"."Item Category Code" THEN
                            LocalItem2.VALIDATE(LocalItem2."Item Category Code", "Corporate Item Master"."Item Category Code");
                    END;

                    /* ==Comment out by Liuyang 11/1/2023
                    //PBCS01.19<<
                    IF LocalItem2."Product Group Code" <> "Corporate Item Master"."Product Group Code" THEN
                        IF LocalItem2."Item Category Code" = "Corporate Item Master"."Item Category Code" THEN
                            LocalItem2.VALIDATE(LocalItem2."Product Group Code", "Corporate Item Master"."Product Group Code");
                    //PBCS01.19>>
                    */
                    IF LocalItem2."Latest Item No." <> "Corporate Item Master"."Latest Item No." THEN
                        LocalItem2."Latest Item No." := "Corporate Item Master"."Latest Item No.";



                    GCorporateItemMaster1.RESET;
                    GCorporateItemMaster1.SETCURRENTKEY(GCorporateItemMaster1."Item No.", GCorporateItemMaster1."Price Group",
                                                        GCorporateItemMaster1."Pricing Structure");
                    GCorporateItemMaster1.SETRANGE(GCorporateItemMaster1."Item No.", "Corporate Item Master"."Item No.");

                    IF GCorporateItemMaster1.FIND('-') THEN BEGIN
                        Vendor1.RESET;
                        Vendor1.SETCURRENTKEY(Vendor1."NKC Buyer Code", Vendor1."NKC Pricing Structure", Vendor1."Currency Code");
                        Vendor1.SETFILTER(Vendor1."NKC Buyer Code", '<>%1', '');
                        currCurrencyCode := '';
                        REPEAT
                            Vendor1.SETRANGE(Vendor1."NKC Pricing Structure", GCorporateItemMaster1."Pricing Structure");
                            currCurrencyCode := GCorporateItemMaster1."Price Group";
                            IF currCurrencyCode = GLSetup1."LCY Code" THEN
                                currCurrencyCode := '';
                            Vendor1.SETRANGE(Vendor1."Currency Code", currCurrencyCode);
                            IF Vendor1.FIND('-') THEN BEGIN
                                REPEAT
                                    /*IF NOT PurchasePrice.GET(GCorporateItemMaster1."Item No.", Vendor1."No.",
                                                             0D, currCurrencyCode, '',
                                                             'PCS', 0) THEN BEGIN
                                        PurchasePrice.INIT;
                                        PurchasePrice.VALIDATE(PurchasePrice."Item No.", GCorporateItemMaster1."Item No.");
                                        PurchasePrice.VALIDATE(PurchasePrice."Vendor No.", Vendor1."No.");
                                        PurchasePrice.VALIDATE(PurchasePrice."Unit of Measure Code", 'PCS');
                                        PurchasePrice.VALIDATE(PurchasePrice."Currency Code", currCurrencyCode);
                                        PurchasePrice.VALIDATE(PurchasePrice."Direct Unit Cost", GCorporateItemMaster1."Unit Price");
                                        PurchasePrice.INSERT;
                                    END ELSE BEGIN
                                        IF PurchasePrice."Direct Unit Cost" <> GCorporateItemMaster1."Unit Price" THEN BEGIN
                                            PurchasePrice."Direct Unit Cost" := GCorporateItemMaster1."Unit Price";
                                            PurchasePrice.MODIFY;
                                        END;
                                    END;*/

                                    PriceHeader.Reset();
                                    if PriceHeader.Get('P00001') then begin
                                        PriceLine.Reset();
                                        PriceLine.SetRange("Price List Code", PriceHeader.Code);
                                        if PriceLine.FindLast() then
                                            PriceLineNo := PriceLine."Line No." + 10000
                                        else
                                            PriceLineNo := 10000;

                                        PriceLine.Reset();
                                        PriceLine.SetRange("Price List Code", PriceHeader.Code);
                                        PriceLine.SetRange("Source Type", PriceLine."Source Type"::Vendor);
                                        PriceLine.SetRange("Source No.", Vendor1."No.");
                                        PriceLine.SetRange("Currency Code", currCurrencyCode);
                                        PriceLine.SetRange("Asset Type", PriceLine."Asset Type"::Item);
                                        PriceLine.SetRange("Asset No.", GCorporateItemMaster1."Item No.");
                                        PriceLine.SetRange("Unit of Measure Code", 'PCS');
                                        if PriceLine.FindFirst() then begin
                                            PriceLine."Direct Unit Cost" := GCorporateItemMaster1."Unit Price";
                                            PriceLine.Modify();
                                        end
                                        else begin
                                            PriceLine.Init();
                                            PriceLine.Validate("Price List Code", PriceHeader.Code);
                                            PriceLine.Validate("Price Type", PriceLine."Price Type"::Purchase);
                                            PriceLine."Line No." := PriceLineNo;
                                            PriceLine.Validate("Source Type", PriceLine."Source Type"::Vendor);
                                            PriceLine.Validate("Source No.", Vendor1."No.");
                                            PriceLine.Validate("Currency Code", currCurrencyCode);
                                            PriceLine.Validate("Asset Type", PriceLine."Asset Type"::Item);
                                            PriceLine.Validate("Asset No.", GCorporateItemMaster1."Item No.");
                                            PriceLine.Validate("Unit of Measure Code", 'PCS');
                                            PriceLine.Validate("Direct Unit Cost", GCorporateItemMaster1."Unit Price");
                                            PriceLine.Validate(Status, PriceLine.Status::Active);
                                            PriceLine.Insert();
                                        end;

                                    end;
                                UNTIL Vendor1.NEXT = 0;
                            END;
                        UNTIL GCorporateItemMaster1.NEXT = 0;
                    END;

                    IF LocalItem2."Part Type" <> "Corporate Item Master"."Part Type" THEN
                        LocalItem2."Part Type" := "Corporate Item Master"."Part Type";

                    IF LocalItem2."Process Type" <> "Corporate Item Master"."Process Type" THEN
                        LocalItem2."Process Type" := "Corporate Item Master"."Process Type";

                    IF LocalItem2."Model Type" <> "Corporate Item Master"."Model Type" THEN
                        LocalItem2."Model Type" := "Corporate Item Master"."Model Type";

                    IF LocalItem2."HS Code" <> "Corporate Item Master"."HS Code" THEN
                        LocalItem2."HS Code" := "Corporate Item Master"."HS Code";

                    IF LocalItem2."HS Sub Code" <> "Corporate Item Master"."HS Sub Code" THEN
                        LocalItem2."HS Sub Code" := "Corporate Item Master"."HS Sub Code";

                    IF LocalItem2.Specification <> "Corporate Item Master".Specification THEN
                        LocalItem2.Specification := "Corporate Item Master".Specification;

                    IF LocalItem2.Material <> "Corporate Item Master".Material THEN
                        LocalItem2.Material := "Corporate Item Master".Material;

                    IF LocalItem2."Production Type" <> "Corporate Item Master"."Production Type" THEN
                        LocalItem2."Production Type" := "Corporate Item Master"."Production Type";

                    IF LocalItem2."Major Group" <> "Corporate Item Master"."Major Group" THEN
                        LocalItem2."Major Group" := "Corporate Item Master"."Major Group";

                    //IF LocalItem2."Product Group" <> "Corporate Item Master"."Product Group" THEN Leon 5/9/2023 update Product Group from Product Group Code as request
                    //LocalItem2."Product Group" := "Corporate Item Master"."Product Group";
                    IF LocalItem2."Product Group" <> "Corporate Item Master"."Product Group Code" THEN
                        LocalItem2."Product Group" := "Corporate Item Master"."Product Group Code";

                    IF LocalItem2."Production Name" <> "Corporate Item Master"."Production Name" THEN
                        LocalItem2."Production Name" := "Corporate Item Master"."Production Name";

                    IF LocalItem2.QA <> "Corporate Item Master".QA THEN
                        LocalItem2.QA := "Corporate Item Master".QA;

                    IF LocalItem2."Serialized Parts" <> "Corporate Item Master"."Serialized Parts" THEN
                        LocalItem2."Serialized Parts" := "Corporate Item Master"."Serialized Parts";

                    IF LocalItem2."With Serial No." <> "Corporate Item Master"."With Serial No." THEN
                        LocalItem2."With Serial No." := "Corporate Item Master"."With Serial No.";

                    IF canUpdate THEN
                        IF "Corporate Item Master"."With Serial No." THEN BEGIN
                            LocalItem2.VALIDATE(LocalItem2."Item Tracking Code", 'SERIAL');
                            LocalItem2.VALIDATE(LocalItem2."Service Item Group", 'SERIAL');
                        END ELSE BEGIN
                            LocalItem2.VALIDATE(LocalItem2."Item Tracking Code", 'NONSERIAL');
                            LocalItem2.VALIDATE(LocalItem2."Service Item Group", 'NONSERIAL');
                        END;

                    IF LocalItem2."Country of Origin Code" <> "Corporate Item Master"."Country Code" THEN
                        LocalItem2.VALIDATE(LocalItem2."Country of Origin Code", "Corporate Item Master"."Country Code");
                    //IF LocalItem2."Country/Region of Origin Code" <> "Corporate Item Master"."Country Code" THEN
                    //    LocalItem2.VALIDATE(LocalItem2."Country/Region of Origin Code", "Corporate Item Master"."Country Code");

                    IF LocalItem2."Product Type" <> "Corporate Item Master"."Series Group" THEN
                        LocalItem2."Product Type" := "Corporate Item Master"."Series Group";

                    //LocalItem2.VALIDATE("Global Dimension 2 Code",'SALES');

                    LocalItem2.Reserve := LocalItem2.Reserve::Optional;
                    LocalItem2."Allow Invoice Disc." := TRUE;

                    LocalItem2.MODIFY;

                END;
            end;


            trigger OnPostDataItem()
            begin
                //PBCS01.18<<
                IF blnShowErr THEN BEGIN
                    //InsertErrorLog(1);
                    COMMIT;
                    ERROR(Text003);
                END;
                //PBCS01.18>>
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        GLSetup1.GET();
        InventorySetup.GET();
        InventorySetup.TESTFIELD(InventorySetup."HQ Vendor Code (Price Update)");

        Vendor.GET(InventorySetup."HQ Vendor Code (Price Update)");

        IF NOT ItemTracking.GET('SERIAL') THEN BEGIN
            ItemTracking.INIT;
            ItemTracking.Code := 'SERIAL';
            ItemTracking.Description := 'Serialized Item (Default for Serialized Item)';
            ItemTracking."SN Specific Tracking" := TRUE;
            ItemTracking."SN Info. Inbound Must Exist" := TRUE;
            ItemTracking."SN Info. Outbound Must Exist" := TRUE;
            ItemTracking."SN Warehouse Tracking" := TRUE;
            ItemTracking."SN Purchase Inbound Tracking" := TRUE;
            ItemTracking."SN Purchase Outbound Tracking" := TRUE;
            ItemTracking."SN Sales Inbound Tracking" := TRUE;
            ItemTracking."SN Sales Outbound Tracking" := TRUE;
            ItemTracking."SN Pos. Adjmt. Inb. Tracking" := TRUE;
            ItemTracking."SN Pos. Adjmt. Outb. Tracking" := TRUE;
            ItemTracking."SN Neg. Adjmt. Inb. Tracking" := TRUE;
            ItemTracking."SN Neg. Adjmt. Outb. Tracking" := TRUE;
            ItemTracking."SN Transfer Tracking" := TRUE;
            ItemTracking."SN Manuf. Inbound Tracking" := TRUE;
            ItemTracking."SN Manuf. Outbound Tracking" := TRUE;
            ItemTracking.INSERT;
        END;

        IF NOT ServiceItemGroup.GET('SERIAL') THEN BEGIN
            ServiceItemGroup.INIT;
            ServiceItemGroup.Code := 'SERIAL';
            ServiceItemGroup.Description := 'Serialized Item (Default for Serialized Item)';
            ServiceItemGroup."Create Service Item" := TRUE;
            ServiceItemGroup.INSERT;
        END;

        IF NOT ItemTracking.GET('NONSERIAL') THEN BEGIN
            ItemTracking.INIT;
            ItemTracking.Code := 'NONSERIAL';
            ItemTracking.Description := 'Non-Serialized Item (Default for Non-Serialized)';
            ItemTracking.INSERT;
        END;

        IF NOT ServiceItemGroup.GET('NONSERIAL') THEN BEGIN
            ServiceItemGroup.INIT;
            ServiceItemGroup.Code := 'NON SERIAL';
            ServiceItemGroup.Description := 'Non-Serialized Item (Default for Non-Serialized)';
            ServiceItemGroup.INSERT;
        END;
    end;

    /*
    PROCEDURE InsertErrorLog(ErrorNo: Integer);
    BEGIN
        EDIErrorLog.INIT;
        IF EDIErrorLog."Entry No." = 0 THEN BEGIN
            EDIErrorLog.LOCKTABLE;
            IF EDIErrorLog.FIND('+') THEN
                EDIErrorLog."Entry No." := EDIErrorLog."Entry No." + 1
            ELSE
                EDIErrorLog."Entry No." := 1;
            EDIErrorLog.Date := TODAY;
            EDIErrorLog.Time := TIME;
            EDIErrorLog."Object ID" := 50014;
            EDIErrorLog."Object Description" := 'Update Local Item Master - NAS';
            IF ErrorNo = 1 THEN
                EDIErrorLog."Message Text" := Text003;
            EDIErrorLog."Error Occurred" := TRUE;
            EDIErrorLog.INSERT;
            COMMIT;
        END;
    END;*/

    var
        LocalItem2: Record Item;
        Text001: Label 'Item already exists.';
        Text002: Label 'Update completed succesfully.';
        InventorySetup: Record "Inventory Setup";
        ItemCategory: Record "Item Category";
        //ProductGroup: Record "Product Group"; ==Comment out by Liuyang 11/1/2023
        Country1: Record "Country/Region";
        ItemTracking: Record "Item Tracking Code";
        ServiceItemGroup: Record "Service Item Group";
        //PurchasePrice: Record "Purchase Price";
        PriceHeader: Record "Price List Header";
        PriceLine: Record "Price List Line";
        Vendor: Record Vendor;
        Vendor1: Record Vendor;
        GCorporateItemMaster1: Record "Corporate Item Master";
        GLSetup1: Record "General Ledger Setup";
        //EDIErrorLog: Record 50004;
        Text003: Label 'There are some item can''t be updated, please check them by report.';
        blnShowErr: Boolean;
        PurchaseLine: Record "Purchase Line";
}
