tableextension 50150 "Service Mgt. Setup Ext" extends "Service Mgt. Setup"
{
    fields
    {
        field(50000; "Prepaid Inv. for Whole Year"; Boolean)
        {
        }
        field(50001; "Defaul Service Item Status"; Option)
        {
            Caption = 'Defaul Service Item Status';
            OptionMembers = " ","Resale/Disposal",BY,"Rental/Click";
        }
        field(50002; "Discount % for Parts Sale"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
    }
}

