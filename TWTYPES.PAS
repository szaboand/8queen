Unit TWTypes;
{****************************************************************************}
{***                                                                      ***}
{***                             TWSZAMLA V1.0a                            ***}
{***                           2001.01.25.-2001.01.25.                    ***}
{***               (C) TwinNet Ltd 1997,2001 (P) Szab¢ Andr s 2001        ***}
{***                        E-mail: szaboand@twinnet.hu                   ***}
{***                    WWW: http://www.twinnet.hu/szaboand               ***}
{***                            All Rights Reserved                       ***}
{***                                                                      ***}
{****************************************************************************}
{***                         Tipusok, konstansok                          ***}
{***                        TURBO PASCAL 7.0 FILE                         ***}
{****************************************************************************}

Interface

Type
 DatumTipus     = record
  Ev         : word;
  Honap      : byte;
  Nap        : byte;
 end;

{****************************************************************************}
{***                      Vev‹ adattipus definici¢k                       ***}
{****************************************************************************}
Const
 VevoAdatSzam           = 18;

 V_AdoSzamHossz         = 13;
 V_AzonositoHossz       = 30;
 V_BankSzamlaSzamHossz  = 26;
 V_NevHossz             = 60;
 V_HelyisegHossz        = 40;
 V_UtcaHossz            = 60;
 V_IrSzamHossz          = 10;
 V_KapcsolatHossz       = 40;
 V_EMailHossz           = 40;
 V_TelefonHossz         = 20;
 V_FaxHossz             = 20;

 FizetesiModSzam        = 5;
 FizetesiMod_KP         = 1;
 FizetesiMod_Atutalas   = 2;
 FizetesiMod_Bankkartya = 3;
 FizetesiMod_Utanvet    = 4;
 FizetesiMod_Egyeb      = 5;
 FizetesiMod_STD        : word          = 2;

 FizetesiNapokSzam      = 6;
 FizNapok_0             = 1;
 FizNapok_8             = 2;
 FizNapok_15            = 3;
 FizNapok_30            = 4;
 FizNapok_60            = 5;
 FizNapok_90            = 6;
 FizNapok_STD           : word          = 2;

 VevoAdatStr : array[1..VevoAdatSzam] of string = (
              'Azonosit¢','N‚v','Helyis‚g','Ir.sz m','Utca',
              'Telefonsz m','Faxsz m','E-Mail cim','Kapcsolat',
              'Ad¢sz m','Banksz mlasz m','Fizet‚si m¢d','Fizet‚si nap',
              'Banki nap','Kedvezm‚nyk¢d','L‚trehoz s','Besorol s','Jegyzet');

 VevoFizetesiModStr : array [1..FizetesiModSzam] of string = (
              'K‚szp‚nz','µtutal s','Bankk rtya','Ut nv‚t','Egy‚b');
 VevoFizetesiNapStr : array [1..FizetesiNapokSzam] of string = (
              '0','8','15','30','60','90');
 VevoFizetesiNapStr2 : string = 'nap';

Type
 VevoTipus      = record
  Azonosito     : string[V_AzonositoHossz];
  Nev           : string[V_NevHossz];
  Helyiseg      : string[V_HelyisegHossz];
  IrSzam        : string[V_IrSzamHossz];
  Utca          : string[V_UtcaHossz];
  Telefon       : string[V_TelefonHossz];
  Fax           : string[V_FaxHossz];
  EMail         : string[V_EMailHossz];
  Kapcsolat     : string[V_KapcsolatHossz];
  Adoszam       : string[V_AdoSzamHossz];
  Bankszamla    : string[V_BankSzamlaSzamHossz];
  FizetesiMod   : byte;
  FizNapok      : word;
  BankiNap      : boolean;
  KedvezmenyKod : word;
  Letrehozas    : DatumTipus;
  Besorolas     : word;
  Jegyzet       : string[255];
 end;

Var
 VevoRecordMeret        : word;

{****************************************************************************}
{***                      T‚tel adattipus definici¢k                      ***}
{****************************************************************************}
Const
 Egyseg_Darab           = 1;
 Egyseg_Doboz           = 2;
 Egyseg_Kilometer       = 3;
 Egyseg_Kilogram        = 4;
 Egyseg_Meter           = 5;
 Egyseg_Ora             = 6;

 AFA_0                  = 0;
 AFA_12                 = 1;
 AFA_25                 = 2;

Type
 TetelTipus      = record
  Cikkszam      : string[20];
  Megnevezes    : string[80];
  VTSZ_SZJ      : string[10];
  Csoport       : word;
  Egyseg        : word;
  EgysegAr      : real;
  AFA           : byte;
  KedvezmenyKod : word;
  Jegyzet       : string[255];
  Letrehozas    : DatumTipus;
 end;

{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

IMPLEMENTATION

{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

BEGIN
VevoRecordMeret:=SizeOf(VevoTipus);
END.