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
    VK_SHIFT:     Result:= 'Shift tu�u';
    VK_CONTROL:   Result:= 'Ctrl tu�u';
    VK_MENU:      Result:= 'Alt tu�u';
    VK_SPACE:     Result:= 'Bo�luk tu�u';
    VK_RETURN:    Result:= 'Enter tu�u';
    VK_PRIOR:     Result:= 'Sayfa Y. tu�u';
    VK_NEXT:      Result:= 'Sayfa A. tu�u';
    VK_END:       Result:= 'Sona Git tu�u';
    VK_HOME:      Result:= 'Ba�a Git tu�u';
    VK_LEFT:      Result:= 'Sol Y�n tu�u';
    VK_UP:        Result:= 'Yukar� Y�n tu�u';
    VK_RIGHT:     Result:= 'Sa� Y�n tu�u';
    VK_DOWN:      Result:= 'A�a�� Y�n tu�u';
    VK_INSERT:    Result:= 'Araya Gir tu�u';
    VK_DELETE:    Result:= 'Silme tu�u';
    VK_NUMPAD0:   Result:= 'Ped 0 tu�u';
    VK_NUMPAD1:   Result:= 'Ped 1 tu�u';
    VK_NUMPAD2:   Result:= 'Ped 2 tu�u';
    VK_NUMPAD3:   Result:= 'Ped 3 tu�u';
    VK_NUMPAD4:   Result:= 'Ped 4 tu�u';
    VK_NUMPAD5:   Result:= 'Ped 5 tu�u';
    VK_NUMPAD6:   Result:= 'Ped 6 tu�u';
    VK_NUMPAD7:   Result:= 'Ped 7 tu�u';
    VK_NUMPAD8:   Result:= 'Ped 8 tu�u';
    VK_NUMPAD9:   Result:= 'Ped 9 tu�u';
    VK_MULTIPLY:  Result:= 'Ped * tu�u';
    VK_ADD:       Result:= 'Ped + tu�u';
    VK_SUBTRACT:  Result:= 'Ped - tu�u';
    VK_DECIMAL :  Result:= 'Ped , tu�u';
    VK_DIVIDE:    Result:= 'Ped / tu�u';
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
