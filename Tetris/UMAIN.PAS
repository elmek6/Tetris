{ **************************************************************************** }
{       Bu program �v�n� Mete taraf�ndan 19.02.2005 y�l�nda yaz�lm��t�r        }
{                                                                              }
{                      web:  www.bilgi.ofisi.com                               }
{                      email:  elmek6@yahoo.com - elmek6@gmail.com             }
{                      icq uin:   29512950                                     }
{                                                                              }
{     Bu oyunun a��k kodlar�n� ismi yaz�l� adreslerden temin edebilirsiniz     }
{ **************************************************************************** }

                                    (*
              Das Programm wurde von �v�nc Mete geschrieben

            Wenn Sie die Kode von diesem Spiel sehen m�chten,
               k�nnen Sie von dieser Adresse herunterladen
                                    *)

{ **************************************************************************** }
{ Yazar�n notu;                                                                }
{                                                                              }
{ Bu oyunu yazma amac�m bildiklerimi sizlerle payla�mak ve kendimi oyun        }
{ programlama konusunda geli�tirmekti, umar�m i�inize yarar.                   }
{                                                                              }
{ Program� yazarken elimden geldi�ince anla��l�r ve etkin kodlar yazmaya       }
{ �al��t�m. Genel amac�m olabildi�ince fazla y�ntemi oyunun i�ine eklemekti.   }
{ Kodlar� inceleyince sizde g�receksiniz ki farkl� y�ntemler ve metodlar ile   }
{ bir �ok tan�mlamalar yapt�m. �zellikle resim dosyas�n� bir Resource i�erisine}
{ g�merek dosya bilgilerini kendi tan�mlad���m bir Nesne olan uTool1 den       }
{ �a�ard�m. Eminim kodlar� biraz detayl� incelerek oyunun �al��mas�n�          }
{ h�zl�ca ke�feredersiniz.                                                     }
{                                                                              }
{ L�tfen sizlerde payla��ml� kodlar yazarak da��t�n�z ve Internet ortam�nda    }
{ T�rk�e kaynaklar�n �o�almas�na yard�mc� olunuz.                              }
{                                                                              }
{          - G�r��lerinizi ve yorumlar�n�z� payla��rsan�z sevinirim -          }
{ **************************************************************************** }


unit uMain;

interface

uses
  uGlobal,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Forms, Controls,
  Dialogs, ExtCtrls, StdCtrls, ActnList, Buttons, ComCtrls, Menus, ActnMan,
  ToolWin, AppEvnts, ActnCtrls,ActnMenus,CustomizeDlg, XPStyleActnCtrls;

type
  TKartlar = class
  private
    FImage    :TImage;
    FCountX,
    FCountY   :Integer;
    FRateX,
    FRateY    :Integer;
  public
    constructor Create(FileName :String; CountX, CountY: Integer);
    procedure dGetXY(sX,sY :Integer; var img:TImage; dX, dY :Integer);
  end;



  TfrmMain = class(TForm)
    pnlMain: TPanel;
    imgTetris: TImage;
    tmrMain: TTimer;
    Panel1: TPanel;
    imgSonra: TImage;
    Label1: TLabel;
    lblSatir: TLabel;
    lblPuan: TLabel;
    ActionManager1: TActionManager;
    oyunBasla: TAction;
    oyunBekle: TAction;
    oyunCikis: TAction;
    MainMenu1: TMainMenu;
    Oyun1: TMenuItem;
    Bala1: TMenuItem;
    Bekle1: TMenuItem;
    k1: TMenuItem;
    ayarlarGorunumM: TAction;
    ayarlarGorunumD: TAction;
    Ayarlar1: TMenuItem;
    Grnmx21: TMenuItem;
    Grnm21: TMenuItem;
    ayarlarAyarlar: TAction;
    actionAbout: TAction;
    Knye1: TMenuItem;
    Ayarlar2: TMenuItem;
    tmrSure: TTimer;
    lblMesaj: TStaticText;
    aeMain: TApplicationEvents;
    oyunSkor: TAction;
    Rekorlar1: TMenuItem;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrMainTimer(Sender: TObject);
    procedure oyunBaslaExecute(Sender: TObject);
    procedure oyunBekleExecute(Sender: TObject);
    procedure oyunCikisExecute(Sender: TObject);
    procedure ayarlarGorunumExecute(Sender: TObject);
    procedure actionAboutExecute(Sender: TObject);
    procedure ayarlarAyarlarExecute(Sender: TObject);
    procedure aeMainDeactivate(Sender: TObject);
    procedure tmrSureTimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure oyunSkorExecute(Sender: TObject);
    procedure aeMainHint(Sender: TObject);
  private
    { Private declarations }
    FImgKaynak  :TKartlar;
    FBlok       :array[1..20] of array [1..10] of byte;
    FTas,
    FTasX,
    FTasY       :Integer;
    FTasSonraki :Integer;
    FPuan,
    FSatir      :Integer;
    function Collision(Tas, x, y :Integer): Boolean;
    function DoluBlokTara: Integer;
    function sn2sure(Saniye: Integer): String;
    procedure OyunBitti;
    procedure BlokSil(y :Integer);
    procedure Goruntule;
    procedure TasiBirak;
    procedure SonrakiTas;
    procedure AsagiKaydir;
    procedure HiziAyarla;
    procedure PuanlariYaz;
    procedure RekorYazdir;
  public
    { Public declarations }
  end;

