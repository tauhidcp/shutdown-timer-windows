unit Timer;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DateUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label5: TLabel;
    Label6: TLabel;
    Timer1: TTimer;
    Label1: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    RadioGroup1: TRadioGroup;
    procedure Button3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  waktu : integer;

implementation

uses Math;

{$R *.lfm}

procedure TForm1.Button3Click(Sender: TObject);
begin
  ShowMessage('Terima Kasih Telah Menggunakan Aplikasi Ini');
  Application.Terminate;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in [#8, '0'..'9']) then
     Key := #0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Label4.Caption:=TimeToStr(time);
  waktu:=waktu-1;
  if waktu=0 then
    begin
      case radiogroup1.ItemIndex of
        0 : ExecuteProcess('c:\windows\system32\cmd.exe', ['/c','shutdown -s -t 0 -f']);
        1 : ExecuteProcess('c:\windows\system32\cmd.exe', ['/c','shutdown -r -t 0 -f']);
      end;
    end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Button2.Enabled:=false;
  Edit1.SetFocus;
  Timer1.Enabled:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  menit : integer;
begin
if (edit1.Text='') or (ComboBox1.Text='-Pilih-') or (RadioGroup1.ItemIndex = -1) then
  begin
    ShowMessage('Isi Waktu Eksekusi dan Centang Salah Satu Pilihan!!');
    Abort;
    edit1.SetFocus;
  end
  else begin
    waktu:=strtoint(edit1.Text);
    edit1.Enabled:=false;
    combobox1.Enabled:=false;
    radiogroup1.Enabled:=false;
    button1.Enabled:=false;
    Button2.Enabled:=true;
    timer1.Enabled:=true;

    case combobox1.ItemIndex of
      0: waktu:=waktu*60;
      1: waktu:=waktu*360;
    end;

    if ComboBox1.Text='Menit' then menit := StrToInt(Edit1.Text) else
    if ComboBox1.Text='Jam' then menit := StrToInt(Edit1.Text)*60;

    Label6.Caption:=TimeToStr(IncMinute(Time,menit));
   end;
 end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Label6.Caption:='00:00';
  Label4.Caption:='00:00';
  timer1.Enabled:=false;
  edit1.Enabled:=true;
  combobox1.Enabled:=true;
  radiogroup1.Enabled:=true;
  Button2.Enabled:=false;
  button1.Enabled:=true;
end;

end.
