unit login_unit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ExtCtrls, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, System.JSON,
  REST.Response.Adapter;

type
  TFormLoginUs = class(TForm)
    edLogin: TEdit;
    edSenha: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    BtnConfirma: TSpeedButton;
    ImgBtnconfirma: TImage;
    btnCancela: TSpeedButton;
    imgBtnCancela: TImage;
    ednome: TEdit;
    procedure btnCancelaClick(Sender: TObject);
    procedure BtnConfirmaClick(Sender: TObject);
  private
    FCodlogin: string;

    { Private declarations }
  public
    property codlogin: string read FCodlogin write FCodlogin;
  end;

var
  FormLoginUs: TFormLoginUs;

implementation
uses chat_mult, module_chat,RESTRequest4D,DataSet.Serialize.Adapter.RestRequest4D;

const
    BASE_URL = 'http://localhost:5000';

{$R *.fmx}

procedure TFormLoginUs.btnCancelaClick(Sender: TObject);
begin
     close;
     Chat_form.Close;
end;

procedure TFormLoginUs.BtnConfirmaClick(Sender: TObject);
var
  id, nome, senha,
  edlog, edSenhas: string;
  encontra: boolean;
begin
    encontra:=False;
    edlog:= edLogin.Text;
    edSenhas:= edSenha.Text;
    try
      //DataModule1.RESTReqChat.Execute;
      TRequest.New.BaseURL(BASE_URL)
          .Resource('usuario')
          .Adapters(TDataSetSerializeAdapter.New(DataModule1.MemTableUsuario))
          .Get;
      while NOT DataModule1.MemTableUsuario.Eof do
            begin
                  id:=DataModule1.MemTableUsuario.FieldByName('usuarioid').AsString;
                  senha:=DataModule1.MemTableUsuario.FieldByName('senha').AsString;
                  if (id=edLog) and (senha=edSenhas) then
                  begin
                      encontra:= True;
                      ednome.Text:= DataModule1.MemTableUsuario.FieldByName('nome').AsString;
                      codlogin:=id;
                  end;
                 DataModule1.MemTableUsuario.Next;
            end;
    Except
        MessageDlg('Houve um problema!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
    end;

    if encontra = True then
    begin
        FormLoginUs.close;
    end
    else
    begin
          MessageDlg('Usuário não encontrado!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
    end;
end;

end.
