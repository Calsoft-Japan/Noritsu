codeunit 50000 "CS FDD012"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostItemJnlLineBeforePost', '', true, true)]
    local procedure "Sales-Post_OnAfterPostItemJnlLineBeforePost"
    (
        var ItemJournalLine: Record "Item Journal Line";
        SalesLine: Record "Sales Line";
        QtyToBeShippedBase: Decimal;
        var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"
    )
    begin
        ItemJournalLine."QSS System Code" := SalesLine."QSS System Code";
        ItemJournalLine."Shipment Creation Date" := SalesLine."Posting Date";

        ItemJournalLine."Expiry Date" := SalesLine."Expiry Date";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeItemJnlPostLine', '', true, true)]
    local procedure "Purch.-Post_OnBeforeItemJnlPostLine"
    (
        var ItemJournalLine: Record "Item Journal Line";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        CommitIsSupressed: Boolean;
        var IsHandled: Boolean;
        WhseReceiptHeader: Record "Warehouse Receipt Header";
        WhseShipmentHeader: Record "Warehouse Shipment Header";
        TempItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)";
        TempWarehouseReceiptHeader: Record "Warehouse Receipt Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."
    )
    begin
        ItemJournalLine."Expiry Date" := PurchaseLine."Expiry Date";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure "Item Jnl.-Post Line_OnAfterInitItemLedgEntry"
    (
        var NewItemLedgEntry: Record "Item Ledger Entry";
        var ItemJournalLine: Record "Item Journal Line";
        var ItemLedgEntryNo: Integer
    )
    begin
        NewItemLedgEntry."QSS System Code" := ItemJournalLine."QSS System Code";
        NewItemLedgEntry."Shipment Creation Date" := ItemJournalLine."Shipment Creation Date";

        NewItemLedgEntry."Expiry Date" := ItemJournalLine."Expiry Date";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSalesLineInsert', '', true, true)]
    local procedure "Sales Header_OnBeforeSalesLineInsert"
    (
        var SalesLine: Record "Sales Line";
        var TempSalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header"
    )
    begin
        //PBC Modification
        SalesLine."QSS System Code" := TempSalesLine."QSS System Code";
        SalesLine."Set Quantity" := TempSalesLine."Set Quantity";
        SalesLine.QA := TempSalesLine.QA;
        SalesLine."Latest Item No." := TempSalesLine."Latest Item No.";
        SalesLine."BOM Item No." := TempSalesLine."BOM Item No.";
        SalesLine."QSS Package Code" := TempSalesLine."QSS Package Code";
        //PBC Modification
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', true, true)]
    local procedure "TransferOrder-Post Shipment_OnAfterCreateItemJnlLine"
    (
        var ItemJournalLine: Record "Item Journal Line";
        TransferLine: Record "Transfer Line";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferShipmentLine: Record "Transfer Shipment Line"
    )
    var
        _InventorySetup: Record "Inventory Setup";
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        _InventorySetup.GET();
        ItemJournalLine."Gen. Bus. Posting Group" := _InventorySetup."Bus. Posting Group (Transfer)";

        if ItemLedgEntry.Get(TransferLine."Appl.-to Item Entry") then
            ItemJournalLine."Expiry Date" := ItemLedgEntry."Expiry Date";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', true, true)]
    local procedure "TransferOrder-Post Receipt_OnBeforePostItemJournalLine"
    (
        var ItemJournalLine: Record "Item Journal Line";
        TransferLine: Record "Transfer Line";
        TransferReceiptHeader: Record "Transfer Receipt Header";
        TransferReceiptLine: Record "Transfer Receipt Line";
        CommitIsSuppressed: Boolean;
        TransLine: Record "Transfer Line";
        PostedWhseRcptHeader: Record "Posted Whse. Receipt Header"
    )
    var
        _InventorySetup: Record "Inventory Setup";
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        _InventorySetup.GET();
        ItemJournalLine."Gen. Bus. Posting Group" := _InventorySetup."Bus. Posting Group (Transfer)";

        if ItemLedgEntry.Get(TransferLine."Appl.-to Item Entry") then
            ItemJournalLine."Expiry Date" := ItemLedgEntry."Expiry Date";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', true, true)]
    local procedure "Item Jnl.-Post Line_OnBeforeInsertItemLedgEntry"
    (
        var ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJournalLine: Record "Item Journal Line";
        TransferItem: Boolean;
        OldItemLedgEntry: Record "Item Ledger Entry";
        ItemJournalLineOrigin: Record "Item Journal Line"
    )
    begin
        if ItemLedgerEntry.Positive then
            ItemLedgerEntry."Expiry Date" := OldItemLedgEntry."Expiry Date";

        if (ItemLedgerEntry."Expiry Date" = 0D) and (ItemJournalLineOrigin."Expiry Date" <> 0D) then
            ItemLedgerEntry."Expiry Date" := ItemJournalLineOrigin."Expiry Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Doc. Management", 'OnRetrieveDocumentItemTracking', '', true, true)]

    local procedure OnRetrieveDocumentItemTracking(var TempTrackingSpecBuffer: Record "Tracking Specification" temporary; SourceID: Code[20]; var Found: Boolean; SourceType: Integer; SourceSubType: Option; RetrieveAsmItemTracking: Boolean)
    var
        TransferLine: Record "Transfer Line";
        Item: Record Item;
        Descr: Text[100];
        ItemTrackingDocManagement: Codeunit "Item Tracking Doc. Management";
    begin
        TransferLine.SetRange("Document No.", SourceID);
        if not TransferLine.IsEmpty() then begin
            TransferLine.FindSet();
            repeat
                if (TransferLine."Item No." <> '') and
                   (TransferLine."Quantity (Base)" <> 0)
                then begin
                    if Item.Get(TransferLine."Item No.") then
                        Descr := Item.Description;
                    ItemTrackingDocManagement.FindReservEntries(
                        TempTrackingSpecBuffer, DATABASE::"Transfer Line", 0,
                        TransferLine."Document No.", '', 0, TransferLine."Line No.", Descr);
                    ItemTrackingDocManagement.FindTrackingEntries(
                        TempTrackingSpecBuffer, DATABASE::"Transfer Line", 0,
                        TransferLine."Document No.", '', 0, TransferLine."Line No.", Descr);
                end;
            until TransferLine.Next() = 0;
        end;
        Found := true;
    end;

}
