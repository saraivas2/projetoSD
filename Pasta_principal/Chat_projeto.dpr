program Chat_projeto;

uses
  System.StartUpCopy,
  FMX.Forms,
  Chat_mult in 'Chat_mult.pas' {Chat_form},
  module_chat in 'module_chat.pas' {DataModule1: TDataModule},
  login_unit in 'login_unit.pas' {FormLoginUs};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TChat_form, Chat_form);
  Application.CreateForm(TFormLoginUs, FormLoginUs);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
