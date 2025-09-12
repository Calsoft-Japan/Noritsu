report 50002 "Update Corporate Item Master"
{
    Caption = 'Update Corporate Item Master';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Integer; "Integer")
        {
            trigger OnPreDataItem()
            begin
                SetRange(Number, 1);
                CreateLogHeader();
            end;

            trigger OnAfterGetRecord()
            var

                NumberOfBytesRead: Integer;
                TextRead: Text;
            begin
                // If you use read then while written after read will not read anything because already everything in InStream variable is read -- vice versa
                //InStr.Read(TextRead);
                //Message(TextRead);

                // Start: Read Each Line one by one
                while not InStr.EOS() do begin
                    NumberOfBytesRead := InStr.ReadText(TextRead);
                    ProcessLine(TextRead);
                    //Message('%1\Size: %2', TextRead, NumberOfBytesRead);                    
                end;
                // Stop: Read Each Line one by one
            end;

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
                    field(File_Name; FileName)
                    {
                        Caption = 'Choose a file';
                        AssistEdit = true;
                        Editable = false;
                        ApplicationArea = All;

                        trigger OnAssistEdit()
                        begin
                            if not (File.UploadIntoStream('Open File', '', 'All Files (*.txt)|*.txt',
                                         FileName, InStr)) then begin
                                Error(GetLastErrorText());
                            end;
                        end;
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

    trigger OnPostReport()
    begin
        if ExcelBuff.Count > 1 then begin
            ExcelBuff.CreateNewBook('UpdateCorItemMaster_Log');
            ExcelBuff.WriteSheet('CorItemMaster', CompanyName(), UserId());
            ExcelBuff.CloseBook();
            ExcelBuff.OpenExcel();
        end;
    end;

    procedure ProcessLine(inputstr: Text)
    var
        Data_Delimiter: Text;
        Modification_Code: Text;
        DateStr: Text[8];
        Year, Month, Day : integer;
        ItemNo: Code[20];
        PriceGroup: Code[4];
        PricingStructure: Code[1];
        CorporateItemMaster: Record "Corporate Item Master";
        LineError: Boolean;
    begin
        Clear(LineError);
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

            //EVALUATE(CorporateItemMaster."Registration Date", DELCHR(COPYSTR(inputstr, 291, 8), '>'));
            DateStr := DELCHR(COPYSTR(inputstr, 291, 8), '>');
            Evaluate(Year, (COPYSTR(DateStr, 1, 4)));
            Evaluate(Month, (COPYSTR(DateStr, 5, 2)));
            Evaluate(Day, (COPYSTR(DateStr, 7, 2)));
            CorporateItemMaster."Registration Date" := DMY2Date(Day, Month, Year);

            //EVALUATE(CorporateItemMaster."Revision Date", DELCHR(COPYSTR(inputstr, 299, 8), '>'));
            DateStr := DELCHR(COPYSTR(inputstr, 299, 8), '>');
            Evaluate(Year, (COPYSTR(DateStr, 1, 4)));
            Evaluate(Month, (COPYSTR(DateStr, 5, 2)));
            Evaluate(Day, (COPYSTR(DateStr, 7, 2)));
            CorporateItemMaster."Revision Date" := DMY2Date(Day, Month, Year);

            if not CorporateItemMaster.Insert(true) then
                if not CorporateItemMaster.Modify(true) then begin
                    Write_Log(CorporateItemMaster, 'E', GetLastErrorText(), Data_Delimiter, Modification_Code);
                    LineError := true;
                end;
        end ELSE
            IF UPPERCASE(Modification_Code) = 'D' THEN BEGIN
                IF CorporateItemMaster.GET(ItemNo, PriceGroup, PricingStructure) THEN begin
                    if not CorporateItemMaster.Delete(true) then begin
                        Write_Log(CorporateItemMaster, 'E', GetLastErrorText(), Data_Delimiter, Modification_Code);
                        LineError := true;
                    end;
                end;
            end
            else begin
                Write_Log(CorporateItemMaster, 'E', 'Record does not exist.', Data_Delimiter, Modification_Code);
                LineError := true;
            end;

        if not LineError then
            Write_Log(CorporateItemMaster, 'S', '', Data_Delimiter, Modification_Code);
    end;

    procedure CreateLogHeader()
    begin
        ExcelBuff.NewRow();
        ExcelBuff.AddColumn('No.', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Status', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Message', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Data Delimiter', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Modification Code', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Item No.', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Latest Item No.', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Price Group', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Pricing Structure', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Description', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Unit Price', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Part Type', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Process Type', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Model Type', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('HS Code', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('HS Sub Code', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Specification', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Material', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Production Type', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Major Group', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Product Group', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Series Group', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Production Name', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Item Category Code', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Product Group Code', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('QA', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Serialized Parts', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('With Serial No.', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Country Code', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Registration Date', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn('Revision Date', false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
    end;

    procedure Write_Log(CorporateItemMaster: Record "Corporate Item Master"; Status: Code[1]; ErrMsg: Text; Data_Delimiter: Text; Modification_Code: Text)
    begin
        ExcelBuff.NewRow();
        ExcelBuff.AddColumn(ExcelBuff."Row No.", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(Status, false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(ErrMsg, false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(Data_Delimiter, false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(Modification_Code, false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Item No.", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Latest Item No.", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Price Group", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Pricing Structure", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Description", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Unit Price", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Part Type", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Process Type", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Model Type", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."HS Code", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."HS Sub Code", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Specification", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Material", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Production Type", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Major Group", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Product Group", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Series Group", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Production Name", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Item Category Code", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Product Group Code", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."QA", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Serialized Parts", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."With Serial No.", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Country Code", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Registration Date", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn(CorporateItemMaster."Revision Date", false, '', false, false, false, '', ExcelBuff."Cell Type"::Text);
    end;

    var
        InStr: InStream;
        FileName: Text;
        ExcelBuff: Record "Excel Buffer" temporary;
}
