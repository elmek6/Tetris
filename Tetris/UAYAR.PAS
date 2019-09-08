unit uAyar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmAyarlar = class(TForm)
    cmdDown: TSpeedButton;
    cmdRotate: TSpeedButton;
    cmdRight: TSpeedButton;
    cmdLeft: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cmdDefault: TSpeedButton;
    cmdOk: TSpeedButton;
    cmdCancel: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDownClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdDefaultClick(Sender: TObject);
  private
    { Private declarations }
    TusBekleniyor :Integer;
    procedure FormGoster;
    function TusKarsiligi(Key: Word): String;
  public
    { Public declarations }
  end;

var
  frmAyarlar: TfrmAyarlar;

implementation

uses uGlobal, uTool1;

{$R *.dfm}

procedure TfrmAyarlar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
    s:string;
begin
  if TusBekleniyor=0 then
    exit;

  case TusBekleniyor of
    1: Ayar.Down   := Key;
    2: Ayar.Rotate := Key;
    3: Ayar.Right  := Key;
    4: Ayar.Left   := Key;
  end;

  FormGoster;

  cmdDown.Down   := False;
  cmdRotate.Down := False;
  cmdLeft.Down   := False;
  cmdRight.Down  := False;

  TusBekleniyor  := 0;
end;

procedure TfrmAyarlar.cmdDownClick(Sender: TObject);
begin
  TusBekleniyor := (sender as TSpeedButton).Tag;
end;

procedure TfrmAyarlar.cmdCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmAyarlar.cmdOkClick(Sender: TObject);
begin
  AyarRW([acWrite]);
  close;
end;

procedure TfrmAyarlar.FormGoster;
begin
  cmdDown.Caption   := TusKarsiligi(Ayar.Down);
  cmdRotate.Caption := TusKarsiligi(Ayar.Rotate);
  cmdRight.Caption  := TusKarsiligi(Ayar.Right);
  cmdLeft.Caption   := TusKarsiligi(Ayar.Left);
end;

function TfrmAyarlar.TusKarsiligi(Key: Word): String;
begin
  case Key of
    VK_SHIFT:     Result:= 'Shift tuþu';
    VK_CONTROL:   Result:= 'Ctrl tuþu';
    VK_MENU:      Result:= 'Alt tuþu';
    VK_SPACE:     Result:= 'Boþluk tuþu';
    VK_RETURN:    Result:= 'Enter tuþu';
    VK_PRIOR:     Result:= 'Sayfa Y. tuþu';
    VK_NEXT:      Result:= 'Sayfa A. tuþu';
    VK_END:       Result:= 'Sona Git tuþu';
    VK_HOME:      Result:= 'Baþa Git tuþu';
    VK_LEFT:      Result:= 'Sol Yön tuþu';
    VK_UP:        Result:= 'Yukarý Yön tuþu';
    VK_RIGHT:     Result:= 'Sað Yön tuþu';
    VK_DOWN:      Result:= 'Aþaðý Yön tuþu';
    VK_INSERT:    Result:= 'Araya Gir tuþu';
    VK_DELETE:    Result:= 'Silme tuþu';
    VK_NUMPAD0:   Result:= 'Ped 0 tuþu';
    VK_NUMPAD1:   Result:= 'Ped 1 tuþu';
    VK_NUMPAD2:   Result:= 'Ped 2 tuþu';
    VK_NUMPAD3:   Result:= 'Ped 3 tuþu';
    VK_NUMPAD4:   Result:= 'Ped 4 tuþu';
    VK_NUMPAD5:   Result:= 'Ped 5 tuþu';
    VK_NUMPAD6:   Result:= 'Ped 6 tuþu';
    VK_NUMPAD7:   Result:= 'Ped 7 tuþu';
    VK_NUMPAD8:   Result:= 'Ped 8 tuþu';
    VK_NUMPAD9:   Result:= 'Ped 9 tuþu';
    VK_MULTIPLY:  Result:= 'Ped * tuþu';
    VK_ADD:       Result:= 'Ped + tuþu';
    VK_SUBTRACT:  Result:= 'Ped - tuþu';
    VK_DECIMAL :  Result:= 'Ped , tuþu';
    VK_DIVIDE:    Result:= 'Ped / tuþu';
  end;
end;

procedure TfrmAyarlar.FormShow(Sender: TObject);
begin
  FormGoster;
end;

procedure TfrmAyarlar.cmdDefaultClick(Sender: TObject);
begin
  AyarRW([acDefault]);
  FormGoster;
end;

end.
