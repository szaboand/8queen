{$A+,B-,D+,E+,F+,G+,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 32768,0,655360}
Program Queen8;
{*****************************************************************************
******************************************************************************
*                           Queen 2.0a Verzi¢                                *
*                       1998.11.05. - 1999.06.07.                            *
*                       (P) Szab¢ Andr†s 1984-98                             *
******************************************************************************
*****************************************************************************}

Uses TWSys{V1.1a},TObject{V4.1e},TObjects{V4.1e},Queen{V1.0a};

{****************************************************************************}
{***                          Objektumok                                  ***}
{****************************************************************************}

Type
 MyQueenType    = object(O_QueenType)
  Step    : boolean;             { LÇpÇsenkÇnt vagy nem            }
  FStop   : boolean;             { Megold†sn†l v†rakoz†s           }
  Constructor Init(NN:byte);     { Objektum inicializ†l†s          }
  Procedure   Show;virtual;
  Procedure   Hide;virtual;
  Procedure   Found;virtual;
  Procedure   Process;virtual;

  Procedure   HideAllQueen;virtual;
  Procedure   Start;virtual;
 end;

{****************************************************************************}
{***                               V†ltoz¢k                               ***}
{****************************************************************************}

Var
   Q    : MyQueenType;

{****************************************************************************}
{***                              Konstansok                              ***}
{****************************************************************************}

