reportextension 50003 "Purchase - Invoice Ext." extends "Purchase - Invoice"
{
    //RDLCLayout = '.\RDLC\PurchaseInvoice_CS.RDLC';

    dataset
    {
        add("Purch. Inv. Header")
        {
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            { }
        }
    }
}
