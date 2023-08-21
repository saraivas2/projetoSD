program ProjChatMulti;

uses
  System.StartUpCopy,
  FMX.Forms,
  Chat_mult in 'Chat_mult.pas' {Chat_form};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TChat_form, Chat_form);
  Application.Run;
end.
