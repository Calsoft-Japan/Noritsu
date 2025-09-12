codeunit 50003 "Sales-Explode BOM Ext"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Explode BOM", 'OnBeforeToSalesLineModify', '', true, true)]
    local procedure "Sales-Explode BOM_OnBeforeToSalesLineModify"
    (
        var ToSalesLine: Record "Sales Line";
        FromSalesLine: Record "Sales Line"
    )
    var
        item2: Record Item;
        BOMItemNo: Code[20];
    begin
        if FromSalesLine."BOM Item No." = '' then
            BOMItemNo := FromSalesLine."No."
        else
            BOMItemNo := FromSalesLine."BOM Item No.";

        //tkh
        item2.GET(BOMItemNo);
        ToSalesLine."QSS System Code" := item2."QSS System Code";
        //
        // SAS 20070423 ->
        ToSalesLine."QSS Package Code" := BOMItemNo;
        // SAS 20070423 <-
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Explode BOM", 'OnInsertOfExplodedBOMLineToSalesLine', '', true, true)]
    local procedure "Sales-Explode BOM_OnInsertOfExplodedBOMLineToSalesLine"
    (
        var ToSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        BOMComponent: Record "BOM Component";
        var SalesHeader: Record "Sales Header";
        LineSpacing: Integer
    )
    var
        item2: Record Item;
        BOMItemNo: Code[20];
    begin
        BOMItemNo := ToSalesLine."BOM Item No.";
        item2.GET(BOMItemNo);

        //tkh
        ToSalesLine."QSS System Code" := item2."QSS System Code";
        ToSalesLine."Set Quantity" := SalesLine."Quantity (Base)";
        //
        // SAS 20070423 ->
        ToSalesLine."QSS Package Code" := BOMItemNo;
        // SAS 20070423 <-
    end;


}
