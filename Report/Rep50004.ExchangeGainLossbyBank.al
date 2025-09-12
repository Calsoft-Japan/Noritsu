report 50004 "Exchange Gain/Loss by Bank"
{
    ApplicationArea = All;
    Caption = 'Exchange Gain/Loss by Bank';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\RDLC\Exchange_Gain_Loss_by_Bank.RDLC';

    dataset
    {
        dataitem(BankAccount; "Bank Account")
        {
            DataItemTableView = SORTING("Currency Code", "Bank Acc. Posting Group")
                          WHERE("Currency Code" = FILTER(<> ''));
            RequestFilterFields = "Currency Code", "Bank Acc. Posting Group", "No.";
            //TotalFields ="Net Change","Net Change (LCY)";
            //GroupTotalFields ="Currency Code","Bank Acc. Posting Group";

            #region Bank Account Columns
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(AdjDate; STRSUBSTNO(Text000, AdjDate))
            { }
            column(CurrDate; Format(Today(), 0, 4))
            { }
            column(CompanyName; COMPANYNAME)
            { }
            column(UserID; UserID)
            { }
            column(FilterStr; STRSUBSTNO('%1: %2', BankAccount.TABLECAPTION, BankAccFilter))
            { }
            column(Amount; "Net Change")
            { }
            column(Amount_LCY_New; "Net Change (LCY)")
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(CurrencyCodeTEXT; STRSUBSTNO(Text003, "Currency Code"))
            {
            }
            column(ExchRate; ExchRate)
            { }
            column(ExchRateTEXT; STRSUBSTNO(Text008, ExchRate))
            { }

            column(BankAccPostingGroup; "Bank Acc. Posting Group")
            { }
            column(BankAccPostingGroupTEXT; STRSUBSTNO(Text004, "Bank Acc. Posting Group"))
            { }
            column(ExchFactor; ExchFactor)
            { }
            column(ExchFactorTEXT; STRSUBSTNO(Text009, ExchFactor))
            { }
            column(Difference; AdjustAmount)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(Amount_LCY_Old; "Net Change (LCY)" - AdjustAmount)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(ActPstGrpTotalTxt; STRSUBSTNO(Text006, "Bank Acc. Posting Group"))
            { }
            column(CurrcyTotalTxt; STRSUBSTNO(Text007, "Currency Code"))
            { }
            #endregion Bank Account Columns            

            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemTableView = SORTING("Bank Account No.", "Posting Date");
                DataItemLink = "Bank Account No." = FIELD("No."),
                     "Posting Date" = FIELD("Date Filter");

                #region Bank Account Ledger Entry Columns
                #endregion Bank Account Ledger Entry Columns
            }

            trigger OnPreDataItem()
            begin
                BankAccount.SETRANGE("Date Filter", 0D, AdjDate);
                //CurrReport.CREATETOTALS(AdjustAmount);
                Clear(AdjustAmount);
            end;

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Net Change", "Net Change (LCY)");

                BankLedgerRef.RESET;
                BankLedgerRef.SETRANGE("Bank Account No.", "No.");
                BankLedgerRef.SETRANGE("Posting Date", AdjDate);
                BankLedgerRef.SETRANGE("Source Code", ExchSourceCode);
                AdjustAmount := 0;
                IF BankLedgerRef.FIND('-') THEN
                    REPEAT
                        AdjustAmount += BankLedgerRef."Amount (LCY)";
                    UNTIL BankLedgerRef.NEXT = 0;

                // suppress no outstanding Bank Account
                IF ("Net Change" = 0) AND ("Net Change (LCY)" = 0) AND (AdjustAmount = 0) THEN
                    "Bank Account Ledger Entry".SETRANGE("Posting Date", 0D)
                ELSE BEGIN
                    "Bank Account Ledger Entry".SETRANGE("Posting Date", 0D, AdjDate);

                    // get exchange rate
                    ExchRateAdjmtReg.RESET;
                    ExchRateAdjmtReg.SETRANGE("Creation Date", AdjDate);
                    ExchRateAdjmtReg.SETRANGE("Account Type", ExchRateAdjmtReg."Account Type"::"Bank Account");
                    ExchRateAdjmtReg.SETRANGE("Currency Code", "Currency Code");
                    ExchRateAdjmtReg.SETRANGE("Posting Group", "Bank Acc. Posting Group");
                    IF ExchRateAdjmtReg.FIND('+') THEN
                        ExchFactor := ExchRateAdjmtReg."Currency Factor"
                    ELSE
                        ExchFactor := 0;

                    ExchRate := CurrExchRate.ExchangeRateAdjmt(AdjDate, "Currency Code");
                END;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(DateRange)
                {
                    field(AdjDate; AdjDate)
                    {
                        Caption = 'As of Date';
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

    trigger OnPreReport()
    begin
        IF AdjDate = 0D THEN
            ERROR(Err001);

        SourceCodeSetupRef.GET;
        ExchSourceCode := SourceCodeSetupRef."Exchange Rate Adjmt.";
        //CurrencyFilter := Currency.GETFILTERS;
        BankAccFilter := BankAccount.GETFILTERS();
    end;


    VAR
        StartDate: Date;
        EndDate: Date;
        BankLedgerRef: Record "Bank Account Ledger Entry";
        BankAccountRef: Record "Bank Account";
        AmountBefore: Decimal;
        AmountLCYBefore: Decimal;
        AmountAfter: Decimal;
        AmountLCYAfter: Decimal;
        ExchRateAdjmtReg: Record "Exch. Rate Adjmt. Reg.";
        Currency2: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        SourceCodeSetupRef: Record "Source Code Setup";
        ExchSourceCode: Code[10];
        ExchFactor: Decimal;
        AdjDate: Date;
        Text000: Label 'As of Date: %1';
        Text001: Label 'Bank Account : %1       %2';
        Text002: Label 'Currency Total : %1';
        CurrencyFilter: Text;
        BankAccFilter: Text;
        AdjustAmount: Decimal;
        Text003: Label 'Currency : %1';
        Text004: Label 'Bank Account Posting Group : %1';
        Text005: Label 'Exchange Difference Total : %1';
        Text006: Label 'Posting Group Total in %1 ';
        Text007: Label 'Currency Total in %1';
        Text008: Label 'Relational Adjmt. Exch. Rate: %1';
        Text009: Label 'New Rate :  %1';
        Err001: Label 'As of Date should be entered.';
        ExchRate: Decimal;

}
