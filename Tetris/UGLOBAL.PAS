unit uGlobal;

interface

uses uTool1, Windows, QForms, SysUtils;

const
      Base = 0;
  T = Base + 1;//mavi
  J = Base + 2;//yesil
  L = Base + 3;//portakal
  S = Base + 4;//mor
  Z = Base + 5;//cam göb
  I = Base + 6;//altin
  O = Base + 7;//kirmizi

type
  TTaslar = record
    SonrakiYon  :Integer;
    TasA : array[1..4] of array[1..4] of byte;
  end;

const
  Taslar:array[0..19] of TTaslar =
 (
  (SonrakiYon:0;   // [0]  -  Bos Tas
   TasA:((0, 0, 0, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:2;   // [1]  -  T.I
   TasA:((0, T, 0, 0),
         (0, T, T, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:3;   // [2]  -  T.II
   TasA:((0, T, T, 0),
         (0, T, 0, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:4;   // [3]  -  T.III
   TasA:((0, T, T, 0),
         (0, 0, T, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:1;   // [4]  -  T.IV
   TasA:((0, 0, T, 0),
         (0, T, T, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:6;   // [5]  -  J.I
   TasA:((0, 0, J, 0),
         (0, 0, J, 0),
         (0, J, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:7;   // [6]  -  J.II
   TasA:((0, J, 0, 0),
         (0, 0, J, J),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:8;   // [7]  -  J.III
   TasA:((0, 0, J, 0),
         (0, J, 0, 0),
         (0, J, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:5;   // [8]  -  J.IV
   TasA:((0, J, J, 0),
         (0, 0, 0, J),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:10;  // [9]  -  L.I
   TasA:((0, L, 0, 0),
         (0, L, 0, 0),
         (0, 0, L, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:11;  // [10]  -  L.II
   TasA:((0, L, L, 0),
         (L, 0, 0, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:12;  // [11]  -  L.III
   TasA:((0, L, 0, 0),
         (0, 0, L, 0),
         (0, 0, L, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:9;   // [12]  -  L.IV
   TasA:((0, 0, L, 0),
         (L, L, 0, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:14;  // [13]  -  S.I
   TasA:((0, 0, S, 0),
         (0, S, 0, 0),
         (S, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:15;  // [14]  -  S.II
   TasA:((0, 0, 0, 0),
         (S, S, S, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:16;  // [15]  -  Z.I
   TasA:((S, 0, 0, 0),
         (0, S, 0, 0),
         (0, 0, S, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:13;  // [16]  -  Z.2
   TasA:((0, S, 0, 0),
         (0, S, 0, 0),
         (0, S, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:18;  // [17]  -  I.I
   TasA:((0, I, 0, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:17;  // [18]  -  I.II
   TasA:((0, I, 0, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0))),

  (SonrakiYon:19;  // [19]  -  O
   TasA:((O, O, 0, 0),
         (O, O, 0, 0),
         (0, 0, 0, 0),
         (0, 0, 0, 0)))
 );

const
  RekorSay  =5;
type
  TRekor    =record
    Sure,
    Isim    :String;
    Satir,
    Puan    :Integer;
  end;

Var
  Ayar    :record
    Down,
    Rotate,
    Right,
    Left      :Integer;
  end;
  Rekor   :array[1..RekorSay] of TRekor;

function AyarRW(Istek : TAccess):boolean;

implementation

function AyarRW(Istek : TAccess):boolean;
  var
    IniAyar :TProb;
    i       :Integer;
begin
  IniAyar := TProb.Create(ExtractFilePath(Application.ExeName) + 'tetris.ini', 'main');

  try
    IniAyar.ProbRndRW(istek, Ayar.Down, VK_DOWN);
    IniAyar.ProbRndRW(istek, Ayar.Rotate, VK_UP);
    IniAyar.ProbRndRW(istek, Ayar.Right, VK_RIGHT);
    IniAyar.ProbRndRW(istek, Ayar.Left, VK_LEFT);

    for i := 1 to RekorSay do begin
      IniAyar.ProbRndRW(istek-[acDefault], Rekor[i].Isim);
      IniAyar.ProbRndRW(istek-[acDefault], Rekor[i].Puan);
      IniAyar.ProbRndRW(istek-[acDefault], Rekor[i].Satir);
      IniAyar.ProbRndRW(istek-[acDefault], Rekor[i].Sure, '00.00.00');
    end;

  finally
    IniAyar.Free;
  end;
end;

begin
  AyarRW([acRead]);
end.
