program ProjTelaLogin;

uses
  System.StartUpCopy,
  FMX.Forms,
  login_unit in 'login_unit.pas' {FormCadUs};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormCadUs, FormCadUs);
  Application.Run;
end.
