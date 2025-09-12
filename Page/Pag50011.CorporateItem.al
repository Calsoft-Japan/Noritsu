page 50011 "Corporate Item"
{
    ApplicationArea = All;
    Caption = 'Corporate Item Card';
    PageType = Card;
    SourceTable = "Corporate Item Master";
    Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Latest Item No."; Rec."Latest Item No.")
                {
                    ToolTip = 'Specifies the value of the Latest Item No. field.';
                }
                field("Price Group"; Rec."Price Group")
                {
                    ToolTip = 'Specifies the value of the Price Group field.';
                }
                field("Pricing Structure"; Rec."Pricing Structure")
                {
                    ToolTip = 'Specifies the value of the Pricing Structure field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
            }

            group(Properties)
            {
                field("Part Type"; Rec."Part Type")
                {
                    ToolTip = 'Specifies the value of the Part Type field.';
                }
                field("Process Type"; Rec."Process Type")
                {
                    ToolTip = 'Specifies the value of the Process Type field.';
                }
                field("Model Type"; Rec."Model Type")
                {
                    ToolTip = 'Specifies the value of the Model Type field.';
                }
                field("HS Code"; Rec."HS Code")
                {
                    ToolTip = 'Specifies the value of the HS Code field.';
                }
                field("HS Sub Code"; Rec."HS Sub Code")
                {
                    ToolTip = 'Specifies the value of the HS Sub Code field.';
                }
                field(Specification; Rec.Specification)
                {
                    ToolTip = 'Specifies the value of the Specification field.';
                }
                field(Material; Rec.Material)
                {
                    ToolTip = 'Specifies the value of the Material field.';
                }
                field("Production Type"; Rec."Production Type")
                {
                    ToolTip = 'Specifies the value of the Production Type field.';
                }
                field("Major Group"; Rec."Major Group")
                {
                    ToolTip = 'Specifies the value of the Major Group field.';
                }
                field("Product Group"; Rec."Product Group")
                {
                    ToolTip = 'Specifies the value of the Product Group field.';
                }
                field("Series Group"; Rec."Series Group")
                {
                    ToolTip = 'Specifies the value of the Series Group field.';
                }
                field("Production Name"; Rec."Production Name")
                {
                    ToolTip = 'Specifies the value of the Production Name field.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ToolTip = 'Specifies the value of the Product Group Code field.';
                }
                field(QA; Rec.QA)
                {
                    ToolTip = 'Specifies the value of the QA field.';
                }
                field("Serialized Parts"; Rec."Serialized Parts")
                {
                    ToolTip = 'Specifies the value of the Serialized Parts field.';
                }
                field("With Serial No."; Rec."With Serial No.")
                {
                    ToolTip = 'Specifies the value of the With Serial No. field.';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ToolTip = 'Specifies the value of the Country Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }

            group(Others)
            {
                field("Registration Date"; Rec."Registration Date")
                {
                    ToolTip = 'Specifies the value of the Registration Date field.';
                }
                field("Revision Date"; Rec."Revision Date")
                {
                    ToolTip = 'Specifies the value of the Revision Date field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateLocalItem)
            {
                Caption = 'Create as Local Item';
                ApplicationArea = All;

                trigger OnAction()
                var
                    CorporateItemMaster: Record "Corporate Item Master";
                begin
                    CurrPage.SETSELECTIONFILTER(CorporateItemMaster);
                    CorporateItemMaster.CreateAsLocalItem;
                end;
            }
        }
    }
}
