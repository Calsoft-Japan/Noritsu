report 50100 "Tax Ana. by Tax Period"
{
    ApplicationArea = All;
    Caption = 'Tax Ana. by Tax Period';
    UsageCategory = ReportsAndAnalysis;
    Permissions = tabledata 254 = RM;
    RDLCLayout = '.\RDLC\TaxAnaByTaxPeriod.RDLC';

    dataset
    {
        //Column "VAT Identifier" is temporary added for FDD010. File name:Tab-Ext50100.VATEnteyExtTemp.al === Leon 12/17/2022 ===
        dataitem("VAT Entry"; "VAT Entry")
        {
            RequestFilterFields = "Type", "Country/Region Code", "VAT Identifier", "Posting Date";
            DataItemTableView = SORTING("Type", "Country/Region Code", "VAT Identifier", "Posting Date", "Document Type", "Document No.") ORDER(Ascending);

            /*
                        ReqFilterFields =Type,Country Code,VAT Identifier,Posting Date;
                        TotalFields =Base,Amount;
                        GroupTotalFields =Type,Country Code,VAT Identifier,Document No.;*/

            column(CompanyName; CompanyInformation.Name)
            { }
            column(TaxPeriod; TaxPeriod)
            { }
            column(CountryRegionCode; "Country/Region Code")
            {
            }
            column(CountryName; CountryName)
            { }
            column(VATIdentifier; "VAT Identifier")//VATPostingSetup."VAT Identifier")
            { }
            column(PostingDate; "Posting Date")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(BilltoPaytoNo; "Bill-to/Pay-to No.")
            {
            }
            column(CurrencyCode; CurrencyCode)
            { }
            column(Base; Base)
            {
            }
            column(Amount; Amount)
            {
            }
            column(NetAmountInFCY; NetAmountInFCY)
            { }
            column(TaxAmountInFCY; TaxAmountInFCY)
            { }

            column(TotalCaption; TotalCaption) { }

            trigger OnPreDataItem()
            begin

                IF "VAT Entry".GETFILTER("VAT Entry".Type) = '' THEN
                    ERROR(Text015);

                TaxPeriod := STRSUBSTNO(Text003, "VAT Entry".GETFILTERS);

                FirstGroupHeader := TRUE;

                //CurrReport.CREATETOTALS(NetAmountInFCY, TaxAmountInFCY); Leon 1/27/2023==This method is not supported on client report definition (RDLC) report layouts. 

                InventoryPostingGroup.RESET;

                IF "VAT Entry".GETFILTER("VAT Entry".Type).ToUpper() = 'SALE' THEN
                    TotalCaption := 'Total Sale'
                else if "VAT Entry".GETFILTER("VAT Entry".Type).ToUpper() = 'PURCHASE' THEN
                    TotalCaption := 'Total Purchase';
            end;


            trigger OnAfterGetRecord()
            VAR
                tmpVATAmount: Decimal;
                SalesInvoiceHeader: Record "Sales Invoice Header";
                SalesInvoiceLine: Record "Sales Invoice Line";
                SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                SalesCrMemoLine: Record "Sales Cr.Memo Line";
                ServiceInvoiceHeader: Record "Service Invoice Header";
                ServiceInvoiceLine: Record "Service Invoice Line";
                ServiceCrMemoHeader: Record "Service Cr.Memo Header";
                ServiceCrMemoLine: Record "Service Cr.Memo Line";
                PurchInvHeader: Record "Purch. Inv. Header";
                PurchInvLine: Record "Purch. Inv. Line";
                PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                PurchCrMemoLine: Record "Purch. Cr. Memo Line";
                CustAmount: Decimal;
                AmountInclVAT: Decimal;
                VATPostingSetup: Record "VAT Posting Setup";
            BEGIN
                VATPostingSetup.Reset();
                if VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then;

                IF Country.GET("VAT Entry"."Country/Region Code") THEN
                    CountryName := Country.Name
                ELSE
                    CountryName := '';

                CurrencyCode := '';
                NetAmountInFCY := "VAT Entry".Base;
                TaxAmountInFCY := "VAT Entry".Amount;

                CustAmount := 0;
                AmountInclVAT := 0;

                IsEquivalent := FALSE;

                IF "VAT Entry".Type = "VAT Entry".Type::Sale THEN BEGIN
                    IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::Invoice THEN BEGIN
                        IF "VAT Entry"."Source Code" = 'SALES' THEN BEGIN
                            IF SalesInvoiceHeader.GET("VAT Entry"."Document No.") THEN BEGIN
                                CurrencyCode := SalesInvoiceHeader."Currency Code";
                                SalesInvoiceLine.RESET;
                                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
                                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Gen. Bus. Posting Group", "VAT Entry"."Gen. Bus. Posting Group");
                                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Gen. Prod. Posting Group", "VAT Entry"."Gen. Prod. Posting Group");
                                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."VAT Bus. Posting Group", "VAT Entry"."VAT Bus. Posting Group");
                                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");

                                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Posting Group", '');
                                IF SalesInvoiceLine.FIND('-') THEN
                                    REPEAT
                                        CustAmount := CustAmount + SalesInvoiceLine."VAT Base Amount";
                                        AmountInclVAT := AmountInclVAT + SalesInvoiceLine."Amount Including VAT";
                                    UNTIL SalesInvoiceLine.NEXT = 0;
                                IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                    IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                        IsEquivalent := TRUE;
                                END ELSE BEGIN
                                    //        IF (ABS(ROUND(CustAmount/SalesInvoiceHeader."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                    IF ABS(ROUND(CustAmount / SalesInvoiceHeader."Currency Factor", 1, '<')) =
                                    ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                        IsEquivalent := TRUE;
                                END;
                                IF IsEquivalent = FALSE THEN BEGIN
                                    IF InventoryPostingGroup.FIND('-') THEN BEGIN
                                        IsEquivalent := FALSE;
                                        REPEAT
                                            //            CustAmount := 0;                                                                               //2007.08.22 NKC1.01
                                            //            AmountInclVAT := 0;                                                                            //2007.08.22 NKC1.01
                                            SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Posting Group", InventoryPostingGroup.Code);
                                            IF SalesInvoiceLine.FIND('-') THEN
                                                REPEAT
                                                    CustAmount := CustAmount + SalesInvoiceLine."VAT Base Amount";
                                                    AmountInclVAT := AmountInclVAT + SalesInvoiceLine."Amount Including VAT";
                                                UNTIL SalesInvoiceLine.NEXT = 0;
                                            IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                                IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                                    IsEquivalent := TRUE;
                                            END ELSE BEGIN
                                                //            IF (ABS(ROUND(CustAmount/SalesInvoiceHeader."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                                IF ABS(ROUND(CustAmount / SalesInvoiceHeader."Currency Factor", 1, '<')) =
                                                ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                                    IsEquivalent := TRUE;
                                            END;
                                        UNTIL (InventoryPostingGroup.NEXT = 0) OR (IsEquivalent = TRUE);
                                    END;
                                END;

                                IF "VAT Entry".Base > 0 THEN BEGIN    // VAT Entry for sales line discount 
                                    NetAmountInFCY := 0;
                                    TaxAmountInFCY := 0;
                                END ELSE BEGIN
                                    NetAmountInFCY := -CustAmount;                                                                         //2007.08.23 NKC1.02
                                    TaxAmountInFCY := -(AmountInclVAT - CustAmount);                                                       //2007.08.23 NKC1.02
                                END;
                            END;
                        END
                        ELSE
                            IF "VAT Entry"."Source Code" = 'SERVICE' THEN BEGIN
                                IF ServiceInvoiceHeader.GET("VAT Entry"."Document No.") THEN BEGIN
                                    CurrencyCode := ServiceInvoiceHeader."Currency Code";
                                    ServiceInvoiceLine.RESET;
                                    ServiceInvoiceLine.SETRANGE(ServiceInvoiceLine."Document No.", ServiceInvoiceHeader."No.");
                                    ServiceInvoiceLine.SETRANGE(ServiceInvoiceLine."Gen. Bus. Posting Group", "VAT Entry"."Gen. Bus. Posting Group");
                                    ServiceInvoiceLine.SETRANGE(ServiceInvoiceLine."Gen. Prod. Posting Group", "VAT Entry"."Gen. Prod. Posting Group");
                                    ServiceInvoiceLine.SETRANGE(ServiceInvoiceLine."VAT Bus. Posting Group", "VAT Entry"."VAT Bus. Posting Group");
                                    ServiceInvoiceLine.SETRANGE(ServiceInvoiceLine."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");

                                    ServiceInvoiceLine.SETRANGE(ServiceInvoiceLine."Posting Group", '');
                                    IF ServiceInvoiceLine.FIND('-') THEN
                                        REPEAT
                                            CustAmount := CustAmount + ServiceInvoiceLine."VAT Base Amount";
                                            AmountInclVAT := AmountInclVAT + ServiceInvoiceLine."Amount Including VAT";
                                        UNTIL ServiceInvoiceLine.NEXT = 0;
                                    IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                        IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                            IsEquivalent := TRUE;
                                    END ELSE BEGIN
                                        //        IF (ABS(ROUND(CustAmount/ServiceInvoiceHeader."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                        IF ABS(ROUND(CustAmount / ServiceInvoiceHeader."Currency Factor", 1, '<')) =
                                        ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                            IsEquivalent := TRUE;
                                    END;
                                    IF IsEquivalent = FALSE THEN BEGIN
                                        IF InventoryPostingGroup.FIND('-') THEN BEGIN
                                            IsEquivalent := FALSE;
                                            REPEAT
                                                //            CustAmount := 0;                                                                               //2007.08.22 NKC1.01
                                                //            AmountInclVAT := 0;                                                                            //2007.08.22 NKC1.01
                                                ServiceInvoiceLine.SETRANGE(ServiceInvoiceLine."Posting Group", InventoryPostingGroup.Code);
                                                IF ServiceInvoiceLine.FIND('-') THEN
                                                    REPEAT
                                                        CustAmount := CustAmount + ServiceInvoiceLine."VAT Base Amount";
                                                        AmountInclVAT := AmountInclVAT + ServiceInvoiceLine."Amount Including VAT";
                                                    UNTIL ServiceInvoiceLine.NEXT = 0;
                                                IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                                    IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                                        IsEquivalent := TRUE;
                                                END ELSE BEGIN
                                                    //            IF (ABS(ROUND(CustAmount/ServiceInvoiceHeader."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                                    IF ABS(ROUND(CustAmount / ServiceInvoiceHeader."Currency Factor", 1, '<')) =
                                                    ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                                        IsEquivalent := TRUE;
                                                END;
                                            UNTIL (InventoryPostingGroup.NEXT = 0) OR (IsEquivalent = TRUE);
                                        END;
                                    END;

                                    IF "VAT Entry".Base > 0 THEN BEGIN    // VAT Entry for sales line discount 
                                        NetAmountInFCY := 0;
                                        TaxAmountInFCY := 0;
                                    END ELSE BEGIN
                                        NetAmountInFCY := -CustAmount;                                                                         //2007.08.23 NKC1.02
                                        TaxAmountInFCY := -(AmountInclVAT - CustAmount);                                                       //2007.08.23 NKC1.02
                                    END;
                                    //NetAmountInFCY := -CustAmount;                                                                         //2007.08.23 NKC1.02
                                    //TaxAmountInFCY := -(AmountInclVAT - CustAmount);                                                       //2007.08.23 NKC1.02

                                END;
                            END;
                    END
                    ELSE
                        IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::"Credit Memo" THEN BEGIN
                            IF "VAT Entry"."Source Code" = 'SALES' THEN BEGIN
                                IF SalesCrMemoHeader.GET("VAT Entry"."Document No.") THEN BEGIN
                                    CurrencyCode := SalesCrMemoHeader."Currency Code";
                                    SalesCrMemoLine.RESET;
                                    SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Document No.", SalesCrMemoHeader."No.");
                                    SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Gen. Bus. Posting Group", "VAT Entry"."Gen. Bus. Posting Group");
                                    SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Gen. Prod. Posting Group", "VAT Entry"."Gen. Prod. Posting Group");
                                    SalesCrMemoLine.SETRANGE(SalesCrMemoLine."VAT Bus. Posting Group", "VAT Entry"."VAT Bus. Posting Group");
                                    SalesCrMemoLine.SETRANGE(SalesCrMemoLine."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");

                                    SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Posting Group", '');
                                    IF SalesCrMemoLine.FIND('-') THEN
                                        REPEAT
                                            CustAmount := CustAmount + SalesCrMemoLine."VAT Base Amount";
                                            AmountInclVAT := AmountInclVAT + SalesCrMemoLine."Amount Including VAT";
                                        UNTIL SalesCrMemoLine.NEXT = 0;
                                    IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                        IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                            IsEquivalent := TRUE;
                                    END ELSE BEGIN
                                        //        IF (ABS(ROUND(CustAmount/SalesCrMemoHeader."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                        IF ABS(ROUND(CustAmount / SalesCrMemoHeader."Currency Factor", 1, '<')) =
                                          ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                            IsEquivalent := TRUE;
                                    END;

                                    IF IsEquivalent = FALSE THEN BEGIN
                                        IF InventoryPostingGroup.FIND('-') THEN BEGIN
                                            IsEquivalent := FALSE;
                                            REPEAT
                                                //            CustAmount := 0;                                                                               //2007.08.22 NKC1.01
                                                //            AmountInclVAT := 0;                                                                            //2007.08.22 NKC1.01
                                                SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Posting Group", InventoryPostingGroup.Code);
                                                IF SalesCrMemoLine.FIND('-') THEN
                                                    REPEAT
                                                        CustAmount := CustAmount + SalesCrMemoLine."VAT Base Amount";
                                                        AmountInclVAT := AmountInclVAT + SalesCrMemoLine."Amount Including VAT";
                                                    UNTIL SalesCrMemoLine.NEXT = 0;
                                                IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                                    IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                                        IsEquivalent := TRUE;
                                                END ELSE BEGIN
                                                    //              IF (ABS(ROUND(CustAmount/SalesCrMemoHeader."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                                    IF ABS(ROUND(CustAmount / SalesCrMemoHeader."Currency Factor", 1, '<')) =
                                                      ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                                        IsEquivalent := TRUE;
                                                END;
                                            UNTIL (InventoryPostingGroup.NEXT = 0) OR (IsEquivalent = TRUE);
                                        END;
                                    END;

                                    NetAmountInFCY := CustAmount;
                                    TaxAmountInFCY := AmountInclVAT - CustAmount;

                                END;
                            END
                            ELSE
                                IF "VAT Entry"."Source Code" = 'SERVICE' THEN BEGIN
                                    IF ServiceCrMemoHeader.GET("VAT Entry"."Document No.") THEN BEGIN
                                        CurrencyCode := ServiceCrMemoHeader."Currency Code";
                                        ServiceCrMemoLine.RESET;
                                        ServiceCrMemoLine.SETRANGE(ServiceCrMemoLine."Document No.", ServiceCrMemoHeader."No.");
                                        ServiceCrMemoLine.SETRANGE(ServiceCrMemoLine."Gen. Bus. Posting Group", "VAT Entry"."Gen. Bus. Posting Group");
                                        ServiceCrMemoLine.SETRANGE(ServiceCrMemoLine."Gen. Prod. Posting Group", "VAT Entry"."Gen. Prod. Posting Group");
                                        ServiceCrMemoLine.SETRANGE(ServiceCrMemoLine."VAT Bus. Posting Group", "VAT Entry"."VAT Bus. Posting Group");
                                        ServiceCrMemoLine.SETRANGE(ServiceCrMemoLine."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");

                                        ServiceCrMemoLine.SETRANGE(ServiceCrMemoLine."Posting Group", '');
                                        IF ServiceCrMemoLine.FIND('-') THEN
                                            REPEAT
                                                CustAmount := CustAmount + ServiceCrMemoLine."VAT Base Amount";
                                                AmountInclVAT := AmountInclVAT + ServiceCrMemoLine."Amount Including VAT";
                                            UNTIL ServiceCrMemoLine.NEXT = 0;
                                        IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                            IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                                IsEquivalent := TRUE;
                                        END ELSE BEGIN
                                            //        IF (ABS(ROUND(CustAmount/ServiceCrMemoHeader."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                            IF ABS(ROUND(CustAmount / ServiceCrMemoHeader."Currency Factor", 1, '<')) =
                                              ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                                IsEquivalent := TRUE;
                                        END;

                                        IF IsEquivalent = FALSE THEN BEGIN
                                            IF InventoryPostingGroup.FIND('-') THEN BEGIN
                                                IsEquivalent := FALSE;
                                                REPEAT
                                                    //            CustAmount := 0;                                                                               //2007.08.22 NKC1.01
                                                    //            AmountInclVAT := 0;                                                                            //2007.08.22 NKC1.01
                                                    ServiceCrMemoLine.SETRANGE(ServiceCrMemoLine."Posting Group", InventoryPostingGroup.Code);
                                                    IF ServiceCrMemoLine.FIND('-') THEN
                                                        REPEAT
                                                            CustAmount := CustAmount + ServiceCrMemoLine."VAT Base Amount";
                                                            AmountInclVAT := AmountInclVAT + ServiceCrMemoLine."Amount Including VAT";
                                                        UNTIL ServiceCrMemoLine.NEXT = 0;
                                                    IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                                        IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                                            IsEquivalent := TRUE;
                                                    END ELSE BEGIN
                                                        //              IF (ABS(ROUND(CustAmount/ServiceCrMemoHeader."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                                        IF ABS(ROUND(CustAmount / ServiceCrMemoHeader."Currency Factor", 1, '<')) =
                                                          ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                                            IsEquivalent := TRUE;
                                                    END;
                                                UNTIL (InventoryPostingGroup.NEXT = 0) OR (IsEquivalent = TRUE);
                                            END;
                                        END;

                                        NetAmountInFCY := CustAmount;
                                        TaxAmountInFCY := AmountInclVAT - CustAmount;

                                    END;
                                END;
                        END;
                END ELSE
                    IF "VAT Entry".Type = "VAT Entry".Type::Purchase THEN BEGIN
                        IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::Invoice THEN BEGIN
                            IF PurchInvHeader.GET("VAT Entry"."Document No.") THEN BEGIN
                                CurrencyCode := PurchInvHeader."Currency Code";
                                PurchInvLine.RESET;
                                PurchInvLine.SETRANGE(PurchInvLine."Document No.", PurchInvHeader."No.");
                                PurchInvLine.SETRANGE(PurchInvLine."Gen. Bus. Posting Group", "VAT Entry"."Gen. Bus. Posting Group");
                                PurchInvLine.SETRANGE(PurchInvLine."Gen. Prod. Posting Group", "VAT Entry"."Gen. Prod. Posting Group");
                                PurchInvLine.SETRANGE(PurchInvLine."VAT Bus. Posting Group", "VAT Entry"."VAT Bus. Posting Group");
                                PurchInvLine.SETRANGE(PurchInvLine."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");

                                PurchInvLine.SETRANGE(PurchInvLine."Posting Group", '');
                                IF PurchInvLine.FIND('-') THEN
                                    REPEAT
                                        CustAmount := CustAmount + PurchInvLine."VAT Base Amount";
                                        AmountInclVAT := AmountInclVAT + PurchInvLine."Amount Including VAT";
                                    UNTIL PurchInvLine.NEXT = 0;
                                IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                    IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                        IsEquivalent := TRUE;
                                END ELSE BEGIN
                                    //        IF (ABS(ROUND(CustAmount/PurchInvHeader."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                    IF ABS(ROUND(CustAmount / PurchInvHeader."Currency Factor", 1, '<')) =
                                      ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                        IsEquivalent := TRUE;
                                END;

                                IF IsEquivalent = FALSE THEN BEGIN
                                    IF InventoryPostingGroup.FIND('-') THEN BEGIN
                                        IsEquivalent := FALSE;
                                        REPEAT
                                            //            CustAmount := 0;                                                                                 //2007.08.22 NKC1.01
                                            //            AmountInclVAT := 0;                                                                              //2007.08.22 NKC1.01
                                            PurchInvLine.SETRANGE(PurchInvLine."Posting Group", InventoryPostingGroup.Code);
                                            IF PurchInvLine.FIND('-') THEN
                                                REPEAT
                                                    CustAmount := CustAmount + PurchInvLine."VAT Base Amount";
                                                    AmountInclVAT := AmountInclVAT + PurchInvLine."Amount Including VAT";
                                                UNTIL PurchInvLine.NEXT = 0;
                                            IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                                IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                                    IsEquivalent := TRUE;
                                            END ELSE BEGIN
                                                //              IF (ABS(ROUND(CustAmount/PurchInvHeader."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                                IF ABS(ROUND(CustAmount / PurchInvHeader."Currency Factor", 1, '<')) =
                                                  ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                                    IsEquivalent := TRUE;
                                            END;
                                        UNTIL (InventoryPostingGroup.NEXT = 0) OR (IsEquivalent = TRUE);
                                    END;
                                END;

                                NetAmountInFCY := CustAmount;
                                TaxAmountInFCY := AmountInclVAT - CustAmount;

                            END;
                        END ELSE
                            IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::"Credit Memo" THEN BEGIN
                                IF PurchCrMemoHdr.GET("VAT Entry"."Document No.") THEN BEGIN
                                    CurrencyCode := PurchCrMemoHdr."Currency Code";
                                    PurchCrMemoLine.RESET;
                                    PurchCrMemoLine.SETRANGE(PurchCrMemoLine."Document No.", PurchCrMemoHdr."No.");
                                    PurchCrMemoLine.SETRANGE(PurchCrMemoLine."Gen. Bus. Posting Group", "VAT Entry"."Gen. Bus. Posting Group");
                                    PurchCrMemoLine.SETRANGE(PurchCrMemoLine."Gen. Prod. Posting Group", "VAT Entry"."Gen. Prod. Posting Group");
                                    PurchCrMemoLine.SETRANGE(PurchCrMemoLine."VAT Bus. Posting Group", "VAT Entry"."VAT Bus. Posting Group");
                                    PurchCrMemoLine.SETRANGE(PurchCrMemoLine."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");

                                    PurchCrMemoLine.SETRANGE(PurchCrMemoLine."Posting Group", '');
                                    IF PurchCrMemoLine.FIND('-') THEN
                                        REPEAT
                                            CustAmount := CustAmount + PurchCrMemoLine."VAT Base Amount";
                                            AmountInclVAT := AmountInclVAT + PurchCrMemoLine."Amount Including VAT";
                                        UNTIL PurchCrMemoLine.NEXT = 0;
                                    IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                        IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                            IsEquivalent := TRUE;
                                    END ELSE BEGIN
                                        //        IF (ABS(ROUND(CustAmount/PurchCrMemoHdr."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                        IF ABS(ROUND(CustAmount / PurchCrMemoHdr."Currency Factor", 1, '<')) =
                                          ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                            IsEquivalent := TRUE;
                                    END;

                                    IF IsEquivalent = FALSE THEN BEGIN
                                        IF InventoryPostingGroup.FIND('-') THEN BEGIN
                                            IsEquivalent := FALSE;
                                            REPEAT
                                                //            CustAmount := 0;                                                                                 //2007.08.22 NKC1.01
                                                //            AmountInclVAT := 0;                                                                              //2007.08.22 NKC1.01
                                                PurchCrMemoLine.SETRANGE(PurchCrMemoLine."Posting Group", InventoryPostingGroup.Code);
                                                IF PurchCrMemoLine.FIND('-') THEN
                                                    REPEAT
                                                        CustAmount := CustAmount + PurchCrMemoLine."VAT Base Amount";
                                                        AmountInclVAT := AmountInclVAT + PurchCrMemoLine."Amount Including VAT";
                                                    UNTIL PurchCrMemoLine.NEXT = 0;
                                                IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                                                    IF (ABS(CustAmount) = ABS("VAT Entry".Base)) THEN
                                                        IsEquivalent := TRUE;
                                                END ELSE BEGIN
                                                    //              IF (ABS(ROUND(CustAmount/PurchCrMemoHdr."Currency Factor",0.01)) = ABS("VAT Entry".Base)) THEN
                                                    IF ABS(ROUND(CustAmount / PurchCrMemoHdr."Currency Factor", 1, '<')) =
                                                      ABS(ROUND("VAT Entry".Base, 1, '<')) THEN
                                                        IsEquivalent := TRUE;
                                                END;
                                            UNTIL (InventoryPostingGroup.NEXT = 0) OR (IsEquivalent = TRUE);
                                        END;
                                    END;

                                    NetAmountInFCY := -CustAmount;                                                                           //2007.08.23 NKC1.02
                                    TaxAmountInFCY := -(AmountInclVAT - CustAmount);                                                         //2007.08.23 NKC1.02

                                END;
                            END;
                    END;

                IF (CurrencyCode = '') OR (CurrencyCode = GeneralLedgerSetup."LCY Code") THEN BEGIN
                    NetAmountInFCY := "VAT Entry".Base;
                    TaxAmountInFCY := "VAT Entry".Amount;
                END;
            END;
        }
    }
    requestpage
    {
        SaveValues = true;

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
        TotalCaption := 'Total';
        CompanyInformation.GET();
        GeneralLedgerSetup.GET();

        VATPostingSetup2.RESET;
        VATEntry2.RESET;
        IF VATPostingSetup2.FIND('-') THEN
            REPEAT
                VATEntry2.SETRANGE(VATEntry2."VAT Bus. Posting Group", VATPostingSetup2."VAT Bus. Posting Group");
                VATEntry2.SETRANGE(VATEntry2."VAT Prod. Posting Group", VATPostingSetup2."VAT Prod. Posting Group");
                VATEntry2.SETRANGE(VATEntry2."VAT Identifier", '');
                VATEntry2.MODIFYALL(VATEntry2."VAT Identifier", VATPostingSetup2."VAT Identifier");
            UNTIL VATPostingSetup2.NEXT = 0;
    END;


    VAR
        CompanyInformation: Record "Company Information";
        Text001: Label 'Page : %1';
        Text002: Label '"Date : "';
        CurrencyCode: Code[10];
        CustLedger: Record "Cust. Ledger Entry";
        VendLedger: Record "Vendor Ledger Entry";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Text003: Label 'Filters : %1';
        TaxPeriod: Text[250];
        CountryName: Text[50];
        VATBusPostingGroup: Record 323;
        VATProdPostingGroup: Record 324;
        Country: Record "Country/Region";
        TotalText: Text[30];
        Text004: Label 'Total %1';
        GeneralLedgerSetup: Record "General Ledger Setup";
        FirstGroupHeader: Boolean;
        Cust: Code[20];
        Suppl: Code[20];
        RowNo: Integer;
        Text005: Label 'TAX ANALYSIS BY TAX PERIOD';
        Text006: Label 'Invoice No.';
        Text007: Label 'Customer';
        Text008: Label 'Vendor';
        Text009: Label 'Currency Code';
        Text010: Label 'Payment|Receipt Amount in LCY';
        Text011: Label 'Net Amount in LCY';
        Text012: Label 'Tax Amount in LCY';
        Text013: Label 'Grand Total';
        VATPostingSetup: Record "VAT Posting Setup";
        //VATIdentifier: Text[50];
        VATPostingSetup2: Record "VAT Posting Setup";
        VATEntry2: Record "VAT Entry";
        Text014: Label 'Filters : %1';
        NetAmountInFCY: Decimal;
        TaxAmountInFCY: Decimal;
        Text015: Label '"No Type filter(s) defined. Please specify Type value. "';
        InventoryPostingGroup: Record "Inventory Posting Group";
        IsEquivalent: Boolean;
        TotalCaption: Text[50];
}