Const
 VMode                 :  word    = _800x600_256;   { Vide¢m¢d k¢dja         }
 ProgramName           :  string  = 'Eight Queen 2.0 (C) Szab¢ Andr†s 1999';
 Info1                 :  string  = 'e-mail:szaboand@mail.petrik.mumszki.hu';
 MDVX                  :  word         = $0003;  { Mouse X oszt†sar†ny (SHR) }
 MDVY                  :  word         = $0003;  { Mouse X oszt†sar†ny (SHR) }
 PixRat                :  word         = $0001;  { Mouse Pixel/Ratio         }
 MouseAct              :  boolean      = TRUE;   { Saj†t mouse megjelen°tÇs  }
 BackgroundColor       :  byte    = $07;         { H†ttÇrszin                }
 DBackgroundColor      :  byte    = $08;         { SîtÇt h†ttÇrszin          }
 DDBackgroundColor     :  byte    = $00;         { SîtÇt h†ttÇrszin          }
 LBackgroundColor      :  byte    = $0F;         { Vil†gos h†ttÇrszin        }
 InfoTextColor         :  byte    = $0F;         { Info textszin             }
 DInfoTextColor        :  byte    = $08;         { SîtÇt info textszin       }
 TimeTextColor         :  byte    = $08;         { Idã textsz°n              }

 _ExitButtonCode                  = $0001;       { Command k¢dok             }
 _GoOnButtonCode                  = $0002;       { Command k¢dok             }
 _StepCButtonCode                 = $0003;

 _ExitButtonString                = ' KilÇp ';   { Exit Button felirat       }
 _GoOnButtonString                = ' Keres ';   { Keres Button felirat      }

 White                 : byte     = 15;          { FehÇr mezã sz°ne          }
 Black                 : byte     = 00;          { Fekete mezã sz°ne         }
 TableX                : word     = 5;           { T†bla bal felsã X koord.  }
 TableY                : word     = 10;          { T†bla bal felsã Y koord.  }

 Queen1 : array [0..34,0..37] of byte = (
(231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,248,243,241),
(231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,231,231,231,239,234,251,244,241),
(231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,231,231,244,240,237,253,244,242),
(231,231,231,231,231,231,249,244,231,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,231,231,250,241,237,254,244,242),
(231,231,231,231,231,231,244,242,237,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,231,242,253,242,237,254,244,242),
(231,231,231,231,231,231,237,241,238,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,248,243,254,242,238,253,244,242),
(231,231,231,231,231,231,250,237,239,242,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,246,252,242,254,242,238,252,244,242),
(231,231,231,231,231,231,248,247,240,244,243,231,231,231,231,231,231,231,244,
231,231,231,231,231,231,231,231,231,231,251,254,244,252,242,237,251,244,242),
(231,231,231,231,231,246,246,244,241,244,245,244,231,231,231,231,231,231,246,
231,231,231,231,231,231,231,231,244,243,254,254,244,251,242,236,250,244,242),
(231,231,231,231,231,250,242,240,240,244,246,247,244,244,231,231,231,246,248,
231,231,231,231,231,244,244,244,244,244,254,253,244,250,242,234,250,244,242),
(231,231,231,231,231,253,240,240,240,244,245,247,247,246,244,244,244,250,251,
244,242,244,244,244,244,244,245,247,250,253,252,244,250,242,234,248,244,242),
(231,231,231,231,250,254,240,240,238,242,244,245,247,248,247,246,246,252,254,
244,245,247,248,250,250,250,250,251,252,253,252,244,248,242,234,248,244,242),
(231,231,231,231,253,254,252,240,237,242,244,244,246,247,248,248,250,254,254,
246,250,252,253,253,253,253,253,252,251,252,250,243,247,242,234,247,244,241),
(231,231,231,231,254,252,248,246,236,242,242,244,244,245,246,246,247,254,253,
245,248,249,250,251,251,251,250,249,248,250,248,242,245,242,234,245,244,242),
(231,231,246,231,254,251,247,245,235,241,242,242,244,244,244,244,245,253,251,
242,244,244,245,245,245,245,245,244,244,248,247,242,244,242,234,244,243,241),
(231,250,253,238,252,249,245,244,235,240,241,242,242,244,244,244,244,251,249,
241,242,242,242,242,242,242,242,242,243,247,245,241,244,242,234,244,244,241),
(231,252,250,242,251,247,244,237,234,239,240,241,242,242,243,244,244,249,247,
240,242,242,242,242,242,242,242,242,242,244,244,240,244,242,234,244,242,241),
(231,245,247,241,250,246,237,237,235,238,239,240,241,242,242,242,243,247,245,
239,241,241,241,241,241,241,241,241,241,244,244,239,242,242,235,243,242,241),
(231,244,245,239,247,244,237,237,234,237,238,239,240,241,242,242,242,246,244,
238,240,240,240,240,240,240,240,240,240,244,244,238,242,242,234,242,242,241),
(231,246,244,237,246,244,244,237,234,237,237,238,239,240,241,242,242,244,244,
237,238,239,239,239,239,239,239,239,239,242,242,237,242,241,235,242,241,240),
(231,231,247,231,244,244,243,241,235,236,237,237,238,239,240,241,241,244,244,
236,237,238,238,239,239,239,239,239,239,242,242,237,242,241,235,241,241,240),
(231,231,231,231,244,243,242,240,234,235,236,237,237,238,239,240,240,244,244,
234,235,237,237,237,238,238,238,238,238,241,242,237,241,240,234,241,241,239),
(231,231,231,231,244,242,241,239,234,235,235,236,237,237,238,239,239,242,244,
234,234,235,236,237,237,237,237,237,237,240,241,234,240,239,235,241,240,239),
(231,231,231,231,242,244,240,235,234,234,234,235,236,237,237,238,238,242,242,
235,234,234,233,234,235,234,235,235,237,240,240,234,239,238,234,240,240,238),
(231,231,231,231,231,244,234,234,235,234,235,234,235,236,237,237,237,244,243,
234,237,237,237,237,234,234,235,234,234,240,240,235,238,238,234,240,240,238),
(231,231,231,231,231,244,235,234,234,234,234,234,241,242,231,231,231,244,242,
231,231,231,231,231,242,241,239,236,235,240,240,234,237,237,235,240,239,238),
(231,231,231,231,231,244,240,234,235,234,234,241,231,231,231,231,231,231,244,
231,231,231,231,231,231,231,231,242,239,240,239,235,237,237,234,239,238,237),
(231,231,231,231,231,231,242,244,234,235,241,231,231,231,231,231,231,231,244,
231,231,231,231,231,231,231,231,231,231,242,240,236,237,237,235,238,237,237),
(231,231,231,231,231,231,244,237,236,241,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,242,241,237,237,237,234,237,237,237),
(231,231,231,231,231,231,239,232,238,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,242,239,238,237,235,237,237,235),
(231,231,231,231,231,231,232,242,242,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,231,242,240,237,234,236,236,235),
(231,231,231,231,231,231,242,242,231,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,231,231,241,238,235,235,235,234),
(231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,231,231,244,240,237,235,235,234),
(231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,231,231,231,242,240,236,235,237),
(231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,
231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,231,241,238,238));

 Colors2 : array [231..255,1..3] of byte = (
        (00,00,00),(12,04,06),(17,05,07),(19,05,08),(24,06,09),
        (26,06,09),(31,06,09),(36,06,09),(39,05,08),(44,04,06),
        (46,03,05),(49,03,04),(51,02,02),(54,01,01),(54,08,04),
        (55,14,09),(55,20,12),(56,26,17),(57,32,21),(57,37,25),
        (58,42,29),(59,46,34),(59,50,38),(60,53,43),(63,63,63));


 WTime   : integer              = 0;       { V†rakoz†si idã                  }
 N       : byte                 = 8;       { 8x8-as t†bla                    }
 RUN     : boolean              = FALSE;   { KeresÇs futtat†s†t jelzi        }

