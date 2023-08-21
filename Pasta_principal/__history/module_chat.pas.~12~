unit module_chat;

interface

uses
  System.SysUtils, System.Classes, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope,DataSet.Serialize;

type
  TDataModule1 = class(TDataModule)
    RESTChat: TRESTClient;
    RESTReqChat: TRESTRequest;
    RESTRespChat: TRESTResponse;
    DataSetAdapterChat: TRESTResponseDataSetAdapter;
    MemTableChat: TFDMemTable;
    RESTUsuario: TRESTClient;
    RESTReqUsuario: TRESTRequest;
    RESTRespUsuario: TRESTResponse;
    DataSetAdapterUsuario: TRESTResponseDataSetAdapter;
    MemTableUsuario: TFDMemTable;
    RESTContatos: TRESTClient;
    RESTReqContatos: TRESTRequest;
    RESTRespContatos: TRESTResponse;
    DataSetAdapterContatos: TRESTResponseDataSetAdapter;
    MemTableContatos: TFDMemTable;
  private
    procedure GetUserDefault;
    procedure GetUserRestRequest;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation
uses RESTRequest4D,DataSet.Serialize.Adapter.RestRequest4D;

const
    BASE_URL = 'http://localhost:5000';

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.GetUserDefault;
begin
     RestChat.BaseURL:= BASE_URL;
     RESTReqChat.Resource:='chat';
     DataSetAdapterChat.Response:= RESTRespChat;
     RESTReqChat.Method:= rmGet;
     RESTReqChat.Execute;

     RESTUsuario.BaseURL:= BASE_URL;
     RESTReqUsuario.Resource:='usuario';
     DataSetAdapterUsuario.Response:= RESTRespUsuario;
     RESTReqUsuario.Method:= rmGet;
     RESTReqUsuario.Execute;

     RESTContatos.BaseURL:= BASE_URL;
     RESTReqContatos.Resource:='contato';
     DataSetAdapterContatos.Response:= RESTRespContatos;
     RESTReqContatos.Method:= rmGet;
     RESTReqContatos.Execute;
end;

procedure TDataModule1.GetUserRestRequest;
begin
     TRequest.New.BaseURL(BASE_URL)
          .Resource('chat')
          .Adapters(TDataSetSerializeAdapter.New(MemTableChat))
          .Get;

     TRequest.New.BaseURL(BASE_URL)
          .Resource('usuario')
          .Adapters(TDataSetSerializeAdapter.New(MemTableUsuario))
          .Get;

     TRequest.New.BaseURL(BASE_URL)
          .Resource('contato')
          .Adapters(TDataSetSerializeAdapter.New(MemTableContatos))
          .Get;
end;

end.
