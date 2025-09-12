reportextension 50106 "Sales Invoice Ext." extends "Standard Sales - Invoice"
{
    RDLCLayout = '.\RDLC\SalesInvoice_NAL_Package.RDLC';

    dataset
    {
        add(Header)
        {
            column(CompanyInfoPicture; CompanyInfo1.Picture)
            {
            }
            column(CompanyFaxNo; CompanyInfo1."Fax No.")
            {
            }
            column(BillToRegNo; BillToRegNo)//CustX."VAT Registration No.")
            {
            }
            column(SellToRegNo; SellToRegNo)
            { }
            column(ABNGSTNo; ABNGSTNo)
            {
            }
            column(DueDateHeader; Format("Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            { }
            column(SellToAddress1; SellToAddrX[1])
            {
            }
            column(SellToAddress2; SellToAddrX[2])
            {
            }
            column(SellToAddress3; SellToAddrX[3])
            {
            }
            column(SellToAddress4; SellToAddrX[4])
            {
            }
            column(SellToAddress5; SellToAddrX[5])
            {
            }
            column(SellToAddress6; SellToAddrX[6])
            {
            }
            column(SellToAddress7; SellToAddrX[7])
            {
            }
            column(SellToAddress8; SellToAddrX[8])
            {
            }
            column(HeaderPstDate; Format("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }

            column(PaymentTermDesc; PaymentTerm.Description)
            { }

            column(BankName; BankName)
            {
            }
            column(BankBSB; BankBSB)
            {
            }
            column(BankAddr; BankAddr)
            {
            }
            column(BankAC; BankAC)
            {
            }
            column(BankSWIFT; BankSWIFT)
            {
            }
            column(BillToPhone; CustBillTo."Phone No.")
            { }
            column(CoRegNo; CompanyInfo1."Registration No.")
            { }
            column(CoRegNSP; CompanyInfo1."Industrial Classification")
            { }
            column(Delivery_Order_No; ShipmentNo)
            { }
            column(PrintSGDTTL; PrintSGDTTL)
            { }
            column(CurrExhRate; CurrExhRate)
            { }
            column(ShipToName; "Ship-to Code")
            { }
        }

        modify(Header)
        {
            RequestFilterFields =;
            trigger OnAfterPreDataItem()
            begin
                CompanyInfo1.Reset();
                CompanyInfo1.Get();
                CompanyInfo1.CalcFields(Picture);
            end;

            trigger OnAfterAfterGetRecord()
            begin
                FormatAddrX.SalesInvSellTo(SellToAddrX, Header);

                if UpperCase("Currency Code") = 'NZD' then begin
                    ABNGSTNo := CompanyInfo1.GetRegistrationNumber();
                end else
                    ABNGSTNo := CompanyInfo1.GetVATRegistrationNumber();

                CustX.Reset();
                if CustX.Get("Sell-to Customer No.") then
                    SellToRegNo := CustX."VAT Registration No.";
                CustX.Reset();
                if CustX.Get("Bill-to Customer No.") then
                    BillToRegNo := CustX."VAT Registration No.";

                PaymentTerm.Reset();
                PaymentTerm.Get("Payment Terms Code");

                Clear(BankName);
                Clear(BankBSB);
                Clear(BankAC);
                Clear(BankAddr);
                Clear(BankSWIFT);

                CustBillTo.Reset();
                CustBillTo.Get("Bill-to Customer No.");
                if CustBillTo."Receiving Bank Account" <> '' then begin
                    BankAct.Get(CustBillTo."Receiving Bank Account");
                    BankName := BankAct.Name;
                    BankBSB := 'BSB: ' + BankAct."Bank Branch No.";
                    BankAddr := BankAct.Address + ' ' + BankAct."Address 2" + ' ' + BankAct.City + ' ' + BankAct."Post Code" + ' ' + BankAct."Country/Region Code";
                    BankAC := 'A/C: ' + BankAct."Bank Account No.";
                    if BankAct."SWIFT Code" <> '' then
                        BankSWIFT := 'SWIFT: ' + BankAct."SWIFT Code";
                end else begin
                    BankName := CompanyInfo1."Bank Name";
                    BankBSB := 'BSB: ' + CompanyInfo1."Bank Branch No.";
                    BankAC := 'A/C: ' + CompanyInfo1."Bank Account No.";
                    BankSWIFT := 'SWIFT: ' + CompanyInfo1."SWIFT Code";
                end;

                Clear(PrintSGDTTL);
                Clear(CurrExhRate);
                PrintSGDTTL := CustBillTo."Totals in Local Currency" and (UpperCase("Currency Code") <> 'SGD');
                ExchangeRate.Reset();
                ExchangeRate.SetRange("Currency Code", Header."Currency Code");//'SGD');
                ExchangeRate.SetRange("Starting Date", 0D, Today);
                if ExchangeRate.FindLast() then begin
                    CurrExhRate := ExchangeRate."Relational Exch. Rate Amount";
                    SGDSub := ExchangeRate."Relational Exch. Rate Amount";
                    SGDGST := ExchangeRate."Relational Exch. Rate Amount";
                    SGDTotal := ExchangeRate."Relational Exch. Rate Amount";
                end;


                Clear(ShipmentNo);
                SalesShipmentHdr.Reset();
                SalesShipmentHdr.SetRange("Order No.", Header."Order No.");
                if SalesShipmentHdr.Find('-') then begin
                    ShipmentNo := SalesShipmentHdr."No.";
                end;
            end;
        }

        /*addfirst(Header)
        {
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                column(CopyText; CopyText)
                { }
                column(OutputNo; OutputNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocumentX.GetCOPYText();
                        OutputNo += 1;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1 + Abs(NoOfCopies);
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }
        }*/

        add(Line)
        {
            column(Serial_No_Line; ItemLedgerEntry."Serial No.")
            { }

            column(DiscountAmount_Line; Line."Line Discount Amount")
            { }
            column(Serial_Line_Pkg; Serial_Line_Pkg)
            { }
            column(UnitPrice_Pkg; UnitPrice_Pkg)
            { }
            column(Amount_Pkg; Amount_Pkg)
            { }
            column(Quantity_Pkg; Quantity_Pkg)
            { }
            column(DiscountAmount_Pkg; DiscountAmount_Pkg)
            { }
        }

        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            var
                SInvLine: Record "Sales Invoice Line";
                ValueEntryRelation: Record "Value Entry Relation";
            begin
                Clear(UnitPrice_Pkg);
                Clear(Amount_Pkg);
                Clear(Quantity_Pkg);
                Clear(DiscountAmount_Pkg);

                UnitPrice_Pkg := Line."Unit Price";
                Quantity_Pkg := Line.Quantity;
                Amount_Pkg := Line.Amount;
                DiscountAmount_Pkg := Line."Line Discount Amount";

                if (Line.Type = Line.Type::" ") and (StrLen(Line."QSS System Code") > 0) then begin
                    if Line.Quantity <> 0 then
                        UnitPrice_Pkg := Line.Amount / Line.Quantity;

                    SInvLine.Reset();
                    SInvLine.SetCurrentKey("Line No.");
                    SInvLine.SetRange("Document No.", Line."Document No.");
                    SInvLine.SetRange(Type, SInvLine.Type::Item);
                    SInvLine.SetFilter("QSS System Code", Line."QSS System Code");
                    SInvLine.SetFilter("Line No.", '>' + Format(Line."Line No."));
                    if SInvLine.Find('-') then begin
                        Quantity_Pkg := SInvLine."Set Quantity";
                        repeat
                            DiscountAmount_Pkg += SInvLine."Line Discount Amount";
                            Amount_Pkg += SInvLine."Line Amount";
                        until SInvLine.Next() = 0;

                        if Quantity_Pkg <> 0 then
                            UnitPrice_Pkg := Amount_Pkg / Quantity_Pkg;
                    end;
                end;

                Clear(Serial_Line_Pkg);
                if Line.Type = Line.Type::Item then begin

                    if StrLen(Line."QSS System Code") > 0 then begin
                        UnitPrice_Pkg := 0;
                        Amount_Pkg := 0;
                        //Quantity_Pkg := 0;
                    end;

                    /*ValueEntry.Reset();
                    ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
                    ValueEntry.SetRange("Document No.", Line."Document No.");
                    ValueEntry.SetRange("Document Line No.", Line."Line No.");
                    ValueEntry.SetRange("Posting Date", Line."Posting Date");
                    if ValueEntry.FindFirst() then begin
                        repeat
                            ItemLedgerEntryPkg.Reset();
                            if ItemLedgerEntryPkg.Get(ValueEntry."Item Ledger Entry No.") then
                                Serial_Line_Pkg := Serial_Line_Pkg + ItemLedgerEntryPkg."Serial No." + ', ';
                        until ValueEntry.Next() = 0;

                        Serial_Line_Pkg := DelStr(Serial_Line_Pkg, StrLen(Serial_Line_Pkg) - 2, 2);
                    end;*/

                    ValueEntryRelation.Reset();
                    ValueEntryRelation.SetRange("Source RowId", Line.RowID1());
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
                    ItemLedgerEntry.SetRange("Document No.", Line."Document No.");
                    ItemLedgerEntry.SetRange("Item No.", Line."No.");
                    ItemLedgerEntry.SetRange("Document Line No.", Line."Line No.");
                    if ItemLedgerEntry.FindFirst() then begin end;
                end;
            end;
        }
    }

    /*requestpage
    {
        layout
        {
            addbefore(LogInteraction)
            {
                field(NoOfCopies; NoOfCopies)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'No. of Copies';
                    ToolTip = 'Specifies how many copies of the document to print.';
                }
            }
        }
    }*/

    var
        CompanyInfo1: Record "Company Information";
        CustX: Record Customer;
        CustBillTo: Record Customer;
        PaymentTerm: Record "Payment Terms";
        ABNGSTNo: Text[20];
        ItemLedgerEntry: Record "Item Ledger Entry";
        FormatAddrX: Codeunit "Format Address";
        SellToAddrX: array[8] of Text[100];
        SalesShipmentHdr: Record "Sales Shipment Header";
        ShipmentNo: Code[20];
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
        ValueEntry: Record "Value Entry";
        ItemLedgerEntryPkg: Record "Item Ledger Entry";
        Serial_Line_Pkg: Text;
        UnitPrice_Pkg: Decimal;
        Amount_Pkg: Decimal;
        Quantity_Pkg: Decimal;
        DiscountAmount_Pkg: Decimal;
        BillToRegNo: Text;
        SellToRegNo: Text;
    /*
            NoOfCopies: Integer;
            OutputNo: Integer;
            NoOfLoops: Integer;
            CopyText: Text[30];
            FormatDocumentX: Codeunit "Format Document";*/
}
