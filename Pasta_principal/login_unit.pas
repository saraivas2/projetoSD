unit login_unit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ExtCtrls, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, System.JSON,
  REST.Response.Adapter, RESTRequest4D;

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
    function autentica(login, senha: string):boolean;
    { Private declarations }
  public
    property codlogin: string read FCodlogin write FCodlogin;
  end;

var
  FormLoginUs: TFormLoginUs;

implementation
uses chat_mult, module_chat,DataSet.Serialize.Adapter.RestRequest4D;

const
    BASE_URL = 'http://localhost:5000';

{$R *.fmx}

procedure TFormLoginUs.btnCancelaClick(Sender: TObject);
begin
     close;
     Chat_form.Close;
end;

function TFormLoginUs.autentica(login, senha: string):boolean;
var
  json: TJSONObject;
  response: IResponse;
  resultado: boolean;
  resp: string;
begin

  json := TJSONObject.Create;
  json.AddPair('usuarioid', login);
  json.AddPair('senha', senha);

  response := TRequest.New.BaseURL(BASE_URL)
    .Resource('autentico')
    .AddBody(json.ToJSON)
    .Accept('application/json')
    .Post;
  resp:=response.StatusText;
  try
    if resp = 'OK' then
    begin
      codlogin:=edLogin.Text;
      FormLoginUs.close;
    end
    else
    begin
      MessageDlg('Usuário não encontrado!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
    end;
  finally
    json.Free;
  end;
end;

procedure TFormLoginUs.BtnConfirmaClick(Sender: TObject);
var
  id, nome, senha,
  edlog, edSenhas: string;
  json: TJSONObject;
  encontra: Boolean;
begin
    edlog:= edLogin.Text;
    edSenhas:= edSenha.Text;
    try
        begin
            encontra:= autentica(edlog, edsenhas);
        end;
    Except
        MessageDlg('Houve um problema!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
    end;


end;

end.