{****************************************************************************}
{***                          Objektumok                                  ***}
{****************************************************************************}

Type
 MyButtonType   = object(ButtonType)
  Procedure DoButton;virtual;
  Procedure SetInit;virtual;
 end;

 MyCButtonType   = object(CButtonType)
  Procedure DoCButton;virtual;
 end;

 TimeType       = object(TextType)
  TF           : boolean;
  Time         : word;
  Constructor  Init(IDd,XX,YY:word);
  Procedure    SetInit;virtual;
  Procedure    Draw;virtual;
  Procedure    Timer;virtual;
 end;

{****************************************************************************}
{***                               V†ltoz¢k                               ***}
{****************************************************************************}

Var
 ExitButton           : MyButtonType;
 GoOnButton           : MyButtonType;
 StepCButton          : MyCButtonType;
 TimeText             : TimeType;

 CommandCode          : word;

 _Step                : boolean;           { LÇptetÇsi v†ltoz¢               }
 _WTime               : integer;           { V†rakoz†si idãsz†ml†l¢          }

 NDX,NDY              : word;              { Egy mezã szÇles/magas           }
 TablaX               : array [1..C_MaxN] of word; { T†bla X koordin†t†i     }
 TablaY               : array [0..C_MaxN] of word; { T†bla Y koordin†t†i     }

{****************************************************************************}
{***                       SegÇdelj†r†sok                                 ***}
{****************************************************************************}

Procedure ShowOneQueen(XX,YY:word);
var EX,EY,MI,MJ,II,JJ:word;
Begin
MI:=34;If NDX+1<MI then MI:=NDX-1;EX:=(NDX-MI) div 2;XX:=XX+EX;
MJ:=37;If NDY+1<MJ then MJ:=NDY-1;EY:=(NDY-MJ) div 2;YY:=YY+EY;
For II:=0 to MI do for JJ:=0 to MJ do
    If Queen1[II,JJ]<>231 then PutPixel(XX+II,YY+JJ,Queen1[II,JJ]);
End;

Procedure HideOneQueen(XX,YY:word);
Begin
SetColor(GetPixel(XX,YY));
Bar(XX,YY,XX+NDX-1,YY+NDY-1);
End;

{****************************************************************************}
{***                  MyQueenType objektum met¢dusai                      ***}
{****************************************************************************}

Constructor MyQueenType.Init(NN:byte);
Begin
Step:=FALSE;FStop:=TRUE;
Inherited Init(NN);
End;

Procedure MyQueenType.Show;
var S,SS:string;I:word;
Begin
If TX[CI]>QN then TX[CI]:=0;
If WTime<0 then Exit;
SS:='';For I:=1 to QN do begin Str(TX[I],S);SS:=SS+S+',';end;
SS:=Copy(SS,1,length(SS)-1);
SetTextBackColor(BackgroundColor);SetColor(0);ROM_8x14;SetTextOver(1);
MouseHide;
OutStringXY(TableX+16*8,TableY+NDY*(N+1)+8,SS);
ShowOneQueen(TablaX[CI],TablaY[TX[CI]]);
MouseShow;
End;

