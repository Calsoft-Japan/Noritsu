reportextension 50115 "Sales Return Receipt Ext." extends "Sales - Return Receipt"
{
    //RDLCLayout = '.\RDLC\PurchaseOrder_NAL.RDLC';

    dataset
    {
        add("Return Receipt Line")
        {
            column(BinCode; "Bin Code")
            {
            }
            column(Serial_Line_Pkg; Serial_Line_Pkg)
            {
            }
        }

        modify("Return Receipt Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                TempItemLedgEntry: Record "Item Ledger Entry" temporary;
            begin

                Clear(Serial_Line_Pkg);
                ItemTrackingDocMgt.RetrieveEntriesFromShptRcpt(TempItemLedgEntry, DATABASE::"Return Receipt Line", 0, "Document No.", '', 0, "Line No.");
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
    }

    var
        Serial_Line_Pkg: Text;

}
