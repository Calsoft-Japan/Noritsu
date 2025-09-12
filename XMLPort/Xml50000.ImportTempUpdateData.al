xmlport 50000 "Import Temp Update Data"
{
    Caption = 'Import Temp Update Data';
    Direction = Import;
    TextEncoding = UTF8;
    Format = VariableText;
    //FieldDelimiter = '';
    //FieldSeparator = '<TAB>';

    schema
    {
        textelement(RootNodeName)
        {
            textelement(Lines)
            {
                textattribute(inputstr)
                {
                    trigger OnAfterAssignVariable()
                    var
                        Data_Delimiter: Text;
                        Modification_Code: Text;
                        ItemNo: Code[20];
                        PriceGroup: Code[4];
                        PricingStructure: Code[1];
                        CorporateItemMaster: Record "Corporate Item Master";
                    begin
                        Data_Delimiter := DELCHR(COPYSTR(inputstr, 1, 2), '>');
                        Modification_Code := DELCHR(COPYSTR(inputstr, 3, 1), '>');
                        ItemNo := DELCHR(COPYSTR(inputstr, 4, 20), '>');
                        PriceGroup := DELCHR(COPYSTR(inputstr, 37, 4), '>');
                        PricingStructure := DELCHR(COPYSTR(inputstr, 41, 1), '>');

                        CorporateItemMaster.Reset();

                        IF UPPERCASE(Modification_Code) = 'U' THEN begin
                            IF not CorporateItemMaster.GET(ItemNo, PriceGroup, PricingStructure) THEN begin
                                CorporateItemMaster.Init();
                            end;

                            CorporateItemMaster."Item No." := DELCHR(COPYSTR(inputstr, 4, 20), '>');
                            CorporateItemMaster."Latest Item No." := DELCHR(COPYSTR(inputstr, 24, 13), '>');//"Latest Model No."
                            CorporateItemMaster."Price Group" := DELCHR(COPYSTR(inputstr, 37, 4), '>');
                            CorporateItemMaster."Pricing Structure" := DELCHR(COPYSTR(inputstr, 41, 1), '>');
                            CorporateItemMaster.Description := DELCHR(COPYSTR(inputstr, 42, 40), '>');
                            EVALUATE(CorporateItemMaster."Unit Price", DELCHR(COPYSTR(inputstr, 82, 14), '>'));
                            EVALUATE(CorporateItemMaster."Part Type", COPYSTR(inputstr, 96, 1));
                            EVALUATE(CorporateItemMaster."Process Type", COPYSTR(inputstr, 97, 1));
                            EVALUATE(CorporateItemMaster."Model Type", COPYSTR(inputstr, 98, 1));
                            CorporateItemMaster."HS Code" := DELCHR(COPYSTR(inputstr, 99, 7), '>');
                            CorporateItemMaster."HS Sub Code" := DELCHR(COPYSTR(inputstr, 106, 3), '>');
                            CorporateItemMaster.Specification := DELCHR(COPYSTR(inputstr, 109, 60), '>');
                            CorporateItemMaster.Material := DELCHR(COPYSTR(inputstr, 169, 40), '>');
                            EVALUATE(CorporateItemMaster."Production Type", COPYSTR(inputstr, 209, 1));
                            CorporateItemMaster."Major Group" := DELCHR(COPYSTR(inputstr, 210, 1), '>');
                            CorporateItemMaster."Product Group" := DELCHR(COPYSTR(inputstr, 211, 2), '>');
                            CorporateItemMaster."Series Group" := DELCHR(COPYSTR(inputstr, 213, 8), '>');
                            CorporateItemMaster."Production Name" := DELCHR(COPYSTR(inputstr, 221, 40), '>');
                            CorporateItemMaster."Item Category Code" := DELCHR(COPYSTR(inputstr, 261, 10), '>');
                            CorporateItemMaster."Product Group Code" := DELCHR(COPYSTR(inputstr, 271, 10), '>');
                            EVALUATE(CorporateItemMaster.QA, DELCHR(COPYSTR(inputstr, 281, 1), '>'));
                            EVALUATE(CorporateItemMaster."Serialized Parts", DELCHR(COPYSTR(inputstr, 282, 1), '>'));
                            EVALUATE(CorporateItemMaster."With Serial No.", DELCHR(COPYSTR(inputstr, 283, 1), '>'));
                            EVALUATE(CorporateItemMaster."Country Code", DELCHR(COPYSTR(inputstr, 284, 7), '>'));
                            EVALUATE(CorporateItemMaster."Registration Date", DELCHR(COPYSTR(inputstr, 291, 8), '>'));
                            EVALUATE(CorporateItemMaster."Revision Date", DELCHR(COPYSTR(inputstr, 299, 8), '>'));

                            if not CorporateItemMaster.Insert(true) then
                                CorporateItemMaster.Modify(true);
                        end ELSE
                            IF UPPERCASE(Modification_Code) = 'D' THEN BEGIN
                                IF CorporateItemMaster.GET(ItemNo, PriceGroup, PricingStructure) THEN begin
                                    CorporateItemMaster.Delete(true);
                                end;
                            end;
                    end;
                }
            }
            /*
            tableelement(CorporateItemMaster; "Corporate Item Master")
            {
                fieldattribute(CountryCode; CorporateItemMaster."Country Code")
                {
                }
                fieldattribute(Description; CorporateItemMaster.Description)
                {
                }
                fieldattribute(HSCode; CorporateItemMaster."HS Code")
                {
                }
                fieldattribute(HSSubCode; CorporateItemMaster."HS Sub Code")
                {
                }
                fieldattribute(ItemCategoryCode; CorporateItemMaster."Item Category Code")
                {
                }
                fieldattribute(ItemNo; CorporateItemMaster."Item No.")
                {
                }
                fieldattribute(LatestItemNo; CorporateItemMaster."Latest Item No.")
                {
                }
                fieldattribute(MajorGroup; CorporateItemMaster."Major Group")
                {
                }
                fieldattribute(Material; CorporateItemMaster.Material)
                {
                }
                fieldattribute(ModelType; CorporateItemMaster."Model Type")
                {
                }
                fieldattribute(PartType; CorporateItemMaster."Part Type")
                {
                }
                fieldattribute(PriceGroup; CorporateItemMaster."Price Group")
                {
                }
                fieldattribute(PricingStructure; CorporateItemMaster."Pricing Structure")
                {
                }
                fieldattribute(ProcessType; CorporateItemMaster."Process Type")
                {
                }
                fieldattribute(ProductGroup; CorporateItemMaster."Product Group")
                {
                }
                fieldattribute(ProductGroupCode; CorporateItemMaster."Product Group Code")
                {
                }
                fieldattribute(ProductionName; CorporateItemMaster."Production Name")
                {
                }
                fieldattribute(ProductionType; CorporateItemMaster."Production Type")
                {
                }
                fieldattribute(QA; CorporateItemMaster.QA)
                {
                }
                fieldattribute(RegistrationDate; CorporateItemMaster."Registration Date")
                {
                }
                fieldattribute(RevisionDate; CorporateItemMaster."Revision Date")
                {
                }
                fieldattribute(SerializedParts; CorporateItemMaster."Serialized Parts")
                {
                }
                fieldattribute(SeriesGroup; CorporateItemMaster."Series Group")
                {
                }
                fieldattribute(Specification; CorporateItemMaster.Specification)
                {
                }
                fieldattribute(SystemCreatedAt; CorporateItemMaster.SystemCreatedAt)
                {
                }
                fieldattribute(SystemCreatedBy; CorporateItemMaster.SystemCreatedBy)
                {
                }
                fieldattribute(SystemId; CorporateItemMaster.SystemId)
                {
                }
                fieldattribute(SystemModifiedAt; CorporateItemMaster.SystemModifiedAt)
                {
                }
                fieldattribute(SystemModifiedBy; CorporateItemMaster.SystemModifiedBy)
                {
                }
                fieldattribute(UnitPrice; CorporateItemMaster."Unit Price")
                {
                }
                fieldattribute(WithSerialNo; CorporateItemMaster."With Serial No.")
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                end;
            }
            */
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
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
}
