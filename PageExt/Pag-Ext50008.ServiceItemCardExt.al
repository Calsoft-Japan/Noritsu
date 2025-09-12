pageextension 50008 "Service Item Card Ext" extends "Service Item Card"
{
    layout
    {
        addafter("Preferred Resource")
        {
            field("QSS System Code"; Rec."QSS System Code")
            {
                ApplicationArea = Service;
                Importance = Promoted;
            }
        }
    }
}
