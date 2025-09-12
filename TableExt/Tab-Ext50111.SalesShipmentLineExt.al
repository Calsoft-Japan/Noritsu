tableextension 50111 "Sales Shipment Line" extends "Sales Shipment Line"
{


    fields
    {

        field(50000; "Latest Item No."; Code[30])
        {
        }
        field(50001; QA; Boolean)
        {
        }
        field(50051; "QSS System Code"; Code[30])
        {
            Editable = false;
        }
        field(50052; "Set Quantity"; Decimal)
        {
            Editable = false;
        }
        field(50053; "QSS Package Code"; Code[30])
        {
            Description = '//SAS';
            Editable = false;
        }
    }


}