const
  blBos     =  0; { blSiyah }
  Kutu      = 20; { Kutucuk boyu }

var
  frmMain: TfrmMain;

  durum  : (drYok, drBekle, drOyun);
  Oran   : Double=1; { G�r�nt�n�n skala oran� }

implementation

uses uAyar, skor, uTool1;


{$R *.dfm}
{$R RESOURCE.RES}  // Ta�lar�n resminin buludu�u dahili kaynak



{ Bir image dosyas�n� belirtilen kaynaktan FImage i�ine al�r }
constructor TKartlar.Create(FileName: String; CountX, CountY: Integer);
begin
  inherited Create;
  FCountX := CountX;
  FCountY := CountY;
  FImage := TImage.Create(nil);
  FImage.AutoSize := True;
  try
    { Resource i�erisinden kaynak Image almak i�in }
    FImage.Picture.Bitmap.Handle := LoadBitmap(hINSTANCE, PChar(FileName));
    { Resim dosyas�ndan kaynak Image almak i�in }
    //FImage.Picture.LoadFromFile(FileName);
    FRateX := FImage.Width div FCountX;
    FRateY := FImage.Height div FCountY;
  except
  end;
end;


{ Belirtilen koordinatdaki resmi parametre girilen Image nesnesine yap��t�r�r }
procedure TKartlar.dGetXY(sX,sY:Integer; var img:TImage; dX, dY :Integer);
  var
    Sour,
    Dest      :TRect;
begin
  Sour.Top    := FRateY * dY;
  Sour.Left   := FRateX * dX;
  Sour.Bottom := Sour.Top  + (FRateY);
  Sour.Right  := Sour.Left + (FRateX);

  Dest.Top    := sY;
  Dest.Left   := sX;
  Dest.Bottom := FRateY + sY;
  Dest.Right  := FRateX + sX;

  img.Canvas.CopyRect(Dest, FImage.Canvas, Sour);
end;


{ Sat�rlar� siler }
procedure TfrmMain.BlokSil(y: Integer);
  var
    by   :Integer;
    bx   :Integer;
begin
  for by:=y downto 2 do
    FBlok[by] := FBlok[by-1];
  for bx := 1 to 10 do
    FBlok[1][bx] := blBos;  // En �stte olu�an belirsiz bo�lu�u engellemek i�in
end;


{ Dolu sat�rlar� bulur }
function TfrmMain.DoluBlokTara: Integer;
  var
    x, y    :Integer;
    t       :Integer;
begin
  result := 0;
  for y := 1 to 20 do begin
    t := 0;

    for x := 1 to 10 do
      if FBlok[y][x]<>blBos then
        inc(t);

    if t=10 then begin
      BlokSil(y);
      inc(result);
    end;

  end;
end;


{ Bas�lan tu�lar� alg�lar, y�n ve spesyal tu�lar da dahil }
procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if durum <> drOyun then //Oynama modunda de�ilse ��k
    exit;


  { A�a�� }
  if Key = Ayar.Down then begin
    AsagiKaydir;

  { D�nd�r }
  end else if Key = Ayar.Rotate then begin
    if not Collision(Taslar[FTas].SonrakiYon, FTasX, FTasY) then
      FTas := Taslar[FTas].SonrakiYon;
    Goruntule;

  { Sa�a }
  end else if Key = Ayar.Right then begin
    if not Collision(FTas, FTasX+1, FTasY) then
      inc(FTasX);
    Goruntule;

  { Sola }
  end else if Key = Ayar.Left then begin
    if not Collision(FTas, FTasX-1, FTasY) then
      dec(FTasX);
    Goruntule;

  end;
end;


{ FBlok ve FTas matrislerini Image nesneleri �zerine �izer }
procedure TfrmMain.Goruntule;
  var
    x,  y :Integer;
    c     :Integer;
