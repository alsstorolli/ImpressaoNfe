unit imprimecte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ControllerImpressaocte, ACBrDFeReport,
  ACBrCTeDACTEClass, ACBrCTeDACTeRLClass, ACBrBase, ACBrDFe, ACBrCTe;

type
  TFImprimeCte = class(TForm)
    ACBrCTe1: TACBrCTe;
    ACBrCTeDACTeRL1: TACBrCTeDACTeRL;
  private
    { Private declarations }
    FControllerImpressaoCte:TControllerImpressaoCte;
  public
    { Public declarations }
    procedure Execute(ControllerImpressaoCte:TControllerImpressaoCte);
  end;

var
  FImprimeCte: TFImprimeCte;

implementation

{$R *.dfm}

{ TFImprimeCte }

procedure TFImprimeCte.Execute(ControllerImpressaoCte: TControllerImpressaoCte);
begin
  FControllerImpressaoCte:=ControllerImpressaoCte;
  if Trim( FControllerImpressaoCte.Movimento.Xml.xml )<>'' then begin
     ACBrCTe1.Conhecimentos.LoadFromString(FControllerImpressaoCte.Movimento.Xml.xml);
     acbrCte1.Conhecimentos.GerarCTe;
     ACBrCTeDACTeRL1.MostraPreview:=true;
     AcbrCte1.Conhecimentos.Items[0].Imprimir;
  end;

end;

end.
