pageextension 50007 "Service Management Setup Ext" extends "Service Mgt. Setup"
{
    layout
    {
        addafter("Contract Value %")
        {
            field("Prepaid Inv. for Whole Year"; Rec."Prepaid Inv. for Whole Year")
            {
                ApplicationArea = Service;
            }

            field("Discount % for Parts Sale"; Rec."Discount % for Parts Sale")
            {
                ApplicationArea = Service;
            }
        }
    }
}
