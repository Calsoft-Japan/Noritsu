report 50011 "Create as Local Item"
{
    ApplicationArea = All;
    Caption = 'Create as Local Item';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    UseRequestPage = false;


    dataset
    {
        dataitem("Corporate Item Master"; "Corporate Item Master")
        {
            trigger OnPreDataItem()
            begin
                noOfErrors := 0;
            end;

            trigger OnAfterGetRecord()
            var
                currCurrencyCode: Code[10];
                PriceLineNo: Integer;
                ItemTemplate: Record "Item Templ.";
            begin

                IF "Corporate Item Master"."Unit Price" = 0 THEN BEGIN
                    MESSAGE(Text003, "Corporate Item Master"."Item No.");
                    noOfErrors += 1;
                    CurrReport.SKIP;
                END;


                IF NOT (LocalItem.GET("Corporate Item Master"."Item No.")) THEN BEGIN
                    LocalItem2.INIT;
                    LocalItem2."No." := "Corporate Item Master"."Item No.";
                    LocalItem2.INSERT;
                    LocalItem2.VALIDATE(LocalItem2.Description, "Corporate Item Master".Description);

                    IF NOT ItemCategory.GET("Corporate Item Master"."Item Category Code") THEN BEGIN
                        ItemCategory.INIT;
                        ItemCategory.Code := "Corporate Item Master"."Item Category Code";
                        ItemCategory.INSERT;
                        //noOfErrors += 1;
                    END;

                    /*==Comment out by Liuyang 11/1/2023
                    IF NOT ProductGroup.GET("Corporate Item Master"."Item Category Code", "Corporate Item Master"."Product Group Code") THEN BEGIN
                        ProductGroup.INIT;
                        ProductGroup.VALIDATE(ProductGroup."Item Category Code", "Corporate Item Master"."Item Category Code");
                        ProductGroup.Code := "Corporate Item Master"."Product Group Code";
                        ProductGroup.INSERT;
                        //noOfErrors += 1;
                    END;
                    */

                    IF NOT Country1.GET("Corporate Item Master"."Country Code") THEN BEGIN
                        Country1.INIT;
                        Country1.Code := "Corporate Item Master"."Country Code";
                        Country1.INSERT;
                        //noOfErrors += 1;
                    END;

                    ItemUnitOfMeasure.INIT;
                    ItemUnitOfMeasure.VALIDATE(ItemUnitOfMeasure."Item No.", "Corporate Item Master"."Item No.");
                    ItemUnitOfMeasure.VALIDATE(ItemUnitOfMeasure.Code, 'PCS');
                    ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
                    ItemUnitOfMeasure.INSERT;

                    LocalItem2.VALIDATE(LocalItem2."Base Unit of Measure", 'PCS');

                    LocalItem2.VALIDATE(LocalItem2."Item Category Code", "Corporate Item Master"."Item Category Code");

                    IF ("Corporate Item Master"."Item Category Code" = 'PARTS') AND (InventorySetup."Parts Item Disc. Group" <> '') THEN
                        LocalItem2.VALIDATE(LocalItem2."Item Disc. Group", InventorySetup."Parts Item Disc. Group");

                    //LocalItem2.VALIDATE(LocalItem2."Product Group Code", "Corporate Item Master"."Product Group Code"); ==Comment out by Liuyang 11/1/2023
                    LocalItem2."Latest Item No." := "Corporate Item Master"."Latest Item No.";

                    LocalItem2."Price Group" := "Corporate Item Master"."Price Group";
                    LocalItem2."Pricing Structure" := "Corporate Item Master"."Pricing Structure";
                    LocalItem2."HQ Unit Price" := "Corporate Item Master"."Unit Price";

                    /*
                    PurchasePrice.INIT;
                    PurchasePrice.VALIDATE(PurchasePrice."Item No.", "Corporate Item Master"."Item No.");
                    PurchasePrice.VALIDATE(PurchasePrice."Vendor No.", InventorySetup."HQ Vendor Code (Price Update)");
                    PurchasePrice.VALIDATE(PurchasePrice."Unit of Measure Code", 'PCS');
                    PurchasePrice.VALIDATE(PurchasePrice."Direct Unit Cost", "Corporate Item Master"."Unit Price");
                    PurchasePrice.INSERT;
                    */

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
                                    /*PurchasePrice.INIT;
                                    PurchasePrice.VALIDATE(PurchasePrice."Item No.", GCorporateItemMaster1."Item No.");
                                    PurchasePrice.VALIDATE(PurchasePrice."Vendor No.", Vendor1."No.");
                                    PurchasePrice.VALIDATE(PurchasePrice."Unit of Measure Code", 'PCS');
                                    PurchasePrice.VALIDATE(PurchasePrice."Currency Code", currCurrencyCode);
                                    PurchasePrice.VALIDATE(PurchasePrice."Direct Unit Cost", GCorporateItemMaster1."Unit Price");
                                    PurchasePrice.INSERT;*/

                                    PriceHeader.Reset();
                                    if PriceHeader.Get('P00001') then begin
                                        PriceLine.Reset();
                                        PriceLine.SetRange("Price List Code", PriceHeader.Code);
                                        if PriceLine.FindLast() then
                                            PriceLineNo := PriceLine."Line No." + 10000
                                        else
                                            PriceLineNo := 10000;

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

                                UNTIL Vendor1.NEXT = 0;
                            END;
                        UNTIL GCorporateItemMaster1.NEXT = 0;
                    END;

                    LocalItem2."Part Type" := "Corporate Item Master"."Part Type";
                    LocalItem2."Process Type" := "Corporate Item Master"."Process Type";
                    LocalItem2."Model Type" := "Corporate Item Master"."Model Type";
                    LocalItem2."HS Code" := "Corporate Item Master"."HS Code";
                    LocalItem2."HS Sub Code" := "Corporate Item Master"."HS Sub Code";
                    LocalItem2.Specification := "Corporate Item Master".Specification;
                    LocalItem2.Material := "Corporate Item Master".Material;
                    LocalItem2."Production Type" := "Corporate Item Master"."Production Type";
                    LocalItem2."Major Group" := "Corporate Item Master"."Major Group";
                    LocalItem2."Product Group" := "Corporate Item Master"."Product Group Code"; //"Corporate Item Master"."Product Group"; Leon 5/9/2023 update Product Group from Product Group Code as request
                    //LocalItem2."Series Group" := "Corporate Item Master"."Series Group";
                    LocalItem2."Production Name" := "Corporate Item Master"."Production Name";
                    LocalItem2.QA := "Corporate Item Master".QA;
                    LocalItem2."Serialized Parts" := "Corporate Item Master"."Serialized Parts";
                    LocalItem2."With Serial No." := "Corporate Item Master"."With Serial No.";

                    IF "Corporate Item Master"."With Serial No." THEN BEGIN
                        LocalItem2.VALIDATE(LocalItem2."Item Tracking Code", 'SERIAL');
                        LocalItem2.VALIDATE(LocalItem2."Service Item Group", 'SERIAL');
                    END ELSE BEGIN
                        LocalItem2.VALIDATE(LocalItem2."Item Tracking Code", 'NONSERIAL');
                        LocalItem2.VALIDATE(LocalItem2."Service Item Group", 'NONSERIAL');
                    END;

                    LocalItem2.VALIDATE(LocalItem2."Country of Origin Code", "Corporate Item Master"."Country Code");
                    //LocalItem2.VALIDATE(LocalItem2."Country/Region of Origin Code", "Corporate Item Master"."Country Code");
                    LocalItem2."Product Type" := "Corporate Item Master"."Series Group";

                    //LocalItem2.VALIDATE("Global Dimension 2 Code",'SALES');
                    LocalItem2.Reserve := LocalItem2.Reserve::Optional;
                    LocalItem2."Allow Invoice Disc." := TRUE;

                    ItemTemplate.Reset();
                    if ItemTemplate.Get("Corporate Item Master"."Item Category Code") then begin
                        LocalItem2.Validate("Gen. Prod. Posting Group", ItemTemplate."Gen. Prod. Posting Group");
                        LocalItem2.Validate("VAT Prod. Posting Group", ItemTemplate."VAT Prod. Posting Group");
                        LocalItem2.Validate("Inventory Posting Group", ItemTemplate."Inventory Posting Group");
                        LocalItem2.Validate("Costing Method", ItemTemplate."Costing Method");
                    end;

                    LocalItem2.MODIFY;
                END ELSE BEGIN
                    MESSAGE(Text004, "Corporate Item Master"."Item No.");
                    noOfErrors += 1;
                END;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE(STRSUBSTNO(Text002, noOfErrors));
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
        //InventorySetup.TESTFIELD(InventorySetup."HQ Vendor Code (Price Update)");

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

        IF NOT ItemTracking.GET('NONSERIAL') THEN BEGIN
            ItemTracking.INIT;
            ItemTracking.Code := 'NONSERIAL';
            ItemTracking.Description := 'Non-Serialized Item (Default for Non-Serialized)';
            ItemTracking.INSERT;
        END;

        IF NOT ServiceItemGroup.GET('NONSERIAL') THEN BEGIN
            ServiceItemGroup.INIT;
            ServiceItemGroup.Code := 'NONSERIAL';
            ServiceItemGroup.Description := 'Non-Serialized Item (Default for Non-Serialized)';
            ServiceItemGroup.INSERT;
        END;

        IF NOT ServiceItemGroup.GET('SERIAL') THEN BEGIN
            ServiceItemGroup.INIT;
            ServiceItemGroup.Code := 'SERIAL';
            ServiceItemGroup.Description := 'Serialized Item (Default for Serialized Item)';
            ServiceItemGroup."Create Service Item" := TRUE;
            ServiceItemGroup.INSERT;
        END;



        IF NOT UnitOfMeasure.GET('PCS') THEN BEGIN
            UnitOfMeasure.INIT;
            UnitOfMeasure.Code := 'PCS';
            UnitOfMeasure.Description := 'Pieces';
            UnitOfMeasure.INSERT;
        END;
    end;

    VAR
        LocalItem: Record Item;
        LocalItem2: Record Item;
        Text001: Label 'Item already exists.';
        Text002: Label 'Selected item(s) created as local item with %1 errors.';
        InventorySetup: Record "Inventory Setup";
        noOfErrors: Integer;
        ItemCategory: Record "Item Category";
        //ProductGroup: Record "Product Group"; ==Comment out by Liuyang 11/1/2023
        //PurchasePrice: Record "Purchase Price";
        PriceHeader: Record "Price List Header";
        PriceLine: Record "Price List Line";
        Country1: Record "Country/Region";
        ItemTracking: Record "Item Tracking Code";
        ServiceItemGroup: Record "Service Item Group";
        UnitOfMeasure: Record "Unit of Measure";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        Text003: Label '%1 : This item can not be copied because Unit Price is Zero.';
        Text004: Label '%1 : This item can not be copied because it had been already registered in your Item Cards.';
        Vendor1: Record Vendor;
        GCorporateItemMaster1: Record "Corporate Item Master";
        GLSetup1: Record "General Ledger Setup";
}
