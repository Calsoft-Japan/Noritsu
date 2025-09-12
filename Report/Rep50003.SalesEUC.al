report 50003 SalesEUC
{
    ApplicationArea = All;
    Caption = 'Export Sales/Service (EUC)';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutExcel;
    /*
      PBCS01.13 20080430 Yuji_Terai   -Add Field "EZiS Customer No."
      PBCS01.14 20080827 momoko_saito -Build Codeunit "Delete CRLF" in order to remove return code.
      PBCS01.16 20080917 fumitaka_tsukagoshi - Change DeleteLF.DeleteCRLFCode to DeleteLF.DeleteCRLFText
    */

    dataset
    {
        dataitem(Lines; Integer)
        {
            DataItemTableView = SORTING(Number)
                          ORDER(Ascending);
            //WHERE(Number = CONST(1));

            #region Columns
            column(Invoice_or_Credit_Memo; InvOrCre)
            { }
            column(Sell_to_Customer_No_H; Sell_to_Customer_No_H)
            { }
            column(No_H; No_H)
            { }
            column(Bill_to_Customer_No_H; Bill_to_Customer_No_H)
            { }
            column(Bill_to_Name_H; Bill_to_Name_H)
            { }
            column(Your_Reference_H; Your_Reference_H)
            { }
            column(Ship_to_Code_H; Ship_to_Code_H)
            { }
            column(Ship_to_Name_H; Ship_to_Name_H)
            { }
            column(Order_Date_H; Order_Date_H)
            { }
            column(Posting_Date_H; Posting_Date_H)
            { }
            column(Shipment_Date_H; Shipment_Date_H)
            { }
            column(Posting_Description_H; Posting_Description_H)
            { }
            column(Payment_Terms_Code_H; Payment_Terms_Code_H)
            { }
            column(Due_Date_H; Due_Date_H)
            { }
            column(Payment_Discount__H; Payment_Discount__H)
            { }
            column(Pmt_Discount_Date_H; Pmt_Discount_Date_H)
            { }
            column(Shipment_Method_Code_H; Shipment_Method_Code_H)
            { }
            column(Location_Code_H; Location_Code_H)
            { }
            column(Shortcut_Dimension_1_Code_H; Shortcut_Dimension_1_Code_H)
            { }
            column(Shortcut_Dimension_2_Code_H; Shortcut_Dimension_2_Code_H)
            { }
            column(Customer_Posting_Group_H; Customer_Posting_Group_H)
            { }
            column(Currency_Code_H; Currency_Code_H)
            { }
            column(Currency_Factor_H; Currency_Factor_H)
            { }
            column(Customer_Price_Group_H; Customer_Price_Group_H)
            { }
            column(Prices_Including_VAT_H; Prices_Including_VAT_H)
            { }
            column(Invoice_Disc_Code_H; Invoice_Disc_Code_H)
            { }
            column(Customer_Disc_Group_H; Customer_Disc_Group_H)
            { }
            column(Language_Code_H; Language_Code_H)
            { }
            column(Salesperson_Code_H; Salesperson_Code_H)
            { }
            column(Order_No_H; Order_No_H)
            { }
            column(Comment_H; Comment_H)
            { }
            column(No_Printed_H; No_Printed_H)
            { }
            column(On_Hold_H; On_Hold_H)
            { }
            column(Applies_to_Doc_Type_H; Applies_to_Doc_Type_H)
            { }
            column(Applies_to_Doc_No_H; Applies_to_Doc_No_H)
            { }
            column(Bal_Account_No_H; Bal_Account_No_H)
            { }
            column(Job_No_H; Job_No_H)
            { }
            column(Amount_H; Amount_H)
            { }
            column(Amount_Including_VAT_H; Amount_Including_VAT_H)
            { }
            column(VAT_Registration_No_H; VAT_Registration_No_H)
            { }
            column(Reason_Code_H; Reason_Code_H)
            { }
            column(Gen_Bus_Posting_Group_H; Gen_Bus_Posting_Group_H)
            { }
            column(EU_3_Party_Trade_H; EU_3_Party_Trade_H)
            { }
            column(Transaction_Type_H; Transaction_Type_H)
            { }
            column(Transport_Method_H; Transport_Method_H)
            { }
            column(VAT_Country_Code_H; VAT_Country_Code_H)
            { }
            column(Sell_to_Customer_Name_H; Sell_to_Customer_Name_H)
            { }
            column(Bill_to_Post_Code_H; Bill_to_Post_Code_H)
            { }
            column(Bill_to_County_H; Bill_to_County_H)
            { }
            column(Bill_to_Country_Code_H; Bill_to_Country_Code_H)
            { }
            column(Sell_to_Post_Code_H; Sell_to_Post_Code_H)
            { }
            column(Sell_to_County_H; Sell_to_County_H)
            { }
            column(Sell_to_Country_Code_H; Sell_to_Country_Code_H)
            { }
            column(Ship_to_Post_Code_H; Ship_to_Post_Code_H)
            { }
            column(Ship_to_County_H; Ship_to_County_H)
            { }
            column(Ship_to_Country_Code_H; Ship_to_Country_Code_H)
            { }
            column(Bal_Account_Type_H; Bal_Account_Type_H)
            { }
            column(Exit_Point_H; Exit_Point_H)
            { }
            column(Correction_H; Correction_H)
            { }
            column(Document_Date_H; Document_Date_H)
            { }
            column(External_Document_No_H; External_Document_No_H)
            { }
            column(Area_H; Area_H)
            { }
            column(Transaction_Specification_H; Transaction_Specification_H)
            { }
            column(Payment_Method_Code_H; Payment_Method_Code_H)
            { }
            column(Shipping_Agent_Code_H; Shipping_Agent_Code_H)
            { }
            column(Package_Tracking_No_H; Package_Tracking_No_H)
            { }
            column(Pre_Assigned_No_Series_H; Pre_Assigned_No_Series_H)
            { }
            column(No_Series_H; No_Series_H)
            { }
            column(Order_No_Series_H; Order_No_Series_H)
            { }
            column(Pre_Assigned_No_H; Pre_Assigned_No_H)
            { }
            column(User_ID_H; User_ID_H)
            { }
            column(Source_Code_H; Source_Code_H)
            { }
            column(Tax_Area_Code_H; Tax_Area_Code_H)
            { }
            column(Tax_Liable_H; Tax_Liable_H)
            { }
            column(VAT_Bus_Posting_Group_H; VAT_Bus_Posting_Group_H)
            { }
            column(VAT_Base_Discount__H; VAT_Base_Discount__H)
            { }
            column(Campaign_No_H; Campaign_No_H)
            { }
            column(Sell_to_Contact_No_H; Sell_to_Contact_No_H)
            { }
            column(Bill_to_Contact_No_H; Bill_to_Contact_No_H)
            { }
            column(Responsibility_Center_H; Responsibility_Center_H)
            { }
            column(Service_Mgt_Document_H; Service_Mgt_Document_H)
            { }
            column(Return_Order_No_H; Return_Order_No_H)
            { }
            column(Return_Order_No_Series_H; Return_Order_No_Series_H)
            { }
            column(Allow_Line_Disc_H; Allow_Line_Disc_H)
            { }
            column(Get_Shipment_Used_H; Get_Shipment_Used_H)
            { }
            column(Date_Sent_H; Date_Sent_H)
            { }
            column(Time_Sent_H; Time_Sent_H)
            { }
            column(BizTalk_Sales_Invoice_H; BizTalk_Sales_Invoice_H)
            { }
            column(Customer_Order_No_H; Customer_Order_No_H)
            { }
            column(BizTalk_Document_Sent_H; BizTalk_Document_Sent_H)
            { }
            column(Sell_to_Customer_No_L; Sell_to_Customer_No_L)
            { }
            column(Customer_Name_L; Customer_Name_L)
            { }
            column(Country_Code_L; Country_Code_L)
            { }
            column(Country_Name_L; Country_Name_L)
            { }
            column(Document_No_L; Document_No_L)
            { }
            column(Line_No_L; Line_No_L)
            { }
            column(Type_L; Type_L)
            { }
            column(No_L; No_L)
            { }
            column(Product_Type_L; Product_Type_L)
            { }
            column(Model_Type_L; Model_Type_L)
            { }
            column(Used_Item_L; Used_Item_L)
            { }
            column(Resource_Group_No_L; Resource_Group_No_L)
            { }
            column(Location_Code_L; Location_Code_L)
            { }
            column(Posting_Group_L; Posting_Group_L)
            { }
            column(Shipment_Date_L; Shipment_Date_L)
            { }
            column(Description_L; Description_L)
            { }
            column(Description_2_L; Description_2_L)
            { }
            column(Unit_of_Measure_L; Unit_of_Measure_L)
            { }
            column(Quantity_L; Quantity_L)
            { }
            column(Unit_Price_L; Unit_Price_L)
            { }
            column(Unit_Cost_LCY_L; Unit_Cost_LCY_L)
            { }
            column(VAT__L; VAT__L)
            { }
            column(Line_Discount__L; Line_Discount__L)
            { }
            column(Line_Discount_Amount_L; Line_Discount_Amount_L)
            { }
            column(Amount_L; Amount_L)
            { }
            column(Amount_Including_VAT_L; Amount_Including_VAT_L)
            { }
            column(Allow_Invoice_Disc_L; Allow_Invoice_Disc_L)
            { }
            column(Gross_Weight_L; Gross_Weight_L)
            { }
            column(Net_Weight_L; Net_Weight_L)
            { }
            column(Units_per_Parcel_L; Units_per_Parcel_L)
            { }
            column(Unit_Volume_L; Unit_Volume_L)
            { }
            column(Appl_to_Item_Entry_L; Appl_to_Item_Entry_L)
            { }
            column(Shortcut_Dimension_1_Code_L; Shortcut_Dimension_1_Code_L)
            { }
            column(Shortcut_Dimension_2_Code_L; Shortcut_Dimension_2_Code_L)
            { }
            column(Customer_Price_Group_L; Customer_Price_Group_L)
            { }
            column(Job_No_L; Job_No_L)
            { }
            column(Appl_to_Job_Entry_L; Appl_to_Job_Entry_L)
            { }
            column(Phase_Code_L; Phase_Code_L)
            { }
            column(Task_Code_L; Task_Code_L)
            { }
            column(Step_Code_L; Step_Code_L)
            { }
            column(Job_Applies_to_ID_L; Job_Applies_to_ID_L)
            { }
            column(Apply_and_Close_Job_L; Apply_and_Close_Job_L)
            { }
            column(Work_Type_Code_L; Work_Type_Code_L)
            { }
            column(Shipment_No_L; Shipment_No_L)
            { }
            column(Shipment_Line_No_L; Shipment_Line_No_L)
            { }
            column(Bill_to_Customer_No_L; Bill_to_Customer_No_L)
            { }
            column(Inv_Discount_Amount_L; Inv_Discount_Amount_L)
            { }
            column(Drop_Shipment_L; Drop_Shipment_L)
            { }
            column(Gen_Bus_Posting_Group_L; Gen_Bus_Posting_Group_L)
            { }
            column(Gen_Prod_Posting_Group_L; Gen_Prod_Posting_Group_L)
            { }
            column(VAT_Calculation_Type_L; VAT_Calculation_Type_L)
            { }
            column(Transaction_Type_L; Transaction_Type_L)
            { }
            column(Transport_Method_L; Transport_Method_L)
            { }
            column(Attached_to_Line_No_L; Attached_to_Line_No_L)
            { }
            column(Exit_Point_L; Exit_Point_L)
            { }
            column(Area_L; Area_L)
            { }
            column(Transaction_Specification_L; Transaction_Specification_L)
            { }
            column(Tax_Area_Code_L; Tax_Area_Code_L)
            { }
            column(Tax_Liable_L; Tax_Liable_L)
            { }
            column(Tax_Group_Code_L; Tax_Group_Code_L)
            { }
            column(VAT_Bus_Posting_Group_L; VAT_Bus_Posting_Group_L)
            { }
            column(VAT_Prod_Posting_Group_L; VAT_Prod_Posting_Group_L)
            { }
            column(Blanket_Order_No_L; Blanket_Order_No_L)
            { }
            column(Blanket_Order_Line_No_L; Blanket_Order_Line_No_L)
            { }
            column(VAT_Base_Amount_L; VAT_Base_Amount_L)
            { }
            column(Unit_Cost_L; Unit_Cost_L)
            { }
            column(System_Created_Entry_L; System_Created_Entry_L)
            { }
            column(Line_Amount_L; Line_Amount_L)
            { }
            column(VAT_Difference_L; VAT_Difference_L)
            { }
            column(VAT_Identifier_L; VAT_Identifier_L)
            { }
            column(IC_Partner_Ref_Type_L; IC_Partner_Ref_Type_L)
            { }
            column(IC_Partner_Reference_L; IC_Partner_Reference_L)
            { }
            column(Variant_Code_L; Variant_Code_L)
            { }
            column(Bin_Code_L; Bin_Code_L)
            { }
            column(Qty_per_Unit_of_Measure_L; Qty_per_Unit_of_Measure_L)
            { }
            column(Unit_of_Measure_Code_L; Unit_of_Measure_Code_L)
            { }
            column(Quantity_Base_L; Quantity_Base_L)
            { }
            column(FA_Posting_Date_L; FA_Posting_Date_L)
            { }
            column(Depreciation_Book_Code_L; Depreciation_Book_Code_L)
            { }
            column(Depr_until_FA_Posting_Date_L; Depr_until_FA_Posting_Date_L)
            { }
            column(Duplicate_in_Depreciation_Book_L; Duplicate_in_Depreciation_Book_L)
            { }
            column(Use_Duplication_List_L; Use_Duplication_List_L)
            { }
            column(Responsibility_Center_L; Responsibility_Center_L)
            { }
            column(Cross_Reference_No_L; Cross_Reference_No_L)
            { }
            column(Unit_of_Measure_Cross_Ref_L; Unit_of_Measure_Cross_Ref_L)
            { }
            column(Cross_Reference_Type_L; Cross_Reference_Type_L)
            { }
            column(Cross_Reference_Type_No_L; Cross_Reference_Type_No_L)
            { }
            column(Item_Category_Code_L; Item_Category_Code_L)
            { }
            column(Nonstock_L; Nonstock_L)
            { }
            column(Purchasing_Code_L; Purchasing_Code_L)
            { }
            column(Product_Group_Code_L; Product_Group_Code_L)
            { }
            column(Appl_from_Item_Entry_L; Appl_from_Item_Entry_L)
            { }
            column(Service_Contract_No_L; Service_Contract_No_L)
            { }
            column(Service_Order_No_L; Service_Order_No_L)
            { }
            column(Service_Item_No_L; Service_Item_No_L)
            { }
            column(Appl_to_Service_Entry_L; Appl_to_Service_Entry_L)
            { }
            column(Service_Item_Line_No_L; Service_Item_Line_No_L)
            { }
            column(Serv_Price_Adjmt_Gr_Code_L; Serv_Price_Adjmt_Gr_Code_L)
            { }
            column(Return_Reason_Code_L; Return_Reason_Code_L)
            { }
            column(Allow_Line_Disc_L; Allow_Line_Disc_L)
            { }
            column(Customer_Disc_Group_L; Customer_Disc_Group_L)
            { }
            column(QSS_System_Code_L; QSS_System_Code_L)
            { }
            column(Set_Quantity_L; Set_Quantity_L)
            { }
            column(Return_Receipt_No_L; Return_Receipt_No_L)
            { }
            column(Return_Receipt_Line_No_L; Return_Receipt_Line_No_L)
            { }
            column(Amount_Before_Discount_LCY_L; AmtBeforeDiscLCY)
            { }
            column(Line_Discount_Amount_LCY_L; LineDiscAmtLCY)
            { }
            column(Invoice_Discount_Amount_LCY_L; InvDiscAmtLCY)
            { }
            column(Amount_After_Discount_LCY_L; AmtAfterDiscLCY)
            { }
            column(Amount_Before_Discount_FC_L; AmtBeforeDiscFC)
            { }
            column(Line_Discount_Amount_FC_L; LineDiscAmtFC)
            { }
            column(Invoice_Discount_Amount_FC_L; InvDiscAmtFC)
            { }
            column(Amount_After_Discount_FC_L; AmtAfterDiscFC)
            { }
            column(EZiS_Customer_No; EZiS_Customer_No)
            { }
            #endregion Columns

            trigger OnPreDataItem()
            begin
                Clear(NoOfLoops);
                Clear(InvCount);
                Clear(CreCount);
                Clear(SvcInvCount);
                Clear(SvcCreCount);
                Clear(CurrInvLoop);
                Clear(CurrCreLoop);
                Clear(CurrSvcInvLoop);
                Clear(CurrSvcCreLoop);
                Clear(InvDone);
                Clear(SvcInvDone);
                Clear(SvcCreDone);
                Clear(CreReady);
                Clear(SvcInvReady);
                Clear(SvcCreReady);

                "Sales Invoice Line".Reset();
                ServiceInvLine.Reset();
                ServiceCreLine.Reset();
                "Sales Cr.Memo Line".Reset();
                //DMY2Date(1, 1, 2023);
                //(FromPostingDate >= 20230101D) and 
                IF (ToPostingDate >= FromPostingDate) and (FromPostingDate <> 0D) and (ToPostingDate <> 0D) THEN begin
                    "Sales Invoice Line".SetRange("Posting Date", FromPostingDate, ToPostingDate);
                    ServiceInvLine.SetRange("Posting Date", FromPostingDate, ToPostingDate);
                    ServiceCreLine.SetRange("Posting Date", FromPostingDate, ToPostingDate);
                    "Sales Cr.Memo Line".SetRange("Posting Date", FromPostingDate, ToPostingDate);
                end;



                //=================================================================================================================                
                if "Sales Invoice Line".FindLast() then begin
                    InvCount := "Sales Invoice Line".Count;
                    NoOfLoops += InvCount;
                end;

                if "Sales Invoice Line".FindFirst() then
                    CurrInvLoop := 1
                else
                    InvDone := true;

                //=================================================================================================================                
                if ServiceInvLine.FindLast() then begin
                    SvcInvCount := ServiceInvLine.Count;
                    NoOfLoops += ServiceInvLine.Count;
                end;


                if not ServiceInvLine.Find('-') then
                    SvcInvDone := true
                else
                    CurrSvcInvLoop := 1;

                //=================================================================================================================                
                if ServiceCreLine.FindLast() then begin
                    SvcCreCount := ServiceCreLine.Count;
                    NoOfLoops += ServiceCreLine.Count;
                end;


                if not ServiceCreLine.Find('-') then
                    SvcCreDone := true
                else
                    CurrSvcCreLoop := 1;

                //=================================================================================================================

                if "Sales Cr.Memo Line".FindLast() then begin
                    CreCount := "Sales Cr.Memo Line".Count;
                    NoOfLoops += CreCount;
                end;

                if "Sales Cr.Memo Line".Find('-') then
                    CurrCreLoop := 1
                else
                    if InvDone and SvcInvDone and SvcCreDone then begin
                        Error('Nothing to export!');
                        CurrReport.Break();
                    end;

                if NoOfLoops > 0 then
                    SetRange(Number, 1, NoOfLoops)
                else
                    CurrReport.Break();

            end;

            trigger OnAfterGetRecord()
            var
                //ItemCat: Record "Item Category";
                Item: Record Item;
                ItemRef: Record "Item Reference";
            begin
                //===========Sales Inoice Lines=================================================================
                #region Sales Invoice Lines
                if not InvDone then begin
                    ClearHeaderVar();
                    ClearLineVar();

                    InvOrCre := 'I';

                    SalesInvHdr.Reset();
                    SalesInvHdr.SetRange("No.", "Sales Invoice Line"."Document No.");
                    IF (ToPostingDate >= FromPostingDate) and (FromPostingDate <> 0D) and (ToPostingDate <> 0D) THEN
                        SalesInvHdr.SetRange("Posting Date", FromPostingDate, ToPostingDate);

                    IF (ToCurrencyCode >= FromCurrencyCode) and (FromCurrencyCode <> '') and (ToCurrencyCode <> '') THEN
                        SalesInvHdr.SetRange("Currency Code", FromCurrencyCode, ToCurrencyCode);

                    IF (ToCountryCode >= FromCountryCode) and (FromCountryCode <> '') and (ToCountryCode <> '') THEN
                        SalesInvHdr.SetRange("Sell-to Country/Region Code", FromCountryCode, ToCountryCode);

                    if SalesInvHdr.Find('-') then begin
                        Sell_to_Customer_No_H := SalesInvHdr."Sell-to Customer No.";
                        No_H := SalesInvHdr."No.";
                        Bill_to_Customer_No_H := SalesInvHdr."Bill-to Customer No.";
                        Bill_to_Name_H := SalesInvHdr."Bill-to Name";
                        Your_Reference_H := SalesInvHdr."Your Reference";
                        Ship_to_Code_H := SalesInvHdr."Ship-to Code";
                        Ship_to_Name_H := SalesInvHdr."Ship-to Name";
                        Order_Date_H := SalesInvHdr."Order Date";
                        Posting_Date_H := SalesInvHdr."Posting Date";
                        Shipment_Date_H := SalesInvHdr."Shipment Date";
                        Posting_Description_H := SalesInvHdr."Posting Description";
                        Payment_Terms_Code_H := SalesInvHdr."Payment Terms Code";
                        Due_Date_H := SalesInvHdr."Due Date";
                        Payment_Discount__H := SalesInvHdr."Payment Discount %";
                        Pmt_Discount_Date_H := SalesInvHdr."Pmt. Discount Date";
                        Shipment_Method_Code_H := SalesInvHdr."Shipment Method Code";
                        Location_Code_H := SalesInvHdr."Location Code";
                        Shortcut_Dimension_1_Code_H := SalesInvHdr."Shortcut Dimension 1 Code";
                        Shortcut_Dimension_2_Code_H := SalesInvHdr."Shortcut Dimension 2 Code";
                        Customer_Posting_Group_H := SalesInvHdr."Customer Posting Group";
                        Currency_Code_H := SalesInvHdr."Currency Code";
                        Currency_Factor_H := SalesInvHdr."Currency Factor";
                        Customer_Price_Group_H := SalesInvHdr."Customer Price Group";
                        Prices_Including_VAT_H := SalesInvHdr."Prices Including VAT";
                        Invoice_Disc_Code_H := SalesInvHdr."Invoice Disc. Code";
                        Customer_Disc_Group_H := SalesInvHdr."Customer Disc. Group";
                        Language_Code_H := SalesInvHdr."Language Code";
                        Salesperson_Code_H := SalesInvHdr."Salesperson Code";
                        Order_No_H := SalesInvHdr."Order No.";
                        Comment_H := SalesInvHdr.Comment;
                        No_Printed_H := SalesInvHdr."No. Printed";
                        On_Hold_H := SalesInvHdr."On Hold";
                        Applies_to_Doc_Type_H := SalesInvHdr."Applies-to Doc. Type";
                        Applies_to_Doc_No_H := SalesInvHdr."Applies-to Doc. No.";
                        Bal_Account_No_H := SalesInvHdr."Bal. Account No.";
                        Job_No_H := '';//Leon Comment Out==SalesInvHdr."Job No.";
                        SalesInvHdr.CalcFields(Amount, "Amount Including VAT");
                        Amount_H := SalesInvHdr.Amount;
                        Amount_Including_VAT_H := SalesInvHdr."Amount Including VAT";
                        VAT_Registration_No_H := SalesInvHdr."VAT Registration No.";
                        Reason_Code_H := SalesInvHdr."Reason Code";
                        Gen_Bus_Posting_Group_H := SalesInvHdr."Gen. Bus. Posting Group";
                        EU_3_Party_Trade_H := SalesInvHdr."EU 3-Party Trade";
                        Transaction_Type_H := SalesInvHdr."Transaction Type";
                        Transport_Method_H := SalesInvHdr."Transport Method";
                        VAT_Country_Code_H := SalesInvHdr."VAT Country/Region Code";
                        Sell_to_Customer_Name_H := SalesInvHdr."Sell-to Customer Name";
                        Bill_to_Post_Code_H := SalesInvHdr."Bill-to Post Code";
                        Bill_to_County_H := SalesInvHdr."Bill-to County";
                        Bill_to_Country_Code_H := SalesInvHdr."Bill-to Country/Region Code";
                        Sell_to_Post_Code_H := SalesInvHdr."Sell-to Post Code";
                        Sell_to_County_H := SalesInvHdr."Sell-to County";
                        Sell_to_Country_Code_H := SalesInvHdr."Sell-to Country/Region Code";
                        Ship_to_Post_Code_H := SalesInvHdr."Ship-to Post Code";
                        Ship_to_County_H := SalesInvHdr."Ship-to County";
                        Ship_to_Country_Code_H := SalesInvHdr."Ship-to Country/Region Code";
                        Bal_Account_Type_H := SalesInvHdr."Bal. Account Type";
                        Exit_Point_H := SalesInvHdr."Exit Point";
                        Correction_H := SalesInvHdr.Correction;
                        Document_Date_H := SalesInvHdr."Document Date";
                        External_Document_No_H := SalesInvHdr."External Document No.";
                        Area_H := SalesInvHdr.Area;
                        Transaction_Specification_H := SalesInvHdr."Transaction Specification";
                        Payment_Method_Code_H := SalesInvHdr."Payment Method Code";
                        Shipping_Agent_Code_H := SalesInvHdr."Shipping Agent Code";
                        Package_Tracking_No_H := SalesInvHdr."Package Tracking No.";
                        Pre_Assigned_No_Series_H := SalesInvHdr."Pre-Assigned No. Series";
                        No_Series_H := SalesInvHdr."No. Series";
                        Order_No_Series_H := SalesInvHdr."Order No. Series";
                        Pre_Assigned_No_H := SalesInvHdr."Pre-Assigned No.";
                        User_ID_H := SalesInvHdr."User ID";
                        Source_Code_H := SalesInvHdr."Source Code";
                        Tax_Area_Code_H := SalesInvHdr."Tax Area Code";
                        Tax_Liable_H := SalesInvHdr."Tax Liable";
                        VAT_Bus_Posting_Group_H := SalesInvHdr."VAT Bus. Posting Group";
                        VAT_Base_Discount__H := SalesInvHdr."VAT Base Discount %";
                        Campaign_No_H := SalesInvHdr."Campaign No.";
                        Sell_to_Contact_No_H := SalesInvHdr."Sell-to Contact No.";
                        Bill_to_Contact_No_H := SalesInvHdr."Bill-to Contact No.";
                        Responsibility_Center_H := SalesInvHdr."Responsibility Center";
                        Service_Mgt_Document_H := false;//Leon Comment Out==SalesInvHdr."Service Mgt. Document";
                        Return_Order_No_H := '';
                        Return_Order_No_Series_H := '';
                        Allow_Line_Disc_H := SalesInvHdr."Allow Line Disc.";
                        Get_Shipment_Used_H := SalesInvHdr."Get Shipment Used";
                        Date_Sent_H := 0D;//Leon Comment Out==SalesInvHdr."Date Sent";
                        Time_Sent_H := 0T;//Leon Comment Out==SalesInvHdr."Time Sent";
                        BizTalk_Sales_Invoice_H := false;//Leon Comment Out==SalesInvHdr."BizTalk Sales Invoice";
                        Customer_Order_No_H := '';//Leon Comment Out==SalesInvHdr."Customer Order No.";
                        BizTalk_Document_Sent_H := false;//Leon Comment Out==SalesInvHdr."BizTalk Document Sent";
                    end else begin
                        if "Sales Invoice Line".Next() = 0 then InvDone := true;
                        CurrReport.Skip();
                    end;



                    Sell_to_Customer_No_L := "Sales Invoice Line"."Sell-to Customer No.";

                    IF Customer.GET("Sales Invoice Line"."Sell-to Customer No.") THEN begin
                        Customer_Name_L := Customer.Name;
                        Country_Code_L := Customer."Country/Region Code";
                        IF NOT Country.GET(Customer."Country/Region Code") THEN
                            Country_Name_L := Country.Name;
                    end;
                    Document_No_L := "Sales Invoice Line"."Document No.";
                    Line_No_L := "Sales Invoice Line"."Line No.";
                    Type_L := "Sales Invoice Line".Type;
                    No_L := "Sales Invoice Line"."No.";

                    Clear(Product_Type_L);
                    Clear(Model_Type_L);
                    Clear(Used_Item_L);
                    if Item.Get("Sales Invoice Line"."No.") then begin
                        Product_Type_L := Item."Product Type";
                        Model_Type_L := Item."Model Type";
                        Used_Item_L := Item."Used Item";
                    end;
                    Clear(Resource_Group_No_L);
                    if Resource.GET("Sales Invoice Line"."No.") then
                        Resource_Group_No_L := Resource."Resource Group No.";

                    Location_Code_L := "Sales Invoice Line"."Location Code";
                    Posting_Group_L := "Sales Invoice Line"."Posting Group";
                    Shipment_Date_L := "Sales Invoice Line"."Shipment Date";
                    Description_L := "Sales Invoice Line".Description;
                    Description_2_L := "Sales Invoice Line"."Description 2";
                    Unit_of_Measure_L := "Sales Invoice Line"."Unit of Measure";
                    Quantity_L := "Sales Invoice Line".Quantity;
                    Unit_Price_L := "Sales Invoice Line"."Unit Price";
                    Unit_Cost_LCY_L := "Sales Invoice Line"."Unit Cost (LCY)";
                    VAT__L := "Sales Invoice Line"."VAT %";
                    Line_Discount__L := "Sales Invoice Line"."Line Discount %";
                    Line_Discount_Amount_L := "Sales Invoice Line"."Line Discount Amount";
                    Amount_L := "Sales Invoice Line".Amount;
                    Amount_Including_VAT_L := "Sales Invoice Line"."Amount Including VAT";
                    Allow_Invoice_Disc_L := "Sales Invoice Line"."Allow Invoice Disc.";
                    Gross_Weight_L := "Sales Invoice Line"."Gross Weight";
                    Net_Weight_L := "Sales Invoice Line"."Net Weight";
                    Units_per_Parcel_L := "Sales Invoice Line"."Units per Parcel";
                    Unit_Volume_L := "Sales Invoice Line"."Unit Volume";
                    Appl_to_Item_Entry_L := "Sales Invoice Line"."Appl.-to Item Entry";
                    Shortcut_Dimension_1_Code_L := "Sales Invoice Line"."Shortcut Dimension 1 Code";
                    Shortcut_Dimension_2_Code_L := "Sales Invoice Line"."Shortcut Dimension 2 Code";
                    Customer_Price_Group_L := "Sales Invoice Line"."Customer Price Group";
                    Job_No_L := "Sales Invoice Line"."Job No.";
                    Appl_to_Job_Entry_L := '';//Leon Comment Out=="Sales Invoice Line"."Appl.-to Job Entry";
                    Phase_Code_L := '';//Leon Comment Out=="Sales Invoice Line"."Phase Code";
                    Task_Code_L := '';//Leon Comment Out=="Sales Invoice Line"."Task Code";
                    Step_Code_L := '';//Leon Comment Out=="Sales Invoice Line"."Step Code";
                    Job_Applies_to_ID_L := '';//Leon Comment Out=="Sales Invoice Line"."Job Applies-to ID";
                    Apply_and_Close_Job_L := '';//Leon Comment Out=="Sales Invoice Line"."Apply and Close (Job)";
                    Work_Type_Code_L := "Sales Invoice Line"."Work Type Code";
                    Shipment_No_L := "Sales Invoice Line"."Shipment No.";
                    Shipment_Line_No_L := "Sales Invoice Line"."Shipment Line No.";
                    Bill_to_Customer_No_L := "Sales Invoice Line"."Bill-to Customer No.";
                    Inv_Discount_Amount_L := "Sales Invoice Line"."Inv. Discount Amount";
                    Drop_Shipment_L := "Sales Invoice Line"."Drop Shipment";
                    Gen_Bus_Posting_Group_L := "Sales Invoice Line"."Gen. Bus. Posting Group";
                    Gen_Prod_Posting_Group_L := "Sales Invoice Line"."Gen. Prod. Posting Group";
                    VAT_Calculation_Type_L := "Sales Invoice Line"."VAT Calculation Type";
                    Transaction_Type_L := "Sales Invoice Line"."Transaction Type";
                    Transport_Method_L := "Sales Invoice Line"."Transport Method";
                    Attached_to_Line_No_L := "Sales Invoice Line"."Attached to Line No.";
                    Exit_Point_L := "Sales Invoice Line"."Exit Point";
                    Area_L := "Sales Invoice Line"."Area";
                    Transaction_Specification_L := "Sales Invoice Line"."Transaction Specification";
                    Tax_Area_Code_L := "Sales Invoice Line"."Tax Area Code";
                    Tax_Liable_L := "Sales Invoice Line"."Tax Liable";
                    Tax_Group_Code_L := "Sales Invoice Line"."Tax Group Code";
                    VAT_Bus_Posting_Group_L := "Sales Invoice Line"."VAT Bus. Posting Group";
                    VAT_Prod_Posting_Group_L := "Sales Invoice Line"."VAT Prod. Posting Group";
                    Blanket_Order_No_L := "Sales Invoice Line"."Blanket Order No.";
                    Blanket_Order_Line_No_L := "Sales Invoice Line"."Blanket Order Line No.";
                    VAT_Base_Amount_L := "Sales Invoice Line"."VAT Base Amount";
                    Unit_Cost_L := "Sales Invoice Line"."Unit Cost";
                    System_Created_Entry_L := "Sales Invoice Line"."System-Created Entry";
                    Line_Amount_L := "Sales Invoice Line"."Line Amount";
                    VAT_Difference_L := "Sales Invoice Line"."VAT Difference";
                    VAT_Identifier_L := "Sales Invoice Line"."VAT Identifier";
                    IC_Partner_Ref_Type_L := "Sales Invoice Line"."IC Partner Ref. Type";
                    IC_Partner_Reference_L := "Sales Invoice Line"."IC Partner Reference";
                    Variant_Code_L := "Sales Invoice Line"."Variant Code";
                    Bin_Code_L := "Sales Invoice Line"."Bin Code";
                    Qty_per_Unit_of_Measure_L := "Sales Invoice Line"."Qty. per Unit of Measure";
                    Unit_of_Measure_Code_L := "Sales Invoice Line"."Unit of Measure Code";
                    Quantity_Base_L := "Sales Invoice Line"."Quantity (Base)";
                    FA_Posting_Date_L := "Sales Invoice Line"."FA Posting Date";
                    Depreciation_Book_Code_L := "Sales Invoice Line"."Depreciation Book Code";
                    Depr_until_FA_Posting_Date_L := "Sales Invoice Line"."Depr. until FA Posting Date";
                    Duplicate_in_Depreciation_Book_L := "Sales Invoice Line"."Duplicate in Depreciation Book";
                    Use_Duplication_List_L := "Sales Invoice Line"."Use Duplication List";
                    Responsibility_Center_L := "Sales Invoice Line"."Responsibility Center";

                    /*ItemRef.Reset();
                    ItemRef.SetRange("Item No.", "Sales Invoice Line"."No.");
                    if ItemRef.Find('-') then begin
                        Cross_Reference_No_L := ItemRef."Reference No.";
                        Unit_of_Measure_Cross_Ref_L := ItemRef."Unit of Measure";
                        Cross_Reference_Type_L := ItemRef."Reference Type";
                        Cross_Reference_Type_No_L := ItemRef."Reference Type No.";
                    end else */
                    begin
                        Cross_Reference_No_L := "Sales Invoice Line"."Item Reference No.";
                        Unit_of_Measure_Cross_Ref_L := "Sales Invoice Line"."Item Reference Unit of Measure";
                        Cross_Reference_Type_L := "Sales Invoice Line"."Item Reference Type";
                        Cross_Reference_Type_No_L := "Sales Invoice Line"."Item Reference Type No.";
                    end;

                    Item_Category_Code_L := "Sales Invoice Line"."Item Category Code";
                    Nonstock_L := "Sales Invoice Line".Nonstock;
                    Purchasing_Code_L := "Sales Invoice Line"."Purchasing Code";

                    //ItemCat.Reset();
                    //if ItemCat.Get("Sales Invoice Line"."Item Category Code") then
                    Item.Reset();
                    if Item.Get("Sales Invoice Line"."No.") then
                        Product_Group_Code_L := Item."Product Group";
                    //Product_Group_Code_L := "Sales Invoice Line"."Product Group Code";

                    Appl_from_Item_Entry_L := "Sales Invoice Line"."Appl.-from Item Entry";
                    Service_Contract_No_L := '';//Leon Comment Out=="Sales Invoice Line"."Service Contract No.";
                    Service_Order_No_L := '';//Leon Comment Out=="Sales Invoice Line"."Service Order No.";
                    Service_Item_No_L := '';//Leon Comment Out==Sales Invoice Line"."Service Item No.";
                    Appl_to_Service_Entry_L := '';//Leon Comment Out=="Sales Invoice Line"."Service Item Line No.";
                    Service_Item_Line_No_L := '';//Leon Comment Out=="Sales Invoice Line"."Service Item Line No.";
                    Serv_Price_Adjmt_Gr_Code_L := '';//Leon Comment Out=="Sales Invoice Line"."Serv. Price Adjmt. Gr. Code";
                    Return_Reason_Code_L := "Sales Invoice Line"."Return Reason Code";
                    Allow_Line_Disc_L := "Sales Invoice Line"."Allow Line Disc.";
                    Customer_Disc_Group_L := "Sales Invoice Line"."Customer Disc. Group";
                    QSS_System_Code_L := "Sales Invoice Line"."QSS System Code";
                    Set_Quantity_L := "Sales Invoice Line"."Set Quantity";
                    Return_Receipt_No_L := '';
                    Return_Receipt_Line_No_L := '';
                    EZiS_Customer_No := Customer."EZiS Customer No.";

                    SalesInvHdr.CALCFIELDS(SalesInvHdr.Amount, SalesInvHdr."Amount Including VAT");
                    AmtBeforeDiscFC := "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price";
                    LineDiscAmtFC := "Sales Invoice Line"."Line Discount Amount";
                    InvDiscAmtFC := "Sales Invoice Line"."Inv. Discount Amount";
                    AmtAfterDiscFC := "Sales Invoice Line".Amount;
                    IF SalesInvHdr."Currency Factor" = 0 THEN BEGIN
                        AmtBeforeDiscLCY := AmtBeforeDiscFC;
                        LineDiscAmtLCY := LineDiscAmtFC;
                        InvDiscAmtLCY := InvDiscAmtFC;
                        AmtAfterDiscLCY := AmtAfterDiscFC;
                    END ELSE BEGIN
                        AmtBeforeDiscLCY := ROUND(AmtBeforeDiscFC / SalesInvHdr."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        LineDiscAmtLCY := ROUND(LineDiscAmtFC / SalesInvHdr."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        InvDiscAmtLCY := ROUND(InvDiscAmtFC / SalesInvHdr."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        AmtAfterDiscLCY := ROUND(AmtAfterDiscFC / SalesInvHdr."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                    END;

                    /*
                    IF Customer.GET("Sales Invoice Line"."Sell-to Customer No.") THEN BEGIN
                        IF NOT Country.GET(Customer."Country/Region Code") THEN
                            Country.INIT;
                    END ELSE BEGIN
                        Customer.INIT;
                        Country.INIT;
                    END;

                    IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item THEN BEGIN
                        Resource.INIT;
                        IF NOT Item.GET("Sales Invoice Line"."No.") THEN
                            Item.INIT;
                    END ELSE BEGIN
                        Item.INIT;
                        IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::Resource THEN BEGIN
                            IF NOT Resource.GET("Sales Invoice Line"."No.") THEN
                                Resource.INIT;
                        END ELSE
                            Resource.INIT;
                    END;
                    */

                    CurrInvLoop += 1;

                    if "Sales Invoice Line".Next() = 0 then begin
                        InvDone := true;
                        SvcInvReady := false;
                        SvcCreReady := false;
                        CreReady := false; //Can not get into the Credit loop directly because it's in the last inv loop now.                        
                        CurrInvLoop := InvCount;
                    end;
                end
                else begin //else for : if not InvDone; means finish all of the inv loop
                    //CreReady := true;
                    SvcInvReady := true;
                    CurrInvLoop := InvCount + 1;
                end;
                #endregion Sales Invoice Lines

                //===========Service Inoice Lines=================================================================
                #region Service Invoice Lines
                if not SvcInvDone and SvcInvReady then begin
                    ClearHeaderVar();
                    ClearLineVar();

                    InvOrCre := 'I';

                    ServiceInvHeader.Reset();
                    ServiceInvHeader.SetRange("No.", ServiceInvLine."Document No.");
                    IF (ToPostingDate >= FromPostingDate) and (FromPostingDate <> 0D) and (ToPostingDate <> 0D) THEN
                        ServiceInvHeader.SetRange("Posting Date", FromPostingDate, ToPostingDate);

                    IF (ToCurrencyCode >= FromCurrencyCode) and (FromCurrencyCode <> '') and (ToCurrencyCode <> '') THEN
                        ServiceInvHeader.SetRange("Currency Code", FromCurrencyCode, ToCurrencyCode);

                    IF (ToCountryCode >= FromCountryCode) and (FromCountryCode <> '') and (ToCountryCode <> '') THEN
                        ServiceInvHeader.SetRange("Country/Region Code", FromCountryCode, ToCountryCode);


                    if ServiceInvHeader.Find('-') then begin
                        Sell_to_Customer_No_H := ServiceInvHeader."Customer No.";
                        No_H := ServiceInvHeader."No.";
                        Bill_to_Customer_No_H := ServiceInvHeader."Bill-to Customer No.";
                        Bill_to_Name_H := ServiceInvHeader."Bill-to Name";
                        Your_Reference_H := ServiceInvHeader."Your Reference";
                        Ship_to_Code_H := ServiceInvHeader."Ship-to Code";
                        Ship_to_Name_H := ServiceInvHeader."Ship-to Name";
                        Order_Date_H := ServiceInvHeader."Order Date";
                        Posting_Date_H := ServiceInvHeader."Posting Date";
                        //Shipment_Date_H := ServiceInvHeader."Shipment Date";
                        Posting_Description_H := ServiceInvHeader."Posting Description";
                        Payment_Terms_Code_H := ServiceInvHeader."Payment Terms Code";
                        Due_Date_H := ServiceInvHeader."Due Date";
                        Payment_Discount__H := ServiceInvHeader."Payment Discount %";
                        Pmt_Discount_Date_H := ServiceInvHeader."Pmt. Discount Date";
                        //Shipment_Method_Code_H := ServiceInvHeader."Shipment Method Code";
                        Location_Code_H := ServiceInvHeader."Location Code";
                        Shortcut_Dimension_1_Code_H := ServiceInvHeader."Shortcut Dimension 1 Code";
                        Shortcut_Dimension_2_Code_H := ServiceInvHeader."Shortcut Dimension 2 Code";
                        Customer_Posting_Group_H := ServiceInvHeader."Customer Posting Group";
                        Currency_Code_H := ServiceInvHeader."Currency Code";
                        Currency_Factor_H := ServiceInvHeader."Currency Factor";
                        Customer_Price_Group_H := ServiceInvHeader."Customer Price Group";
                        Prices_Including_VAT_H := ServiceInvHeader."Prices Including VAT";
                        Invoice_Disc_Code_H := ServiceInvHeader."Invoice Disc. Code";
                        Customer_Disc_Group_H := ServiceInvHeader."Customer Disc. Group";
                        Language_Code_H := ServiceInvHeader."Language Code";
                        Salesperson_Code_H := ServiceInvHeader."Salesperson Code";
                        Order_No_H := ServiceInvHeader."Order No.";
                        Comment_H := ServiceInvHeader.Comment;
                        No_Printed_H := ServiceInvHeader."No. Printed";
                        //On_Hold_H := ServiceInvHeader."On Hold";
                        Applies_to_Doc_Type_H := ServiceInvHeader."Applies-to Doc. Type";
                        Applies_to_Doc_No_H := ServiceInvHeader."Applies-to Doc. No.";
                        Bal_Account_No_H := ServiceInvHeader."Bal. Account No.";
                        Job_No_H := '';//Leon Comment Out==ServiceInvHeader."Job No.";
                        ServiceInvHeader.CalcFields(Amount, "Amount Including VAT");
                        Amount_H := ServiceInvHeader.Amount;
                        Amount_Including_VAT_H := ServiceInvHeader."Amount Including VAT";
                        VAT_Registration_No_H := ServiceInvHeader."VAT Registration No.";
                        Reason_Code_H := ServiceInvHeader."Reason Code";
                        Gen_Bus_Posting_Group_H := ServiceInvHeader."Gen. Bus. Posting Group";
                        EU_3_Party_Trade_H := ServiceInvHeader."EU 3-Party Trade";
                        Transaction_Type_H := ServiceInvHeader."Transaction Type";
                        Transport_Method_H := ServiceInvHeader."Transport Method";
                        VAT_Country_Code_H := ServiceInvHeader."VAT Country/Region Code";
                        Sell_to_Customer_Name_H := ServiceInvHeader."Name";
                        Bill_to_Post_Code_H := ServiceInvHeader."Bill-to Post Code";
                        Bill_to_County_H := ServiceInvHeader."Bill-to County";
                        Bill_to_Country_Code_H := ServiceInvHeader."Bill-to Country/Region Code";
                        Sell_to_Post_Code_H := ServiceInvHeader."Post Code";
                        Sell_to_County_H := ServiceInvHeader."County";
                        Sell_to_Country_Code_H := ServiceInvHeader."Country/Region Code";
                        Ship_to_Post_Code_H := ServiceInvHeader."Ship-to Post Code";
                        Ship_to_County_H := ServiceInvHeader."Ship-to County";
                        Ship_to_Country_Code_H := ServiceInvHeader."Ship-to Country/Region Code";
                        Bal_Account_Type_H := ServiceInvHeader."Bal. Account Type";
                        Exit_Point_H := ServiceInvHeader."Exit Point";
                        Correction_H := ServiceInvHeader.Correction;
                        Document_Date_H := ServiceInvHeader."Document Date";
                        //External_Document_No_H := ServiceInvHeader."External Document No.";
                        Area_H := ServiceInvHeader.Area;
                        Transaction_Specification_H := ServiceInvHeader."Transaction Specification";
                        Payment_Method_Code_H := ServiceInvHeader."Payment Method Code";
                        //Shipping_Agent_Code_H := '';//ServiceInvHeader."Shipping Agent Code";
                        //Package_Tracking_No_H := '';//ServiceInvHeader."Package Tracking No.";
                        Pre_Assigned_No_Series_H := ServiceInvHeader."Pre-Assigned No. Series";
                        No_Series_H := ServiceInvHeader."No. Series";
                        Order_No_Series_H := ServiceInvHeader."Order No. Series";
                        Pre_Assigned_No_H := ServiceInvHeader."Pre-Assigned No.";
                        User_ID_H := ServiceInvHeader."User ID";
                        Source_Code_H := ServiceInvHeader."Source Code";
                        Tax_Area_Code_H := ServiceInvHeader."Tax Area Code";
                        Tax_Liable_H := ServiceInvHeader."Tax Liable";
                        VAT_Bus_Posting_Group_H := ServiceInvHeader."VAT Bus. Posting Group";
                        VAT_Base_Discount__H := ServiceInvHeader."VAT Base Discount %";
                        Campaign_No_H := '';//ServiceInvHeader."Campaign No.";
                        Sell_to_Contact_No_H := ServiceInvHeader."Contact No.";
                        Bill_to_Contact_No_H := ServiceInvHeader."Bill-to Contact No.";
                        Responsibility_Center_H := ServiceInvHeader."Responsibility Center";
                        Service_Mgt_Document_H := false;//Leon Comment Out==ServiceInvHeader."Service Mgt. Document";
                        Return_Order_No_H := '';
                        Return_Order_No_Series_H := '';
                        Allow_Line_Disc_H := ServiceInvHeader."Allow Line Disc.";
                        //Get_Shipment_Used_H := ServiceInvHeader."Get Shipment Used";
                        Date_Sent_H := 0D;//Leon Comment Out==ServiceInvHeader."Date Sent";
                        Time_Sent_H := 0T;//Leon Comment Out==ServiceInvHeader."Time Sent";
                        BizTalk_Sales_Invoice_H := false;//Leon Comment Out==ServiceInvHeader."BizTalk Sales Invoice";
                        Customer_Order_No_H := '';//Leon Comment Out==ServiceInvHeader."Customer Order No.";
                        BizTalk_Document_Sent_H := false;//Leon Comment Out==ServiceInvHeader."BizTalk Document Sent";
                    end else begin
                        if ServiceInvLine.Next() = 0 then SvcInvDone := true;
                        CurrReport.Skip();
                    end;



                    Sell_to_Customer_No_L := ServiceInvLine."Customer No.";

                    IF Customer.GET(ServiceInvLine."Customer No.") THEN begin
                        Customer_Name_L := Customer.Name;
                        Country_Code_L := Customer."Country/Region Code";
                        IF NOT Country.GET(Customer."Country/Region Code") THEN
                            Country_Name_L := Country.Name;
                    end;
                    Document_No_L := ServiceInvLine."Document No.";
                    Line_No_L := ServiceInvLine."Line No.";
                    Type_L := ServiceInvLine.Type;
                    No_L := ServiceInvLine."No.";

                    Clear(Product_Type_L);
                    Clear(Model_Type_L);
                    Clear(Used_Item_L);
                    if Item.Get(ServiceInvLine."No.") then begin
                        Product_Type_L := Item."Product Type";
                        Model_Type_L := Item."Model Type";
                        Used_Item_L := Item."Used Item";
                    end;
                    Clear(Resource_Group_No_L);
                    if Resource.GET(ServiceInvLine."No.") then
                        Resource_Group_No_L := Resource."Resource Group No.";

                    Location_Code_L := ServiceInvLine."Location Code";
                    Posting_Group_L := ServiceInvLine."Posting Group";
                    Shipment_Date_L := 0D;//ServiceInvLine."Shipment Date";
                    Description_L := ServiceInvLine.Description;
                    Description_2_L := ServiceInvLine."Description 2";
                    Unit_of_Measure_L := ServiceInvLine."Unit of Measure";
                    Quantity_L := ServiceInvLine.Quantity;
                    Unit_Price_L := ServiceInvLine."Unit Price";
                    Unit_Cost_LCY_L := ServiceInvLine."Unit Cost (LCY)";
                    VAT__L := ServiceInvLine."VAT %";
                    Line_Discount__L := ServiceInvLine."Line Discount %";
                    Line_Discount_Amount_L := ServiceInvLine."Line Discount Amount";
                    Amount_L := ServiceInvLine.Amount;
                    Amount_Including_VAT_L := ServiceInvLine."Amount Including VAT";
                    Allow_Invoice_Disc_L := ServiceInvLine."Allow Invoice Disc.";
                    Gross_Weight_L := ServiceInvLine."Gross Weight";
                    Net_Weight_L := ServiceInvLine."Net Weight";
                    Units_per_Parcel_L := ServiceInvLine."Units per Parcel";
                    Unit_Volume_L := ServiceInvLine."Unit Volume";
                    Appl_to_Item_Entry_L := ServiceInvLine."Appl.-to Item Entry";
                    Shortcut_Dimension_1_Code_L := ServiceInvLine."Shortcut Dimension 1 Code";
                    Shortcut_Dimension_2_Code_L := ServiceInvLine."Shortcut Dimension 2 Code";
                    Customer_Price_Group_L := ServiceInvLine."Customer Price Group";
                    //Job_No_L := ServiceInvLine."Job No.";
                    Appl_to_Job_Entry_L := '';//Leon Comment Out==ServiceInvLine."Appl.-to Job Entry";
                    Phase_Code_L := '';//Leon Comment Out==ServiceInvLine."Phase Code";
                    Task_Code_L := '';//Leon Comment Out==ServiceInvLine."Task Code";
                    Step_Code_L := '';//Leon Comment Out==ServiceInvLine."Step Code";
                    Job_Applies_to_ID_L := '';//Leon Comment Out==ServiceInvLine."Job Applies-to ID";
                    Apply_and_Close_Job_L := '';//Leon Comment Out==ServiceInvLine."Apply and Close (Job)";
                    Work_Type_Code_L := ServiceInvLine."Work Type Code";
                    Shipment_No_L := ServiceInvLine."Shipment No.";
                    Shipment_Line_No_L := ServiceInvLine."Shipment Line No.";
                    Bill_to_Customer_No_L := ServiceInvLine."Bill-to Customer No.";
                    Inv_Discount_Amount_L := ServiceInvLine."Inv. Discount Amount";
                    //Drop_Shipment_L := ServiceInvLine."Drop Shipment";
                    Gen_Bus_Posting_Group_L := ServiceInvLine."Gen. Bus. Posting Group";
                    Gen_Prod_Posting_Group_L := ServiceInvLine."Gen. Prod. Posting Group";
                    VAT_Calculation_Type_L := ServiceInvLine."VAT Calculation Type";
                    Transaction_Type_L := ServiceInvLine."Transaction Type";
                    Transport_Method_L := ServiceInvLine."Transport Method";
                    Attached_to_Line_No_L := ServiceInvLine."Attached to Line No.";
                    Exit_Point_L := ServiceInvLine."Exit Point";
                    Area_L := ServiceInvLine."Area";
                    Transaction_Specification_L := ServiceInvLine."Transaction Specification";
                    Tax_Area_Code_L := ServiceInvLine."Tax Area Code";
                    Tax_Liable_L := ServiceInvLine."Tax Liable";
                    Tax_Group_Code_L := ServiceInvLine."Tax Group Code";
                    VAT_Bus_Posting_Group_L := ServiceInvLine."VAT Bus. Posting Group";
                    VAT_Prod_Posting_Group_L := ServiceInvLine."VAT Prod. Posting Group";
                    //Blanket_Order_No_L := ServiceInvLine."Blanket Order No.";
                    //Blanket_Order_Line_No_L := ServiceInvLine."Blanket Order Line No.";
                    VAT_Base_Amount_L := ServiceInvLine."VAT Base Amount";
                    Unit_Cost_L := ServiceInvLine."Unit Cost (LCY)"; //"Unit Cost";
                    System_Created_Entry_L := ServiceInvLine."System-Created Entry";
                    Line_Amount_L := ServiceInvLine."Line Amount";
                    VAT_Difference_L := ServiceInvLine."VAT Difference";
                    VAT_Identifier_L := ServiceInvLine."VAT Identifier";
                    //IC_Partner_Ref_Type_L := ServiceInvLine."IC Partner Ref. Type";
                    //IC_Partner_Reference_L := ServiceInvLine."IC Partner Reference";
                    Variant_Code_L := ServiceInvLine."Variant Code";
                    Bin_Code_L := ServiceInvLine."Bin Code";
                    Qty_per_Unit_of_Measure_L := ServiceInvLine."Qty. per Unit of Measure";
                    Unit_of_Measure_Code_L := ServiceInvLine."Unit of Measure Code";
                    Quantity_Base_L := ServiceInvLine."Quantity (Base)";
                    //FA_Posting_Date_L := ServiceInvLine."FA Posting Date";
                    //Depreciation_Book_Code_L := ServiceInvLine."Depreciation Book Code";
                    //Depr_until_FA_Posting_Date_L := ServiceInvLine."Depr. until FA Posting Date";
                    //Duplicate_in_Depreciation_Book_L := ServiceInvLine."Duplicate in Depreciation Book";
                    //Use_Duplication_List_L := ServiceInvLine."Use Duplication List";
                    Responsibility_Center_L := ServiceInvLine."Responsibility Center";

                    ItemRef.Reset();
                    ItemRef.SetRange("Item No.", ServiceInvLine."No.");
                    if ItemRef.Find('-') then begin
                        Cross_Reference_No_L := ItemRef."Reference No.";
                        Unit_of_Measure_Cross_Ref_L := ItemRef."Unit of Measure";
                        Cross_Reference_Type_L := ItemRef."Reference Type";
                        Cross_Reference_Type_No_L := ItemRef."Reference Type No.";
                    end else begin
                        //Cross_Reference_No_L := ServiceInvLine."Cross-Reference No.";
                        //Unit_of_Measure_Cross_Ref_L := ServiceInvLine."Unit of Measure (Cross Ref.)";
                        //Cross_Reference_Type_L := ServiceInvLine."Cross-Reference Type";
                        //Cross_Reference_Type_No_L := ServiceInvLine."Cross-Reference Type No.";
                    end;

                    Item_Category_Code_L := ServiceInvLine."Item Category Code";
                    Nonstock_L := ServiceInvLine.Nonstock;
                    //Purchasing_Code_L := ServiceInvLine."Purchasing Code";

                    //ItemCat.Reset();
                    //if ItemCat.Get(ServiceInvLine."Item Category Code") then
                    //    Product_Group_Code_L := ItemCat."Parent Category";
                    Item.Reset();
                    if Item.Get(ServiceInvLine."No.") then
                        Product_Group_Code_L := Item."Product Group";
                    //Product_Group_Code_L := ServiceInvLine."Product Group Code";

                    //Appl_from_Item_Entry_L := ServiceInvLine."Appl.-from Item Entry";
                    Service_Contract_No_L := '';//Leon Comment Out==ServiceInvLine."Service Contract No.";
                    Service_Order_No_L := '';//Leon Comment Out==ServiceInvLine."Service Order No.";
                    Service_Item_No_L := '';//Leon Comment Out==Sales Invoice Line"."Service Item No.";
                    Appl_to_Service_Entry_L := '';//Leon Comment Out==ServiceInvLine."Service Item Line No.";
                    Service_Item_Line_No_L := '';//Leon Comment Out==ServiceInvLine."Service Item Line No.";
                    Serv_Price_Adjmt_Gr_Code_L := '';//Leon Comment Out==ServiceInvLine."Serv. Price Adjmt. Gr. Code";
                    Return_Reason_Code_L := ServiceInvLine."Return Reason Code";
                    Allow_Line_Disc_L := ServiceInvLine."Allow Line Disc.";
                    Customer_Disc_Group_L := ServiceInvLine."Customer Disc. Group";
                    //QSS_System_Code_L := ServiceInvLine."QSS System Code";
                    //Set_Quantity_L := ServiceInvLine."Set Quantity";
                    Return_Receipt_No_L := '';
                    Return_Receipt_Line_No_L := '';
                    EZiS_Customer_No := Customer."EZiS Customer No.";

                    ServiceInvHeader.CALCFIELDS(ServiceInvHeader.Amount, ServiceInvHeader."Amount Including VAT");
                    AmtBeforeDiscFC := ServiceInvLine.Quantity * ServiceInvLine."Unit Price";
                    LineDiscAmtFC := ServiceInvLine."Line Discount Amount";
                    InvDiscAmtFC := ServiceInvLine."Inv. Discount Amount";
                    AmtAfterDiscFC := ServiceInvLine.Amount;
                    IF ServiceInvHeader."Currency Factor" = 0 THEN BEGIN
                        AmtBeforeDiscLCY := AmtBeforeDiscFC;
                        LineDiscAmtLCY := LineDiscAmtFC;
                        InvDiscAmtLCY := InvDiscAmtFC;
                        AmtAfterDiscLCY := AmtAfterDiscFC;
                    END ELSE BEGIN
                        AmtBeforeDiscLCY := ROUND(AmtBeforeDiscFC / ServiceInvHeader."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        LineDiscAmtLCY := ROUND(LineDiscAmtFC / ServiceInvHeader."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        InvDiscAmtLCY := ROUND(InvDiscAmtFC / ServiceInvHeader."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        AmtAfterDiscLCY := ROUND(AmtAfterDiscFC / ServiceInvHeader."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                    END;


                    CurrSvcInvLoop += 1;

                    if ServiceInvLine.Next() = 0 then begin
                        SvcInvDone := true;
                        SvcInvReady := false;
                        SvcCreReady := false;
                        CreReady := false; //Can not get into the Credit loop directly because it's in the last inv loop now.                        
                        CurrSvcInvLoop := SvcInvCount;
                    end;
                end
                else
                    if InvDone and SvcInvDone and ((CurrInvLoop = 0) or (CurrInvLoop > InvCount)) then begin //else for : if not InvDone; means finish all of the inv loop
                        SvcCreReady := true;
                        CurrSvcInvLoop := SvcInvCount + 1;
                    end;
                #endregion Service Invoice Lines

                //===========Service Credit Memo Lines=================================================================   
                #region Service Credit Memo Lines
                if not SvcCreDone and SvcCreReady then begin
                    ClearHeaderVar();
                    ClearLineVar();

                    InvOrCre := 'C';

                    ServiceCreHeader.Reset();
                    ServiceCreHeader.SetRange("No.", ServiceCreLine."Document No.");
                    IF (ToPostingDate >= FromPostingDate) and (FromPostingDate <> 0D) and (ToPostingDate <> 0D) THEN
                        ServiceCreHeader.SetRange("Posting Date", FromPostingDate, ToPostingDate);

                    IF (ToCurrencyCode >= FromCurrencyCode) and (FromCurrencyCode <> '') and (ToCurrencyCode <> '') THEN
                        ServiceCreHeader.SetRange("Currency Code", FromCurrencyCode, ToCurrencyCode);

                    IF (ToCountryCode >= FromCountryCode) and (FromCountryCode <> '') and (ToCountryCode <> '') THEN
                        ServiceCreHeader.SetRange("Country/Region Code", FromCountryCode, ToCountryCode);


                    if ServiceCreHeader.Find('-') then begin
                        Sell_to_Customer_No_H := ServiceCreHeader."Customer No.";
                        No_H := ServiceCreHeader."No.";
                        Bill_to_Customer_No_H := ServiceCreHeader."Bill-to Customer No.";
                        Bill_to_Name_H := ServiceCreHeader."Bill-to Name";
                        Your_Reference_H := ServiceCreHeader."Your Reference";
                        Ship_to_Code_H := ServiceCreHeader."Ship-to Code";
                        Ship_to_Name_H := ServiceCreHeader."Ship-to Name";
                        //Order_Date_H := ServiceCreHeader."Order Date";
                        Posting_Date_H := ServiceCreHeader."Posting Date";
                        //Shipment_Date_H := ServiceCreHeader."Shipment Date";
                        Posting_Description_H := ServiceCreHeader."Posting Description";
                        Payment_Terms_Code_H := ServiceCreHeader."Payment Terms Code";
                        Due_Date_H := ServiceCreHeader."Due Date";
                        Payment_Discount__H := ServiceCreHeader."Payment Discount %";
                        Pmt_Discount_Date_H := ServiceCreHeader."Pmt. Discount Date";
                        //Shipment_Method_Code_H := ServiceCreHeader."Shipment Method Code";
                        Location_Code_H := ServiceCreHeader."Location Code";
                        Shortcut_Dimension_1_Code_H := ServiceCreHeader."Shortcut Dimension 1 Code";
                        Shortcut_Dimension_2_Code_H := ServiceCreHeader."Shortcut Dimension 2 Code";
                        Customer_Posting_Group_H := ServiceCreHeader."Customer Posting Group";
                        Currency_Code_H := ServiceCreHeader."Currency Code";
                        Currency_Factor_H := ServiceCreHeader."Currency Factor";
                        Customer_Price_Group_H := ServiceCreHeader."Customer Price Group";
                        Prices_Including_VAT_H := ServiceCreHeader."Prices Including VAT";
                        Invoice_Disc_Code_H := ServiceCreHeader."Invoice Disc. Code";
                        Customer_Disc_Group_H := ServiceCreHeader."Customer Disc. Group";
                        Language_Code_H := ServiceCreHeader."Language Code";
                        Salesperson_Code_H := ServiceCreHeader."Salesperson Code";
                        //Order_No_H := ServiceCreHeader."Order No.";
                        Comment_H := ServiceCreHeader.Comment;
                        No_Printed_H := ServiceCreHeader."No. Printed";
                        //On_Hold_H := ServiceCreHeader."On Hold";
                        Applies_to_Doc_Type_H := ServiceCreHeader."Applies-to Doc. Type";
                        Applies_to_Doc_No_H := ServiceCreHeader."Applies-to Doc. No.";
                        Bal_Account_No_H := ServiceCreHeader."Bal. Account No.";
                        Job_No_H := '';//Leon Comment Out==ServiceCreHeader."Job No.";
                        ServiceCreHeader.CalcFields(Amount, "Amount Including VAT");
                        Amount_H := -ServiceCreHeader.Amount;
                        Amount_Including_VAT_H := -ServiceCreHeader."Amount Including VAT";
                        VAT_Registration_No_H := ServiceCreHeader."VAT Registration No.";
                        Reason_Code_H := ServiceCreHeader."Reason Code";
                        Gen_Bus_Posting_Group_H := ServiceCreHeader."Gen. Bus. Posting Group";
                        EU_3_Party_Trade_H := ServiceCreHeader."EU 3-Party Trade";
                        Transaction_Type_H := ServiceCreHeader."Transaction Type";
                        Transport_Method_H := ServiceCreHeader."Transport Method";
                        VAT_Country_Code_H := ServiceCreHeader."VAT Country/Region Code";
                        Sell_to_Customer_Name_H := ServiceCreHeader."Name";
                        Bill_to_Post_Code_H := ServiceCreHeader."Bill-to Post Code";
                        Bill_to_County_H := ServiceCreHeader."Bill-to County";
                        Bill_to_Country_Code_H := ServiceCreHeader."Bill-to Country/Region Code";
                        Sell_to_Post_Code_H := ServiceCreHeader."Post Code";
                        Sell_to_County_H := ServiceCreHeader."County";
                        Sell_to_Country_Code_H := ServiceCreHeader."Country/Region Code";
                        Ship_to_Post_Code_H := ServiceCreHeader."Ship-to Post Code";
                        Ship_to_County_H := ServiceCreHeader."Ship-to County";
                        Ship_to_Country_Code_H := ServiceCreHeader."Ship-to Country/Region Code";
                        Bal_Account_Type_H := ServiceCreHeader."Bal. Account Type";
                        Exit_Point_H := ServiceCreHeader."Exit Point";
                        Correction_H := ServiceCreHeader.Correction;
                        Document_Date_H := ServiceCreHeader."Document Date";
                        //External_Document_No_H := ServiceCreHeader."External Document No.";
                        Area_H := ServiceCreHeader.Area;
                        Transaction_Specification_H := ServiceCreHeader."Transaction Specification";
                        Payment_Method_Code_H := ServiceCreHeader."Payment Method Code";
                        //Shipping_Agent_Code_H := '';//ServiceCreHeader."Shipping Agent Code";
                        //Package_Tracking_No_H := '';//ServiceCreHeader."Package Tracking No.";
                        Pre_Assigned_No_Series_H := ServiceCreHeader."Pre-Assigned No. Series";
                        No_Series_H := ServiceCreHeader."No. Series";
                        //Order_No_Series_H := ServiceCreHeader."Order No. Series";
                        Pre_Assigned_No_H := ServiceCreHeader."Pre-Assigned No.";
                        User_ID_H := ServiceCreHeader."User ID";
                        Source_Code_H := ServiceCreHeader."Source Code";
                        Tax_Area_Code_H := ServiceCreHeader."Tax Area Code";
                        Tax_Liable_H := ServiceCreHeader."Tax Liable";
                        VAT_Bus_Posting_Group_H := ServiceCreHeader."VAT Bus. Posting Group";
                        VAT_Base_Discount__H := ServiceCreHeader."VAT Base Discount %";
                        Campaign_No_H := '';//ServiceCreHeader."Campaign No.";
                        Sell_to_Contact_No_H := ServiceCreHeader."Contact No.";
                        Bill_to_Contact_No_H := ServiceCreHeader."Bill-to Contact No.";
                        Responsibility_Center_H := ServiceCreHeader."Responsibility Center";
                        Service_Mgt_Document_H := false;//Leon Comment Out==ServiceCreHeader."Service Mgt. Document";
                        Return_Order_No_H := '';
                        Return_Order_No_Series_H := '';
                        Allow_Line_Disc_H := ServiceCreHeader."Allow Line Disc.";
                        //Get_Shipment_Used_H := ServiceCreHeader."Get Shipment Used";
                        Date_Sent_H := 0D;//Leon Comment Out==ServiceCreHeader."Date Sent";
                        Time_Sent_H := 0T;//Leon Comment Out==ServiceCreHeader."Time Sent";
                        BizTalk_Sales_Invoice_H := false;//Leon Comment Out==ServiceCreHeader."BizTalk Sales Invoice";
                        Customer_Order_No_H := '';//Leon Comment Out==ServiceCreHeader."Customer Order No.";
                        BizTalk_Document_Sent_H := false;//Leon Comment Out==ServiceCreHeader."BizTalk Document Sent";
                    end else begin
                        if ServiceCreLine.Next() = 0 then SvcCreDone := true;
                        CurrReport.Skip();
                    end;



                    Sell_to_Customer_No_L := ServiceCreLine."Customer No.";

                    IF Customer.GET(ServiceCreLine."Customer No.") THEN begin
                        Customer_Name_L := Customer.Name;
                        Country_Code_L := Customer."Country/Region Code";
                        IF NOT Country.GET(Customer."Country/Region Code") THEN
                            Country_Name_L := Country.Name;
                    end;
                    Document_No_L := ServiceCreLine."Document No.";
                    Line_No_L := ServiceCreLine."Line No.";
                    Type_L := ServiceCreLine.Type;
                    No_L := ServiceCreLine."No.";

                    Clear(Product_Type_L);
                    Clear(Model_Type_L);
                    Clear(Used_Item_L);
                    if Item.Get(ServiceCreLine."No.") then begin
                        Product_Type_L := Item."Product Type";
                        Model_Type_L := Item."Model Type";
                        Used_Item_L := Item."Used Item";
                    end;
                    Clear(Resource_Group_No_L);
                    if Resource.GET(ServiceCreLine."No.") then
                        Resource_Group_No_L := Resource."Resource Group No.";

                    Location_Code_L := ServiceCreLine."Location Code";
                    Posting_Group_L := ServiceCreLine."Posting Group";
                    Shipment_Date_L := 0D;//ServiceCreLine."Shipment Date";
                    Description_L := ServiceCreLine.Description;
                    Description_2_L := ServiceCreLine."Description 2";
                    Unit_of_Measure_L := ServiceCreLine."Unit of Measure";
                    Quantity_L := ServiceCreLine.Quantity;
                    Unit_Price_L := ServiceCreLine."Unit Price";
                    Unit_Cost_LCY_L := ServiceCreLine."Unit Cost (LCY)";
                    VAT__L := ServiceCreLine."VAT %";
                    Line_Discount__L := ServiceCreLine."Line Discount %";
                    Line_Discount_Amount_L := -ServiceCreLine."Line Discount Amount";
                    Amount_L := -ServiceCreLine.Amount;
                    Amount_Including_VAT_L := -ServiceCreLine."Amount Including VAT";
                    Allow_Invoice_Disc_L := ServiceCreLine."Allow Invoice Disc.";
                    Gross_Weight_L := ServiceCreLine."Gross Weight";
                    Net_Weight_L := ServiceCreLine."Net Weight";
                    Units_per_Parcel_L := ServiceCreLine."Units per Parcel";
                    Unit_Volume_L := ServiceCreLine."Unit Volume";
                    //Appl_to_Item_Entry_L := ServiceCreLine."Appl.-to Item Entry";
                    Shortcut_Dimension_1_Code_L := ServiceCreLine."Shortcut Dimension 1 Code";
                    Shortcut_Dimension_2_Code_L := ServiceCreLine."Shortcut Dimension 2 Code";
                    Customer_Price_Group_L := ServiceCreLine."Customer Price Group";
                    //Job_No_L := ServiceCreLine."Job No.";
                    Appl_to_Job_Entry_L := '';//Leon Comment Out==ServiceCreLine."Appl.-to Job Entry";
                    Phase_Code_L := '';//Leon Comment Out==ServiceCreLine."Phase Code";
                    Task_Code_L := '';//Leon Comment Out==ServiceCreLine."Task Code";
                    Step_Code_L := '';//Leon Comment Out==ServiceCreLine."Step Code";
                    Job_Applies_to_ID_L := '';//Leon Comment Out==ServiceCreLine."Job Applies-to ID";
                    Apply_and_Close_Job_L := '';//Leon Comment Out==ServiceCreLine."Apply and Close (Job)";
                    Work_Type_Code_L := ServiceCreLine."Work Type Code";
                    Shipment_No_L := ServiceCreLine."Shipment No.";
                    //Shipment_Line_No_L := ServiceCreLine."Shipment Line No.";
                    Bill_to_Customer_No_L := ServiceCreLine."Bill-to Customer No.";
                    Inv_Discount_Amount_L := -ServiceCreLine."Inv. Discount Amount";
                    //Drop_Shipment_L := ServiceCreLine."Drop Shipment";
                    Gen_Bus_Posting_Group_L := ServiceCreLine."Gen. Bus. Posting Group";
                    Gen_Prod_Posting_Group_L := ServiceCreLine."Gen. Prod. Posting Group";
                    VAT_Calculation_Type_L := ServiceCreLine."VAT Calculation Type";
                    Transaction_Type_L := ServiceCreLine."Transaction Type";
                    Transport_Method_L := ServiceCreLine."Transport Method";
                    Attached_to_Line_No_L := ServiceCreLine."Attached to Line No.";
                    Exit_Point_L := ServiceCreLine."Exit Point";
                    Area_L := ServiceCreLine."Area";
                    Transaction_Specification_L := ServiceCreLine."Transaction Specification";
                    Tax_Area_Code_L := ServiceCreLine."Tax Area Code";
                    Tax_Liable_L := ServiceCreLine."Tax Liable";
                    Tax_Group_Code_L := ServiceCreLine."Tax Group Code";
                    VAT_Bus_Posting_Group_L := ServiceCreLine."VAT Bus. Posting Group";
                    VAT_Prod_Posting_Group_L := ServiceCreLine."VAT Prod. Posting Group";
                    //Blanket_Order_No_L := ServiceCreLine."Blanket Order No.";
                    //Blanket_Order_Line_No_L := ServiceCreLine."Blanket Order Line No.";
                    VAT_Base_Amount_L := -ServiceCreLine."VAT Base Amount";
                    Unit_Cost_L := ServiceCreLine."Unit Cost (LCY)"; //"Unit Cost";
                    System_Created_Entry_L := ServiceCreLine."System-Created Entry";
                    Line_Amount_L := -ServiceCreLine."Line Amount";
                    VAT_Difference_L := ServiceCreLine."VAT Difference";
                    VAT_Identifier_L := ServiceCreLine."VAT Identifier";
                    //IC_Partner_Ref_Type_L := ServiceCreLine."IC Partner Ref. Type";
                    //IC_Partner_Reference_L := ServiceCreLine."IC Partner Reference";
                    Variant_Code_L := ServiceCreLine."Variant Code";
                    Bin_Code_L := ServiceCreLine."Bin Code";
                    Qty_per_Unit_of_Measure_L := ServiceCreLine."Qty. per Unit of Measure";
                    Unit_of_Measure_Code_L := ServiceCreLine."Unit of Measure Code";
                    Quantity_Base_L := ServiceCreLine."Quantity (Base)";
                    //FA_Posting_Date_L := ServiceCreLine."FA Posting Date";
                    //Depreciation_Book_Code_L := ServiceCreLine."Depreciation Book Code";
                    //Depr_until_FA_Posting_Date_L := ServiceCreLine."Depr. until FA Posting Date";
                    //Duplicate_in_Depreciation_Book_L := ServiceCreLine."Duplicate in Depreciation Book";
                    //Use_Duplication_List_L := ServiceCreLine."Use Duplication List";
                    Responsibility_Center_L := ServiceCreLine."Responsibility Center";

                    ItemRef.Reset();
                    ItemRef.SetRange("Item No.", ServiceCreLine."No.");
                    if ItemRef.Find('-') then begin
                        Cross_Reference_No_L := ItemRef."Reference No.";
                        Unit_of_Measure_Cross_Ref_L := ItemRef."Unit of Measure";
                        Cross_Reference_Type_L := ItemRef."Reference Type";
                        Cross_Reference_Type_No_L := ItemRef."Reference Type No.";
                    end else begin
                        //Cross_Reference_No_L := ServiceCreLine."Cross-Reference No.";
                        //Unit_of_Measure_Cross_Ref_L := ServiceCreLine."Unit of Measure (Cross Ref.)";
                        //Cross_Reference_Type_L := ServiceCreLine."Cross-Reference Type";
                        //Cross_Reference_Type_No_L := ServiceCreLine."Cross-Reference Type No.";
                    end;

                    Item_Category_Code_L := ServiceCreLine."Item Category Code";
                    Nonstock_L := ServiceCreLine.Nonstock;
                    //Purchasing_Code_L := ServiceCreLine."Purchasing Code";

                    //ItemCat.Reset();
                    //if ItemCat.Get(ServiceCreLine."Item Category Code") then
                    //    Product_Group_Code_L := ItemCat."Parent Category";
                    Item.Reset();
                    if Item.Get(ServiceCreLine."No.") then
                        Product_Group_Code_L := Item."Product Group";
                    //Product_Group_Code_L := ServiceCreLine."Product Group Code";

                    //Appl_from_Item_Entry_L := ServiceCreLine."Appl.-from Item Entry";
                    Service_Contract_No_L := '';//Leon Comment Out==ServiceCreLine."Service Contract No.";
                    Service_Order_No_L := '';//Leon Comment Out==ServiceCreLine."Service Order No.";
                    Service_Item_No_L := '';//Leon Comment Out==Sales Invoice Line"."Service Item No.";
                    Appl_to_Service_Entry_L := '';//Leon Comment Out==ServiceCreLine."Service Item Line No.";
                    Service_Item_Line_No_L := '';//Leon Comment Out==ServiceCreLine."Service Item Line No.";
                    Serv_Price_Adjmt_Gr_Code_L := '';//Leon Comment Out==ServiceCreLine."Serv. Price Adjmt. Gr. Code";
                    Return_Reason_Code_L := ServiceCreLine."Return Reason Code";
                    Allow_Line_Disc_L := ServiceCreLine."Allow Line Disc.";
                    Customer_Disc_Group_L := ServiceCreLine."Customer Disc. Group";
                    //QSS_System_Code_L := ServiceCreLine."QSS System Code";
                    //Set_Quantity_L := ServiceCreLine."Set Quantity";
                    Return_Receipt_No_L := '';
                    Return_Receipt_Line_No_L := '';
                    EZiS_Customer_No := Customer."EZiS Customer No.";

                    ServiceCreHeader.CALCFIELDS(ServiceCreHeader.Amount, ServiceCreHeader."Amount Including VAT");
                    AmtBeforeDiscFC := -ServiceCreLine.Quantity * ServiceCreLine."Unit Price";
                    LineDiscAmtFC := -ServiceCreLine."Line Discount Amount";
                    InvDiscAmtFC := -ServiceCreLine."Inv. Discount Amount";
                    AmtAfterDiscFC := -ServiceCreLine.Amount;
                    IF ServiceCreHeader."Currency Factor" = 0 THEN BEGIN
                        AmtBeforeDiscLCY := AmtBeforeDiscFC;
                        LineDiscAmtLCY := LineDiscAmtFC;
                        InvDiscAmtLCY := InvDiscAmtFC;
                        AmtAfterDiscLCY := AmtAfterDiscFC;
                    END ELSE BEGIN
                        AmtBeforeDiscLCY := -ROUND(AmtBeforeDiscFC / ServiceCreHeader."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        LineDiscAmtLCY := -ROUND(LineDiscAmtFC / ServiceCreHeader."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        InvDiscAmtLCY := -ROUND(InvDiscAmtFC / ServiceCreHeader."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        AmtAfterDiscLCY := -ROUND(AmtAfterDiscFC / ServiceCreHeader."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                    END;
                    IF ServiceCreLine.Type = ServiceCreLine.Type::Item THEN
                        CrMmQty := -ServiceCreLine.Quantity
                    ELSE
                        CrMmQty := ServiceCreLine.Quantity;


                    CurrSvcCreLoop += 1;

                    if ServiceCreLine.Next() = 0 then begin
                        SvcCreDone := true;
                        SvcInvReady := false;
                        SvcCreReady := false;
                        CreReady := false; //Can not get into the Credit loop directly because it's in the last inv loop now.                        
                        CurrSvcCreLoop := SvcCreCount;
                    end;
                end
                else
                    if InvDone and SvcInvDone and SvcCreDone and ((CurrInvLoop = 0) or (CurrInvLoop > InvCount)) and ((CurrSvcInvLoop = 0) or (CurrSvcInvLoop > SvcInvCount)) then begin //else for : if SvcCreDone; means finish all of the Service Credit Memo Lines loop
                        CreReady := true;
                        CurrSvcCreLoop := SvcCreCount + 1;
                    end;
                #endregion Service Credit Memo Lines


                //===========Sales Credit Memo Lines=================================================================
                #region Sales Credit Memo Lines
                if CreReady and (CurrCreLoop <= CreCount) then begin
                    ClearHeaderVar();
                    ClearLineVar();

                    InvOrCre := 'C';

                    SalesCrMmHdr.Reset();
                    SalesCrMmHdr.SetRange("No.", "Sales Cr.Memo Line"."Document No.");
                    IF (ToPostingDate >= FromPostingDate) and (FromPostingDate <> 0D) and (ToPostingDate <> 0D) THEN
                        SalesCrMmHdr.SetRange("Posting Date", FromPostingDate, ToPostingDate);

                    IF (ToCurrencyCode >= FromCurrencyCode) and (FromCurrencyCode <> '') and (ToCurrencyCode <> '') THEN
                        SalesCrMmHdr.SetRange("Currency Code", FromCurrencyCode, ToCurrencyCode);

                    IF (ToCountryCode >= FromCountryCode) and (FromCountryCode <> '') and (ToCountryCode <> '') THEN
                        SalesCrMmHdr.SetRange("Sell-to Country/Region Code", FromCountryCode, ToCountryCode);

                    if SalesCrMmHdr.Find('-') then begin
                        Sell_to_Customer_No_H := SalesCrMmHdr."Sell-to Customer No.";
                        No_H := SalesCrMmHdr."No.";
                        Bill_to_Customer_No_H := SalesCrMmHdr."Bill-to Customer No.";
                        Bill_to_Name_H := SalesCrMmHdr."Bill-to Name";
                        Your_Reference_H := SalesCrMmHdr."Your Reference";
                        Ship_to_Code_H := SalesCrMmHdr."Ship-to Code";
                        Ship_to_Name_H := SalesCrMmHdr."Ship-to Name";
                        Order_Date_H := 0D;//Leon Comment Out==SalesCrMmHdr."Order Date";
                        Posting_Date_H := SalesCrMmHdr."Posting Date";
                        Shipment_Date_H := SalesCrMmHdr."Shipment Date";
                        Posting_Description_H := SalesCrMmHdr."Posting Description";
                        Payment_Terms_Code_H := SalesCrMmHdr."Payment Terms Code";
                        Due_Date_H := SalesCrMmHdr."Due Date";
                        Payment_Discount__H := SalesCrMmHdr."Payment Discount %";
                        Pmt_Discount_Date_H := SalesCrMmHdr."Pmt. Discount Date";
                        Shipment_Method_Code_H := SalesCrMmHdr."Shipment Method Code";
                        Location_Code_H := SalesCrMmHdr."Location Code";
                        Shortcut_Dimension_1_Code_H := SalesCrMmHdr."Shortcut Dimension 1 Code";
                        Shortcut_Dimension_2_Code_H := SalesCrMmHdr."Shortcut Dimension 2 Code";
                        Customer_Posting_Group_H := SalesCrMmHdr."Customer Posting Group";
                        Currency_Code_H := SalesCrMmHdr."Currency Code";
                        Currency_Factor_H := SalesCrMmHdr."Currency Factor";
                        Customer_Price_Group_H := SalesCrMmHdr."Customer Price Group";
                        Prices_Including_VAT_H := SalesCrMmHdr."Prices Including VAT";
                        Invoice_Disc_Code_H := SalesCrMmHdr."Invoice Disc. Code";
                        Customer_Disc_Group_H := SalesCrMmHdr."Customer Disc. Group";
                        Language_Code_H := SalesCrMmHdr."Language Code";
                        Salesperson_Code_H := SalesCrMmHdr."Salesperson Code";
                        Order_No_H := '';//SalesCrMmHdr."Order No.";
                        Comment_H := SalesCrMmHdr.Comment;
                        No_Printed_H := SalesCrMmHdr."No. Printed";
                        On_Hold_H := SalesCrMmHdr."On Hold";
                        Applies_to_Doc_Type_H := SalesCrMmHdr."Applies-to Doc. Type";
                        Applies_to_Doc_No_H := SalesCrMmHdr."Applies-to Doc. No.";
                        Bal_Account_No_H := SalesCrMmHdr."Bal. Account No.";
                        Job_No_H := '';//Leon Comment Out==SalesCrMmHdr."Job No.";
                        SalesCrMmHdr.CalcFields(Amount, "Amount Including VAT");
                        Amount_H := -SalesCrMmHdr.Amount;
                        Amount_Including_VAT_H := -SalesCrMmHdr."Amount Including VAT";
                        VAT_Registration_No_H := SalesCrMmHdr."VAT Registration No.";
                        Reason_Code_H := SalesCrMmHdr."Reason Code";
                        Gen_Bus_Posting_Group_H := SalesCrMmHdr."Gen. Bus. Posting Group";
                        EU_3_Party_Trade_H := SalesCrMmHdr."EU 3-Party Trade";
                        Transaction_Type_H := SalesCrMmHdr."Transaction Type";
                        Transport_Method_H := SalesCrMmHdr."Transport Method";
                        VAT_Country_Code_H := SalesCrMmHdr."VAT Country/Region Code";
                        Sell_to_Customer_Name_H := SalesCrMmHdr."Sell-to Customer Name";
                        Bill_to_Post_Code_H := SalesCrMmHdr."Bill-to Post Code";
                        Bill_to_County_H := SalesCrMmHdr."Bill-to County";
                        Bill_to_Country_Code_H := SalesCrMmHdr."Bill-to Country/Region Code";
                        Sell_to_Post_Code_H := SalesCrMmHdr."Sell-to Post Code";
                        Sell_to_County_H := SalesCrMmHdr."Sell-to County";
                        Sell_to_Country_Code_H := SalesCrMmHdr."Sell-to Country/Region Code";
                        Ship_to_Post_Code_H := SalesCrMmHdr."Ship-to Post Code";
                        Ship_to_County_H := SalesCrMmHdr."Ship-to County";
                        Ship_to_Country_Code_H := SalesCrMmHdr."Ship-to Country/Region Code";
                        Bal_Account_Type_H := SalesCrMmHdr."Bal. Account Type";
                        Exit_Point_H := SalesCrMmHdr."Exit Point";
                        Correction_H := SalesCrMmHdr.Correction;
                        Document_Date_H := SalesCrMmHdr."Document Date";
                        External_Document_No_H := SalesCrMmHdr."External Document No.";
                        Area_H := SalesCrMmHdr.Area;
                        Transaction_Specification_H := SalesCrMmHdr."Transaction Specification";
                        Payment_Method_Code_H := SalesCrMmHdr."Payment Method Code";
                        Shipping_Agent_Code_H := SalesCrMmHdr."Shipping Agent Code";
                        Package_Tracking_No_H := SalesCrMmHdr."Package Tracking No.";
                        Pre_Assigned_No_Series_H := SalesCrMmHdr."Pre-Assigned No. Series";
                        No_Series_H := SalesCrMmHdr."No. Series";
                        Order_No_Series_H := '';//SalesCrMmHdr."Order No. Series";
                        Pre_Assigned_No_H := SalesCrMmHdr."Pre-Assigned No.";
                        User_ID_H := SalesCrMmHdr."User ID";
                        Source_Code_H := SalesCrMmHdr."Source Code";
                        Tax_Area_Code_H := SalesCrMmHdr."Tax Area Code";
                        Tax_Liable_H := SalesCrMmHdr."Tax Liable";
                        VAT_Bus_Posting_Group_H := SalesCrMmHdr."VAT Bus. Posting Group";
                        VAT_Base_Discount__H := SalesCrMmHdr."VAT Base Discount %";
                        Campaign_No_H := SalesCrMmHdr."Campaign No.";
                        Sell_to_Contact_No_H := SalesCrMmHdr."Sell-to Contact No.";
                        Bill_to_Contact_No_H := SalesCrMmHdr."Bill-to Contact No.";
                        Responsibility_Center_H := SalesCrMmHdr."Responsibility Center";
                        Service_Mgt_Document_H := false;//Leon Comment Out==SalesCrMmHdr."Service Mgt. Document";
                        Return_Order_No_H := '';
                        Return_Order_No_Series_H := '';
                        Allow_Line_Disc_H := SalesCrMmHdr."Allow Line Disc.";
                        Get_Shipment_Used_H := SalesCrMmHdr."Get Return Receipt Used";
                        Date_Sent_H := 0D;//Leon Comment Out==SalesCrMmHdr."Date Sent";
                        Time_Sent_H := 0T;//Leon Comment Out==SalesCrMmHdr."Time Sent";
                        BizTalk_Sales_Invoice_H := false;//Leon Comment Out==SalesCrMmHdr."BizTalk Sales Invoice";
                        Customer_Order_No_H := '';//Leon Comment Out==SalesCrMmHdr."Customer Order No.";
                        BizTalk_Document_Sent_H := false;//Leon Comment Out==SalesCrMmHdr."BizTalk Document Sent";
                    end else begin
                        if "Sales Cr.Memo Line".Next() = 0 then CurrReport.Break();
                        CurrReport.Skip();
                    end;

                    Sell_to_Customer_No_L := "Sales Cr.Memo Line"."Sell-to Customer No.";

                    IF Customer.GET("Sales Cr.Memo Line"."Sell-to Customer No.") THEN begin
                        Customer_Name_L := Customer.Name;
                        Country_Code_L := Customer."Country/Region Code";
                        IF NOT Country.GET(Customer."Country/Region Code") THEN
                            Country_Name_L := Country.Name;
                    end;
                    Document_No_L := "Sales Cr.Memo Line"."Document No.";
                    Line_No_L := "Sales Cr.Memo Line"."Line No.";
                    Type_L := "Sales Cr.Memo Line".Type;
                    No_L := "Sales Cr.Memo Line"."No.";

                    Clear(Product_Type_L);
                    Clear(Model_Type_L);
                    Clear(Used_Item_L);
                    if Item.Get("Sales Cr.Memo Line"."No.") then begin
                        Product_Type_L := Item."Product Type";
                        Model_Type_L := Item."Model Type";
                        Used_Item_L := Item."Used Item";
                    end;
                    Clear(Resource_Group_No_L);
                    if Resource.GET("Sales Cr.Memo Line"."No.") then
                        Resource_Group_No_L := Resource."Resource Group No.";

                    Location_Code_L := "Sales Cr.Memo Line"."Location Code";
                    Posting_Group_L := "Sales Cr.Memo Line"."Posting Group";
                    Shipment_Date_L := "Sales Cr.Memo Line"."Shipment Date";
                    Description_L := "Sales Cr.Memo Line".Description;
                    Description_2_L := "Sales Cr.Memo Line"."Description 2";
                    Unit_of_Measure_L := "Sales Cr.Memo Line"."Unit of Measure";
                    Quantity_L := "Sales Cr.Memo Line".Quantity;
                    Unit_Price_L := "Sales Cr.Memo Line"."Unit Price";
                    Unit_Cost_LCY_L := "Sales Cr.Memo Line"."Unit Cost (LCY)";
                    VAT__L := "Sales Cr.Memo Line"."VAT %";
                    Line_Discount__L := "Sales Cr.Memo Line"."Line Discount %";
                    Line_Discount_Amount_L := -"Sales Cr.Memo Line"."Line Discount Amount";
                    Amount_L := -"Sales Cr.Memo Line".Amount;
                    Amount_Including_VAT_L := -"Sales Cr.Memo Line"."Amount Including VAT";
                    Allow_Invoice_Disc_L := "Sales Cr.Memo Line"."Allow Invoice Disc.";
                    Gross_Weight_L := "Sales Cr.Memo Line"."Gross Weight";
                    Net_Weight_L := "Sales Cr.Memo Line"."Net Weight";
                    Units_per_Parcel_L := "Sales Cr.Memo Line"."Units per Parcel";
                    Unit_Volume_L := "Sales Cr.Memo Line"."Unit Volume";
                    Appl_to_Item_Entry_L := "Sales Cr.Memo Line"."Appl.-to Item Entry";
                    Shortcut_Dimension_1_Code_L := "Sales Cr.Memo Line"."Shortcut Dimension 1 Code";
                    Shortcut_Dimension_2_Code_L := "Sales Cr.Memo Line"."Shortcut Dimension 2 Code";
                    Customer_Price_Group_L := "Sales Cr.Memo Line"."Customer Price Group";
                    Job_No_L := "Sales Cr.Memo Line"."Job No.";
                    Appl_to_Job_Entry_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Appl.-to Job Entry";
                    Phase_Code_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Phase Code";
                    Task_Code_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Task Code";
                    Step_Code_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Step Code";
                    Job_Applies_to_ID_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Job Applies-to ID";
                    Apply_and_Close_Job_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Apply and Close (Job)";
                    Work_Type_Code_L := "Sales Cr.Memo Line"."Work Type Code";
                    Shipment_No_L := '';//"Sales Cr.Memo Line"."Shipment No.";
                    Shipment_Line_No_L := 0;//Leon Comment Out=="Sales Cr.Memo Line"."Shipment Line No.";
                    Bill_to_Customer_No_L := "Sales Cr.Memo Line"."Bill-to Customer No.";
                    Inv_Discount_Amount_L := -"Sales Cr.Memo Line"."Inv. Discount Amount";
                    Drop_Shipment_L := false;//Leon Comment Out=="Sales Cr.Memo Line"."Drop Shipment";
                    Gen_Bus_Posting_Group_L := "Sales Cr.Memo Line"."Gen. Bus. Posting Group";
                    Gen_Prod_Posting_Group_L := "Sales Cr.Memo Line"."Gen. Prod. Posting Group";
                    VAT_Calculation_Type_L := "Sales Cr.Memo Line"."VAT Calculation Type";
                    Transaction_Type_L := "Sales Cr.Memo Line"."Transaction Type";
                    Transport_Method_L := "Sales Cr.Memo Line"."Transport Method";
                    Attached_to_Line_No_L := "Sales Cr.Memo Line"."Attached to Line No.";
                    Exit_Point_L := "Sales Cr.Memo Line"."Exit Point";
                    Area_L := "Sales Cr.Memo Line"."Area";
                    Transaction_Specification_L := "Sales Cr.Memo Line"."Transaction Specification";
                    Tax_Area_Code_L := "Sales Cr.Memo Line"."Tax Area Code";
                    Tax_Liable_L := "Sales Cr.Memo Line"."Tax Liable";
                    Tax_Group_Code_L := "Sales Cr.Memo Line"."Tax Group Code";
                    VAT_Bus_Posting_Group_L := "Sales Cr.Memo Line"."VAT Bus. Posting Group";
                    VAT_Prod_Posting_Group_L := "Sales Cr.Memo Line"."VAT Prod. Posting Group";
                    Blanket_Order_No_L := "Sales Cr.Memo Line"."Blanket Order No.";
                    Blanket_Order_Line_No_L := "Sales Cr.Memo Line"."Blanket Order Line No.";
                    VAT_Base_Amount_L := -"Sales Cr.Memo Line"."VAT Base Amount";
                    Unit_Cost_L := "Sales Cr.Memo Line"."Unit Cost";
                    System_Created_Entry_L := "Sales Cr.Memo Line"."System-Created Entry";
                    Line_Amount_L := -"Sales Cr.Memo Line"."Line Amount";
                    VAT_Difference_L := -"Sales Cr.Memo Line"."VAT Difference";
                    VAT_Identifier_L := "Sales Cr.Memo Line"."VAT Identifier";
                    IC_Partner_Ref_Type_L := "Sales Cr.Memo Line"."IC Partner Ref. Type";
                    IC_Partner_Reference_L := "Sales Cr.Memo Line"."IC Partner Reference";
                    Variant_Code_L := "Sales Cr.Memo Line"."Variant Code";
                    Bin_Code_L := "Sales Cr.Memo Line"."Bin Code";
                    Qty_per_Unit_of_Measure_L := "Sales Cr.Memo Line"."Qty. per Unit of Measure";
                    Unit_of_Measure_Code_L := "Sales Cr.Memo Line"."Unit of Measure Code";
                    Quantity_Base_L := "Sales Cr.Memo Line"."Quantity (Base)";
                    FA_Posting_Date_L := "Sales Cr.Memo Line"."FA Posting Date";
                    Depreciation_Book_Code_L := "Sales Cr.Memo Line"."Depreciation Book Code";
                    Depr_until_FA_Posting_Date_L := "Sales Cr.Memo Line"."Depr. until FA Posting Date";
                    Duplicate_in_Depreciation_Book_L := "Sales Cr.Memo Line"."Duplicate in Depreciation Book";
                    Use_Duplication_List_L := "Sales Cr.Memo Line"."Use Duplication List";
                    Responsibility_Center_L := "Sales Cr.Memo Line"."Responsibility Center";

                    /*ItemRef.Reset();
                    ItemRef.SetRange("Item No.", "Sales Cr.Memo Line"."No.");
                    if ItemRef.Find('-') then begin
                        Cross_Reference_No_L := ItemRef."Reference No.";
                        Unit_of_Measure_Cross_Ref_L := ItemRef."Unit of Measure";
                        Cross_Reference_Type_L := ItemRef."Reference Type";
                        Cross_Reference_Type_No_L := ItemRef."Reference Type No.";
                    end else */
                    begin
                        Cross_Reference_No_L := "Sales Cr.Memo Line"."Item Reference No.";
                        Unit_of_Measure_Cross_Ref_L := "Sales Cr.Memo Line"."Item Reference Unit of Measure";
                        Cross_Reference_Type_L := "Sales Cr.Memo Line"."Item Reference Type";
                        Cross_Reference_Type_No_L := "Sales Cr.Memo Line"."Item Reference Type No.";
                    end;

                    Item_Category_Code_L := "Sales Cr.Memo Line"."Item Category Code";
                    Nonstock_L := "Sales Cr.Memo Line".Nonstock;
                    Purchasing_Code_L := "Sales Cr.Memo Line"."Purchasing Code";

                    //ItemCat.Reset();
                    //if ItemCat.Get("Sales Cr.Memo Line"."Item Category Code") then
                    //    Product_Group_Code_L := ItemCat."Parent Category";
                    Item.Reset();
                    if Item.Get("Sales Cr.Memo Line"."No.") then
                        Product_Group_Code_L := Item."Product Group";
                    //Product_Group_Code_L := "Sales Cr.Memo Line"."Product Group Code";

                    Appl_from_Item_Entry_L := "Sales Cr.Memo Line"."Appl.-from Item Entry";
                    Service_Contract_No_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Service Contract No.";
                    Service_Order_No_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Service Order No.";
                    Service_Item_No_L := '';//Leon Comment Out==Sales Invoice Line"."Service Item No.";
                    Appl_to_Service_Entry_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Service Item Line No.";
                    Service_Item_Line_No_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Service Item Line No.";
                    Serv_Price_Adjmt_Gr_Code_L := '';//Leon Comment Out=="Sales Cr.Memo Line"."Serv. Price Adjmt. Gr. Code";
                    Return_Reason_Code_L := "Sales Cr.Memo Line"."Return Reason Code";
                    Allow_Line_Disc_L := "Sales Cr.Memo Line"."Allow Line Disc.";
                    Customer_Disc_Group_L := "Sales Cr.Memo Line"."Customer Disc. Group";
                    QSS_System_Code_L := "Sales Cr.Memo Line"."QSS System Code";
                    Set_Quantity_L := -"Sales Cr.Memo Line"."Set Quantity";
                    Return_Receipt_No_L := '';
                    Return_Receipt_Line_No_L := '';
                    EZiS_Customer_No := Customer."EZiS Customer No.";

                    SalesCrMmHdr.CALCFIELDS(SalesCrMmHdr.Amount, SalesCrMmHdr."Amount Including VAT");
                    AmtBeforeDiscFC := -"Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price";
                    LineDiscAmtFC := -"Sales Cr.Memo Line"."Line Discount Amount";
                    InvDiscAmtFC := -"Sales Cr.Memo Line"."Inv. Discount Amount";
                    AmtAfterDiscFC := -"Sales Cr.Memo Line".Amount;
                    IF SalesCrMmHdr."Currency Factor" = 0 THEN BEGIN
                        AmtBeforeDiscLCY := AmtBeforeDiscFC;
                        LineDiscAmtLCY := LineDiscAmtFC;
                        InvDiscAmtLCY := InvDiscAmtFC;
                        AmtAfterDiscLCY := AmtAfterDiscFC;
                    END ELSE BEGIN
                        AmtBeforeDiscLCY := -ROUND(AmtBeforeDiscFC / SalesCrMmHdr."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        LineDiscAmtLCY := -ROUND(LineDiscAmtFC / SalesCrMmHdr."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        InvDiscAmtLCY := -ROUND(InvDiscAmtFC / SalesCrMmHdr."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                        AmtAfterDiscLCY := -ROUND(AmtAfterDiscFC / SalesCrMmHdr."Currency Factor", GeneralLedgerSetup."Amount Rounding Precision");
                    END;
                    IF "Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::Item THEN
                        CrMmQty := -"Sales Cr.Memo Line".Quantity
                    ELSE
                        CrMmQty := "Sales Cr.Memo Line".Quantity;

                    /*
                    IF Customer.GET("Sales Cr.Memo Line"."Sell-to Customer No.") THEN BEGIN
                        IF NOT Country.GET(Customer."Country/Region Code") THEN
                            Country.INIT;
                    END ELSE BEGIN
                        Customer.INIT;
                        Country.INIT;
                    END;

                    IF "Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::Item THEN BEGIN
                        Resource.INIT;
                        IF NOT Item.GET("Sales Cr.Memo Line"."No.") THEN
                            Item.INIT;
                    END ELSE BEGIN
                        Item.INIT;
                        IF "Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::Resource THEN BEGIN
                            IF NOT Resource.GET("Sales Cr.Memo Line"."No.") THEN
                                Resource.INIT;
                        END ELSE
                            Resource.INIT;
                    END;
                    */

                    CurrCreLoop += 1;
                    if "Sales Cr.Memo Line".Next() = 0 then CurrCreLoop := CreCount + 1;
                end
                else //else for : if CreReady and (CurrCreLoop <= CreCount); means finish all of the Invoice and Credit loop
                    if CurrCreLoop > CreCount then CurrReport.Break();//Exit Report After All done.
                #endregion Sales Credit Memo Lines


            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(FromPostingDate; FromPostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From Posting Date';
                    }
                    field(ToPostingDate; ToPostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To Posting Date';
                    }
                }

                group(Currency)
                {
                    field(FromCurrencyCode; FromCurrencyCode)
                    {
                        ApplicationArea = All;
                        Caption = 'From Currency Code';
                        TableRelation = Currency.Code;
                    }
                    field(ToCurrencyCode; ToCurrencyCode)
                    {
                        ApplicationArea = All;
                        Caption = 'To Currency Code';
                        TableRelation = Currency.Code;
                    }
                }
                group(Country)
                {
                    field(FromCountryCode; FromCountryCode)
                    {
                        ApplicationArea = All;
                        Caption = 'From Country Code';
                        TableRelation = "Country/Region".Code;
                    }
                    field(ToCountryCode; ToCountryCode)
                    {
                        ApplicationArea = All;
                        Caption = 'To Country Code';
                        TableRelation = "Country/Region".Code;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    rendering
    {
        layout(LayoutExcel)
        {
            Type = Excel;
            LayoutFile = 'Sales (EUC).xlsx';
        }
    }

    var
        InvOrCre: Code[1];

        SalesInvHdr: Record "Sales Invoice Header";
        "Sales Invoice Line": Record "Sales Invoice Line";
        Filler: Text[1];
        SalesCrMmHdr: Record "Sales Cr.Memo Header";
        "Sales Cr.Memo Line": Record "Sales Cr.Memo Line";
        ServiceInvHeader: Record "Service Invoice Header";
        ServiceInvLine: Record "Service Invoice Line";
        ServiceCreHeader: Record "Service Cr.Memo Header";
        ServiceCreLine: Record "Service Cr.Memo Line";
        AmtBeforeDiscLCY: Decimal;
        LineDiscAmtLCY: Decimal;
        InvDiscAmtLCY: Decimal;
        AmtAfterDiscLCY: Decimal;
        AmtBeforeDiscFC: Decimal;
        LineDiscAmtFC: Decimal;
        InvDiscAmtFC: Decimal;
        AmtAfterDiscFC: Decimal;
        GeneralLedgerSetup: Record "General Ledger Setup";
        CrMmQty: Decimal;
        FromPostingDate: Date;
        ToPostingDate: Date;
        FromCurrencyCode: Code[10];
        ToCurrencyCode: Code[10];
        FromCountryCode: Code[10];
        ToCountryCode: Code[10];
        Customer: Record Customer;
        txtFileName: Text[250];
        Item: Record Item;
        Resource: Record Resource;
        Country: Record "Country/Region";
        //DelCRLF: Codeunit 50020;
        #region Variables for columns
        Invoice_or_Credit_Memo: Text;
        Sell_to_Customer_No_H: Text;
        No_H: Text;
        Bill_to_Customer_No_H: Text;
        Bill_to_Name_H: Text;
        Your_Reference_H: Text;
        Ship_to_Code_H: Text;
        Ship_to_Name_H: Text;
        Order_Date_H: Date;
        Posting_Date_H: Date;
        Shipment_Date_H: Date;
        Posting_Description_H: Text;
        Payment_Terms_Code_H: Text;
        Due_Date_H: Date;
        Payment_Discount__H: Decimal;
        Pmt_Discount_Date_H: Date;
        Shipment_Method_Code_H: Text;
        Location_Code_H: Text;
        Shortcut_Dimension_1_Code_H: Text;
        Shortcut_Dimension_2_Code_H: Text;
        Customer_Posting_Group_H: Text;
        Currency_Code_H: Text;
        Currency_Factor_H: Decimal;
        Customer_Price_Group_H: Text;
        Prices_Including_VAT_H: Boolean;
        Invoice_Disc_Code_H: Text;
        Customer_Disc_Group_H: Text;
        Language_Code_H: Text;
        Salesperson_Code_H: Text;
        Order_No_H: Text;
        Comment_H: Boolean;
        No_Printed_H: Integer;
        On_Hold_H: Text;
        Applies_to_Doc_Type_H: Enum "Gen. Journal Document Type";
        Applies_to_Doc_No_H: Text;
        Bal_Account_No_H: Text;
        Job_No_H: Text;
        Amount_H: Decimal;
        Amount_Including_VAT_H: Decimal;
        VAT_Registration_No_H: Text;
        Reason_Code_H: Text;
        Gen_Bus_Posting_Group_H: Text;
        EU_3_Party_Trade_H: Boolean;
        Transaction_Type_H: Text;
        Transport_Method_H: Text;
        VAT_Country_Code_H: Text;
        Sell_to_Customer_Name_H: Text;
        Bill_to_Post_Code_H: Text;
        Bill_to_County_H: Text;
        Bill_to_Country_Code_H: Text;
        Sell_to_Post_Code_H: Text;
        Sell_to_County_H: Text;
        Sell_to_Country_Code_H: Text;
        Ship_to_Post_Code_H: Text;
        Ship_to_County_H: Text;
        Ship_to_Country_Code_H: Text;
        Bal_Account_Type_H: Enum "Payment Balance Account Type";
        Exit_Point_H: Text;
        Correction_H: Boolean;
        Document_Date_H: Date;
        External_Document_No_H: Text;
        Area_H: Text;
        Transaction_Specification_H: Text;
        Payment_Method_Code_H: Text;
        Shipping_Agent_Code_H: Text;
        Package_Tracking_No_H: Text;
        Pre_Assigned_No_Series_H: Text;
        No_Series_H: Text;
        Order_No_Series_H: Text;
        Pre_Assigned_No_H: Text;
        User_ID_H: Text;
        Source_Code_H: Text;
        Tax_Area_Code_H: Text;
        Tax_Liable_H: Boolean;
        VAT_Bus_Posting_Group_H: Text;
        VAT_Base_Discount__H: Decimal;
        Campaign_No_H: Text;
        Sell_to_Contact_No_H: Text;
        Bill_to_Contact_No_H: Text;
        Responsibility_Center_H: Text;
        Service_Mgt_Document_H: Boolean;
        Return_Order_No_H: Text;
        Return_Order_No_Series_H: Text;
        Allow_Line_Disc_H: Boolean;
        Get_Shipment_Used_H: Boolean;
        Date_Sent_H: Date;
        Time_Sent_H: Time;
        BizTalk_Sales_Invoice_H: Boolean;
        Customer_Order_No_H: Text;
        BizTalk_Document_Sent_H: Boolean;
        Sell_to_Customer_No_L: Text;
        Customer_Name_L: Text;
        Country_Code_L: Text;
        Country_Name_L: Text;
        Document_No_L: Text;
        Line_No_L: Integer;
        Type_L: Enum "Sales Line Type";
        No_L: Text;
        Product_Type_L: Text;
        Model_Type_L: Option " ",QSS,"dDP (dDP)","MYTIS (Other)";
        Used_Item_L: Boolean;
        Resource_Group_No_L: Text;
        Location_Code_L: Text;
        Posting_Group_L: Text;
        Shipment_Date_L: Date;
        Description_L: Text;
        Description_2_L: Text;
        Unit_of_Measure_L: Text;
        Quantity_L: Decimal;
        Unit_Price_L: Decimal;
        Unit_Cost_LCY_L: Decimal;
        VAT__L: Decimal;
        Line_Discount__L: Decimal;
        Line_Discount_Amount_L: Decimal;
        Amount_L: Decimal;
        Amount_Including_VAT_L: Decimal;
        Allow_Invoice_Disc_L: Boolean;
        Gross_Weight_L: Decimal;
        Net_Weight_L: Decimal;
        Units_per_Parcel_L: Decimal;
        Unit_Volume_L: Decimal;
        Appl_to_Item_Entry_L: Integer;
        Shortcut_Dimension_1_Code_L: Text;
        Shortcut_Dimension_2_Code_L: Text;
        Customer_Price_Group_L: Text;
        Job_No_L: Text;
        Appl_to_Job_Entry_L: Text;
        Phase_Code_L: Text;
        Task_Code_L: Text;
        Step_Code_L: Text;
        Job_Applies_to_ID_L: Text;
        Apply_and_Close_Job_L: Text;
        Work_Type_Code_L: Text;
        Shipment_No_L: Text;
        Shipment_Line_No_L: Integer;
        Bill_to_Customer_No_L: Text;
        Inv_Discount_Amount_L: Decimal;
        Drop_Shipment_L: Boolean;
        Gen_Bus_Posting_Group_L: Text;
        Gen_Prod_Posting_Group_L: Text;
        VAT_Calculation_Type_L: Enum "Tax Calculation Type";
        Transaction_Type_L: Text;
        Transport_Method_L: Text;
        Attached_to_Line_No_L: Integer;
        Exit_Point_L: Text;
        Area_L: Text;
        Transaction_Specification_L: Text;
        Tax_Area_Code_L: Text;
        Tax_Liable_L: Boolean;
        Tax_Group_Code_L: Text;
        VAT_Bus_Posting_Group_L: Text;
        VAT_Prod_Posting_Group_L: Text;
        Blanket_Order_No_L: Text;
        Blanket_Order_Line_No_L: Integer;
        VAT_Base_Amount_L: Decimal;
        Unit_Cost_L: Decimal;
        System_Created_Entry_L: Boolean;
        Line_Amount_L: Decimal;
        VAT_Difference_L: Decimal;
        VAT_Identifier_L: Text;
        IC_Partner_Ref_Type_L: Enum "IC Partner Reference Type";
        IC_Partner_Reference_L: Text;
        Variant_Code_L: Text;
        Bin_Code_L: Text;
        Qty_per_Unit_of_Measure_L: Decimal;
        Unit_of_Measure_Code_L: Text;
        Quantity_Base_L: Decimal;
        FA_Posting_Date_L: Date;
        Depreciation_Book_Code_L: Text;
        Depr_until_FA_Posting_Date_L: Boolean;
        Duplicate_in_Depreciation_Book_L: Text;
        Use_Duplication_List_L: Boolean;
        Responsibility_Center_L: Text;
        Cross_Reference_No_L: Text;
        Unit_of_Measure_Cross_Ref_L: Text;
        //Cross_Reference_Type_L: Option " ",Customer,Vendor,"Bar Code";
        Cross_Reference_Type_L: Enum "Item Reference Type";
        Cross_Reference_Type_No_L: Text;
        Item_Category_Code_L: Text;
        Nonstock_L: Boolean;
        Purchasing_Code_L: Text;
        Product_Group_Code_L: Text;
        Appl_from_Item_Entry_L: Integer;
        Service_Contract_No_L: Text;
        Service_Order_No_L: Text;
        Service_Item_No_L: Text;
        Appl_to_Service_Entry_L: Text;
        Service_Item_Line_No_L: Text;
        Serv_Price_Adjmt_Gr_Code_L: Text;
        Return_Reason_Code_L: Text;
        Allow_Line_Disc_L: Boolean;
        Customer_Disc_Group_L: Text;
        QSS_System_Code_L: Text;
        Set_Quantity_L: Decimal;
        Return_Receipt_No_L: Text;
        Return_Receipt_Line_No_L: Text;
        Amount_Before_Discount_LCY_L: Text;
        Line_Discount_Amount_LCY_L: Text;
        Invoice_Discount_Amount_LCY_L: Text;
        Amount_After_Discount_LCY_L: Text;
        Amount_Before_Discount_FC_L: Text;
        Line_Discount_Amount_FC_L: Text;
        Invoice_Discount_Amount_FC_L: Text;
        Amount_After_Discount_FC_L: Text;
        EZiS_Customer_No: Text;
        #endregion Variables for columns
        NoOfLoops: Integer;
        InvCount: Integer;
        SvcInvCount: Integer;
        SvcCreCount: Integer;
        CreCount: Integer;
        CurrInvLoop: Integer;
        CurrCreLoop: Integer;
        CurrSvcInvLoop: Integer;
        CurrSvcCreLoop: Integer;
        InvDone: Boolean;
        CreReady: Boolean;
        SvcInvDone: Boolean;
        SvcCreDone: Boolean;
        SvcInvReady: Boolean;
        SvcCreReady: Boolean;


    procedure ClearHeaderVar()
    begin
        Clear(Invoice_or_Credit_Memo);
        Clear(Sell_to_Customer_No_H);
        Clear(No_H);
        Clear(Bill_to_Customer_No_H);
        Clear(Bill_to_Name_H);
        Clear(Your_Reference_H);
        Clear(Ship_to_Code_H);
        Clear(Ship_to_Name_H);
        Clear(Order_Date_H);
        Clear(Posting_Date_H);
        Clear(Shipment_Date_H);
        Clear(Posting_Description_H);
        Clear(Payment_Terms_Code_H);
        Clear(Due_Date_H);
        Clear(Payment_Discount__H);
        Clear(Pmt_Discount_Date_H);
        Clear(Shipment_Method_Code_H);
        Clear(Location_Code_H);
        Clear(Shortcut_Dimension_1_Code_H);
        Clear(Shortcut_Dimension_2_Code_H);
        Clear(Customer_Posting_Group_H);
        Clear(Currency_Code_H);
        Clear(Currency_Factor_H);
        Clear(Customer_Price_Group_H);
        Clear(Prices_Including_VAT_H);
        Clear(Invoice_Disc_Code_H);
        Clear(Customer_Disc_Group_H);
        Clear(Language_Code_H);
        Clear(Salesperson_Code_H);
        Clear(Order_No_H);
        Clear(Comment_H);
        Clear(No_Printed_H);
        Clear(On_Hold_H);
        Clear(Applies_to_Doc_Type_H);
        Clear(Applies_to_Doc_No_H);
        Clear(Bal_Account_No_H);
        Clear(Job_No_H);
        Clear(Amount_H);
        Clear(Amount_Including_VAT_H);
        Clear(VAT_Registration_No_H);
        Clear(Reason_Code_H);
        Clear(Gen_Bus_Posting_Group_H);
        Clear(EU_3_Party_Trade_H);
        Clear(Transaction_Type_H);
        Clear(Transport_Method_H);
        Clear(VAT_Country_Code_H);
        Clear(Sell_to_Customer_Name_H);
        Clear(Bill_to_Post_Code_H);
        Clear(Bill_to_County_H);
        Clear(Bill_to_Country_Code_H);
        Clear(Sell_to_Post_Code_H);
        Clear(Sell_to_County_H);
        Clear(Sell_to_Country_Code_H);
        Clear(Ship_to_Post_Code_H);
        Clear(Ship_to_County_H);
        Clear(Ship_to_Country_Code_H);
        Clear(Bal_Account_Type_H);
        Clear(Exit_Point_H);
        Clear(Correction_H);
        Clear(Document_Date_H);
        Clear(External_Document_No_H);
        Clear(Area_H);
        Clear(Transaction_Specification_H);
        Clear(Payment_Method_Code_H);
        Clear(Shipping_Agent_Code_H);
        Clear(Package_Tracking_No_H);
        Clear(Pre_Assigned_No_Series_H);
        Clear(No_Series_H);
        Clear(Order_No_Series_H);
        Clear(Pre_Assigned_No_H);
        Clear(User_ID_H);
        Clear(Source_Code_H);
        Clear(Tax_Area_Code_H);
        Clear(Tax_Liable_H);
        Clear(VAT_Bus_Posting_Group_H);
        Clear(VAT_Base_Discount__H);
        Clear(Campaign_No_H);
        Clear(Sell_to_Contact_No_H);
        Clear(Bill_to_Contact_No_H);
        Clear(Responsibility_Center_H);
        Clear(Service_Mgt_Document_H);
        Clear(Return_Order_No_H);
        Clear(Return_Order_No_Series_H);
        Clear(Allow_Line_Disc_H);
        Clear(Get_Shipment_Used_H);
        Clear(Date_Sent_H);
        Clear(Time_Sent_H);
        Clear(BizTalk_Sales_Invoice_H);
        Clear(Customer_Order_No_H);
        Clear(BizTalk_Document_Sent_H);
    end;

    procedure ClearLineVar()
    begin
        Clear(Sell_to_Customer_No_L);
        Clear(Customer_Name_L);
        Clear(Country_Code_L);
        Clear(Country_Name_L);
        Clear(Document_No_L);
        Clear(Line_No_L);
        Clear(Type_L);
        Clear(No_L);
        Clear(Product_Type_L);
        Clear(Model_Type_L);
        Clear(Used_Item_L);
        Clear(Resource_Group_No_L);
        Clear(Location_Code_L);
        Clear(Posting_Group_L);
        Clear(Shipment_Date_L);
        Clear(Description_L);
        Clear(Description_2_L);
        Clear(Unit_of_Measure_L);
        Clear(Quantity_L);
        Clear(Unit_Price_L);
        Clear(Unit_Cost_LCY_L);
        Clear(VAT__L);
        Clear(Line_Discount__L);
        Clear(Line_Discount_Amount_L);
        Clear(Amount_L);
        Clear(Amount_Including_VAT_L);
        Clear(Allow_Invoice_Disc_L);
        Clear(Gross_Weight_L);
        Clear(Net_Weight_L);
        Clear(Units_per_Parcel_L);
        Clear(Unit_Volume_L);
        Clear(Appl_to_Item_Entry_L);
        Clear(Shortcut_Dimension_1_Code_L);
        Clear(Shortcut_Dimension_2_Code_L);
        Clear(Customer_Price_Group_L);
        Clear(Job_No_L);
        Clear(Appl_to_Job_Entry_L);
        Clear(Phase_Code_L);
        Clear(Task_Code_L);
        Clear(Step_Code_L);
        Clear(Job_Applies_to_ID_L);
        Clear(Apply_and_Close_Job_L);
        Clear(Work_Type_Code_L);
        Clear(Shipment_No_L);
        Clear(Shipment_Line_No_L);
        Clear(Bill_to_Customer_No_L);
        Clear(Inv_Discount_Amount_L);
        Clear(Drop_Shipment_L);
        Clear(Gen_Bus_Posting_Group_L);
        Clear(Gen_Prod_Posting_Group_L);
        Clear(VAT_Calculation_Type_L);
        Clear(Transaction_Type_L);
        Clear(Transport_Method_L);
        Clear(Attached_to_Line_No_L);
        Clear(Exit_Point_L);
        Clear(Area_L);
        Clear(Transaction_Specification_L);
        Clear(Tax_Area_Code_L);
        Clear(Tax_Liable_L);
        Clear(Tax_Group_Code_L);
        Clear(VAT_Bus_Posting_Group_L);
        Clear(VAT_Prod_Posting_Group_L);
        Clear(Blanket_Order_No_L);
        Clear(Blanket_Order_Line_No_L);
        Clear(VAT_Base_Amount_L);
        Clear(Unit_Cost_L);
        Clear(System_Created_Entry_L);
        Clear(Line_Amount_L);
        Clear(VAT_Difference_L);
        Clear(VAT_Identifier_L);
        Clear(IC_Partner_Ref_Type_L);
        Clear(IC_Partner_Reference_L);
        Clear(Variant_Code_L);
        Clear(Bin_Code_L);
        Clear(Qty_per_Unit_of_Measure_L);
        Clear(Unit_of_Measure_Code_L);
        Clear(Quantity_Base_L);
        Clear(FA_Posting_Date_L);
        Clear(Depreciation_Book_Code_L);
        Clear(Depr_until_FA_Posting_Date_L);
        Clear(Duplicate_in_Depreciation_Book_L);
        Clear(Use_Duplication_List_L);
        Clear(Responsibility_Center_L);
        Clear(Cross_Reference_No_L);
        Clear(Unit_of_Measure_Cross_Ref_L);
        Clear(Cross_Reference_Type_L);
        Clear(Cross_Reference_Type_No_L);
        Clear(Item_Category_Code_L);
        Clear(Nonstock_L);
        Clear(Purchasing_Code_L);
        Clear(Product_Group_Code_L);
        Clear(Appl_from_Item_Entry_L);
        Clear(Service_Contract_No_L);
        Clear(Service_Order_No_L);
        Clear(Service_Item_No_L);
        Clear(Appl_to_Service_Entry_L);
        Clear(Service_Item_Line_No_L);
        Clear(Serv_Price_Adjmt_Gr_Code_L);
        Clear(Return_Reason_Code_L);
        Clear(Allow_Line_Disc_L);
        Clear(Customer_Disc_Group_L);
        Clear(QSS_System_Code_L);
        Clear(Set_Quantity_L);
        Clear(Return_Receipt_No_L);
        Clear(Return_Receipt_Line_No_L);
        Clear(Amount_Before_Discount_LCY_L);
        Clear(Line_Discount_Amount_LCY_L);
        Clear(Invoice_Discount_Amount_LCY_L);
        Clear(Amount_After_Discount_LCY_L);
        Clear(Amount_Before_Discount_FC_L);
        Clear(Line_Discount_Amount_FC_L);
        Clear(Invoice_Discount_Amount_FC_L);
        Clear(Amount_After_Discount_FC_L);
        Clear(EZiS_Customer_No);
    end;
}
