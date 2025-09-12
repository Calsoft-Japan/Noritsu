reportextension 50110 "G/L Register Ext" extends "G/L Register"
{
    //RDLCLayout = '.\RDLC\GLRegister_CS.RDLC';
    dataset
    {
        add("G/L Register")
        {
            column(Creation_Date; Format("Creation Date", 0, '<Year>/<Month,2>/<Day,2>'))
            { }
            column(User_ID; "User ID")
            { }
        }
        add("G/L Entry")
        {
            column(Source_Type; "Source Type")
            { }
            column(Source_No_; "Source No.")
            { }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            { }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            { }
            column(DebitAmount; DebitAmount)
            { }
            column(CreditAmount; CreditAmount)
            { }
        }

        modify("G/L Entry")
        {
            trigger OnAfterAfterGetRecord()
            begin
                Clear(DebitAmount);
                Clear(CreditAmount);
                DebitAmount := "Debit Amount";
                CreditAmount := "Credit Amount";
            end;
        }


        modify("Purch. Inv. Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                Clear(DebitAmount);
                Clear(CreditAmount);
            end;
        }

    }
    var
        DebitAmount: Decimal;
        CreditAmount: Decimal;

        Pur_DebitAmount: Decimal;
        Pur_CreditAmount: Decimal;
}
