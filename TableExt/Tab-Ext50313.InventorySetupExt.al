tableextension 50313 "Inventory Setup Ext" extends "Inventory Setup"
{


    fields
    {

        field(50000;"Parts Item Category";Code[10])
        {
            TableRelation = "Item Category".Code;
        }
        field(50001;"Default Serial Tracking Code";Code[10])
        {
            Caption = 'Default Serial Tracking Code (Interface)';
            TableRelation = "Item Tracking Code".Code WHERE ("SN Specific Tracking"=CONST(true),
                                                             "SN Info. Inbound Must Exist"=CONST(true),
                                                             "SN Info. Outbound Must Exist"=CONST(true),
                                                             "SN Warehouse Tracking"=CONST(true),
                                                             "SN Purchase Inbound Tracking"=CONST(true),
                                                             "SN Purchase Outbound Tracking"=CONST(true),
                                                             "SN Sales Inbound Tracking"=CONST(true),
                                                             "SN Sales Outbound Tracking"=CONST(true),
                                                             "SN Pos. Adjmt. Inb. Tracking"=CONST(true),
                                                             "SN Pos. Adjmt. Outb. Tracking"=CONST(true),
                                                             "SN Neg. Adjmt. Inb. Tracking"=CONST(true),
                                                             "SN Neg. Adjmt. Outb. Tracking"=CONST(true),
                                                             "SN Transfer Tracking"=CONST(true),
                                                             "SN Manuf. Inbound Tracking"=CONST(true),
                                                             "SN Manuf. Outbound Tracking"=CONST(true));
        }
        field(50002;"Default Service Item Group";Code[10])
        {
            Caption = 'Default Service Item Group (Interface)';
            TableRelation = "Service Item Group".Code WHERE ("Create Service Item"=CONST(true));
        }
        field(50003;"HQ Vendor Code (Price Update)";Code[20])
        {
            Caption = 'HQ Vendor Code (Price Update - Interface)';
            TableRelation = Vendor;
        }
        field(50004;"Bus. Posting Group (Transfer)";Code[10])
        {
            Caption = 'Gen. Bus. Posting Group (Transfer)';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(50005;"Parts Item Disc. Group";Code[10])
        {
            TableRelation = "Item Discount Group".Code;
        }
        field(50006;"Bus. Posting Grp. (Manufact.)";Code[10])
        {
            TableRelation = "Gen. Business Posting Group".Code;
        }
    }


}

