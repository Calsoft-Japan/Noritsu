reportextension 50109 "Customer Statment Ext" extends "Standard Statement"
{
    WordLayout = '.\RDLC\StandardStatement_NSP.docx';

    dataset
    {
        modify(CurrencyLoop)
        {
            trigger OnBeforeAfterGetRecord()
            begin
                Clear(TotalReceiveAmount);
                Clear(TotalRemainingAmount);
            end;

            trigger OnAfterAfterGetRecord()
            var
                TempCurrency2: Record Currency temporary;
                CustLedgerEntry: Record "Cust. Ledger Entry";
                IsFirstLoop, EntriesExists : Boolean;
                rmAmount: Decimal;
            begin
                /*CustLedgerEntry.Reset();
                CustLedgerEntry.SetCurrentKey("Currency Code");
                TempCurrency2.Init();
                while CustLedgerEntry.FindFirst() do begin
                    TempCurrency2.Code := CustLedgerEntry."Currency Code";
                    TempCurrency2.Insert();
                    CustLedgerEntry.SetFilter("Currency Code", '>%1', CustLedgerEntry."Currency Code");
                end;

                TempCurrency2.Find('-');

                repeat
                    if not IsFirstLoop then
                        IsFirstLoop := true
                    else
                        if TempCurrency2.Next() = 0 then
                            CurrReport.Break();
                    CustLedgerEntry.SetCurrentKey("Customer No.", "Posting Date", "Currency Code");
                    CustLedgerEntry.SetRange("Customer No.", Customer."No.");
                    CustLedgerEntry.SetRange("Posting Date", 0D, EndDate);
                    CustLedgerEntry.SetRange("Currency Code", TempCurrency2.Code);
                    EntriesExists := not CustLedgerEntry.IsEmpty();

                    rmAmount := CustLedgerEntry."Remaining Amount";
                    CustLedgerEntry.CalcFields("Remaining Amount");
                until EntriesExists;

                if OnlyForRemainAmt and (TotalRemainingAmount = 0) then
                    CurrReport.Skip();*/
            end;
        }

        add(DtldCustLedgEntries)
        {
            column(ReceiveAmount; ReceiveAmount)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }

        }

        modify(DtldCustLedgEntries)
        {
            trigger OnAfterPreDataItem()
            begin

                /*
                if ForNSP then begin
                    SetRange("Document Type", "Document Type"::Invoice, "Document Type"::"Credit Memo");
                end;*/
            end;

            trigger OnBeforeAfterGetRecord()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
                rmAmount: Decimal;
            begin
                /*if OnlyForRemainAmt then begin
                    Clear(rmAmount);

                    CustLedgerEntry.Reset();
                    if DtldCustLedgEntries."Entry Type" = DtldCustLedgEntries."Entry Type"::"Initial Entry" then begin
                        CustLedgerEntry.Get("Cust. Ledger Entry No.");
                        CustLedgerEntry.SetRange("Date Filter", 0D, EndDate);
                        CustLedgerEntry.CalcFields("Remaining Amount");
                        rmAmount := CustLedgerEntry."Remaining Amount";
                    end;

                    if rmAmount = 0 then CurrReport.Skip();
                end;*/
            end;

            trigger OnAfterAfterGetRecord()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
                rmAmount: Decimal;
            begin
                Clear(rmAmount);
                if DtldCustLedgEntries."Entry Type" = DtldCustLedgEntries."Entry Type"::"Initial Entry" then begin
                    CustLedgerEntry.Reset();
                    CustLedgerEntry.Get("Cust. Ledger Entry No.");
                    CustLedgerEntry.SetRange("Date Filter", StartDate, EndDate);
                    CustLedgerEntry.CalcFields("Remaining Amount");
                    rmAmount := CustLedgerEntry."Remaining Amount";

                    RemainingAmount := rmAmount;
                end;
                if OnlyForRemainAmt and (rmAmount = 0) then
                    CurrReport.Skip();

                //if OnlyForRemainAmt and (RemainingAmount = 0) then CurrReport.Skip();

                if DtldCustLedgEntries."Entry Type" = DtldCustLedgEntries."Entry Type"::"Initial Entry" then begin
                    ReceiveAmount := Amount - rmAmount;//RemainingAmount;

                    TotalReceiveAmount += ReceiveAmount;
                    TotalRemainingAmount += rmAmount;//RemainingAmount;

                    CurrCode := "Currency Code";
                end;
            end;
        }

        add(CustLedgEntryFooter)
        {
            column(TotalReceiveAmount; TotalReceiveAmount)
            {
                AutoFormatExpression = CurrCode;
                AutoFormatType = 1;
            }
            column(TotalRemainingAmount; TotalRemainingAmount)
            {
                AutoFormatExpression = CurrCode;
                AutoFormatType = 1;
            }
        }

        modify(CustLedgEntry2)
        {
            /*trigger OnAfterPreDataItem()
            begin
                if ForNSP then begin
                    SetRange("Document Type", "Document Type"::Invoice, "Document Type"::"Credit Memo");
                end;
            end;*/

            trigger OnBeforeAfterGetRecord()
            var
                rmAmount: Decimal;
            begin
                if OnlyForRemainAmt then begin
                    CustLedgEntry2.CalcFields("Remaining Amount");
                    rmAmount := CustLedgEntry2."Remaining Amount";
                    if rmAmount = 0 then CurrReport.Skip();
                end;
            end;
        }

        modify(AgingCustLedgEntry)
        {
            /*trigger OnAfterPreDataItem()
            begin
                if ForNSP then begin
                    SetRange("Document Type", "Document Type"::Invoice, "Document Type"::"Credit Memo");
                end;
            end;*/

            trigger OnBeforeAfterGetRecord()
            var
                rmAmount: Decimal;
            begin
                if OnlyForRemainAmt then begin
                    AgingCustLedgEntry.CalcFields("Remaining Amount");
                    rmAmount := AgingCustLedgEntry."Remaining Amount";
                    if rmAmount = 0 then CurrReport.Skip();
                end;
            end;
        }

        add(Customer)
        {
            column(CompanyInfoXPicture; CompanyInfoX.Picture) { }
            column(StartDate_Req; Format(StartDate_Req)) { }
        }

        modify(Customer)
        {
            trigger OnAfterAfterGetRecord()
            begin
                Clear(TotalReceiveAmount);
                Clear(TotalRemainingAmount);
            end;
        }
    }

    requestpage
    {
        layout
        {
            addafter(ShowOverdueEntries)
            {
                field(OnlyForRemainAmt; OnlyForRemainAmt)
                {
                    Caption = 'Show Only Entries with Remaining Amount';
                    ApplicationArea = All;
                }
            }

            /*addafter("End Date")
            {
                field(ForNSP; ForNSP)
                {
                    Caption = 'For NSP';
                    ApplicationArea = All;
                }
            }*/
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfoX.Get();
        CompanyInfoX.CalcFields(Picture);

        StartDate_Req := StartDate;
        if OnlyForRemainAmt then StartDate := DMY2Date(1, 1, 2000);
    end;

    var
        CompanyInfoX: Record "Company Information";
        ReceiveAmount: Decimal;
        TotalReceiveAmount: Decimal;
        TotalRemainingAmount: Decimal;
        CurrCode: Code[10];
        OnlyForRemainAmt: Boolean;
        StartDate_Req: Date;
    //ForNSP: Boolean;
}
