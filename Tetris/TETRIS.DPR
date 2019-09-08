program tetris;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uGlobal in 'uGlobal.pas',
  uTool1 in 'uTool1.pas',
  uAyar in 'uAyar.pas' {frmAyarlar},
  skor in 'skor.pas' {frmSkor};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'TeTRiS';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAyarlar, frmAyarlar);
  Application.CreateForm(TfrmSkor, frmSkor);
  Application.Run;
end.
