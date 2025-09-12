table 50002 "Transport Method Code"
{
    Caption = 'Transport Method Code';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[4])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
