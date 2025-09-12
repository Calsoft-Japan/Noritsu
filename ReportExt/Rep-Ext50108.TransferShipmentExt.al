reportextension 50108 "Transfer Shipment Ext" extends "Transfer Shipment"
{
    //RDLCLayout = '.\RDLC\TransferShipment_NAL.RDLC';
    dataset
    {
        add(PageLoop)
        {
            column(CompanyPic; CompanyInfo.Picture)
            { }
            column(CompanyPhone; CompanyInfo."Phone No.")
            { }
            column(CompanyFax; CompanyInfo."Fax No.")
            { }
            column(CompanyVATNo; CompanyInfo."VAT Registration No.")
            { }
            column(CompanyCoRegNo; CompanyInfo."Registration No.")
            { }
            column(TransOrderNo; "Transfer Shipment Header"."Transfer Order No.")
            { }
            column(TransToName; "Transfer Shipment Header"."Transfer-to Name")
            { }
            column(TransFromName; "Transfer Shipment Header"."Transfer-from Name")
            { }
        }

        add("Transfer Shipment Line")
        {
            column(Serial_No_Line; Serial_No_Line)
            { }
            column(QtyOrdered; QtyOrdered)
            { }
            column(ShippingQty; ShippingQty)
            { }
            column(ShippedQty; ShippedQty)
            { }
        }
        modify("Transfer Shipment Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                Clear(Serial_No_Line);
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Transfer Shipment");
                ItemLedgerEntry.SetRange("Document No.", "Transfer Shipment Line"."Document No.");
                ItemLedgerEntry.SetRange("Item No.", "Transfer Shipment Line"."Item No.");
                ItemLedgerEntry.SetRange("Document Line No.", "Transfer Shipment Line"."Line No.");
                if ItemLedgerEntry.FindFirst() then Serial_No_Line := ItemLedgerEntry."Serial No.";

                Clear(QtyOrdered);
                Clear(ShippingQty);
                Clear(ShippedQty);
                if "Transfer Shipment Line"."Item No." <> '' then begin
                    TransLine.Reset();
                    TransLine.SetRange("Document No.", "Transfer Shipment Line"."Transfer Order No.");
                    TransLine.SetFilter("Line No.", '%1', "Transfer Shipment Line"."Trans. Order Line No.");
                    if TransLine.Find('-') then begin
                        QtyOrdered := TransLine.Quantity;
                    end else begin //if Transfer Order has been fully posted to Transfer Shipments
                        TranShipmenLine.Reset();
                        TranShipmenLine.SetRange("Transfer Order No.", "Transfer Shipment Line"."Transfer Order No.");
                        TranShipmenLine.SetFilter("Line No.", '%1', "Transfer Shipment Line"."Line No.");
                        if TranShipmenLine.Find('-') then begin
                            repeat
                                QtyOrdered += TranShipmenLine.Quantity;
                            until TranShipmenLine.Next() = 0;
                        end;
                    end;
                    ShippingQty := "Transfer Shipment Line".Quantity;
                    TranShipmenLine.Reset();
                    TranShipmenLine.SetRange("Transfer Order No.", "Transfer Shipment Line"."Transfer Order No.");
                    TranShipmenLine.SetFilter("Line No.", '%1', "Transfer Shipment Line"."Line No.");
                    if TranShipmenLine.Find('-') then
                        repeat
                            ShippedQty += TranShipmenLine.Quantity;
                        until TranShipmenLine.Next() = 0;
                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TransLine: Record "Transfer Line";
        TranShipmenLine: Record "Transfer Shipment Line";
        QtyOrdered: Decimal;
        ShippingQty: Decimal;
        ShippedQty: Decimal;
        Serial_No_Line: Text;
}
