{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit Chat_mult;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.StdCtrls, FMX.Objects, FMX.ListView, FMX.Layouts,FMX.TextLayout,
  FMX.Controls.Presentation, FMX.Edit, DataSet.Serialize.Config,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  FMX.ExtCtrls, System.JSON, FMX.ComboEdit;

type
  TChat_form = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    ListView_mensagens: TListView;
    imagem_fundo: TImage;
    ImageControl1: TImageControl;
    StyleBook1: TStyleBook;
    Ed_mensagem: TEdit;
    btn_envia: TSpeedButton;
    Image1: TImage;
    ListView_contatos: TListView;
    LabelUsuario: TLabel;
    CBcontatos: TComboEdit;
    BtnAddContato: TSpeedButton;
    img_btn_enviar: TImage;
    procedure FormShow(Sender: TObject);
    procedure ListView_mensagensUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView_contatosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure BtnAddContatoClick(Sender: TObject);
  private
    FCod_login: string;
    FCod_contato: string;
    FNome_contato: string;
    FNome_login: string;
    procedure AddMessage(id_msg: integer; texto, dt,env,rec: string; logado:Boolean);
    procedure ListarMensagem;
    procedure Layoutlvproprio(item:TListViewItem);
    procedure Layoutlv(item: TListViewItem);
    function GetTextHeight(const D: TListItemText; const Width: single;
      const Text: string): Integer;
    procedure AddUsuario(id_usuario, nome: string);
    procedure ListarContatos;
    procedure LayoutUs(item: TListViewItem);
    procedure ListarUsuarios;
    function averigualista(const x: String; listacontato: TStrings): Boolean;
    function verificaNomeId(nome,idcont: String): String;
    { Private declarations }
  public
    property cod_login: string read FCod_login write FCod_login;
    property cod_contato: string read FCod_contato write FCod_contato;
    property nome_login: string read FNome_login write FNome_login;
    property nome_contato: string read FNome_contato write FNome_contato;
  end;

var
  Chat_form: TChat_form;

implementation
uses RESTRequest4D,DataSet.Serialize.Adapter.RestRequest4D, module_chat, login_unit;

const
    BASE_URL = 'http://localhost:5000';

{$R *.fmx}

function TChat_form.GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
var
  Layout: TTextLayout;
begin
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;

    Result := Round(Layout.Height);

    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;


procedure TChat_form.Image1Click(Sender: TObject);
var
  tempo: TDateTime;
  digitado, datahora,env,rec: String;
  cont: Integer;
  json: TJSONObject;

begin
      cont:=0;
      cont:= cont + 1;
      digitado:=Ed_mensagem.text;
      tempo:= now;
      datahora:= DateTimeToStr(tempo);
      env:=cod_login;
      rec:=cod_contato;
      if digitado='' then
      begin
          MessageDlg('Digite uma mensagem!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
      end
      else
      begin

          AddMessage(cont, digitado, datahora, env,rec,True);

          json:= TJSONObject.Create;
          json.AddPair('mensagem',digitado);
          json.AddPair('data',datahora);
          json.AddPair('usuarioenv',env);
          json.AddPair('usuariorec',rec);


          TRequest.New.BaseURL(BASE_URL)
          .Resource('chat')
          .AddBody(json.ToJSON)
          .Accept('application/json')
          .Post;

           Ed_mensagem.text:= '';
           ListView_mensagens.Items.Clear;
           ListarMensagem;
           ListView_mensagens.ScrollTo(ListView_mensagens.Items.Count-1);
      end;


end;

procedure TChat_form.Layoutlvproprio(item:TListViewItem);
var
  img: TListItemImage;
  txt: TListItemText;
begin
    //Posiciona o texto
    txt:= TListItemText(item.Objects.FindDrawable('txt_foto'));
    txt.Width:= ListView_mensagens.Width/2 - 16;
    txt.PlaceOffset.Y:= 10;
    txt.Height:= GetTextHeight(txt, txt.Width, txt.text);
    txt.TextColor:= $FFFFFFFF;



    //Fundo_mensagem
    img:= TListItemImage(item.Objects.FindDrawable('img_foto'));
    if txt.Height < 40 then  // Mensagem com apenas uma linha
    begin
      img.Width:= Trunc(txt.Text.Length * 8.5)
    end
    else
    begin
       img.Width:= ListView_mensagens.Width/2;
    end;
    img.PlaceOffset.X:= ListView_mensagens.Width - img.Width - 10;
    img.PlaceOffset.Y:= 10;
    img.Height:= txt.Height;
    img.Opacity:=1;

    //Posicionamento do Texto da mensagem
    txt.PlaceOffset.X:=  img.PlaceOffset.X + 2;
    //txt.TextAlign:= TTextAlign.Trailing;

    //Posiciona da Data
    txt:= TListItemText(item.Objects.FindDrawable('txt_data'));
    txt.PlaceOffset.X:= img.PlaceOffset.X + img.Width - 101;
    txt.PlaceOffset.Y:= img.PlaceOffset.Y + img.Height - 6;

    //Altura do Item da ListView
    item.Height:= Trunc(img.PlaceOffset.Y) + Trunc(img.Height) + 15;
end;

procedure TChat_form.Layoutlv(item:TListViewItem);
var
  img: TListItemImage;
  txt: TListItemText;
begin
    //Posiciona o texto
    txt:= TListItemText(item.Objects.FindDrawable('txt_foto'));
    txt.Width:= ListView_mensagens.Width/2 - 16;
    txt.PlaceOffset.X:= 20;
    txt.PlaceOffset.Y:= 10;
    txt.Height:= GetTextHeight(txt, txt.Width, txt.text);
    txt.TextColor:= $FF000000;

    //Fundo_mensagem
    img:= TListItemImage(item.Objects.FindDrawable('img_foto'));
    img.Width:= ListView_mensagens.Width/2;
    img.PlaceOffset.X:= 19;
    img.PlaceOffset.Y:= 10;
    img.Height:= txt.Height;
    img.Opacity:=0.3;

    if txt.Height < 40 then  // Mensagem com apenas uma linha
    begin
      img.Width:= Trunc(txt.Text.Length * 8.5)
    end;

    //Posiciona da Data
    txt:= TListItemText(item.Objects.FindDrawable('txt_data'));
    txt.PlaceOffset.X:= img.PlaceOffset.X -10;
    txt.PlaceOffset.Y:= img.PlaceOffset.Y + img.Height - 6;
    //txt.TextColor:= $FF000000;

    //Altura do Item da ListView
    item.Height:= Trunc(img.PlaceOffset.Y) + Trunc(img.Height) + 15;
end;

procedure TChat_form.LayoutUs(item:TListViewItem);
var
  txt: TListItemText;
begin
    //Posiciona o texto
    txt:= TListItemText(item.Objects.FindDrawable('txt_us'));
    txt.Width:= ListView_contatos.Width-10;
    txt.PlaceOffset.X:= 5;
    txt.PlaceOffset.Y:= 5;
    txt.Height:= 40;
end;

procedure TChat_form.AddMessage(id_msg: integer; texto, dt, env,rec: string; logado: Boolean);
var
 item: TListViewItem;
begin

     item:= ListView_mensagens.Items.Add;

     with item do
     begin
          Height:= 100;
          Tag:= id_msg;

          if logado then
              TagString:= 'S'
          else
              TagString:= 'N';

          //Fundo
          TListItemImage(Objects.FindDrawable('img_foto')).Bitmap:= imagem_fundo.Bitmap;

          //Texto
          TListItemText(Objects.FindDrawable('txt_foto')).Text:= texto;

          //TextoData
          TListItemText(Objects.FindDrawable('txt_data')).Text:= dt;
     end;

     if logado then
     begin
       Layoutlvproprio(item);
     end
     else
     begin
        Layoutlv(item);
     end;
end;

procedure TChat_form.AddUsuario(id_usuario, nome: string);
var
 item: TListViewItem;
begin
     item:= ListView_contatos.Items.Add;

     with item do
     begin
          Height:= 50;
          Tag:= Integer(id_usuario);
          TagString:= id_usuario;

          //Texto
          TListItemText(Objects.FindDrawable('txt_us')).Text:= nome;

     end;
     LayoutUs(item);
end;


procedure TChat_form.FormCreate(Sender: TObject);
begin
     TDataSetSerializeConfig.GetInstance.CaseNameDefinition:= cndLower;
     TDataSetSerializeConfig.GetInstance.import.DecimalSeparator:= '.';
end;

procedure TChat_form.FormShow(Sender: TObject);
begin
         FormLoginUs.ShowModal;
         cod_login:= FormLoginUs.codlogin;
         ListarUsuarios;
         ListarContatos;
         ListarMensagem;
end;

procedure TChat_form.ListarMensagem;
var
  ident:integer;
  msm, datahora, usenv, usrec: string;
  us_logado: Boolean;
begin
    DataModule1.MemTableChat.FieldDefs.Clear;
    ListView_mensagens.Items.Clear;
    try
      //DataModule1.RESTReqChat.Execute;
      TRequest.New.BaseURL(BASE_URL)
          .Resource('chat')
          .Adapters(TDataSetSerializeAdapter.New(DataModule1.MemTableChat))
          .AddParam('login', cod_login)
          .AddParam('contato', cod_contato)
          .Accept('application/json')
          .Get;

      ListView_mensagens.BeginUpdate;

      while NOT DataModule1.MemTableChat.Eof do
          begin
                ident:=DataModule1.MemTableChat.FieldByName('id').AsInteger;
                msm:= DataModule1.MemTableChat.FieldByName('mensagem').AsString;
                datahora:=DataModule1.MemTableChat.FieldByName('data').AsString;
                usenv:= DataModule1.MemTableChat.FieldByName('usuarioenv').AsString;
                if (usenv=cod_login) then
                    begin
                      us_logado:=True;
                    end
                    else
                    begin
                        us_logado:=False;
                    end;
                usrec:= DataModule1.MemTableChat.FieldByName('usuariorec').AsString;
                AddMessage(0,msm,datahora,usenv,usrec,us_logado);
                DataModule1.MemTableChat.Next;
          end;

    Except
        MessageDlg('Erro ao enviar mensagem!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
    end;
    ListView_mensagens.EndUpdate;
end;

procedure TChat_form.ListarUsuarios;
var
  id, nome: string;
begin
    CBcontatos.Items.Create;
    DataModule1.MemTableUsuario.FieldDefs.clear;
    try
      TRequest.New.BaseURL(BASE_URL)
          .Resource('usuario')
          .Adapters(TDataSetSerializeAdapter.New(DataModule1.MemTableUsuario))
          .Get;

      while NOT DataModule1.MemTableUsuario.Eof do
          begin
                id:=DataModule1.MemTableUsuario.FieldByName('usuarioid').AsString;
                nome:= DataModule1.MemTableUsuario.FieldByName('nome').AsString;
                CBcontatos.Items.Add(nome);
                if id=cod_login then
                begin
                  LabelUsuario.Text:= nome;
                  nome_login:=nome;
                end;
                DataModule1.MemTableUsuario.Next;
          end;
    Except
        MessageDlg('Erro ao carregar contatos!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
    end;
end;

procedure TChat_form.ListarContatos;
var
  usuarioid, nomeus, nomecont,
  idcontato: string;
  I: integer;
  bol: Boolean;
  Lista: TSTrings;
begin
    lista:=TStringList.Create;
    lista.Add('');
    DataModule1.MemTableContatos.FieldDefs.clear;

    try
      TRequest.New.BaseURL(BASE_URL)
          .Resource('contato')
          .Adapters(TDataSetSerializeAdapter.New(DataModule1.MemTableContatos))
          .Get;

      ListView_contatos.BeginUpdate;

      while NOT DataModule1.MemTableContatos.Eof do
          begin
                bol:=True;
                usuarioid:=DataModule1.MemTableContatos.FieldByName('usuarioid').AsString;
                idcontato:=DataModule1.MemTableContatos.FieldByName('idcontato').AsString;
                nomeus:=DataModule1.MemTableContatos.FieldByName('nomeusuario').AsString;
                nomecont:=DataModule1.MemTableContatos.FieldByName('nomecontato').AsString;
                    if (usuarioid=cod_login) and (idcontato<>cod_login) then
                        begin
                            bol:=averigualista(nomecont, lista);
                            if bol=False then
                                begin
                                    lista.Add(nomecont);
                                    AddUsuario(idcontato, nomecont);
                                    cod_contato:=idcontato;
                                    nome_contato:=nomecont;
                                end;
                        end
                    else

                    if (usuarioid<>cod_login) and (idcontato=cod_login) then
                        begin
                            bol:=averigualista(nomeus, lista);
                            if bol=False then
                                begin
                                    lista.Add(nomeus);
                                    AddUsuario(usuarioid, nomeus);
                                    cod_contato:=usuarioid;
                                    nome_contato:=nomeus;
                                end;
                        end;
                DataModule1.MemTableContatos.Next;

          end;
    Except
        MessageDlg('Erro ao carregar contatos!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
    end;
    ListView_contatos.EndUpdate;
    Lista.free
end;

function TChat_form.averigualista(const x: String; listacontato: TStrings):Boolean;
var
  I: Integer;
  ato: boolean;
begin
    for I := 0 to listacontato.Count-1 do
      begin
          if not (listacontato[I]=x) then
            ato:= False
          else
             ato:= True;
      end;
end;

function TChat_form.verificaNomeId(nome,idcont: String):String;
var
  idrecebe, nomeus: String;
begin
       DataModule1.MemTableUsuario.FieldDefs.clear;
       Try
       TRequest.New.BaseURL(BASE_URL)
          .Resource('usuario')
          .Adapters(TDataSetSerializeAdapter.New(DataModule1.MemTableUsuario))
          .Get;

        while not DataModule1.MemTableUsuario.Eof do
            begin
               idrecebe:=DataModule1.MemTableUsuario.FieldByName('usuarioid').AsString;
               nomeus:=DataModule1.MemTableUsuario.FieldByName('nome').AsString;
               if (nomeus=nome) then
                   begin
                      cod_contato:=idrecebe;
                   end;
               if (idrecebe=cod_login) then
                   begin
                      nome_login:=nome;
                   end;
               if (idcont=idrecebe) then
                   begin
                      nome_contato:=nome;
                   end;
               DataModule1.MemTableUsuario.Next;
            end;
       except
        MessageDlg('Algo deu errado',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
       End;
end;
procedure TChat_form.BtnAddContatoClick(Sender: TObject);
var
  idusuario, idcontato, retorno,
  nomecontCB, nomeus, nomecont: String;
  json: TJSONObject;
  presente: boolean;
begin
    presente:= True;
    if CBcontatos.text='Contatos' then
        begin
            MessageDlg('Selecione um contato',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
        end
    else

        try
         nomecontCB:=CBcontatos.text;
         TRequest.New.BaseURL(BASE_URL)
                      .Resource('contato')
                      .Adapters(TDataSetSerializeAdapter.New(DataModule1.MemTableContatos))
                      .Get;
          retorno:=verificaNomeId(nomecontCB,'xxx');

          while not DataModule1.MemTableContatos.Eof do
            begin
                idusuario:=DataModule1.MemTableContatos.FieldByName('usuarioid').AsString;
                idcontato:=DataModule1.MemTableContatos.FieldByName('idcontato').AsString;
                nomeus:=DataModule1.MemTableContatos.FieldByName('nomeusuario').AsString;
                nomecont:=DataModule1.MemTableContatos.FieldByName('nomecontato').AsString;

                if ((cod_contato=idcontato) and (idusuario=cod_login)) or ((cod_contato=idusuario) and (idcontato=cod_login)) then
                    begin
                      presente:=False;
                    end;
                DataModule1.MemTableContatos.Next;
            end;

          if presente=False then
             begin
                MessageDlg('Contato já cadastrado',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
             end
          else
            begin
              nomeus:=LabelUsuario.text;
              json:= TJSONObject.Create;
              json.AddPair('usuarioid',cod_login);
              json.AddPair('idcontato',cod_contato);
              json.AddPair('nomeusuario',nomeus);
              json.AddPair('nomecontato',nomecontCB);


              TRequest.New.BaseURL(BASE_URL)
              .Resource('contato')
              .AddBody(json.ToJSON)
              .Accept('application/json')
              .Post;

             ListView_contatos.Items.Clear;
              ListarContatos;
              ListView_contatos.ScrollTo(ListView_contatos.Items.Count-1);
            end;
        except
            MessageDlg('Algo deu errado com o cadastro de novo contato!',System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes], 0);
        end;
end;

procedure TChat_form.ListView_contatosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    cod_contato:=AItem.TagString;
    ListarMensagem;
end;

procedure TChat_form.ListView_mensagensUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
    if AItem.TagString= 'S' then
     begin
       Layoutlvproprio(AItem);
     end
     else
     begin
        Layoutlv(AItem);
     end;
end;

end.
