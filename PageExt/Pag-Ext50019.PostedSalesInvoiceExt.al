pageextension 50019 "Posted Sales Invoice Ext" extends "Posted Sales Invoice"
{
    layout
    { }
    actions
    {
        addafter(SendCustom)
        {
            action(PrintPkg)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print (Package Summary)';
                Ellipsis = true;
                Image = SendToMultiple;
                //RunObject = report 1306;
                //RunPageOnRec = true;

                trigger OnAction()
                var
                    SInv: Record "Sales Invoice Header";
                begin
                    SInv.Reset();
                    SInv.SetRange("No.", Rec."No.");
                    SInv.Find('-');
                    Report.Run(1306, true, false, SInv);
                end;
            }
        }

        addafter(SendCustom_Promoted)
        {
            actionref(PrintPkg_Promoted; PrintPkg)
            { }
        }
    }
}