Procedure MyQueenType.Hide;
var II,JJ:word;
Begin
If TX[CI]>QN then Exit;
If WTime<0 then Exit;
MouseHide;
HideOneQueen(TablaX[CI],TablaY[TX[CI]]);
MouseShow;
End;

Procedure MyQueenType.HideAllQueen;
var I:word;
Begin
MouseHide;
For I:=1 to QN do HideOneQueen(TablaX[I],TablaY[TX[I]]);
MouseShow;
End;

Procedure MyQueenType.Process;
Begin
_Step:=not Step;_WTime:=WTime;
If Step then begin GoOnButton.Enable;GoOnButton.SetKeyFocus;end;
repeat
      TObjectProcess
until ((_WTime<=0) and (not Step)) or (Step and _Step) or (CommandCode=_ExitButtonCode);
If Step then GoOnButton.Disable;
End;

Procedure MyQueenType.Found;
var II:byte;SS,S:string;
Begin
SS:='';For II:=1 to QN do begin Str(TX[II],S);SS:=SS+S+',';end;
SS:=Copy(SS,1,length(SS)-1);
SetTextBackColor(BackgroundColor);SetColor(0);ROM_8x14;SetTextOver(1);
MouseHide;
OutStringXY(TableX+16*8,TableY+NDY*(N+1)+8,SS);
Str(MSzam,SS);OutStringXY(TableX+144,TableY+NDY*(N+1)+22,SS);
If not FStop then begin MouseShow;Exit;end;
For II:=231 to 255 do SetRGBReg(II,Colors2[II,3],Colors2[II,2],Colors2[II,1]);
If WTime<0 then For II:=1 to N do ShowOneQueen(TablaX[II],TablaY[Q.TX[II]]);
MouseShow;_Step:=False;GoOnButton.Enable;GoOnButton.SetKeyFocus;
repeat TObjectProcess until (_Step) or (CommandCode=_ExitButtonCode);
GoOnButton.Disable;
If WTime<0
   then begin
        Q.HideAllQueen;SS:='Searching...';
        while length(SS)<N*2 do SS:=SS+' ';SS:=Copy(SS,1,length(SS)-1);
        OutStringXY(TableX+16*8,TableY+NDY*(N+1)+80,SS);
        end;
For II:=231 to 255 do SetRGBReg(II,Colors2[II,1],Colors2[II,2],Colors2[II,2]);
End;

Procedure MyQueenType.Start;
Begin
If WTime<0 then HideAllQueen;
Inherited Start;
End;

{****************************************************************************}
{***                    MyButtonType objektum met¢dusai                   ***}
{****************************************************************************}

Procedure MyButtonType.DoButton;
Begin
CommandCode:=ID;
Case Id of
     _ExitButtonCode : Q.QueenExit:=True;
     _GoOnButtonCode : _Step:=True;
     end;
End;

Procedure MyButtonType.SetInit;
Begin
End;

{****************************************************************************}
{***                       CButtonType objektum met¢dusai                 ***}
{****************************************************************************}

Procedure MyCButtonType.DoCButton;
Begin
Case ID of
     _StepCButtonCode : Case Value of
                             0 : begin
                                 Q.Step:=FALSE;
                                 If RUN
                                    then begin
                                         GoOnButton.Off;
                                         ExitButton.SetKeyFocus;
                                         end;
                                 end;
                             1 : begin
                                 Q.Step:=TRUE;
                                 If RUN
                                    then begin
                                         GoOnButton.On;
                                         GoOnButton.SetKeyFocus;
                                         end;
                                 end;
                             end;
     end;
End;


{****************************************************************************}
{***                         TimeType objektum met¢dusai                  ***}
{****************************************************************************}

Constructor TimeType.Init(IDd,XX,YY:word);
Begin
Inherited Init(IDd,XX,YY,11,2,nil);
End;

Procedure TimeType.SetInit;
Begin
Chars:=1;LineSpace:=1;DY:=CDY*(8+LineSpace);
TextColor:=TimeTextColor;TextBackColor:=BackgroundColor;
End;

Procedure TimeType.Timer;
Begin
Draw;
End;

