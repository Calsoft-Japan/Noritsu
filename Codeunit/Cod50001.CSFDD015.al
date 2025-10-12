codeunit 50001 CSFDD015
{


    [EventSubscriber(ObjectType::Table, Database::"Service Contract Header", 'OnIsInvoicePeriodInTimeSegment', '', true, true)]
    local procedure "Service Contract Header_OnIsInvoicePeriodInTimeSegment"
    (
        ServiceContractHeader: Record "Service Contract Header";
        var InvoicePeriodInTimeSegment: Boolean
    )
    begin
        InvoicePeriodInTimeSegment :=
                    ServiceContractHeader."Invoice Period" in [ServiceContractHeader."Invoice Period"::Month, ServiceContractHeader."Invoice Period"::"Two Months", ServiceContractHeader."Invoice Period"::Quarter, ServiceContractHeader."Invoice Period"::"Half Year", ServiceContractHeader."Invoice Period"::Year, ServiceContractHeader."Invoice Period"::"Eighteen Months", ServiceContractHeader."Invoice Period"::"Two Years", ServiceContractHeader."Invoice Period"::"Three Years"];
    end;



    [EventSubscriber(ObjectType::Table, Database::"Service Contract Header", 'OnAfterReturnNoOfPer', '', true, true)]
    local procedure "Service Contract Header_OnAfterReturnNoOfPer"
    (
        InvoicePeriod: Enum "Service Contract Header Invoice Period";
        var RetPer: Integer
    )
    begin
        case InvoicePeriod of
            InvoicePeriod::Month:
                RetPer := 12;
            InvoicePeriod::"Two Months":
                RetPer := 6;
            InvoicePeriod::Quarter:
                RetPer := 4;
            InvoicePeriod::"Half Year":
                RetPer := 2;
            InvoicePeriod::Year:
                RetPer := 1;
            // PBC MOD. BEGIN additional contract periods for 18months, 2years and 3years
            InvoicePeriod::"Eighteen Months":
                RetPer := 18;
            InvoicePeriod::"Two Years":
                RetPer := 24;
            InvoicePeriod::"Three Years":
                RetPer := 36;
            // PBC MOD. END additional contract periods for 18months, 2years and 3years
            else
                RetPer := 0;
        end;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Service Contract Header", 'OnBeforeCalculateEndPeriodDate', '', true, true)]
    local procedure "Service Contract Header_OnBeforeCalculateEndPeriodDate"
    (
        var ServiceContractHeader: Record "Service Contract Header";
        PrepaidContract: Boolean;
        NextInvDate: Date;
        var Result: Date;
        var IsHandled: Boolean
    )
    var
        TempDate2: Date;
    begin
        if PrepaidContract then begin
            case ServiceContractHeader."Invoice Period" of
                ServiceContractHeader."Invoice Period"::Month:
                    TempDate2 := CalcDate('<1M-1D>', NextInvDate);
                ServiceContractHeader."Invoice Period"::"Two Months":
                    TempDate2 := CalcDate('<2M-1D>', NextInvDate);
                ServiceContractHeader."Invoice Period"::Quarter:
                    TempDate2 := CalcDate('<3M-1D>', NextInvDate);
                ServiceContractHeader."Invoice Period"::"Half Year":
                    TempDate2 := CalcDate('<6M-1D>', NextInvDate);
                ServiceContractHeader."Invoice Period"::Year:
                    TempDate2 := CalcDate('<12M-1D>', NextInvDate);
                // PBC MOD. BEGIN additional contract periods for 18months, 2years and 3years
                ServiceContractHeader."Invoice Period"::"Eighteen Months":
                    TempDate2 := CALCDATE('<18M-1D>', NextInvDate);
                ServiceContractHeader."Invoice Period"::"Two Years":
                    TempDate2 := CALCDATE('<24M-1D>', NextInvDate);
                ServiceContractHeader."Invoice Period"::"Three Years":
                    TempDate2 := CALCDATE('<36M-1D>', NextInvDate);
                // PBC MOD. END additional contract periods for 18months, 2years and 3years
                ServiceContractHeader."Invoice Period"::None:
                    TempDate2 := 0D;
                else
                    ;
            end;
            Result := TempDate2;
            IsHandled := true;
            exit;
        end;
        case ServiceContractHeader."Invoice Period" of
            ServiceContractHeader."Invoice Period"::Month:
                TempDate2 := CalcDate('<-CM>', NextInvDate);
            ServiceContractHeader."Invoice Period"::"Two Months":
                TempDate2 := CalcDate('<-CM-1M>', NextInvDate);
            ServiceContractHeader."Invoice Period"::Quarter:
                TempDate2 := CalcDate('<-CM-2M>', NextInvDate);
            ServiceContractHeader."Invoice Period"::"Half Year":
                TempDate2 := CalcDate('<-CM-5M>', NextInvDate);
            ServiceContractHeader."Invoice Period"::Year:
                TempDate2 := CalcDate('<-CM-11M>', NextInvDate);
            // PBC MOD. BEGIN additional contract periods for 18months, 2years and 3years
            ServiceContractHeader."Invoice Period"::"Eighteen Months":
                TempDate2 := CALCDATE('<-CM-17M>', NextInvDate);
            ServiceContractHeader."Invoice Period"::"Two Years":
                TempDate2 := CALCDATE('<-CM-23M>', NextInvDate);
            ServiceContractHeader."Invoice Period"::"Three Years":
                TempDate2 := CALCDATE('<-CM-35M>', NextInvDate);
            // PBC MOD. END additional contract periods for 18months, 2years and 3years
            ServiceContractHeader."Invoice Period"::None:
                TempDate2 := 0D;
            else
                ;
        end;
        Result := TempDate2;
        IsHandled := true;
        exit;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Service Contract Header", 'OnValidateNextInvoiceDateOnBeforeCheck', '', true, true)]
    local procedure "Service Contract Header_OnValidateNextInvoiceDateOnBeforeCheck"
    (
        var ServiceContractHeader: Record "Service Contract Header";
        var IsHandled: Boolean
    )
    begin
        IsHandled := true;
    end;


    //=============================================================================================================================================


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SignServContractDoc", 'OnBeforeCheckServContractNextInvoiceDate', '', true, true)]
    local procedure "SignServContractDoc_OnBeforeCheckServContractNextInvoiceDate"
    (
        ServiceContractHeader: Record "Service Contract Header";
        var IsHandled: Boolean
    )
    var
        ConfirmManagement: Codeunit "Confirm Management";
        Text003: Label '%1 must be the first day of the month.';
        Text005: Label '%1 is not the last day of the month.\\Confirm that this is the correct date.';
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        ServMgtSetup.GET();  //PBC Modification
        IsHandled := true;

        if ServiceContractHeader.IsInvoicePeriodInTimeSegment() then
            //PBC MODIFICATION
            if ServiceContractHeader.Prepaid AND (ServMgtSetup."Prepaid Inv. for Whole Year" = FALSE) then begin
                if CalcDate('<-CM>', ServiceContractHeader."Next Invoice Date") <> ServiceContractHeader."Next Invoice Date"
                    then
                    Error(Text003, ServiceContractHeader.FieldCaption("Next Invoice Date")); //PBC MODIFICATION
            end else
                if CalcDate('<CM>', ServiceContractHeader."Next Invoice Date") <> ServiceContractHeader."Next Invoice Date" then
                    //if not HideDialog then //PBC MODIFICATION
                        if not ConfirmManagement.GetResponseOrDefault(
                             StrSubstNo(Text005, ServiceContractHeader.FieldCaption("Next Invoice Date")), true)
                        then
                        exit;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServContractManagement", 'OnCreateServiceLedgerEntryOnBeforeLoopPeriods', '', true, true)]
    local procedure "ServContractManagement_OnCreateServiceLedgerEntryOnBeforeLoopPeriods"
    (
        ServContractHeader: Record "Service Contract Header";
        ServContractLine: Record "Service Contract Line";
        var InvFrom: Date;
        var WDate: Date;
        var DateExpression: Text
    )
    var
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        ServMgtSetup.GET();  //PBC Modification

        IF ServMgtSetup."Prepaid Inv. for Whole Year" = FALSE THEN //PBC Modification
            WDate := CALCDATE('<-CM>', InvFrom) //PBC Modification
        ELSE  //PBC Modification
            WDate := InvFrom; //PBC Modification
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServContractManagement", 'OnAfterCalcContractLineAmount', '', true, true)]
    local procedure "ServContractManagement_OnAfterCalcContractLineAmount"
    (
        AnnualAmount: Decimal;
        PeriodStarts: Date;
        PeriodEnds: Date;
        var AmountCalculated: Decimal
    )
    VAR
        NoOfMonths: Integer;
        NoOfDays: Integer;
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        //AmountCalculated := AnnualAmount / 12 * NoOfMonthsAndMPartsInPeriod(PeriodStarts, PeriodEnds);
        //OnAfterCalcContractLineAmount(AnnualAmount, PeriodStarts, PeriodEnds, AmountCalculated);

        AmountCalculated := 0;

        ServMgtSetup.GET();  //PBC Modification

        IF ServMgtSetup."Prepaid Inv. for Whole Year" = FALSE THEN BEGIN //PBC Modification
            /*
            NoOfMonthsAndDaysInPeriod(PeriodStarts, PeriodEnds, NoOfMonths, NoOfDays); //PBC Modification
            AmountCalculated :=
              (AnnualAmount / 12 * NoOfMonths) +
              (AnnualAmount / NoOfDayInYear(PeriodStarts) * NoOfDays);
            */

            AmountCalculated := AnnualAmount / 12 * NoOfMonthsAndMPartsInPeriod(PeriodStarts, PeriodEnds);
        END ELSE BEGIN
            NoOfMonthsAndDaysInPeriod2(PeriodStarts, PeriodEnds, NoOfMonths, NoOfDays); //PBC Modification
                                                                                        //  IF NoOfDays >= 365 THEN //PBC Modification
                                                                                        //    AmountCalculated := (AnnualAmount / NoOfDayInYear(PeriodStarts)) * NoOfDays //PBC Modification
                                                                                        //    AmountCalculated := (AnnualAmount / 12) * NoOfMonths //PBC Modification
                                                                                        //  ELSE BEGIN
            AmountCalculated := AnnualAmount / 12 * NoOfMonths; //PBC Modification;
                                                                //  END;
        END;
    end;

    procedure NoOfMonthsAndDaysInPeriod(Day1: Date; Day2: Date; var NoOfMonthsInPeriod: Integer; var NoOfDaysInPeriod: Integer)
    var
        Wdate: Date;
        FirstDayinCrntMonth: Date;
        LastDayinCrntMonth: Date;
    begin
        NoOfMonthsInPeriod := 0;
        NoOfDaysInPeriod := 0;

        if Day1 > Day2 then
            exit;
        if Day1 = 0D then
            exit;
        if Day2 = 0D then
            exit;

        Wdate := Day1;
        repeat
            FirstDayinCrntMonth := CalcDate('<-CM>', Wdate);
            LastDayinCrntMonth := CalcDate('<CM>', Wdate);
            if (Wdate = FirstDayinCrntMonth) and (LastDayinCrntMonth <= Day2) then begin
                NoOfMonthsInPeriod := NoOfMonthsInPeriod + 1;
                Wdate := LastDayinCrntMonth + 1;
            end else begin
                NoOfDaysInPeriod := NoOfDaysInPeriod + 1;
                Wdate := Wdate + 1;
            end;
        until Wdate > Day2;
    end;

    procedure NoOfDayInYear(InputDate: Date): Integer
    var
        W1: Date;
        W2: Date;
        YY: Integer;
    begin
        YY := Date2DMY(InputDate, 3);
        W1 := DMY2Date(1, 1, YY);
        W2 := DMY2Date(31, 12, YY);
        exit(W2 - W1 + 1);
    end;

    procedure NoOfMonthsAndMPartsInPeriod(Day1: Date; Day2: Date) MonthsAndMParts: Decimal
    var
        WDate: Date;
        OldWDate: Date;
    begin
        if Day1 > Day2 then
            exit;
        if (Day1 = 0D) or (Day2 = 0D) then
            exit;
        MonthsAndMParts := 0;

        WDate := CalcDate('<-CM>', Day1);
        repeat
            OldWDate := CalcDate('<CM>', WDate);
            if WDate < Day1 then
                WDate := Day1;
            if OldWDate > Day2 then
                OldWDate := Day2;
            if (WDate <> CalcDate('<-CM>', WDate)) or (OldWDate <> CalcDate('<CM>', OldWDate)) then
                MonthsAndMParts := MonthsAndMParts +
                  (OldWDate - WDate + 1) / (CalcDate('<CM>', OldWDate) - CalcDate('<-CM>', WDate) + 1)
            else
                MonthsAndMParts := MonthsAndMParts + 1;
            WDate := CalcDate('<CM>', OldWDate) + 1;
        //if MonthsAndMParts <> Round(MonthsAndMParts, 1) then
        //CheckMParts := true;
        until WDate > Day2;
    end;

    PROCEDURE NoOfMonthsAndDaysInPeriod2(Day1: Date; Day2: Date; VAR NoOfMonthsInPeriod: Integer; VAR NoOfDaysInPeriod: Integer);
    VAR
        Wdate: Date;
        FirstDayinCrntMonth: Date;
        LastDayinCrntMonth: Date;
    BEGIN
        //PBC Created routine for proper calculation of Contract Amount

        NoOfMonthsInPeriod := 0;
        NoOfDaysInPeriod := 0;

        IF Day1 > Day2 THEN
            EXIT;
        IF Day1 = 0D THEN
            EXIT;
        IF Day2 = 0D THEN
            EXIT;

        NoOfDaysInPeriod := Day2 - Day1 + 1;

        Wdate := Day1;
        IF Day1 <> CALCDATE('<-CM>', Wdate) THEN
            NoOfMonthsInPeriod := 1;

        REPEAT
            FirstDayinCrntMonth := CALCDATE('<-CM>', Wdate);
            LastDayinCrntMonth := CALCDATE('<CM>', Wdate);
            IF (Wdate = FirstDayinCrntMonth) AND (LastDayinCrntMonth <= Day2) THEN BEGIN
                NoOfMonthsInPeriod := NoOfMonthsInPeriod + 1;
                Wdate := LastDayinCrntMonth + 1;
            END ELSE
                Wdate := Wdate + 1;
        UNTIL Wdate > Day2;
    END;


    //procedure ValidateNextInvoicePeriod()


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServContractManagement", 'OnServLedgEntryToServiceLineOnBeforeServLineInsert', '', true, true)]
    local procedure "ServContractManagement_OnServLedgEntryToServiceLineOnBeforeServLineInsert"
    (
        var ServiceLine: Record "Service Line";
        TotalServiceLine: Record "Service Line";
        TotalServiceLineLCY: Record "Service Line";
        ServiceHeader: Record "Service Header";
        ServiceLedgerEntry: Record "Service Ledger Entry";
        ServiceLedgerEntryParm: Record "Service Ledger Entry";
        var IsHandled: Boolean;
        InvFrom: Date;
        InvTo: Date
    )
    var
        InvoicedServContractHeader: Record "Service Contract Header";
        ServMgtSetup: Record "Service Mgt. Setup";
        StdText: Record "Standard Text";
        TempServLineDescription: Text[250];
        Text013: Label '%1 cannot be created because the %2 is too long. Please shorten the %3 %4 %5 by removing %6 character(s).';
    begin
        InvoicedServContractHeader.Reset();
        InvoicedServContractHeader.SetRange("Contract No.", ServiceHeader."Contract No.");
        InvoicedServContractHeader.SetRange("Contract Type", InvoicedServContractHeader."Contract Type"::Contract);
        if InvoicedServContractHeader.Find('-') then begin
            InvFrom := InvoicedServContractHeader."Next Invoice Period Start";
            InvTo := InvoicedServContractHeader."Next Invoice Period End";

            ServMgtSetup.Get();
            if ServMgtSetup."Contract Inv. Period Text Code" <> '' then begin
                StdText.Get(ServMgtSetup."Contract Inv. Period Text Code");
                TempServLineDescription := StrSubstNo('%1 %2 - %3', StdText.Description, Format(InvFrom), Format(InvTo));
                if StrLen(TempServLineDescription) > MaxStrLen(ServiceLine.Description) then
                    Error(
                      Text013,
                      ServiceLine.TableCaption, ServiceLine.FieldCaption(Description),
                      StdText.TableCaption(), StdText.Code, StdText.FieldCaption(Description),
                      Format(StrLen(TempServLineDescription) - MaxStrLen(ServiceLine.Description)));
                ServiceLine.Description := CopyStr(TempServLineDescription, 1, MaxStrLen(ServiceLine.Description));
            end else
                ServiceLine.Description :=
                  StrSubstNo('%1 - %2', Format(InvFrom), Format(InvTo));

            if ServMgtSetup."Prepaid Inv. for Whole Year" then ServiceLine."Appl.-to Service Entry" := 0;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServContractManagement", 'OnGetInvoicePeriodTextOnCaseElse', '', true, true)]
    local procedure "ServContractManagement_OnGetInvoicePeriodTextOnCaseElse"
    (
        InvoicePeriod: Enum "Service Contract Header Invoice Period";
        var InvPeriodText: Text[4]
    )
    begin
        case InvoicePeriod of
            InvoicePeriod::"Eighteen Months":
                InvPeriodText := '<8M>';
            InvoicePeriod::"Two Years":
                InvPeriodText := '<2Y>';
            InvoicePeriod::"Three Years":
                InvPeriodText := '<3Y>';
        end;
    end;


    [EventSubscriber(ObjectType::Report, Report::"Contract Invoicing", 'OnAfterSetInvoiceDates', '', true, true)]
    local procedure "Contract Invoicing_OnAfterSetInvoiceDates"
    (
        var ServiceContractHeader: Record "Service Contract Header";
        var InvoiceFrom: Date;
        var InvoiceTo: Date
    )
    begin
        InvoiceFrom := ServiceContractHeader."Next Invoice Period Start";
        InvoiceTo := ServiceContractHeader."Next Invoice Period End";
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServContractManagement", 'OnCreateServiceLedgerEntryOnBeforeCheckServContractLineStartingDate', '', true, true)]
    local procedure "ServContractManagement_OnCreateServiceLedgerEntryOnBeforeCheckServContractLineStartingDate"
    (
        ServContractHeader: Record "Service Contract Header";
        var CountOfEntryLoop: Integer
    )
    var
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        ServMgtSetup.GET();  //PBC Modification
        if ServContractHeader.Prepaid AND (ServMgtSetup."Prepaid Inv. for Whole Year" = TRUE) then
            CountOfEntryLoop := 1;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServContractManagement", 'OnCreateServiceLedgerEntryOnBeforeInsertMultipleServLedgEntries', '', true, true)]
    local procedure "ServContractManagement_OnCreateServiceLedgerEntryOnBeforeInsertMultipleServLedgEntries"
    (
        var NextInvDate: Date;
        ServContractHeader: Record "Service Contract Header";
        ServContractLine: Record "Service Contract Line";
        var NoOfPayments: Integer;
        var DueDate: Date;
        var InvFromDate: Date;
        var AddingNewLines: Boolean;
        var CountOfEntryLoop: Integer
    )
    var
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        ServMgtSetup.GET();  //PBC Modification
        if ServContractHeader.Prepaid AND (ServMgtSetup."Prepaid Inv. for Whole Year" = TRUE) then
            NoOfPayments := CountOfEntryLoop;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServContractManagement", 'OnBeforeServLineInsert', '', true, true)]
    local procedure "ServContractManagement_OnBeforeServLineInsert"
    (
        var ServiceLine: Record "Service Line";
        ServiceHeader: Record "Service Header";
        ServiceContractHeader: Record "Service Contract Header"
    )
    var
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        ServMgtSetup.Get();
        if ServMgtSetup."Prepaid Inv. for Whole Year" then ServiceLine."Appl.-to Service Entry" := 0;
    end;

    /*//===========PBC try to not copy code from standard codeunit 5940 for service contactor but can not make it so many triggers used by FDD115=====================================
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ServContractManagement, 'OnBeforeCreateServiceLine', '', false, false)]
    local procedure ServContractManagement_OnBeforeCreateServiceLine(ServiceHeader: Record "Service Header"; ContractType: Enum "Service Contract Type"; ContractNo: Code[20];
                                                                                                                               InvFromDate: Date;
                                                                                                                               InvToDate: Date;
                                                                                                                               ServiceApplyEntry: Integer;
                                                                                                                               SigningContract: Boolean; var IsHandled: Boolean)
    var
        ServContractHeader: Record "Service Contract Header";
        ServDocReg: Record "Service Document Register";
        ServiceLedgerEntry: Record "Service Ledger Entry";
        TotalServLine: Record "Service Line";
        TotalServLineLCY: Record "Service Line";
        ServContractAccGr: Record "Service Contract Account Group";
        LatestInvToDate: Date;

        ServLine: Record "Service Line";
        GLAcc: Record "G/L Account";
        ServLineNo: Integer;
        AppliedGLAccount: Code[20];
    begin
        IsHandled := true;

        ServContractHeader.Get(ContractType, ContractNo);
        if ServContractHeader."Invoice Period" = ServContractHeader."Invoice Period"::None then
            exit;
        ServLineNo := 0;
        ServLine.Reset();
        ServLine.SetRange("Document Type", ServLine."Document Type"::Invoice);
        ServLine.SetRange("Document No.", ServiceHeader."No.");
        if ServLine.FindLast() then
            ServLineNo := ServLine."Line No.";

        if ServContractHeader.Prepaid and not SigningContract then begin
            ServContractHeader.TestField("Serv. Contract Acc. Gr. Code");
            ServContractAccGr.Get(ServContractHeader."Serv. Contract Acc. Gr. Code");
            ServContractAccGr.TestField("Prepaid Contract Acc.");
            GLAcc.Get(ServContractAccGr."Prepaid Contract Acc.");
            GLAcc.TestField("Direct Posting");
        end else begin
            ServContractHeader.TestField("Serv. Contract Acc. Gr. Code");
            ServContractAccGr.Get(ServContractHeader."Serv. Contract Acc. Gr. Code");
            ServContractAccGr.TestField("Non-Prepaid Contract Acc.");
            GLAcc.Get(ServContractAccGr."Non-Prepaid Contract Acc.");
            GLAcc.TestField("Direct Posting");
        end;
        AppliedGLAccount := GLAcc."No.";

        LatestInvToDate := InvToDate;
        if ServiceLedgerEntry.Get(ServiceApplyEntry) then begin
            ServiceLedgerEntry.SetRange("Entry No.", ServiceApplyEntry, ServiceLedgerEntry."Apply Until Entry No.");
            if ServiceLedgerEntry.FindSet() then begin
                repeat
                    //PBC Modification Comment out by Leon 5/11/2023
                    //if ServiceLedgerEntry.Prepaid then begin
                    //    InvFromDate := ServiceLedgerEntry."Posting Date";
                    //    InvToDate := CalcDate('<CM>', InvFromDate);
                    //    if InvToDate > LatestInvToDate then
                    //        InvToDate := LatestInvToDate;
                    //end; //Comment out for fix the issue when create service invoice line with wrong line description by Leon 05/11/2023
                    //OnCreateServiceLineOnBeforeServLedgEntryToServiceLine(ServHeader, ServContractHeader, ServiceLedgerEntry, InvFromDate, InvToDate);
                    ServLedgEntryToServiceLine(
                      TotalServLine,
                      TotalServLineLCY,
                      ServiceHeader,
                      ServiceLedgerEntry,
                      ContractNo,
                      InvFromDate,
                      InvToDate,
                      AppliedGLAccount);
                until ServiceLedgerEntry.Next() = 0;
                //OnCreateServiceLineOnAfterServLedgEntryToServiceLine(ServHeader, InvFromDate, InvToDate);
            end;
        end else begin
            Clear(ServiceLedgerEntry);
            //OnCreateServiceLineOnBeforeServLedgEntryToServiceLine(ServHeader, ServContractHeader, ServiceLedgerEntry, InvFromDate, InvToDate);
            ServLedgEntryToServiceLine(
              TotalServLine,
              TotalServLineLCY,
              ServiceHeader,
              ServiceLedgerEntry,
              ContractNo,
              InvFromDate,
              InvToDate,
              AppliedGLAccount);
        end;

        Clear(ServDocReg);
        ServDocReg.InsertServiceSalesDocument(
          ServDocReg."Source Document Type"::Contract, ContractNo,
          ServDocReg."Destination Document Type"::Invoice, ServLine."Document No.");
    end;

    procedure ServLedgEntryToServiceLine(var TotalServLine: Record "Service Line"; var TotalServLineLCY: Record "Service Line"; ServHeader: Record "Service Header"; ServiceLedgerEntry: Record "Service Ledger Entry"; ContractNo: Code[20]; InvFrom: Date; InvTo: Date; AppliedGLAccount: Code[20])
    var
        StdText: Record "Standard Text";
        IsHandled: Boolean;

        ServMgtSetup: Record "Service Mgt. Setup";
        ServLine: Record "Service Line";
        //GLAcc: Record "G/L Account";
        ServLineNo: Integer;
        TempServLineDescription: Text[250];
        Text013: Label '%1 cannot be created because the %2 is too long. Please shorten the %3 %4 %5 by removing %6 character(s).';
    begin
        //OnBeforeServLedgEntryToServiceLine(TotalServLine, TotalServLineLCY, ServHeader, ServLedgEntry, IsHandled, ServiceLedgerEntry, InvFrom, InvTo);
        //if IsHandled then
        //    exit;

        ServMgtSetup.Get();
        ServLineNo := 0;
        ServLine.Reset();
        ServLine.SetRange("Document Type", ServLine."Document Type"::Invoice);
        ServLine.SetRange("Document No.", ServHeader."No.");
        if ServLine.FindLast() then
            ServLineNo := ServLine."Line No.";

        ServLineNo := ServLineNo + 10000;
        ServLine.Reset();
        ServLine.Init();
        ServLine."Document Type" := ServHeader."Document Type";
        ServLine."Document No." := ServHeader."No.";
        ServLine."Line No." := ServLineNo;
        ServLine."Customer No." := ServHeader."Customer No.";
        ServLine."Location Code" := ServHeader."Location Code";
        ServLine."Gen. Bus. Posting Group" := ServHeader."Gen. Bus. Posting Group";
        ServLine."Transaction Specification" := ServHeader."Transaction Specification";
        ServLine."Transport Method" := ServHeader."Transport Method";
        ServLine."Exit Point" := ServHeader."Exit Point";
        ServLine."Area" := ServHeader.Area;
        ServLine."Transaction Specification" := ServHeader."Transaction Specification";

        //InitServiceLineAppliedGLAccount();
        ServLine.Type := ServLine.Type::"G/L Account";
        ServLine.Validate("No.", AppliedGLAccount);

        ServLine.Validate(ServLine.Quantity, 1);
        if ServMgtSetup."Contract Inv. Period Text Code" <> '' then begin
            StdText.Get(ServMgtSetup."Contract Inv. Period Text Code");
            TempServLineDescription := StrSubstNo('%1 %2 - %3', StdText.Description, Format(InvFrom), Format(InvTo));
            if StrLen(TempServLineDescription) > MaxStrLen(ServLine.Description) then
                Error(
                  Text013,
                  ServLine.TableCaption, ServLine.FieldCaption(ServLine.Description),
                  StdText.TableCaption(), StdText.Code, StdText.FieldCaption(Description),
                  Format(StrLen(TempServLineDescription) - MaxStrLen(ServLine.Description)));
            ServLine.Description := CopyStr(TempServLineDescription, 1, MaxStrLen(ServLine.Description));
        end else
            ServLine.Description :=
              StrSubstNo('%1 - %2', Format(InvFrom), Format(InvTo));
        ServLine."Contract No." := ContractNo;
        ServLine."Appl.-to Service Entry" := ServiceLedgerEntry."Entry No.";
        ServLine."Service Item No." := ServiceLedgerEntry."Service Item No. (Serviced)";
        ServLine."Unit Cost (LCY)" := ServiceLedgerEntry."Unit Cost";
        ServLine."Unit Price" := -ServiceLedgerEntry."Unit Price";

        TotalServLine."Unit Price" += ServLine."Unit Price";
        TotalServLine."Line Amount" += -ServiceLedgerEntry."Amount (LCY)";
        if (ServiceLedgerEntry."Amount (LCY)" <> 0) or (ServiceLedgerEntry."Discount %" > 0) then
            if ServHeader."Currency Code" <> '' then begin
                ServLine.Validate(ServLine."Unit Price",
                  AmountToFCY(TotalServLine."Unit Price", ServHeader) - TotalServLineLCY."Unit Price");
                ServLine.Validate(ServLine."Line Amount",
                  AmountToFCY(TotalServLine."Line Amount", ServHeader) - TotalServLineLCY."Line Amount");
            end else begin
                ServLine.Validate(ServLine."Unit Price");
                ServLine.Validate(ServLine."Line Amount", -ServiceLedgerEntry."Amount (LCY)");
            end;
        TotalServLineLCY."Unit Price" += ServLine."Unit Price";
        TotalServLineLCY."Line Amount" += ServLine."Line Amount";

        //IsHandled := false;
        //OnServLedgEntryToServiceLineOnBeforeDimSet(ServLine, ServiceLedgerEntry, ServHeader, IsHandled);
        //if IsHandled then
        //    exit;

        ServLine."Shortcut Dimension 1 Code" := ServiceLedgerEntry."Global Dimension 1 Code";
        ServLine."Shortcut Dimension 2 Code" := ServiceLedgerEntry."Global Dimension 2 Code";
        ServLine."Dimension Set ID" := ServiceLedgerEntry."Dimension Set ID";

        //IsHandled := false;
        //OnServLedgEntryToServiceLineOnBeforeServLineInsert(ServLine, TotalServLine, TotalServLineLCY, ServHeader, ServLedgEntry, ServiceLedgerEntry, IsHandled, InvFrom, InvTo);
        //if IsHandled then
        //    exit;

        ServLine.Insert();
        ServLine.CreateDimFromDefaultDim(0);
    end;

    procedure AmountToFCY(AmountLCY: Decimal; var ServHeader3: Record "Service Header"): Decimal
    var
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
    begin
        Currency.Get(ServHeader3."Currency Code");
        Currency.TestField("Unit-Amount Rounding Precision");
        exit(
          Round(
            CurrExchRate.ExchangeAmtLCYToFCY(
              ServHeader3."Posting Date", ServHeader3."Currency Code",
              AmountLCY, ServHeader3."Currency Factor"),
            Currency."Unit-Amount Rounding Precision"));
    end;*/

}
