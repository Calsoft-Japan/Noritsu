reportextension 50112 "Pick Instruction Ext." extends "Pick Instruction"
{

    dataset
    {
        add("Sales Line")
        {
            column(Serial_Line_Pkg; Serial_Line_Pkg)
            {
            }
        }

        modify("Sales Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                TempTrackingSpecBuffer: Record "Tracking Specification" temporary;
            begin
                Clear(Serial_Line_Pkg);
                ItemTrackingDocMgt.RetrieveDocumentItemTracking(TempTrackingSpecBuffer, "Document No.", DATABASE::"Sales Header", 1);
                if TempTrackingSpecBuffer.Find('-') then begin
                    repeat
                        if (TempTrackingSpecBuffer."Item No." = "No.") and (TempTrackingSpecBuffer."Serial No." <> '') then
                            Serial_Line_Pkg := Serial_Line_Pkg + TempTrackingSpecBuffer."Serial No." + ', ';
                    until TempTrackingSpecBuffer.Next() = 0;

                    if StrLen(Serial_Line_Pkg.Trim()) > 0 then
                        Serial_Line_Pkg := DelStr(Serial_Line_Pkg, StrLen(Serial_Line_Pkg) - 1, 2);
                end;
            end;
        }
    }

    var
        Serial_Line_Pkg: Text;

}
