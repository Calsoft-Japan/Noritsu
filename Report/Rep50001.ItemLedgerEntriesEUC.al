report 50001 "Item Ledger Entries (EUC)"
{
    ApplicationArea = All;
    Caption = 'Export Item Ledger Entries (EUC)';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutExcel;
    /*
      PBCS01.14 20080827 momoko_saito -Build Codeunit "Delete CRLF" in order to remove return code.
      PBCS01.16 20080917 fumitaka_tsukagoshi - Change DeleteLF.DeleteCRLFCode to DeleteLF.DeleteCRLFText
      PBCS01.23 20100331 KAKU - Add Function FindAppliedEntry() for modify "Quantity" and "Inventory Value (Calculated)"
    */

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Item No.", Positive, "Completely Invoiced", "Last Invoice Date", "Location Code", "Variant Code")
                          ORDER(Ascending)
                          WHERE( //"Source Type" = const("Source Type"::Vendor),
                            Positive = const(true),
                                "Completely Invoiced" = CONST(true));
            RequestFilterFields = "Item No.";
            column(EntryNo; "Entry No.")
            {
            }
            column(EntryType; "Entry Type")
            {
            }
            column(PostingDate; FORMAT("Posting Date", 0, '<year4><month,2><day,2>'))
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(ItemName; Item.Description)
            {
            }
            column(ItemCategoryCode; "Item Category Code")
            {
            }
            column(ProductGroupCode; ProductGroupCode)
            { }
            column(ProductType; ProductType)
            { }
            column(ModelType; ModelType)
            { }
            column(SerialNo; "Serial No.")
            {
            }
            column(PurchaseCost; PurchaseCost)
            { }
            column(UnitCostCalculated; UnitCostCalculated)
            { }
            column(InventoryValueCalculated; InventoryValueCalculated)
            { }
            column(WriteOffAmount; WriteOffAmount)
            { }
            column(UnitCostRevalued; UnitCostRevalued)
            { }
            column(InventoryValueRevalued; InventoryValueRevalued)
            { }
            column(Quantity; _Quantity)
            {
            }
            column(VendorNo; "Source No.")
            { }
            column(VendorName; Vendor.Name)
            { }
            column(GenBusPostingGroup; GenBusPostingGroup)
            { }
            column(DimensionValueAffiliates; DimensionValueAffiliates)
            { }
            column(DimensionValueCostCenter; DimensionValueCostCenter)
            { }
            column(LastReceiptDateText; LastReceiptDateText)
            { }
            column(LastShipmentDateText; LastShipmentDateText)
            { }
            column(AgeDay; AgeDay)
            { }
            column(AgeYear; AgeYear)
            { }
            column(LocationCode; "Location Code")
            {
            }
            trigger OnPreDataItem()
            begin
                "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Last Invoice Date", 0D, _PostingDate);
            end;

            trigger OnAfterGetRecord()
            var
                _GLSetup1: Record "General Ledger Setup";
                ItemApplnEntry: Record "Item Application Entry";
                ItemCat: Record "Item Category";
            begin
                //Vendor.Reset();
                //if not Vendor.Get("Item Ledger Entry"."Source No.") then CurrReport.Skip();
                //=====================================================================================================
                InitVariables;
                Clear(ProductGroupCode);

                Item.Reset();
                IF Item.GET("Item Ledger Entry"."Item No.") THEN BEGIN
                    ItemName := Item.Description;
                    ItemCategoryCode := Item."Item Category Code";

                    ItemCat.Reset();
                    //if ItemCat.Get(Item."Item Category Code") then
                    //    ProductGroupCode := ItemCat."Parent Category"; //Item."Product Group Code";
                    ProductGroupCode := Item."Product Group";

                    ProductType := Item."Product Type";
                    ModelType := FORMAT(Item."Model Type");
                END;

                EntryType := FORMAT("Item Ledger Entry"."Entry Type");

                IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Purchase THEN
                    IF PurchRcptHeader.GET("Item Ledger Entry"."Document No.") THEN BEGIN
                        VendorNo := PurchRcptHeader."Buy-from Vendor No.";
                        VendorName := PurchRcptHeader."Buy-from Vendor Name";
                        GenBusPostingGroup := PurchRcptHeader."Gen. Bus. Posting Group";
                    END;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY(ItemLedgerEntry."Item No.", ItemLedgerEntry."Serial No.",
                                              ItemLedgerEntry."Entry Type", ItemLedgerEntry."Posting Date");
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", "Item Ledger Entry"."Item No.");
                // 2006/01/13 PBC modification - add 1 line
                //   from specification change
                // add date filter to find last shipment date
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", 0D, _PostingDate);

                IF "Item Ledger Entry"."Serial No." <> '' THEN BEGIN

                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Serial No.", "Item Ledger Entry"."Serial No.");

                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                    IF ItemLedgerEntry.FIND('+') THEN
                        LastReceiptDate := ItemLedgerEntry."Posting Date";

                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
                    IF ItemLedgerEntry.FIND('+') THEN
                        LastReceiptDate2 := ItemLedgerEntry."Posting Date";

                    IF LastReceiptDate2 > LastReceiptDate THEN
                        LastReceiptDate := LastReceiptDate2;

                    //LastReceiptDate := "Item Ledger Entry"."Posting Date";
                    LastShipmentDate := 0D;
                END ELSE BEGIN
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                    IF ItemLedgerEntry.FIND('+') THEN
                        LastReceiptDate := ItemLedgerEntry."Posting Date";

                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
                    IF ItemLedgerEntry.FIND('+') THEN
                        LastReceiptDate2 := ItemLedgerEntry."Posting Date";

                    IF LastReceiptDate2 > LastReceiptDate THEN
                        LastReceiptDate := LastReceiptDate2;

                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                    IF ItemLedgerEntry.FIND('+') THEN
                        LastShipmentDate := ItemLedgerEntry."Posting Date";
                END;

                IF "Item Ledger Entry"."Serial No." <> '' THEN BEGIN
                    IF LastReceiptDate <> 0D THEN BEGIN
                        AgeDay := _PostingDate - LastReceiptDate;
                        AgeYear := ROUND(AgeDay / 365, 1, '<');
                    END;
                END ELSE BEGIN
                    IF LastShipmentDate <> 0D THEN BEGIN
                        AgeDay := _PostingDate - LastShipmentDate;
                        AgeYear := ROUND(AgeDay / 365, 1, '<');
                    END ELSE
                        IF LastReceiptDate <> 0D THEN BEGIN
                            AgeDay := _PostingDate - LastReceiptDate;
                            AgeYear := ROUND(AgeDay / 365, 1, '<');
                        END;
                END;

                LastReceiptDateText := FORMAT(LastReceiptDate, 0, '<year4><month,2><day,2>');
                LastShipmentDateText := FORMAT(LastShipmentDate, 0, '<year4><month,2><day,2>');

                //PBCS01.23 BEGIN
                IF "Item Ledger Entry".Correction = TRUE THEN BEGIN
                    ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Output Completely Invd. Date");
                    ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    IF ItemApplnEntry.FIND('-') THEN BEGIN
                        IF FindAppliedEntry(ItemApplnEntry."Outbound Item Entry No.") = FALSE THEN
                            CurrReport.SKIP;
                    END;
                END;
                //PBCS01.23 END                

                RemQty := CalculateRemQuantity("Item Ledger Entry"."Entry No.", _PostingDate);
                //RemQty := "Item Ledger Entry"."Invoiced Quantity";

                _Quantity := RemQty;

                //==========FDD013 move before the CalculateRemInvValue_New cuz it will use the _Quantity==========
                //IF ((_Quantity = 0) AND (InventoryValueCalculated = 0))
                IF (_Quantity = 0)
                OR ("Item Ledger Entry"."Invoiced Quantity" = 0) THEN
                    CurrReport.Skip;//CurrDataport.SKIP;

                PurchaseCost := CalculateRemInvValue("Item Ledger Entry"."Entry No.", "Item Ledger Entry".Quantity,
                                                     RemQty, _PostingDate, TRUE);

                //=====FDD013 Comment out previously logic=========
                //InventoryValueCalculated := CalculateRemInvValue("Item Ledger Entry"."Entry No.", "Item Ledger Entry".Quantity,
                //                                     RemQty, _PostingDate, FALSE);

                //======FDD013 New Formulation=========
                InventoryValueCalculated := CalculateRemInvValue_New("Item Ledger Entry"."Entry No.", "Item No.", _Quantity, _PostingDate, "Item Ledger Entry"."Serial No.");

                WriteOffAmount := PurchaseCost - InventoryValueCalculated;



                _GLSetup1.GET();
                UnitCostCalculated := ROUND(
                  InventoryValueCalculated / _Quantity, _GLSetup1."Unit-Amount Rounding Precision");

                DimensionValueAffiliates := "Item Ledger Entry"."Global Dimension 1 Code";
                DimensionValueCostCenter := "Item Ledger Entry"."Global Dimension 2 Code";

                LocationCode := "Item Ledger Entry"."Location Code";

                //PBCS01.14 <<
                /*ItemName := DelCRLF.DeleteCRLFText(ItemName, MAXSTRLEN(ItemName));
                ItemCategoryCode := DelCRLF.DeleteCRLFText(ItemCategoryCode, MAXSTRLEN(ItemCategoryCode));
                ProductGroupCode := DelCRLF.DeleteCRLFText(ProductGroupCode, MAXSTRLEN(ProductGroupCode));
                ProductType := DelCRLF.DeleteCRLFText(ProductType, MAXSTRLEN(ProductType));
                ModelType := DelCRLF.DeleteCRLFText(ModelType, MAXSTRLEN(ModelType));
                VendorNo := DelCRLF.DeleteCRLFText(VendorNo, MAXSTRLEN(VendorNo));
                VendorName := DelCRLF.DeleteCRLFText(VendorName, MAXSTRLEN(VendorName));
                GenBusPostingGroup := DelCRLF.DeleteCRLFText(GenBusPostingGroup, MAXSTRLEN(GenBusPostingGroup));*/
                //PBCS01.14 >>
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(AsOfDate)
                {
                    field(_PostingDate; _PostingDate)
                    {
                        Caption = 'As Of Date';
                        ApplicationArea = All;
                    }
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

    rendering
    {
        layout(LayoutExcel)
        {
            Type = Excel;
            LayoutFile = 'Item Ledger Entries (EUC).xlsx';
        }
    }

    PROCEDURE InitVariables();
    BEGIN

        ItemName := '';
        ItemCategoryCode := '';
        ProductGroupCode := '';
        ProductType := '';
        ModelType := '';
        PurchaseCost := 0;
        InventoryValueCalculated := 0;
        WriteOffAmount := 0;
        UnitCostRevalued := 0;
        InventoryValueRevalued := 0;
        _Quantity := 0;
        VendorNo := '';
        VendorName := '';
        GenBusPostingGroup := '';
        LastReceiptDate := 0D;
        LastReceiptDate2 := 0D;
        LastShipmentDate := 0D;
        AgeDay := 0;
        AgeYear := 0;
        ValQty := 0;
    END;

    PROCEDURE CalculateRemQuantity(ItemLedgEntryNo: Integer; PostingDate: Date): Decimal;
    VAR
        ItemApplnEntry: Record "Item Application Entry";
    BEGIN
        //WITH ItemApplnEntry DO BEGIN
        ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Output Completely Invd. Date");
        ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgEntryNo);
        ItemApplnEntry.SETFILTER("Output Completely Invd. Date", '>%1&<=%2', 0D, PostingDate);
        ItemApplnEntry.CALCSUMS(Quantity);
        EXIT(ItemApplnEntry.Quantity);
        //END;
    END;

    PROCEDURE CalculateRemInvValue(ItemLedgEntryNo: Integer; ItemLedgEntryQty: Decimal; RemQty: Decimal; PostingDate: Date; DirectCostOnly: Boolean): Decimal;
    VAR
        ValueEntry: Record "Value Entry";
        AdjustedCost: Decimal;
        AdjustedCost2: Decimal;
        ItemApplnEntry2: Record "Item Application Entry";
        ItemApplnEntry3: Record "Item Application Entry" temporary;
    BEGIN
        AdjustedCost := 0;
        AdjustedCost2 := 0;
        ItemApplnEntry2.SETCURRENTKEY(ItemApplnEntry2."Inbound Item Entry No.",
                                      ItemApplnEntry2."Output Completely Invd. Date");
        ItemApplnEntry2.SETRANGE(ItemApplnEntry2."Inbound Item Entry No.", ItemLedgEntryNo);
        ItemApplnEntry2.SETFILTER(ItemApplnEntry2."Output Completely Invd. Date", '>%1&<=%2', 0D, PostingDate);

        IF ItemApplnEntry2.FIND('-') THEN
            REPEAT
                IF ItemApplnEntry2.Quantity > 0 THEN BEGIN
                    //WITH ValueEntry DO BEGIN
                    ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Expected Cost");
                    ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntryNo);
                    ValueEntry.SETRANGE("Expected Cost", FALSE);
                    ValueEntry.SETRANGE("Posting Date", 0D, PostingDate);
                    IF DirectCostOnly = TRUE THEN
                        //SETRANGE("Entry Type","Entry Type"::"Direct Cost");
                        ValueEntry.SETFILTER("Entry Type", '%1|%2', ValueEntry."Entry Type"::"Direct Cost", ValueEntry."Entry Type"::Rounding);
                    IF ValueEntry.FIND('-') THEN
                        REPEAT
                            AdjustedCost := AdjustedCost + ValueEntry."Cost Amount (Actual)";
                        UNTIL ValueEntry.NEXT = 0;
                    //END;
                    AdjustedCost2 := AdjustedCost;
                    ValQty := ItemApplnEntry2.Quantity;
                END ELSE BEGIN
                    ItemApplnEntry3.TRANSFERFIELDS(ItemApplnEntry2);
                    ItemApplnEntry3.INSERT;
                END;
            UNTIL ItemApplnEntry2.NEXT = 0;

        IF ValQty <> 0 THEN
            IF ItemApplnEntry3.FIND('-') THEN
                REPEAT
                    AdjustedCost := AdjustedCost +
                    ROUND(ItemApplnEntry3.Quantity * (AdjustedCost2 / ValQty), _GLSetup1."Unit-Amount Rounding Precision");
                UNTIL ItemApplnEntry3.NEXT = 0;

        EXIT(AdjustedCost);
    END;

    PROCEDURE FindAppliedEntry(ItemLedgEntryNo: Integer): Boolean;
    VAR
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemApplnEntry: Record "Item Application Entry";
        Result: Boolean;
    BEGIN
        //PBCS01.23 BEGIN

        ItemLedgEntry.GET(ItemLedgEntryNo);
        Result := FALSE;
        //WITH ItemLedgEntry DO BEGIN
        IF ItemLedgEntry.Positive THEN BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Inbound Item Entry No.", "Cost Application", "Outbound Item Entry No.");
            ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Cost Application", TRUE);
            ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
            IF ItemApplnEntry.FIND('-') THEN
                Result := TRUE;
        END ELSE BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Cost Application", TRUE);
            IF ItemApplnEntry.FIND('-') THEN
                Result := TRUE;
        END;
        //END;
        EXIT(Result);

        //PBCS01.23 END
    END;

    //=====FDD013 UPDATE set Inventory Value (Calculate)===================================================

    PROCEDURE CalculateRemInvValue_New(ItemLedgEntryNo: Integer; ItemNo: Code[20]; _Quantity: Decimal; PostingDate: Date; SerialNo: Code[50]): Decimal;
    VAR
        ValueEntry: Record "Value Entry";
        RemQty: Decimal;
        AdjustedCost: Decimal;
    BEGIN
        AdjustedCost := 0;
        RemQty := 0;

        IF SerialNo <> '' THEN BEGIN
            ValueEntry.Reset();
            ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
            ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgEntryNo);
            ValueEntry.SETRANGE("Posting Date", 0D, PostingDate);
            IF ValueEntry.FIND('-') THEN
                REPEAT
                    AdjustedCost := AdjustedCost + ValueEntry."Cost Amount (Actual)";
                UNTIL ValueEntry.NEXT = 0;
        END ELSE BEGIN
            ValueEntry.Reset();
            ValueEntry.SETCURRENTKEY("Item No.");
            ValueEntry.SetRange("Item No.", ItemNo);
            ValueEntry.SETRANGE("Posting Date", 0D, PostingDate);
            IF ValueEntry.FIND('-') THEN
                REPEAT
                    AdjustedCost := AdjustedCost + ValueEntry."Cost Amount (Actual)";
                    RemQty := RemQty + ValueEntry."Item Ledger Entry Quantity";
                UNTIL ValueEntry.NEXT = 0;

            IF RemQty > 0 THEN
                AdjustedCost := ROUND(AdjustedCost * _Quantity / RemQty, 0.01);
        END;

        EXIT(AdjustedCost);
    END;
    //======FDD013 UPDATE set Inventory Value (Calculate)==================================================

    var
        Vendor: Record Vendor;
        //=======================================
        _GLSetup1: Record "General Ledger Setup";
        EntryType: Text[30];
        ItemName: Text[50];
        PurchaseCost: Decimal;
        InventoryValueCalculated: Decimal;
        WriteOffAmount: Decimal;
        VendorNo: Code[20];
        VendorName: Text[50];
        LastReceiptDate: Date;
        LastShipmentDate: Date;
        AgeDay: Integer;
        AgeYear: Integer;
        Item: Record Item;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        ItemLedgerEntry: Record "Item Ledger Entry";
        LastReceiptDateText: Text[30];
        LastShipmentDateText: Text[30];
        LastReceiptDate2: Date;
        ItemCategoryCode: Code[10];
        ProductGroupCode: Code[10];
        ProductType: Code[10];
        ModelType: Text[50];
        UnitCostRevalued: Decimal;
        InventoryValueRevalued: Decimal;
        GenBusPostingGroup: Code[10];
        _Quantity: Decimal;
        _PostingDate: Date;
        txtFileName: Text[250];
        RemQty: Decimal;
        DimensionValueAffiliates: Code[20];
        DimensionValueCostCenter: Code[20];
        UnitCostCalculated: Decimal;
        LocationCode: Code[10];
        ValQty: Decimal;
    //DelCRLF: Codeunit 50020;

}
