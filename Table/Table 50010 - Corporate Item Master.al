table 50010 "Corporate Item Master"
{
    DataPerCompany = false;
    DrillDownPageID = 50010;
    LookupPageID = 50010;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Latest Item No."; Code[20])
        {
        }
        field(3; "Price Group"; Code[4])
        {
            Caption = 'Currency Code';
        }
        field(4; "Pricing Structure"; Code[1])
        {
        }
        field(5; Description; Text[50])
        {
        }
        field(6; "Unit Price"; Decimal)
        {
        }
        field(7; "Part Type"; Option)
        {
            OptionMembers = " ",Parts,Option,Consumables,Material;
        }
        field(8; "Process Type"; Option)
        {
            OptionMembers = " ","Wet Process","Dry Process","Dry & Wet";
        }
        field(9; "Model Type"; Option)
        {
            OptionMembers = " ",QSS,"dDP (dDP)","MYTIS (Other)";
        }
        field(10; "HS Code"; Code[7])
        {
        }
        field(11; "HS Sub Code"; Code[3])
        {
        }
        field(12; Specification; Text[60])
        {
        }
        field(13; Material; Text[40])
        {
        }
        field(14; "Production Type"; Option)
        {
            OptionMembers = " ",FP,PP,NOUS,Peripheral,Large;
        }
        field(15; "Major Group"; Code[10])
        {
        }
        field(16; "Product Group"; Code[10])
        {
        }
        field(17; "Series Group"; Text[10])
        {
        }
        field(18; "Production Name"; Text[50])
        {
        }
        field(19; "Item Category Code"; Code[10])
        {
        }
        field(20; "Product Group Code"; Code[10])
        {
        }
        field(21; QA; Boolean)
        {
        }
        field(22; "Serialized Parts"; Boolean)
        {
        }
        field(23; "With Serial No."; Boolean)
        {
        }
        field(24; "Country Code"; Code[10])
        {
        }
        field(25; "Registration Date"; Date)
        {
        }
        field(26; "Revision Date"; Date)
        {
            Caption = 'Revision Date';
        }
    }

    keys
    {
        key(Key1; "Item No.", "Price Group", "Pricing Structure")
        {
        }
        key(Key2; "Price Group", "Pricing Structure", "Item No.")
        {
        }
        key(Key3; "Revision Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CorporateItemMaster: Record "Corporate Item Master";

    procedure CreateAsLocalItem()
    begin
        CorporateItemMaster.Reset();
        CorporateItemMaster.Copy(Rec);
        CorporateItemMaster.Find('-');
        REPORT.RunModal(50011, true, false, CorporateItemMaster);
    end;
}

