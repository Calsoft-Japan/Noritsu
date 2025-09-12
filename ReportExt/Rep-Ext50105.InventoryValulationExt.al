reportextension 50105 "Inventory Valulation Ext." extends "Inventory Valuation"
{
    //RDLCLayout = '.\RDLC\InventoryValuation_Zero.RDLC';

    dataset
    {
        add(Item)
        {
            column(DonotshowZero; DonotshowZero)
            { }
        }
    }

    requestpage
    {
        layout
        {
            addafter(IncludeExpectedCost)
            {
                field(DonotshowZero; DonotshowZero)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Do Not Show Zero Value Items';
                }
            }
        }
    }

    var
        DonotshowZero: Boolean;

}
