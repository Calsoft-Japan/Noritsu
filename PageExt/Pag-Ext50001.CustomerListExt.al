pageextension 50001 "Customer List Ext" extends "Customer List"
{
    layout
    {
        //#if not CLEAN22
        modify("Name 2")
        {
            Visible = true;
        }
        //#endif
        addafter(Contact)
        {
            field("Customer Group 1"; Rec."Customer Group Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Customer Group 2"; Rec."Customer Group 2 Code")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
