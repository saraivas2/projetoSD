unit cad_us_unit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ExtCtrls, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit;

type
  TFormCadUs = class(TForm)
    edLogin: TEdit;
    edNome: TEdit;
    edSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edSenhaConfirma: TEdit;
    BtnConfirma: TSpeedButton;
    ImgBtnconfirma: TImage;
    ImgLogin: TImage;
    ImagemView: TImageViewer;
    btnCancela: TSpeedButton;
    imgBtnCancela: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadUs: TFormCadUs;

implementation
uses module_chat;

{$R *.fmx}

end.
