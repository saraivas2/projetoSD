unit cad_us_unit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ExtCtrls, FMX.Objects, FMX.StdCtrls, REST.Response.Adapter,
  FMX.Controls.Presentation, FMX.Edit,System.JSON;

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
    btnCancela: TSpeedButton;
    imgBtnCancela: TImage;
    procedure BtnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadUs: TFormCadUs;

implementation
uses RESTRequest4D,DataSet.Serialize.Adapter.RestRequest4D,module_chat;

const
    BASE_URL = 'http://localhost:5000';

{$R *.fmx}

procedure TFormCadUs.BtnConfirmaClick(Sender: TObject);
var
  id, nome, senha,
  login, confsenha: String;
  json: TJSONObject;
  confirma:Boolean;
begin
      confirma:=True;
      nome:=edNome.Text;
      login:=edLogin.Text;
      senha:=edSenha.text;
      confsenha:=edSenhaConfirma.Text;
      if (nome='') or (login='') or (senha = '') or (confsenha='') then
          begin
              MessageDlg('Preencha todos os campos!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
          end
      else
        begin
              try
                TRequest.New.BaseURL(BASE_URL)
                    .Resource('usuario')
                    .Adapters(TDataSetSerializeAdapter.New(DataModule1.MemTableUsuario))
                    .Get;
                while NOT DataModule1.MemTableUsuario.Eof do
                    begin
                          id:=DataModule1.MemTableUsuario.FieldByName('usuarioid').AsString;
                          if (id=login)then
                            begin
                                confirma:=False;
                                MessageDlg('Usuário já existe!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
                            end;
                          DataModule1.MemTableUsuario.Next;
                    end;

                    if confirma = True then
                        begin
                            json:= TJSONObject.Create;
                            json.AddPair('usuarioid',login);
                            json.AddPair('nome',nome);
                            json.AddPair('senha',senha);



                            TRequest.New.BaseURL(BASE_URL)
                            .Resource('usuario')
                            .AddBody(json.ToJSON)
                            .Accept('application/json')
                            .Post;

                             edNome.Text:= '';
                             edLogin.Text:= '';
                             edSenha.text:= '';
                             edSenhaConfirma.Text:='';
                             edLogin.SetFocus;
                             MessageDlg('Cadastro concluído com sucesso!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
                        end;

              Except
                  MessageDlg('Erro ao cadastrar usuário!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
              end;
          end;

end;

end.
