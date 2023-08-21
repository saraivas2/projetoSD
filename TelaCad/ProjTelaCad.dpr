program ProjTelaCad;

uses
  System.StartUpCopy,
  FMX.Forms,
  Cad_us_unit in 'Cad_us_unit.pas' {FormCadUs},
  module_chat in '..\Pasta_principal\module_chat.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormCadUs, FormCadUs);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
