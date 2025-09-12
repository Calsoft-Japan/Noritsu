reportextension 50101 "Sales Quote Ext." extends "Standard Sales - Quote"
{
    //RDLCLayout = '.\RDLC\SalesQuote_NSP.RDLC';

    dataset
    {
        add(Header)
        {
            column(CompanyFaxNo; CompanyInfo1."Fax No.")
            {
            }

            column(CoRegNo; CompanyInfo1."Industrial Classification")
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

            column(SellToVATNo; SellToVATNo)
            { }
            column(BillToVATNo; BillToVATNo)
            { }
        }

        modify(Header)
        {
            trigger OnAfterPreDataItem()
            begin
                CompanyInfo1.Get();
            end;

            trigger OnAfterAfterGetRecord()
            var
                Cust: Record Customer;
            begin
                FormatAddrX.SalesHeaderSellTo(SellToAddrX, Header);

                Clear(BillToVATNo);
                Cust.Reset();
                if Cust.Get("Bill-to Customer No.") then
                    BillToVATNo := Cust."VAT Registration No.";

                Clear(SellToVATNo);
                Cust.Reset();
                if Cust.Get("Sell-to Customer No.") then
                    SellToVATNo := Cust."VAT Registration No.";
            end;
        }


        add(Line)
        {
            column(LineDiscountAmount; "Line Discount Amount")
            {
                AutoFormatExpression = Header."Currency Code";
                AutoFormatType = 1;
            }
            column(Amount; Amount)
            {
                AutoFormatExpression = Header."Currency Code";
                AutoFormatType = 1;
            }
            column(ItemInventory; ItemInventory)
            { }
            column(StockAvaliable; StockAvaliable)
            { }
            column(ItemHSCode; ItemHSCode)
            { }

        }

        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                Clear(StockAvaliable);
                Clear(ItemInventory);
                Clear(ItemHSCode);

                Item.Reset();
                if Line.Type = Line.Type::Item then begin
                    Item.Get(Line."No.");
                    ItemHSCode := Item."HS Code";
                    Item.CalcFields(Inventory);
                    if Item.Inventory > 0 then begin
                        StockAvaliable := 'Yes';
                        ItemInventory := Item.Inventory;
                    end;
                end;
            end;
        }
    }

    var
        CompanyInfo1: Record "Company Information";
        Item: Record Item;
        StockAvaliable: Code[5];
        ItemInventory: Decimal;

        FormatAddrX: Codeunit "Format Address";
        SellToAddrX: array[8] of Text[100];
        ItemHSCode: Text;
        BillToVATNo: Text;
        SellToVATNo: Text;
}
