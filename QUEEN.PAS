{$A+,B-,D+,E+,F+,G+,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 32768,0,655360}
Unit Queen;
{*****************************************************************************
******************************************************************************
*                        Queen Unit 1.0a Verzi¢                              *
*                       1998.11.05. - 1999.04.25.                            *
*                       (P) Szab¢ Andr†s 1984-98                             *
******************************************************************************
*****************************************************************************}

Interface

{****************************************************************************}
{***                              Konstansok                              ***}
{****************************************************************************}

Const
 C_MaxN                   = 32;           { Max 32x32 t†bla                  }

{****************************************************************************}
{***                             T°pusok                                  ***}
{****************************************************************************}

Type
 T_TType                  = array [1..C_MaxN] of byte;

{****************************************************************************}
{***                          Objektumok                                  ***}
{****************************************************************************}

 O_QueenType             = object
 private
  TLX        : T_TType;                   { Sorozatok elemsz†ma              }
  TLY        : array [1..C_MaxN] of byte; { KeresÇsi vektor                  }
  Function    _NemUt(J:Byte):Boolean;     { ötÇsvizsg†lat fÅggvÇny           }
  Function    _RosszEset:Boolean;         { Rossz eset?                      }
  Function    _JoEsetKeres:Boolean;       { J¢ eset keresÇse                 }
  Procedure   _Kereses;                   { KeresÇsi elj†r†s                 }
  Procedure   _QInit;                     { Inicializ†l†s                    }
 public
  QN         : byte;                      { N db kir†lynã                    }
  TX         : T_TType;                   { Aktu†lis keresÇsi vektor         }
  CI         : byte;                      { Melyik oszlopot vizsg†ljuk       }
  MSzam      : word;                      { Megold†sok sz†ma                 }
  ME         : byte;                      { Melyikkel prob†lkozik            }
  QueenExit  : boolean;                   { KilÇpÇs                          }
  ShowQueen  : boolean;                   { L†that¢                          }
  Procedure   Start;                             { KeresÇs ind°t†sa          }
  Constructor Init(NN:byte);                     { Objektum inicializ†l†s    }
  Destructor  Done;                              { Objektum lez†r†s          }
  Procedure   Hide;virtual;                      { EltÅntetã elj†r†s         }
  Procedure   Show;virtual;                      { Megjelen°tã elj†r†s       }
  Procedure   Found;virtual;                     { Tal†lt egy megold†st      }
  Procedure   Process;virtual;                   { Cikluson belÅli elj†r†s   }
 end;


{****************************************************************************}
{***                               V†ltoz¢k                               ***}
{****************************************************************************}


{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

Implementation

{****************************************************************************}
{***                   Eigth Queen backtrack elj†r†sok                    ***}
{****************************************************************************}

Function O_QueenType._NemUt(J:Byte):Boolean;
Begin
_NemUt:=True;
If (ME = TLX[J]) Or (Abs(CI-J) = Abs(ME-TLX[J])) then _NemUt:=False;
End;

Function O_QueenType._RosszEset:Boolean;
Var J:byte;
Begin
J:=1;While (J<CI) and (_NemUt(J)) do Inc(J);
_RosszEset:=J<CI;
End;

Function O_QueenType._JoEsetKeres:Boolean;
Begin
TX:=TLX;If ShowQueen then Hide;ME:=TLX[CI]+1;TX[CI]:=ME;
If ShowQueen then Show;Process;
While (ME<=TLY[CI]) and (_RosszEset) and (not QueenExit)
      do begin
         If ShowQueen then Hide;Inc(ME);TX[CI]:=ME;
         If ShowQueen then Show;Process;
         end;
_JoEsetKeres:=(ME<=TLY[CI]);
End;

Procedure O_QueenType._Kereses;
Begin
While (CI>=1) and (not QueenExit)
      do begin
         If CI>QN then begin Dec(CI);Inc(MSzam);Found;end;
         If not QueenExit
            then If _JoEsetKeres
                    then begin TLX[CI]:=ME;Inc(CI);end
                    else begin TLX[CI]:=0;Dec(CI);end;
         end;
End;

Procedure O_QueenType._QInit;
var J:word;
Begin
CI:=1;MSzam:=0;ME:=0;QueenExit:=False;
For J:=1 to QN do begin TLX[J]:=0;TLY[J]:=QN;end;
End;

Constructor O_QueenType.Init(NN:byte);
Begin
QN:=NN;ShowQueen:=True;_QInit;
End;

Destructor O_QueenType.Done;
Begin
End;

Procedure O_QueenType.Start;
Begin
_QInit;_Kereses;
End;

{****************************************************************************}

Procedure O_QueenType.Show;
Begin
End;

Procedure O_QueenType.Hide;
Begin
End;

Procedure O_QueenType.Found;
Begin
End;

Procedure O_QueenType.Process;
Begin
End;

{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

BEGIN
END.