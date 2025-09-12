reportextension 50104 "Sales Credit Memo Ext" extends "Standard Sales - Credit Memo"
{
    //RDLCLayout = '.\RDLC\SalesCreditMemo_NAL.RDLC';

    dataset
    {
        add(Header)
        {
            column(CompanyFaxNo; CompanyInfo1."Fax No.")
            {
            }
            column(GstRegNo; CustX."VAT Registration No.")
            { }
            column(ABNGSTNo; ABNGSTNo)
            {
            }
            column(RetOrder; Header."Return Order No.")
            { }

            column(PstDate; Header."Posting Date")
            { }

            column(BillToPhone; CustX."Phone No.")
            { }

            column(CoRegNo; CompanyInfo1."Registration No.")
            {
            }

            column(ReturnOrder; Header."Return Order No.")
            { }
            column(HeaderIndustrial; CompanyInfo1."Industrial Classification")
            { }
            column(ApplyDocType; Format(Header."Applies-to Doc. Type"))
            { }
            column(ApplyDocNo; Header."Applies-to Doc. No.")
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
            column(SellToRegNo; SellToRegNo)
            { }
            column(SellToPhoneNo; SellToPhoneNo)
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
        }

        modify(Header)
        {
            trigger OnAfterPreDataItem()
            begin
                CompanyInfo1.Get();
            end;

            trigger OnAfterAfterGetRecord()
            begin
                if UpperCase("Currency Code") = 'NZD' then begin
                    ABNGSTNo := CompanyInfo1.GetRegistrationNumber();
                end else
                    ABNGSTNo := CompanyInfo1.GetVATRegistrationNumber();

                CustX.Reset();
                CustX.Get(Header."Bill-to Customer No.");

                FormatAddrX.FormatAddr(
                  ShipToAddrX, "Ship-to Name", "Ship-to Name 2", "Ship-to Contact", "Ship-to Address", "Ship-to Address 2",
                  "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code");

                FormatAddrX.SalesCrMemoSellTo(SellToAddrX, Header);
                CustSellTo.Reset();
                if CustSellTo.Get("Sell-to Customer No.") then begin
                    SellToRegNo := CustSellTo."VAT Registration No.";
                    SellToPhoneNo := CustSellTo."Phone No.";
                end;
            end;
        }

        add(Line)
        {
            column(LineDiscountAmount; "Line Discount Amount")
            {
            }
            column(UnitCost; "Unit Price")// "Unit Cost")
            { }
            column(Amount; Amount)
            {
            }

            column(Serial_Line_Pkg; Serial_Line_Pkg)
            { }
        }

        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            var
                ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                TempItemLedgEntry: Record "Item Ledger Entry" temporary;
            begin
                Clear(Serial_Line_Pkg);

                ItemTrackingDocMgt.RetrieveEntriesFromPostedInvoice(TempItemLedgEntry, Line.RowID1());
                if TempItemLedgEntry.Find('-') then begin
                    repeat
                        if TempItemLedgEntry."Serial No." <> '' then
                            Serial_Line_Pkg := Serial_Line_Pkg + TempItemLedgEntry."Serial No." + ', ';
                    until TempItemLedgEntry.Next() = 0;

                    if StrLen(Serial_Line_Pkg.Trim()) > 0 then
                        Serial_Line_Pkg := DelStr(Serial_Line_Pkg, StrLen(Serial_Line_Pkg) - 1, 2);
                end;
            end;
        }

        addfirst(Line)
        {
            dataitem(ItemEntry; "Item Entry Relation")
            {
                DataItemLink = "Source ID" = field("Document No."), "Source Ref. No." = FIELD("Line No.");
                DataItemLinkReference = Line;
                DataItemTableView = SORTING("Source ID", "Source Ref. No.");

                column(Serial_No_; "Serial No.")
                { }
            }
        }

        modify(ReportTotalsLine)
        {
            trigger OnAfterPreDataItem()
            var
                GLSetup: Record "General Ledger Setup";
            begin
                GLSetup.Get();

                ReportTotalsLine.Reset();
                ReportTotalsLine.SetFilter(Description, '%1', '* VAT (LCY)');
                if ReportTotalsLine.Find('-') and (Header."Currency Code" <> GLSetup."LCY Code") then
                    ReportTotalsLine.Delete();

                ReportTotalsLine.Reset();
                if ReportTotalsLine.FindFirst() then;
            end;

        }

    }

    var
        CompanyInfo1: Record "Company Information";
        ShipToAddrX: array[8] of Text[100];
        CustX: Record Customer;
        CustSellTo: Record Customer;
        FormatAddrX: Codeunit "Format Address";
        SellToAddrX: array[8] of Text[100];
        ABNGSTNo: Text;
        Serial_Line_Pkg: Text;
        SellToRegNo: Text;
        SellToPhoneNo: Text;
}
