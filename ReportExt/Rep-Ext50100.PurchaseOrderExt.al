reportextension 50100 "Purchase Order Ext." extends "Standard Purchase - Order"
{
    //RDLCLayout = '.\RDLC\PurchaseOrder_NAL.RDLC';

    dataset
    {
        add("Purchase Header")
        {
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }

            column(CompanyFaxNo; CompanyInfo1."Fax No.")
            {
            }

            column(CoRegNo; CompanyInfo1."Registration No.")
            {

            }
        }

        modify("Purchase Header")
        {
            trigger OnAfterPreDataItem()
            begin
                CompanyInfo1.Get();
            end;
        }

        add("Purchase Line")
        {
            column(LineDiscountAmount; "Line Discount Amount")
            {
                AutoFormatExpression = "Purchase Header"."Currency Code";
                AutoFormatType = 1;
            }
            column(Amount; Amount)
            {
                AutoFormatExpression = "Purchase Header"."Currency Code";
                AutoFormatType = 1;
            }
            column(Description_2; "Description 2")
            {

            }
        }


    }

    var
        CompanyInfo1: Record "Company Information";
}
