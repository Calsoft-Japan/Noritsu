page 50052 "Standard Accessories"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    ApplicationArea = All;
    Caption = 'Standard Accessories';
    PageType = List;
    SourceTable = "Standard Accessory";
    UsageCategory = Lists;
    Editable = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Module No."; Rec."Module No.")
                {
                    Caption = 'Item Code (Machine)';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Code (Machine) field.';
                }
                field("Module Serial No."; Rec."Module Serial No.")
                {
                    Caption = 'Serial No. (Machine)';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Serial No. (Machine) field.';
                }
                field("Accessory Code"; Rec."Accessory Code")
                {
                    Caption = 'Item Code (Parts)';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Code (Parts) field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Acc. Serial No."; Rec."Acc. Serial No.")
                {
                    Caption = 'Serial No. (Parts)';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Serial No. (Parts) field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SA: Record "Standard Accessory";
    begin
        SA.Reset();
        SA.SetRange("Module No.", Rec."Module No.");
    end;
}
