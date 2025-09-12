pageextension 50024 "Serial No. Information Ext" extends "Serial No. Information Card"
{
    actions
    {
        addafter(Comment)
        {
            action(StandardAcces)
            {
                ApplicationArea = ItemTracking;
                Caption = 'Standard Accessories';
                Image = ViewComments;
                RunObject = Page "Standard Accessories";
                RunPageLink = "Module No." = FIELD("Item No."),
                                  "Module Serial No." = FIELD("Serial No.");
                ToolTip = 'View standard accessories for the record.';
            }
        }
    }
}