Procedure TimeType.Draw;
var t:string;tt:^byte;mh:boolean;
Begin
If _WTime>0 then Dec(_WTime);
If Time<18 then begin Inc(Time);Exit;end;
T:='C-TW '+GetTimeStr(0);
If TF then T:=T+' ' else T:=T+'.';TF:=Not(TF);
T:=T+chr(10)+GetDateStr(false)+chr(0);
TT:=@T;Inc(TT);TextPointer:=TT;mh:=false;
If (GetMouseX<X+DX+16) and (GetMouseY+16>Y) then begin mh:=true;MouseHide;end;
Inherited Draw;If MH then MouseShow;
Time:=0;
End;

{****************************************************************************}
{***                         Inicializ†l†sok                              ***}
{****************************************************************************}

Procedure InitProgramText;
Var X,Y:word;
Begin
X:=TableX+(N)*NDX+5;Y:=TablaY[1];
SetTextBackColor(BackgroundColor);SetColor(0);ROM_8x8;SetTextOver(1);
OutStringXY(X,Y,'Function NemUt(J:Byte):Boolean;');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'Begin');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'NemUt:=True;');Y:=Y+8;
OutStringXY(X,Y,'If (ME=X[J]) Or');Y:=Y+8;
OutStringXY(X,Y,'   (Abs(I-J)=Abs(ME-X[J]))');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'then NemUt:=False;');Y:=Y+8;X:=TablaY[N]+5;
OutStringXY(X,Y,'End;');Y:=Y+8;
Y:=Y+8;
OutStringXY(X,Y,'Function RosszEset:Boolean;');Y:=Y+8;
OutStringXY(X,Y,'Var J:byte;');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'Begin');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'J:=1;');Y:=Y+8;
OutStringXY(X,Y,'While (J<I) and (NemUt(J)) do');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'Inc(J);');Y:=Y+8;X:=X-4;
OutStringXY(X,Y,'RosszEset:=J<I;');Y:=Y+8;X:=TablaY[N]+5;
OutStringXY(X,Y,'End;');Y:=Y+8;
Y:=Y+8;
OutStringXY(X,Y,'Function JoEsetKeres:Boolean;');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'Begin');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'ME:=X[I]+1;');Y:=Y+8;
OutStringXY(X,Y,'While (ME<=Y[I]) and (RosszEset) do');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'Inc(ME)');Y:=Y+8;
OutStringXY(X,Y,'JoEsetKeres:=(ME<=Y[I]);');Y:=Y+8;X:=TablaY[N]+5;
OutStringXY(X,Y,'End;');Y:=Y+8;
Y:=Y+8;
OutStringXY(X,Y,'Procedure Kereses;');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'Begin');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'While I>=1 do');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'begin');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'If I>N');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'then begin Dec(I);Inc(M);end;');Y:=Y+8;X:=X-4;
OutStringXY(X,Y,'If JoEsetKeres');Y:=Y+8;X:=X+4;
OutStringXY(X,Y,'then begin X[I]:=ME;Inc(I);end');Y:=Y+8;
OutStringXY(X,Y,'else begin X[I]:=0;Dec(I);end;');Y:=Y+8;X:=X-8;
OutStringXY(X,Y,'end;');Y:=Y+8;X:=TablaY[N]+5;
OutStringXY(X,Y,'End;');Y:=Y+16;
SetColor(LBackGroundColor);Line(X,Y,GetMaxX-1-5,Y);Y:=Y+1;
SetColor(DBackGroundColor);Line(X,Y,GetMaxX-1-5,Y);
End;

Procedure InitTable;
var I,J,K1,K2:word;C:byte;
Begin
MouseHide;NDX:=384 div (N+1);NDY:=384 div (N+1);K1:=1;
J:={(GetMaxY-30-(N+1)*NDY) div 2}TableY;;TablaY[0]:=J-2;J:=J+NDY;
For K1:=1 to N do
      begin
      If K1 mod 2=0 then C:=White else C:=Black;
      I:={(GetMaxX-N*NDX) div 2}TableX;TablaY[K1]:=J;
      For K2:=1 to N do
          begin
          SetColor(C);If C=White then C:=Black else C:=White;
          Bar(I,J,I+NDX,J+NDY);TablaX[K2]:=I;I:=I+NDX;
          end;
      J:=J+NDY;
      end;
