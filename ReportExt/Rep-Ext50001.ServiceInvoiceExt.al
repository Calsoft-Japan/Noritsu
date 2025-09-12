reportextension 50001 "Service Invoice Ext." extends "Service - Invoice"
{
    //RDLCLayout = '.\RDLC\ServiceInvoice_NMS.RDLC';

    dataset
    {
        add("Service Invoice Header")
        {
            column(FirstLineDesc; FirstLineDesc)
            { }
        }

        modify("Service Invoice Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                SvcInvLine: Record "Service Invoice Line";
            //ValueEntryRelation: Record "Value Entry Relation";
            begin
                Clear(FirstLineDesc);
                SvcInvLine.Reset();
                SvcInvLine.SetRange(Type, SvcInvLine.Type::Item, SvcInvLine.Type::Resource);
                SvcInvLine.SetRange("Document No.", "No.");
                if SvcInvLine.FindFirst() then begin
                    /* ValueEntryRelation.Reset();
                    ValueEntryRelation.SetRange("Source RowId", SvcInvLine.RowID1());
                    if ValueEntryRelation.Find('-') then
                        if ValueEntry.Get(ValueEntryRelation."Value Entry No.") then
                            if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                                ItemLedgerEntryPkg.SetRange("Document No.", ItemLedgerEntry."Document No.");
                                ItemLedgerEntryPkg.SetRange("Document Line No.", ItemLedgerEntry."Document Line No.");
                                if ItemLedgerEntryPkg.Find('-') then begin
                                    repeat
                                        if ItemLedgerEntryPkg."Serial No." <> '' then
                                            FirstLineDesc := FirstLineDesc + ItemLedgerEntryPkg."Serial No." + ', ';
                                    until ItemLedgerEntryPkg.Next() = 0;

                                    if StrLen(FirstLineDesc.Trim()) > 0 then
                                        FirstLineDesc := DelStr(FirstLineDesc, StrLen(Serial_Line_Pkg) - 1, 2);
                                end;
                            end; */

                    FirstLineDesc := SvcInvLine."Service Item Serial No." + ' ' + SvcInvLine."Service Item Line Description";
                end;

            end;
        }

        add(PageLoop)
        {
            column(CompanyInfoXPic; CompanyInfoX.Picture)
            { }
            column(CoRegNo; CompanyInfoX."Registration No.")
            { }
            column(CoRegNSP; CompanyInfoX."Industrial Classification")
            { }
            column(HomePage; CompanyInfoX."Home Page")
            { }
            column(ABNGSTNo; ABNGSTNo)
            { }
            column(BillToRegNo; BillToRegNo)//CustX."VAT Registration No.")
            { }
            column(SellToCustomerNo; "Service Invoice Header"."Customer No.")
            { }
            column(SellToRegNo; SellToRegNo)
            { }
            column(SellToPhone; SellToPhone)
            { }
            column(BillToPhone; BillToPhone)
            { }
            column(SellToAddress1; SellToAddrX[1])
            { }
            column(SellToAddress2; SellToAddrX[2])
            { }
            column(SellToAddress3; SellToAddrX[3])
            { }
            column(SellToAddress4; SellToAddrX[4])
            { }
            column(SellToAddress5; SellToAddrX[5])
            { }
            column(SellToAddress6; SellToAddrX[6])
            { }
            column(SellToAddress7; SellToAddrX[7])
            { }
            column(SellToAddress8; SellToAddrX[8])
            { }
            column(PaymentTermDesc; PaymentTerm.Description)
            { }
            column(BankName; BankName)
            { }
            column(BankBSB; BankBSB)
            { }
            column(BankAddr; BankAddr)
            { }
            column(BankAC; BankAC)
            { }
            column(BankSWIFT; BankSWIFT)
            { }
            column(Delivery_Order_No; ShipmentNo)
            { }
            column(PrintSGDTTL; PrintSGDTTL)
            { }
            column(CurrExhRate; CurrExhRate)
            { }
            column(DueDateHeader; Format("Service Invoice Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            { }
            column(HeaderPstDate; Format("Service Invoice Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            { }
            column(ShipToAddrX1; ShipToAddrX[1])
            {
            }
            column(ShipToAddrX2; ShipToAddrX[2])
            {
            }
            column(ShipToAddrX3; ShipToAddrX[3])
            {
            }
            column(ShipToAddrX4; ShipToAddrX[4])
            {
            }
            column(ShipToAddrX5; ShipToAddrX[5])
            {
            }
            column(ShipToAddrX6; ShipToAddrX[6])
            {
            }
            column(ShipToAddrX7; ShipToAddrX[7])
            {
            }
            column(ShipToAddrX8; ShipToAddrX[8])
            {
            }
            column(ShipToName; "Service Invoice Header"."Ship-to Code")
            { }
        }

        modify(PageLoop)
        {
            trigger OnAfterAfterGetRecord()
            var
                FormatDocument: Codeunit "Format Document";
            begin
                Clear(SellToRegNo);
                Clear(SellToPhone);
                Clear(BillToRegNo);
                Clear(BillToPhone);


                FormatAddrX.ServiceInvBillTo(BillToAddr, "Service Invoice Header");
                FormatAddrX.ServiceInvShipTo(ShipToAddrX, BillToAddr, "Service Invoice Header");

                FormatAddrX.FormatAddr(SellToAddrX, "Service Invoice Header".Name, "Service Invoice Header"."Name 2", "Service Invoice Header"."Contact Name",
                    "Service Invoice Header".Address, "Service Invoice Header"."Address 2", "Service Invoice Header".City, "Service Invoice Header"."Post Code",
                    "Service Invoice Header".County, "Service Invoice Header"."Country/Region Code");

                if UpperCase("Service Invoice Header"."Currency Code") = 'NZD' then begin
                    ABNGSTNo := CompanyInfoX.GetRegistrationNumber();
                end else
                    ABNGSTNo := CompanyInfoX.GetVATRegistrationNumber();

                CustX.Reset();
                if CustX.Get("Service Invoice Header"."Customer No.") then begin //"Sell-to Customer No."
                    SellToRegNo := CustX."VAT Registration No.";
                    SellToPhone := CustX."Phone No.";
                end;
                CustX.Reset();
                if CustX.Get("Service Invoice Header"."Bill-to Customer No.") then begin
                    BillToRegNo := CustX."VAT Registration No.";
                    BillToPhone := CustX."Phone No.";
                end;

                PaymentTerm.Reset();
                PaymentTerm.Get("Service Invoice Header"."Payment Terms Code");

                Clear(BankName);
                Clear(BankBSB);
                Clear(BankAC);
                Clear(BankAddr);
                Clear(BankSWIFT);

                CustX.Reset();
                CustX.Get("Service Invoice Header"."Bill-to Customer No.");
                if CustX."Receiving Bank Account" <> '' then begin
                    BankAct.Get(CustX."Receiving Bank Account");
                    BankName := BankAct.Name;
                    BankBSB := 'BSB: ' + BankAct."Bank Branch No.";
                    BankAddr := BankAct.Address + ' ' + BankAct."Address 2" + ' ' + BankAct.City + ' ' + BankAct."Post Code" + ' ' + BankAct."Country/Region Code";
                    BankAC := 'A/C: ' + BankAct."Bank Account No.";
                    if BankAct."SWIFT Code" <> '' then
                        BankSWIFT := 'SWIFT: ' + BankAct."SWIFT Code";
                end else begin
                    BankName := CompanyInfoX."Bank Name";
                    BankBSB := 'BSB: ' + CompanyInfoX."Bank Branch No.";
                    BankAC := 'A/C: ' + CompanyInfoX."Bank Account No.";
                    BankSWIFT := 'SWIFT: ' + CompanyInfoX."SWIFT Code";
                end;

                Clear(PrintSGDTTL);
                Clear(CurrExhRate);
                PrintSGDTTL := CustX."Totals in Local Currency" and (UpperCase("Service Invoice Header"."Currency Code") <> 'SGD');
                ExchangeRate.Reset();
                ExchangeRate.SetRange("Currency Code", "Service Invoice Header"."Currency Code");//'SGD');
                ExchangeRate.SetRange("Starting Date", 0D, Today);
                if ExchangeRate.FindLast() then begin
                    CurrExhRate := ExchangeRate."Relational Exch. Rate Amount";
                    SGDSub := ExchangeRate."Relational Exch. Rate Amount";
                    SGDGST := ExchangeRate."Relational Exch. Rate Amount";
                    SGDTotal := ExchangeRate."Relational Exch. Rate Amount";
                end;

                Clear(ShipmentNo);
                ServiceShipmentHdr.Reset();
                ServiceShipmentHdr.SetRange("Order No.", "Service Invoice Header"."Order No.");
                if ServiceShipmentHdr.Find('-') then begin
                    ShipmentNo := ServiceShipmentHdr."No.";
                end;

                FormatDocument.SetTotalLabels("Service Invoice Header"."Currency Code", TotalTextX, TotalInclVATTextX, TotalExclVATTextX);

            end;
        }

        add("Service Invoice Line")
        {
            column(Type_Line; Format(Type))
            {
            }

            column(Serial_No_Line; ItemLedgerEntry."Serial No.")
            { }

            column(DiscountAmount_Line; "Service Invoice Line"."Line Discount Amount")
            {
                AutoFormatExpression = GetCurrencyCode();
                AutoFormatType = 1;
            }
            column(Serial_Line_Pkg; Serial_Line_Pkg)
            { }
            column(DiscountRate_Line; "Line Discount %")
            {
            }
        }

        modify("Service Invoice Line")
        {
            trigger OnAfterPreDataItem()
            begin
                VATAmountLine.Reset();
                VATAmountLine.DeleteAll();

                TotalAmountX := 0;
                TotalAmountInclVATX := 0;
                TotalSubTotalX := 0;
                TotalAmountVATX := 0;
                TotalInvDiscAmountX := 0;
            end;

            trigger OnAfterAfterGetRecord()
            var
                ValueEntryRelation: Record "Value Entry Relation";
            begin
                Clear(Serial_Line_Pkg);
                if "Service Invoice Line".Type = "Service Invoice Line".Type::Item then begin

                    /*ValueEntry.Reset();
                    ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
                    ValueEntry.SetRange("Document No.","Service Invoice Line"."Document No.");
                    ValueEntry.SetRange("Document Line No.","Service Invoice Line"."Line No.");
                    ValueEntry.SetRange("Posting Date","Service Invoice Line"."Posting Date");
                    if ValueEntry.FindFirst() then begin
                        repeat
                            ItemLedgerEntryPkg.Reset();
                            if ItemLedgerEntryPkg.Get(ValueEntry."Item Ledger Entry No.") then
                                Serial_Line_Pkg := Serial_Line_Pkg + ItemLedgerEntryPkg."Serial No." + ', ';
                        until ValueEntry.Next() = 0;

                        Serial_Line_Pkg := DelStr(Serial_Line_Pkg, StrLen(Serial_Line_Pkg) - 2, 2);
                    end;*/

                    ValueEntryRelation.Reset();
                    ValueEntryRelation.SetRange("Source RowId", "Service Invoice Line".RowID1());
                    if ValueEntryRelation.Find('-') then
                        if ValueEntry.Get(ValueEntryRelation."Value Entry No.") then
                            if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                                ItemLedgerEntryPkg.SetRange("Document No.", ItemLedgerEntry."Document No.");
                                ItemLedgerEntryPkg.SetRange("Document Line No.", ItemLedgerEntry."Document Line No.");
                                if ItemLedgerEntryPkg.Find('-') then begin
                                    repeat
                                        if ItemLedgerEntryPkg."Serial No." <> '' then
                                            Serial_Line_Pkg := Serial_Line_Pkg + ItemLedgerEntryPkg."Serial No." + ', ';
                                    until ItemLedgerEntryPkg.Next() = 0;

                                    if StrLen(Serial_Line_Pkg.Trim()) > 0 then
                                        Serial_Line_Pkg := DelStr(Serial_Line_Pkg, StrLen(Serial_Line_Pkg) - 1, 2);
                                end;
                            end;

                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                    ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Invoice");
                    ItemLedgerEntry.SetRange("Document No.", "Service Invoice Line"."Document No.");
                    ItemLedgerEntry.SetRange("Item No.", "Service Invoice Line"."No.");
                    ItemLedgerEntry.SetRange("Document Line No.", "Service Invoice Line"."Line No.");
                    if ItemLedgerEntry.FindFirst() then begin end;
                end;

                VATAmountLine.Init();
                VATAmountLine."VAT Identifier" := "VAT Identifier";
                VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                VATAmountLine."Tax Group Code" := "Tax Group Code";
                VATAmountLine."VAT %" := "VAT %";
                VATAmountLine."VAT Base" := Amount;
                VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                VATAmountLine."Line Amount" := "Line Amount";
                if "Allow Invoice Disc." then
                    VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                VATAmountLine.InsertLine();

                TotalAmountX += Amount;
                TotalAmountInclVATX += "Amount Including VAT";
                TotalSubTotalX += "Line Amount";
                TotalAmountVATX += "Amount Including VAT" - Amount;
                TotalInvDiscAmountX += "Inv. Discount Amount";
            end;
        }

        addbefore(LineFee)
        {
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = SORTING("Line No.");
                UseTemporary = true;
                column(Description_ReportTotalsLine; Description)
                {
                }
                column(Amount_ReportTotalsLine; Amount)
                {
                    AutoFormatExpression = "Service Invoice Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                    AutoFormatExpression = "Service Invoice Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(FontBold_ReportTotalsLine; "Font Bold")
                {
                }
                column(FontUnderline_ReportTotalsLine; "Font Underline")
                {
                }

                trigger OnPreDataItem()
                begin
                    CreateReportTotalLines();
                end;
            }
        }


        addlast(PageLoop)
        {
            dataitem(Totals; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(TotalTextX; TotalTextX)
                { }
                column(TotalInclVATTextX; TotalInclVATTextX)
                { }
                column(TotalExclVATTextX; TotalExclVATTextX)
                { }
                column(TotalAmountX; TotalAmountX)
                {
                    AutoFormatExpression = "Service Invoice Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmountInclVATX; TotalAmountInclVATX)
                {
                    AutoFormatExpression = "Service Invoice Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalSubTotalX; TotalSubTotalX)
                {
                    AutoFormatExpression = "Service Invoice Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmountVATX; TotalAmountVATX)
                {
                    AutoFormatExpression = "Service Invoice Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalInvDiscAmountX; TotalInvDiscAmountX)
                {
                    AutoFormatExpression = "Service Invoice Header"."Currency Code";
                    AutoFormatType = 1;
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfoX.Get();
        CompanyInfoX.CalcFields(Picture);
    end;

    procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();

        if (TotalInvDiscAmountX <> 0) or (TotalAmountVATX <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotalX, true, false, false);
        if TotalInvDiscAmountX <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmountX, false, false, false);
            if TotalAmountVATX <> 0 then
                if "Service Invoice Header"."Prices Including VAT" then
                    ReportTotalsLine.Add(TotalInclVATTextX, TotalAmountInclVATX, true, false, false)
                else
                    ReportTotalsLine.Add(TotalExclVATTextX, TotalAmountX, true, false, false);
        end;
        if TotalAmountVATX <> 0 then
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVATX, false, true, false);
    end;

    var
        SubtotalLbl: Label 'Subtotal';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        TotalExclVATTextX: Text[50];
        TotalInclVATTextX: Text[50];
        TotalTextX: Text[50];
        VATAmountLine: Record "VAT Amount Line" temporary;
        TotalAmountX: Decimal;
        TotalAmountInclVATX: Decimal;
        TotalSubTotalX: Decimal;
        TotalAmountVATX: Decimal;
        TotalInvDiscAmountX: Decimal;
        CompanyInfoX: Record "Company Information";
        CustX: Record Customer;
        FormatAddrX: Codeunit "Format Address";
        SellToAddrX: array[8] of Text[100];
        ShipToAddrX: array[8] of Text[100];
        BillToAddr: array[8] of Text[100];
        BillToRegNo: Text;
        SellToRegNo: Text;
        BillToPhone: Text;
        SellToPhone: Text;
        ABNGSTNo: Text;
        PaymentTerm: Record "Payment Terms";
        BankAct: Record "Bank Account";
        BankName: Text[100];
        BankBSB: Text[100];
        BankAC: Text[100];
        BankSWIFT: Text[100];
        BankAddr: Text[200];
        PrintSGDTTL: Boolean;
        ExchangeRate: Record "Currency Exchange Rate";
        CurrExhRate: Decimal;
        SGDSub: Decimal;
        SGDGST: Decimal;
        SGDTotal: Decimal;
        ShipmentNo: Text;
        ServiceShipmentHdr: Record "Service Shipment Header";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntryPkg: Record "Item Ledger Entry";
        Serial_Line_Pkg: Text;
        FirstLineDesc: Text;
}
