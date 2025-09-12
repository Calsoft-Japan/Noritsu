reportextension 50103 "Sales Shipment Ext" extends "Sales - Shipment"
{
    //RDLCLayout = '.\RDLC\SalesShipment_NAL.RDLC';

    dataset
    {
        add(PageLoop)
        {
            column(CompanyInfoPicture; CompanyInfoX.Picture)
            { }
            column(SelltoCustName_SalesShptHeader; "Sales Shipment Header"."Sell-to Customer Name")
            { }
            column(PostDate_SalesShptHeader; "Sales Shipment Header"."Posting Date")
            { }

            column(OrderDate_SalesShptHeader; "Sales Shipment Header"."Order Date")
            { }

            column(SellToCustAddr1; SellToCustAddr[1])
            {
            }
            column(SellToCustAddr2; SellToCustAddr[2])
            {
            }
            column(SellToCustAddr3; SellToCustAddr[3])
            {
            }
            column(SellToCustAddr4; SellToCustAddr[4])
            {
            }
            column(SellToCustAddr5; SellToCustAddr[5])
            {
            }
            column(SellToCustAddr6; SellToCustAddr[6])
            {
            }
            column(SellToCustAddr7; SellToCustAddr[7])
            {
            }
            column(SellToCustAddr8; SellToCustAddr[8])
            {
            }

            column(ShipToPhone; Cust."Phone No.")
            { }

            column(VATRegistrationNo; "Sales Shipment Header".GetCustomerVATRegistrationNumber())
            {
            }
            column(CoRegNo; CompanyInfoX."Registration No.")
            {
            }
            column(Industrial_Classification; CompanyInfoX."Industrial Classification")
            {
            }
            column(SaleInvoiceNo; SInvNo)
            { }
            column(ShipToCode; "Sales Shipment Header"."Ship-to Code")
            { }

            column(FormateDate_SalesShptHeader; Format("Sales Shipment Header"."Document Date", 0, 4))
            {
            }
        }

        modify("Sales Shipment Header")
        {
            trigger OnAfterPreDataItem()
            begin
                CompanyInfoX.Get();
                CompanyInfoX.CalcFields(Picture);
            end;

            trigger OnAfterAfterGetRecord()
            begin
                Clear(SInvNo);

                FormatAddrX.SalesShptSellTo(SellToCustAddr, "Sales Shipment Header");

                Cust.Get("Sales Shipment Header"."Sell-to Customer No.");

                SOInvHdr.Reset();
                SOInvHdr.SetRange("Order No.", "Sales Shipment Header"."Order No.");
                if SOInvHdr.FindFirst() then
                    SInvNo := SOInvHdr."No.";
            end;
        }

        add("Sales Shipment Line")
        {
            column(Serial_No_Line; ItemLedgerEntry."Serial No.")
            { }

            column(Serial_Line_Pkg; Serial_Line_Pkg)
            { }

            column(Ordered; Ordered)
            { }

            column(BackOrder; BackOrder)
            { }
        }

        addfirst("Sales Shipment Line")
        {
            /*
            dataitem(ReservationEntry; "Reservation Entry")
            {
                DataItemLink = "Source ID" = field("Document No."), "Source Ref. No." = FIELD("Line No.");
                DataItemLinkReference = "Sales Shipment Line";
                DataItemTableView = SORTING("Source ID", "Source Ref. No.");
            }
            */

            dataitem(ItemEntry; "Item Entry Relation")
            {
                DataItemLink = "Source ID" = field("Document No."), "Source Ref. No." = FIELD("Line No.");
                DataItemLinkReference = "Sales Shipment Line";
                DataItemTableView = SORTING("Source ID", "Source Ref. No.");

                column(Serial_No_; "Serial No.")
                { }
            }
        }

        modify("Sales Shipment Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                TempItemLedgEntry: Record "Item Ledger Entry" temporary;
            begin
                Clear(Ordered);
                Clear(BackOrder);

                Clear(Serial_Line_Pkg);
                ItemTrackingDocMgt.RetrieveEntriesFromShptRcpt(TempItemLedgEntry, DATABASE::"Sales Shipment Line", 0, "Document No.", '', 0, "Line No.");
                if TempItemLedgEntry.Find('-') then begin
                    repeat
                        if TempItemLedgEntry."Serial No." <> '' then
                            Serial_Line_Pkg := Serial_Line_Pkg + TempItemLedgEntry."Serial No." + ', ';
                    until TempItemLedgEntry.Next() = 0;

                    if StrLen(Serial_Line_Pkg.Trim()) > 0 then
                        Serial_Line_Pkg := DelStr(Serial_Line_Pkg, StrLen(Serial_Line_Pkg) - 1, 2);
                end;


                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                ItemLedgerEntry.SetRange("Document No.", "Sales Shipment Line"."Document No.");
                ItemLedgerEntry.SetRange("Item No.", "Sales Shipment Line"."No.");
                ItemLedgerEntry.SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
                if ItemLedgerEntry.FindFirst() then begin end;

                if "Sales Shipment Line"."Order No." <> '' then begin
                    SOLine.Reset();
                    SOLine.SetRange("Document Type", SOLine."Document Type"::Order);
                    SOLine.SetRange("Document No.", "Sales Shipment Line"."Order No.");
                    SOLine.SetRange("Line No.", "Sales Shipment Line"."Order Line No.");
                    if SOLine.FindFirst() then begin
                        Ordered := SOLine.Quantity;
                        //BackOrder := SOLine."Outstanding Quantity";
                    end
                    else begin
                        ShptLine.Reset();
                        ShptLine.SetRange("Order No.", "Sales Shipment Line"."Order No.");
                        ShptLine.SetRange("Order Line No.", "Sales Shipment Line"."Order Line No.");
                        if ShptLine.FindFirst() then begin
                            repeat
                                Ordered += ShptLine.Quantity;
                            until ShptLine.Next() = 0;
                        end;
                    end;

                    ShptLine.Reset();
                    ShptLine.SetRange("Order No.", "Sales Shipment Line"."Order No.");
                    ShptLine.SetRange("Order Line No.", "Sales Shipment Line"."Order Line No.");
                    ShptLine.SetFilter("Item Shpt. Entry No.", '<=%1', "Sales Shipment Line"."Item Shpt. Entry No.");
                    //ShptLine.SetFilter("Posting Date", '..%1', "Sales Shipment Line"."Posting Date");
                    if ShptLine.FindFirst() then begin
                        repeat
                            BackOrder += ShptLine.Quantity;
                        until ShptLine.Next() = 0;

                        BackOrder := Ordered - BackOrder;
                    end;
                end
                else begin
                    Ordered := "Sales Shipment Line".Quantity;
                    BackOrder := 0;
                end;
            end;
        }

    }

    var
        CompanyInfoX: Record "Company Information";
        ItemLedgerEntry: Record "Item Ledger Entry";
        SOLine: Record "Sales Line";
        ShptLine: Record "Sales Shipment Line";
        SOInvHdr: Record "Sales Invoice Header";
        Cust: Record Customer;

        Ordered: Decimal;
        BackOrder: Decimal;
        SellToCustAddr: array[8] of Text[100];
        FormatAddrX: Codeunit "Format Address";

        SInvNo: Code[20];
        Serial_Line_Pkg: Text;

}