MouseShow;
End;

Function Init_Video:word;
var I,II,JJ:byte;
Begin
If SetGraphMode(VMode)<>0 then begin Init_Video:=1;Exit;end;
ClearScreen(BackGroundColor);
SetColor(BackGroundColor);Bar(0,GetMaxY-26,GetMaxX-1,GetMaxY-1);
SetColor(DBackGroundColor);Line(0,GetMaxY-27,GetMaxX-1,GetMaxY-27);
SetColor(DDBackGroundColor);Line(0,GetMaxY-28,GetMaxX-1,GetMaxY-28);
BorderDraw_2b(2,GetMaxY-25,90,18,BackGroundColor,DBackGroundColor,LBackGroundColor);
InitTable;
SetTextBackColor(BackgroundColor);SetColor(0);ROM_8x14;SetTextOver(1);
OutStringXY(TableX,TableY+NDY*(N+1)+22,'Megold†sok sz†ma: 0');
OutStringXY(TableX,TableY+NDY*(N+1)+8,'Megold†svektor  : ');
For II:=231 to 255 do SetRGBReg(II,Colors2[II,1],Colors2[II,2],Colors2[II,3]);
For I:=1 to N do ShowOneQueen(TablaX[I],TablaY[0]);
InitProgramText;
Init_Video:=0;
End;

Function Init_Mouse:byte;
Begin
If MouseInit(MouseAct,PixRat,MDVX,MDVY)=0
   then Init_Mouse:=1
   else begin Init_Mouse:=0;MouseShow;end;
End;

Procedure VideoDone;
Begin
Asm mov  ax,0003h;int 10h End;
WriteLn(ProgramName);
End;

{****************************************************************************}
{***                  Objektumok inicializ†l†sa/lez†r†sa                  ***}
{****************************************************************************}

Procedure ObjectInit;
Begin
GoOnButton.Init(_GoOnButtonCode,GetMaxX-132,GetMaxY-24,_GoOnButtonString);
ExitButton.Init(_ExitButtonCode,GetMaxX-66,GetMaxY-24,_ExitButtonString);
StepCButton.Init(_StepCButtonCode,GetMaxX-252,GetMaxY-22,'LÇpÇsenkÇnt',0);
StepCButton.CBFlag:=StepCButton.CBFlag or 1;
TimeText.Init(0,6,GetMaxY-21);TimeText.Time:=20;
SetTimer(1,1,0,0,Seg(TimeText),Ofs(TimeText));
End;

Procedure ObjectDone;
Begin
SetTimer(1,0,0,0,0,0);
TimeText.Done;
StepCButton.Done;
GoOnButton.Done;
ExitButton.Done;
End;

{****************************************************************************}
{***                   Inicializ†l†s/lez†r†sok                            ***}
{****************************************************************************}

Procedure Init;
Begin
If Init_Video<>0
   then begin WriteLn('Nem sikerÅlt a videom¢d inicializ†l†sa!');Halt;end;
Init_Mouse;
ObjectInit;
End;

Procedure Done;
Begin
ObjectDone;
VideoDone;
End;

{****************************************************************************}
{***                               Fãprogram                              ***}
{****************************************************************************}

Procedure Main;
var I:byte;
Begin
ClearCommandPuffer;I:=0;Q.Init(N);
repeat
      Case I of
           0 : begin end;
           1 : begin CommandCode:=0;GoOnButton.SetKeyFocus;end;
           2 : repeat TObjectProcess until CommandCode<>0;
           3 : Case CommandCode of
                    _GoOnButtonCode : begin
                                      GoOnButton.Disable;
                                      RUN:=True;Q.Start;RUN:=False;
                                      GoOnButton.Enable;
                                      end;
                    end;
           end;
      Inc(I);If I>4 then I:=1;
until CommandCode=_ExitButtonCode;
Q.Done;
End;

{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

BEGIN
Init;
TProcOn;
Main;
TProcOff;
Done;
END.