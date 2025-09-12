reportextension 50107 "Service Order Ext" extends "Service Order"
{
    //RDLCLayout = '.\RDLC\ServiceOrder_NMS.RDLC';
    dataset
    {
        modify("Service Header")
        {
            trigger OnAfterAfterGetRecord()
            begin
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
            end;
        }
        add(PageLoop)
        {
            column(CompanyPic; CompanyX.Picture)
            { }
            column(CompanyVATRegNo; CompanyX."VAT Registration No.")
            { }
            column(DocDate; Format("Service Header"."Document Date", 0, 4))
            { }
            column(YourRef; "Service Header"."Your Reference")
            { }
            column(SellToPhone; Cust."Phone No.")
            { }
            column(SellToCustCode; "Service Header"."Customer No.")
            { }
        }

        modify(PageLoop)
        {
            trigger OnAfterAfterGetRecord()
            begin
                Cust.Reset();
                if Cust.Get("Service Header"."Customer No.") then;
            end;
        }

        add("Service Line")
        {
            column(Warranty_ServiceLine; Warranty)
            { }
            column(Contract_No_ServiceLine; "Contract No.")
            { }
            column(Line_Discount__; "Line Discount %")
            { }
            column(Line_Discount_Amount; "Line Discount Amount")
            { }
            column(Amount; Amount)
            { }
            column(TotalAmount; TotalAmount)
            { }
            column(TotalAmountVAT; TotalAmountVAT)
            { }
            column(TotalAmountInclVAT; TotalAmountInclVAT)
            { }
        }

        modify("Service Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                TotalAmount += Amount;
                TotalAmountVAT += "Amount Including VAT" - Amount;
                TotalAmountInclVAT += "Amount Including VAT";
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyX.Get();
        CompanyX.CalcFields(Picture);
    end;

    var
        CompanyX: Record "Company Information";
        Cust: Record Customer;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
}
