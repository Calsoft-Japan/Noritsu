reportextension 50102 "Sales Ord Confirmation Ext" extends "Standard Sales - Order Conf."
{
    //RDLCLayout = '.\RDLC\SalesOrderConf_NAL.RDLC';

    dataset
    {
        add(Header)
        {
            column(CompanyFaxNo; CompanyInfo1."Fax No.")
            {
            }
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
            column(CustVATRegNo; CustVATRegNo)
            {
            }
            column(BillToVATNo; BillToVATNo)
            { }
            column(ABNGSTNo; ABNGSTNo)
            { }
        }

        modify(Header)
        {
            trigger OnAfterPreDataItem()
            begin
                CompanyInfo1.Get();
            end;

            trigger OnAfterAfterGetRecord()
            begin
                FormatAddrX.SalesHeaderSellTo(SellToAddrX, Header);


                Clear(CustVATRegNo);
                CustX.Reset();
                if CustX.Get("Sell-to Customer No.") then
                    CustVATRegNo := CustX."VAT Registration No.";

                Clear(BillToVATNo);
                CustX.Reset();
                if CustX.Get("Bill-to Customer No.") then
                    BillToVATNo := CustX."VAT Registration No.";

                if UpperCase(Header."Currency Code") = 'NZD' then begin
                    ABNGSTNo := CompanyInfo1.GetRegistrationNumber();
                end else
                    ABNGSTNo := CompanyInfo1.GetVATRegistrationNumber();
            end;
        }

        add(Line)
        {
            column(LineDiscountAmount; "Line Discount Amount")
            {
            }
            column(Amount; Amount)
            {
            }
        }

    }

    var
        CompanyInfo1: Record "Company Information";
        CustX: Record Customer;
        CustVATRegNo: Text[20];
        FormatAddrX: Codeunit "Format Address";
        SellToAddrX: array[8] of Text[100];
        BillToVATNo: Text;
        ABNGSTNo: Text;
}
