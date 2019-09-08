unit skor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids;

type
  TfrmSkor = class(TForm)
    sgSkor: TStringGrid;
    cmdTamam: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure cmdTamamClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const
  bosGR:TGridRect=
  (
   Left:-1;
   Top:-1;
   Right:-1;
   Bottom:-1;
  );


var
  frmSkor: TfrmSkor;

implementation

uses uGlobal;

{$R *.dfm}

procedure TfrmSkor.FormShow(Sender: TObject);
  var
    i     :Integer;
begin
  sgSkor.Selection := bosGR;

  sgSkor.Cells[0,0] := 'Sýra';
  sgSkor.Cells[1,0] := 'Ýsim';
  sgSkor.Cells[2,0] := 'Puan';
  sgSkor.Cells[3,0] := 'Satýr';
  sgSkor.Cells[4,0] := 'Süre';


  for i := 1 to RekorSay do begin
    sgSkor.Cells[0,i] := inttostr(i);
    sgSkor.Cells[1,i] := Rekor[i].Isim;
    sgSkor.Cells[2,i] := inttostr(Rekor[i].Puan);
    sgSkor.Cells[3,i] := inttostr(Rekor[i].Satir);
    sgSkor.Cells[4,i] := Rekor[i].Sure;
  end;

end;

procedure TfrmSkor.cmdTamamClick(Sender: TObject);
begin
  close;
end;

end.
