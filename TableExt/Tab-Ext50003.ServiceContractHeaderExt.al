tableextension 50003 "Service Contract Header Ext" extends "Service Contract Header"
{
    #region Comment out for BC27
    /* fields
    {
        modify("Invoice Period")
        {
            trigger OnAfterValidate()
            begin
                CalcInvPeriodDuration();
                if (Format("Price Update Period") <> '') and
                   (CalcDate("Price Update Period", "Starting Date") < CalcDate(InvPeriodDuration, "Starting Date"))
                then
                    Error(Text065, FieldCaption("Invoice Period"), FieldCaption("Price Update Period"));

                CheckChangeStatus();

                if ("Invoice Period" = "Invoice Period"::None) and
                   ("Last Invoice Date" <> 0D)
                then
                    Error(Text041,
                      FieldCaption("Invoice Period"),
                      Format("Invoice Period"),
                      TableCaption);

                if "Invoice Period" = "Invoice Period"::None then begin
                    "Amount per Period" := 0;
                    "Next Invoice Date" := 0D;
                    "Next Invoice Period Start" := 0D;
                    "Next Invoice Period End" := 0D;
                end else
                    if IsInvoicePeriodInTimeSegment() then //==Leon Comment out for new period options 4/12/2023
                        if Prepaid then begin
                            if "Next Invoice Date" = 0D then begin
                                if "Last Invoice Date" = 0D then begin
                                    TestField("Starting Date");
                                    if "Starting Date" = CalcDate('<-CM>', "Starting Date") then
                                        Validate("Next Invoice Date", "Starting Date")
                                    else begin
                                        ServMgtSetup.GET(); //PBC Modification
                                        IF ServMgtSetup."Prepaid Inv. for Whole Year" = FALSE THEN //PBC Modification
                                            VALIDATE("Next Invoice Date", CALCDATE('<-CM+1M>', "Starting Date"))
                                        ELSE
                                            VALIDATE("Next Invoice Date", "Starting Date"); //PBC Modification

                                        //Validate("Next Invoice Date", CalcDate('<-CM+1M>', "Starting Date"));
                                    end;
                                end else
                                    if "Last Invoice Date" = CalcDate('<-CM>', "Last Invoice Date") then
                                        Validate("Next Invoice Date", CalcDate('<CM+1D>', "Last Invoice Period End"))
                                    else
                                        Validate("Next Invoice Date", CalcDate('<-CM+1M>', "Last Invoice Date"));
                            end else
                                Validate("Next Invoice Date");
                        end else
                            Validate("Last Invoice Date");
            end;
        }

        modify("Last Invoice Date")
        {
            trigger OnAfterValidate()
            begin
                TestField("Starting Date");
                if "Last Invoice Date" = 0D then
                    if Prepaid then begin

                        ServMgtSetup.GET(); //PBC Modification
                        IF ServMgtSetup."Prepaid Inv. for Whole Year" = FALSE THEN
                            TempDate := CalcDate('<-1D-CM>', "Starting Date")//Origin==>TempDate := CALCDATE('<-CM+1M>', "Starting Date")
                        ELSE
                            TempDate := "Starting Date"; //PBC Modification
                    end
                    else
                        TempDate := CalcDate('<-1D+CM>', "Starting Date")
                else
                    TempDate := "Last Invoice Date";
                case "Invoice Period" of
                    "Invoice Period"::Month:
                        "Next Invoice Date" := CalcDate('<1M>', TempDate);
                    "Invoice Period"::"Two Months":
                        "Next Invoice Date" := CalcDate('<2M>', TempDate);
                    "Invoice Period"::Quarter:
                        "Next Invoice Date" := CalcDate('<3M>', TempDate);
                    "Invoice Period"::"Half Year":
                        "Next Invoice Date" := CalcDate('<6M>', TempDate);
                    "Invoice Period"::Year:
                        "Next Invoice Date" := CalcDate('<12M>', TempDate);
                    "Invoice Period"::None:
                        if Prepaid then
                            "Next Invoice Date" := 0D;

                    // PBC MOD. BEGIN additional contract periods for 18months, 2years and 3years
                    "Invoice Period"::"Eighteen Months":
                        "Next Invoice Date" := CALCDATE('<18M>', TempDate);
                    "Invoice Period"::"Two Years":
                        "Next Invoice Date" := CALCDATE('<24M>', TempDate);
                    "Invoice Period"::"Three Years":
                        "Next Invoice Date" := CALCDATE('<36M>', TempDate);
                // PBC MOD. END additional contract periods for 18months, 2years and 3years
                end;
                if not Prepaid and ("Next Invoice Date" <> 0D) then
                    "Next Invoice Date" := CalcDate('<CM>', "Next Invoice Date");

                if ("Last Invoice Date" <> 0D) and ("Last Invoice Date" <> xRec."Last Invoice Date") then
                    if Prepaid then
                        Validate("Last Invoice Period End", "Next Invoice Period End")
                    else
                        Validate("Last Invoice Period End", "Last Invoice Date");

                Validate("Next Invoice Date");
            end;
        }

        modify("Next Invoice Date")
        {
            trigger OnAfterValidate()
            var
                ServLedgEntry: Record "Service Ledger Entry";
            begin
                if "Next Invoice Date" = 0D then begin
                    "Next Invoice Period Start" := 0D;
                    "Next Invoice Period End" := 0D;
                    exit;
                end;
                if "Last Invoice Date" <> 0D then
                    if "Last Invoice Date" > "Next Invoice Date" then begin
                        ServLedgEntry.SetRange(Type, ServLedgEntry.Type::"Service Contract");
                        ServLedgEntry.SetRange("No.", "Contract No.");
                        if not ServLedgEntry.IsEmpty() then
                            Error(Text023, FieldCaption("Next Invoice Date"), FieldCaption("Last Invoice Date"));
                        "Last Invoice Date" := 0D;
                    end;

                if "Next Invoice Date" < "Starting Date" then
                    Error(Text024, FieldCaption("Next Invoice Date"), FieldCaption("Starting Date"));

                if Prepaid then begin
                    ServMgtSetup.GET(); //PBC Modification
                    IF ServMgtSetup."Prepaid Inv. for Whole Year" = FALSE THEN //PBC Modification
                        if "Next Invoice Date" <> CalcDate('<-CM>', "Next Invoice Date") then begin
                            Error(Text026, FieldCaption("Next Invoice Date"));
                        end;
                    TempDate := CalculateEndPeriodDate(true, "Next Invoice Date");
                    if "Expiration Date" <> 0D then
                        if "Next Invoice Date" > "Expiration Date" then
                            "Next Invoice Date" := 0D
                        else
                            if TempDate > "Expiration Date" then
                                TempDate := "Expiration Date";
                    if ("Next Invoice Date" <> 0D) and (TempDate <> 0D) then begin
                        "Next Invoice Period Start" := "Next Invoice Date";
                        "Next Invoice Period End" := TempDate;
                    end else begin
                        "Next Invoice Period Start" := 0D;
                        "Next Invoice Period End" := 0D;
                    end;
                end else begin
                    if "Next Invoice Date" <> CalcDate('<CM>', "Next Invoice Date") then begin

                        Error(Text028, FieldCaption("Next Invoice Date"));
                    end;
                    TempDate := CalculateEndPeriodDate(false, "Next Invoice Date");
                    if TempDate < "Starting Date" then
                        TempDate := "Starting Date";

                    if "Expiration Date" <> 0D then
                        if "Expiration Date" < TempDate then
                            "Next Invoice Date" := 0D
                        else
                            if "Expiration Date" < "Next Invoice Date" then
                                "Next Invoice Date" := "Expiration Date";

                    if ("Next Invoice Date" <> 0D) and (TempDate <> 0D) then begin
                        "Next Invoice Period Start" := TempDate;
                        "Next Invoice Period End" := "Next Invoice Date";
                    end else begin
                        "Next Invoice Period Start" := 0D;
                        "Next Invoice Period End" := 0D;
                    end;
                end;

                MyValidateNextInvoicePeriod();
            end;
        }

        modify("Starting Date")
        {
            trigger OnAfterValidate()
            begin
                CheckChangeStatus();

                if "Last Invoice Date" <> 0D then
                    Error(
                      Text029,
                      FieldCaption("Starting Date"), Format("Contract Type"));
                if "Starting Date" = 0D then begin
                    Validate("Next Invoice Date", 0D);
                    "First Service Date" := 0D;
                    ServContractLine.Reset();
                    ServContractLine.SetRange("Contract Type", "Contract Type");
                    ServContractLine.SetRange("Contract No.", "Contract No.");
                    ServContractLine.SetRange("New Line", true);

                    if ServContractLine.Find('-') then begin
                        repeat
                            ServContractLine."Starting Date" := 0D;
                            ServContractLine."Next Planned Service Date" := 0D;
                            ServContractLine.Modify();
                        until ServContractLine.Next() = 0;
                        Modify(true);
                    end;
                end else begin
                    if "Starting Date" > "First Service Date" then
                        "First Service Date" := "Starting Date";
                    ServContractLine.Reset();
                    ServContractLine.SetRange("Contract Type", "Contract Type");
                    ServContractLine.SetRange("Contract No.", "Contract No.");
                    ServContractLine.SetRange("New Line", true);

                    if ServContractLine.Find('-') then begin
                        repeat
                            ServContractLine.SuspendStatusCheck(true);
                            ServContractLine."Starting Date" := "Starting Date";
                            ServContractLine."Next Planned Service Date" := "First Service Date";
                            ServContractLine.Modify();
                        until ServContractLine.Next() = 0;
                        Modify(true);
                    end;
                    if "Next Price Update Date" = 0D then
                        "Next Price Update Date" := CalcDate("Price Update Period", "Starting Date");
                    if IsInvoicePeriodInTimeSegment() then //==Leon Comment out for new period options 4/12/2023
                        if Prepaid then begin
                            if "Starting Date" = CalcDate('<-CM>', "Starting Date") then
                                Validate("Next Invoice Date", "Starting Date")
                            else begin
                                ServMgtSetup.GET(); //PBC Modification
                                IF ServMgtSetup."Prepaid Inv. for Whole Year" = FALSE THEN //PBC Modification
                                    VALIDATE("Next Invoice Date", CALCDATE('<-CM+1M>', "Starting Date")) //PBC Modification
                                ELSE
                                    VALIDATE("Next Invoice Date", "Starting Date"); //PBC Modification
                                                                                    //Validate("Next Invoice Date", CalcDate('<-CM+1M>', "Starting Date"))
                            end;
                        end else
                            Validate("Last Invoice Date");
                    Validate("Service Period");
                end;
            end;
        }

        modify("Expiration Date")
        {
            trigger OnAfterValidate()
            var
                ConfirmManagement: Codeunit "Confirm Management";
                Confirmed: Boolean;
            begin
                CheckChangeStatus();

                if "Expiration Date" <> xRec."Expiration Date" then begin
                    CheckExpirationDate();

                    ServContractLine.Reset();
                    ServContractLine.SetRange("Contract Type", "Contract Type");
                    ServContractLine.SetRange("Contract No.", "Contract No.");
                    ServContractLine.SetRange(Credited, false);

                    if ("Expiration Date" <> 0D) or
                       ("Contract Type" = "Contract Type"::Quote)
                    then begin
                        if "Contract Type" = "Contract Type"::Contract then begin
                            ServContractLine.SetFilter("Contract Expiration Date", '>%1', "Expiration Date");
                            if ServContractLine.Find('-') then begin
                                if HideValidationDialog then
                                    Confirmed := true
                                else
                                    Confirmed :=
                                        ConfirmManagement.GetResponseOrDefault(
                                            StrSubstNo(Text056, FieldCaption("Expiration Date"), TableCaption(), "Expiration Date"), true);
                                if not Confirmed then
                                    Error('');
                            end;
                            ServContractLine.SetFilter("Contract Expiration Date", '>%1 | %2', "Expiration Date", 0D);
                        end;

                        if ServContractLine.Find('-') then begin
                            repeat
                                ServContractLine."Contract Expiration Date" := "Expiration Date";
                                ServContractLine."Credit Memo Date" := "Expiration Date";
                                ServContractLine.Modify();
                            until ServContractLine.Next() = 0;
                            Modify(true);
                        end ELSE BEGIN        // PBC MOD. BEG
                            ServContractLine.SETFILTER("Contract Expiration Date", '<>%1', "Expiration Date");
                            IF ServContractLine.FIND('-') THEN
                                MESSAGE(Text999);   // PBC MOD. END
                        END;
                    end;
                    Validate("Invoice Period");
                end;
            end;
        }

        modify(Prepaid)
        {
            trigger OnAfterValidate()
            var
                ServLedgEntry: Record "Service Ledger Entry";
            begin
                if Prepaid <> xRec.Prepaid then begin
                    if "Contract Type" = "Contract Type"::Contract then begin
                        ServLedgEntry.SetCurrentKey("Service Contract No.");
                        ServLedgEntry.SetRange("Service Contract No.", "Contract No.");
                        if not ServLedgEntry.IsEmpty() then
                            Error(
                              Text032,
                              FieldCaption(Prepaid), TableCaption(), "Contract No.");
                    end;
                    TestField("Starting Date");
                    if Prepaid then begin
                        if "Invoice after Service" then
                            Error(
                              Text057,
                              FieldCaption("Invoice after Service"),
                              FieldCaption(Prepaid));
                        if "Invoice Period" = "Invoice Period"::None then
                            Validate("Next Invoice Date", 0D)
                        else
                            if IsInvoicePeriodInTimeSegment() then  //==Leon Comment out for new period options 4/12/2023
                                if "Starting Date" = CalcDate('<-CM>', "Starting Date") then
                                    Validate("Next Invoice Date", "Starting Date")
                                else BEGIN
                                    ServMgtSetup.GET(); //PBC Modification
                                    IF ServMgtSetup."Prepaid Inv. for Whole Year" = FALSE THEN //PBC Modification
                                        VALIDATE("Next Invoice Date", CALCDATE('<-CM+1M>', "Starting Date")) //PBC Modification
                                    ELSE
                                        VALIDATE("Next Invoice Date", "Starting Date"); //PBC Modification
                                                                                        //Validate("Next Invoice Date", CalcDate('<-CM+1M>', "Starting Date"));
                                END;
                    end else
                        Validate("Last Invoice Date");
                end;
            end;
        }

    } */
    #endregion Comment out for BC27

    procedure getSuspendChangeStatus(): Boolean //for code unit 50001
    begin
        exit(SuspendChangeStatus);
    end;

    procedure getHideValidationDialog(): Boolean//for code unit 50001
    begin
        exit(HideValidationDialog);
    end;

    /* Comment out for BC27
            local procedure CalcInvPeriodDuration()
            begin
                if "Invoice Period" <> "Invoice Period"::None then
                    case "Invoice Period" of
                        "Invoice Period"::Month:
                            Evaluate(InvPeriodDuration, '<1M>');
                        "Invoice Period"::"Two Months":
                            Evaluate(InvPeriodDuration, '<2M>');
                        "Invoice Period"::Quarter:
                            Evaluate(InvPeriodDuration, '<3M>');
                        "Invoice Period"::"Half Year":
                            Evaluate(InvPeriodDuration, '<6M>');
                        "Invoice Period"::Year:
                            Evaluate(InvPeriodDuration, '<1Y>');
                        // PBC MOD. BEGIN additional contract periods for 18months, 2years and 3years
                        "Invoice Period"::"Eighteen Months":
                            Evaluate(InvPeriodDuration, '<18M>');
                        "Invoice Period"::"Two Years":
                            Evaluate(InvPeriodDuration, '<24M>');
                        "Invoice Period"::"Three Years":
                            Evaluate(InvPeriodDuration, '<36M>');
                        // PBC MOD. END additional contract periods for 18months, 2years and 3years
                        else
                            ;
                    end;
            end;

            local procedure CheckChangeStatus()
            begin
                if (Status <> Status::Cancelled) and
                   not SuspendChangeStatus
                then
                    TestField("Change Status", "Change Status"::Open);
            end;

            local procedure CheckExpirationDate()
            begin
                if "Expiration Date" <> 0D then begin
                    if "Expiration Date" < "Starting Date" then
                        Error(Text023, FieldCaption("Expiration Date"), FieldCaption("Starting Date"));
                    if "Last Invoice Date" <> 0D then
                        if "Expiration Date" < "Last Invoice Date" then
                            Error(
                                Text023, FieldCaption("Expiration Date"), FieldCaption("Last Invoice Date"));
                end;
            end;

            procedure MyValidateNextInvoicePeriod()
            var
                InvFrom: Date;
                InvTo: Date;
                NoOfDays: Integer;
                NoOfMonths: Integer;
                DaysInThisInvPeriod: Integer;
                DaysInFullInvPeriod: Integer;
                Currency: Record Currency;
                ServContractMgt: Codeunit "ServContractMgmt Copy"; //ServContractManagement;
            begin
                if NextInvoicePeriod() = '' then begin
                    "Amount per Period" := 0;
                    exit;
                end;
                Currency.InitRoundingPrecision();
                InvFrom := "Next Invoice Period Start";
                InvTo := "Next Invoice Period End";

                DaysInThisInvPeriod := InvTo - InvFrom + 1;

                ServMgtSetup.GET; // PBC MOD.

                if Prepaid then begin
                    TempDate := CalculateEndPeriodDate(true, "Next Invoice Date");
                    DaysInFullInvPeriod := TempDate - "Next Invoice Date" + 1;
                end else begin
                    TempDate := CalculateEndPeriodDate(false, "Next Invoice Date");
                    DaysInFullInvPeriod := "Next Invoice Date" - TempDate + 1;
                    if (DaysInFullInvPeriod = DaysInThisInvPeriod) and ("Next Invoice Date" = "Expiration Date") then
                        DaysInFullInvPeriod := CalculateEndPeriodDate(true, TempDate) - TempDate + 1;
                end;

                //SetAmountPerPeriod(InvFrom, InvTo);
                if DaysInFullInvPeriod = DaysInThisInvPeriod then
                    IF ServMgtSetup."Prepaid Inv. for Whole Year" = FALSE THEN // PBC MOD
                        "Amount per Period" :=
                          Round("Annual Amount" / ReturnNoOfPer("Invoice Period"), Currency."Amount Rounding Precision")
                    ELSE BEGIN  // PBC MOD
                        //ServContractMgt.NoOfMonthsAndDaysInPeriod2(InvFrom, InvTo, NoOfMonths, NoOfDays); // PBC MOD.
                        NoOfMonthsAndDaysInPeriod2(InvFrom, InvTo, NoOfMonths, NoOfDays); // PBC MOD.
                        "Amount per Period" :=
                          ROUND("Annual Amount" / 12 * NoOfMonths, Currency."Amount Rounding Precision"); // PBC MOD.
                    END // PBC MOD.
                else
                    "Amount per Period" := Round(
                        ServContractMgt.CalcContractAmount(Rec, InvFrom, InvTo), Currency."Amount Rounding Precision");
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

            var
                Text023: Label '%1 cannot be less than %2.';
                Text024: Label 'The %1 cannot be before the %2.';
                Text026: Label '%1 must be the first day in the month.';
                Text028: Label '%1 must be the last day in the month.';
                Text029: Label 'You are not allowed to change %1 because the %2 has been invoiced.';
                Text032: Label 'You cannot change %1 because %2 %3 has been invoiced.';
                Text041: Label '%1 cannot be changed to %2 because this %3 has been invoiced';
                Text056: Label 'The contract expiration dates on the service contract lines that are later than %1 on the %2 will be replaced with %3.\Do you want to continue?';
                Text057: Label 'You cannot select both the %1 and the %2 check boxes.';
                Text065: Label '%1 cannot be more than %2.';
                Text999: Label 'Please change Contract Expiration Date and Credit Memo Date  in each line manually!';
                InvPeriodDuration: DateFormula;
                TempDate: Date;
                ServMgtSetup: Record "Service Mgt. Setup";
                ServContractLine: Record "Service Contract Line";
         */
}