begin
  for y := 1 to 20 do
    for x := 1 to 10 do
      FImgKaynak.dGetXY(Kutu*(x-1), Kutu*(y-1), imgTetris, FBlok[y][x], 0);

  for y := 1 to 4 do begin
    for x := 1 to 4 do begin
      c := Taslar[FTas].TasA[x][y];
      if c>0 then
        FImgKaynak.dGetXY(Kutu*(FTasX+x-2), Kutu*(FTasY+y-2), imgTetris, c, 0);
    end;
  end;
end;


{ Oyun bitimi }
procedure TfrmMain.OyunBitti;
begin
  tmrMain.Enabled := False;
  tmrSure.Enabled := False;
  lblMesaj.Caption := 'Oyun Bitti';
  lblMesaj.Visible := True;
  durum := drYok;

  RekorYazdir;

  OyunSkor.Execute;
end;


procedure TfrmMain.FormShow(Sender: TObject);
begin
  Goruntule;
  PuanlariYaz;
end;


procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FImgKaynak := TKartlar.Create('TASLAR', 11, 1); //K�bik olarak resim dizilim say�lar�
  durum := drYok;
  Randomize;
end;


{ Ta�lar�n otomatik a�a��ya d��mesi }
procedure TfrmMain.tmrMainTimer(Sender: TObject);
begin
  AsagiKaydir;
end;


{ Ta�lar�n bir birine de�me ve ekran s�n�rlar�n� a�ma kontrolu }
function TfrmMain.Collision(Tas, x, y: Integer): boolean;
  var
    ix, iy   :Integer;
    t        :Boolean;
begin
  result := False;

  for iy:=0 to 3 do begin
    for ix:=0 to 3 do begin
      t := Taslar[Tas].TasA[ix+1][iy+1] > blBos;

      { taslar�n birbirlerine de�meleri }
      if(t)and(FBlok[iy+y][ix+x]>blBos)then
        result := True;

      { taslar�n ekran s�n�rlar�n� a�mas� }
      if(t)and((x+ix<1)or(x+ix>10)or(y+iy<1)or(y+iy>20))then
        result := True;
    end;
  end;
end;


procedure TfrmMain.oyunBaslaExecute(Sender: TObject);
  var
    x,y  :Integer;
begin
  for y:=1 to 20 do
    for x:=1 to 10 do
      FBlok[y][x] := blBos;

  FPuan := 0;
  FSatir := 0;
  HiziAyarla;
  FTasSonraki := Random(19)+1;
  SonrakiTas;

  durum := drOyun;
  tmrMain.Enabled := True;
  tmrSure.Tag := 0;
  tmrSure.Enabled := True;
  lblMesaj.Visible := False;
end;


procedure TfrmMain.oyunBekleExecute(Sender: TObject);
begin
  case durum of
    drBekle:
      begin
        durum := drOyun;
        tmrMain.Enabled := True;
        tmrSure.Enabled := True;
        lblMesaj.Visible := False;
      end;
    drOyun:
      begin
        durum := drBekle;
        tmrMain.Enabled := False;
        tmrSure.Enabled := False;
        lblMesaj.Caption := 'Bekleniyor';
        lblMesaj.Visible := True;
      end;
  end;
end;


procedure TfrmMain.oyunCikisExecute(Sender: TObject);
begin
  Close;
end;


{ Ta��n hareket edecek yeri kalmad���nda oldu�u yere pozisyonlanmas� }
procedure TfrmMain.TasiBirak;
  var
    c,r,y
     ,x    :Integer;
begin
  for y:=0 to 3 do begin
    for x:=0 to 3 do begin
      c := Taslar[FTas].TasA[x+1][y+1];
      if c > blBos then
        FBlok[FTasY+y][FTasX+x] := c;
    end;
  end;

  r := DoluBlokTara;
  if r>0 then begin
    inc(FSatir, r);
    { 1s=10p  -  2s=30p  -  3s=60p  -  4s=100p }
    inc(FPuan, 5*(r+1)*r);
    PuanlariYaz;
  end;

  HiziAyarla;
  SonrakiTas;
end;


{ Gelecek bir sonraki ta� }
procedure TfrmMain.SonrakiTas;
  var
    x, y   :Integer;
begin
  FTas := FTasSonraki;
  FTasSonraki := Random(19)+1;
  FTasX := 4;
  FTasY := 1;

  if Collision(FTas, FTasX, FTasY) then begin
    OyunBitti;
    exit;
  end;

  for y := 0 to 3 do
    for x := 0 to 3 do
      FImgKaynak.dGetXY(Kutu*x, Kutu*y, imgSonra, Taslar[FTasSonraki].TasA[x+1][y+1], 0);
end;


procedure TfrmMain.AsagiKaydir;
begin
  if not Collision(FTas, FTasX, FTasY+1) then
    inc(FTasY)
  else
    TasiBirak;

  Goruntule;
end;


procedure TfrmMain.ayarlarGorunumExecute(Sender: TObject);
begin

  if sender = ayarlarGorunumD then
    Oran := oran / 2
  else
      Oran := oran * 2;

  imgTetris.Width := Trunc(Kutu * 10 * Oran);
  imgTetris.Height := Trunc(Kutu * 20 * Oran);

  imgSonra.Width := Trunc(Kutu * 4 * Oran);
  imgSonra.Height := Trunc(Kutu * 4 * Oran);

  frmMain.Width := Trunc(333 * (Oran+0.3));
  frmMain.Height := Trunc(433 * (Oran+0.2));
end;


procedure TfrmMain.HiziAyarla;
  var
    orj,
    hiz  :Integer;
begin

  orj := tmrMain.Interval;

  case FPuan of
       0..0999: hiz := 800;
    1000..1999: hiz := 700;
    2000..2999: hiz := 600;
    3000..3999: hiz := 500;
    4000..4999: hiz := 400;
    5000..5999: hiz := 300;
    6000..9999: hiz := 250;
          else  hiz := 200; // Caption := 'Oyun Bitti (Mant�ksal)';
  end;

  if hiz<>orj then
    tmrMain.Interval := hiz;
end;


procedure TfrmMain.actionAboutExecute(Sender: TObject);
begin
  showmessage(
    'Bu program 19.02.2005''de �v�n� Mete taraf�ndan yaz�lm��t�r'+#13#13+
    '     * web:  www.bilgi.ofisi.com'+#13+
    '     * email:  elmek6@yahoo.com'+#13+
    '     * icq uin:   29512950'+#13#13+
    'Bu oyunun a��k kodlar�n� ismi yaz�l� adreslerden temin edebilirsiniz'
  );
end;


procedure TfrmMain.ayarlarAyarlarExecute(Sender: TObject);
begin
  frmAyarlar.ShowModal;
end;


procedure TfrmMain.aeMainDeactivate(Sender: TObject);
begin
  if Durum=drOyun then
    OyunBekle.Execute;
end;


procedure TfrmMain.tmrSureTimer(Sender: TObject);
begin
  tmrSure.Tag := tmrSure.Tag + 1;

  Caption := 'TeTRiS ['+ sn2sure(tmrSure.Tag) +']';
end;


procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then { escape }
      OyunBekle.Execute;
end;


procedure TfrmMain.oyunSkorExecute(Sender: TObject);
begin
  frmSkor.ShowModal;
end;


procedure TfrmMain.PuanlariYaz;
begin
  lblSatir.Caption := format('Sat�r: %d', [FSatir]);
  lblPuan.Caption  := format('Puan: %d', [FPuan]);
end;


procedure TfrmMain.aeMainHint(Sender: TObject);
begin
  if Application.Hint = '' then
    Caption := 'TeTRiS'
  else
    Caption := Application.Hint
end;


procedure TfrmMain.RekorYazdir;
  var
    i,
    Siralama  :Integer;
begin
  Siralama := 0;
  for i := RekorSay downto 1 do begin
    if fPuan > Rekor[i].Puan then begin
      Siralama := i;
      if i<>RekorSay then
        Rekor[i+1] := Rekor[i];
    end;
  end;

  if Siralama = 0 then
    exit;

{ Yukar�daki kod ile ayn� i�i yapan basit s�n�rl� s�ralama kodu
  if fPuan > Rekor[1].Puan then begin
    Rekor[3] := Rekor[2];
    Rekor[2] := Rekor[1];
    Siralama := 1;
  end else if fPuan > Rekor[2].Puan then begin
    Rekor[3] := Rekor[2];
    Siralama := 2;
  end else if fPuan > Rekor[3].Puan then
    Siralama := 3
  else
    exit;
}

  Rekor[Siralama].Isim := InputBox(format('%d. oldunuz', [Siralama]), 'l�tfen isminizi girin..', 'Kahraman');
  Rekor[Siralama].Sure := sn2sure(tmrSure.Tag);
  Rekor[Siralama].Satir:= fSatir;
  Rekor[Siralama].Puan := fPuan;

  AyarRW([acWrite]);
end;

{ Saniye bilgisini [SS:DD:ss] bi�iminde geri d�ndedir }
function TfrmMain.sn2sure(Saniye: Integer): String;
  var
    saat,
    dakika  :Integer;
begin
  saat := saniye div 3600;
  dec(saniye, saat * 3600);

  dakika := saniye div 60;
  dec(saniye, dakika * 60);

  result := Format('%.2d:%.2d:%.2d', [Saat, Dakika, Saniye]);
end;

END.
