unit relatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ControllerImpressaoNfe, ACBrDFeReport,
  ACBrCTeDACTEClass, ACBrCTeDACTeRLClass, ACBrBase, ACBrDFe, ACBrCTe,
  MidasLib;
type
  TFRelatorio = class(TForm)
    ACBrCTe1: TACBrCTe;
    ACBrCTeDACTeRL1: TACBrCTeDACTeRL;
  private
    { Private declarations }
    FControllerImpressaoNfe:TControllerImpressaoNfe;
  public
    { Public declarations }
    procedure Execute(ControllerImpressaoNfe:TControllerImpressaoNfe);
  end;

var
  FRelatorio: TFRelatorio;

implementation

{$R *.dfm}

{ TFImprimeCte }

procedure TFRelatorio.Execute(ControllerImpressaoNfe: TControllerImpressaoNfe);
begin
  FControllerImpressaoNfe:=ControllerImpressaoNfe;
  if Trim( FControllerImpressaoNfe.Movimento.Xml.xml )<>'' then begin
     ACBrCTe1.Conhecimentos.LoadFromString(FControllerImpressaoNfe.Movimento.Xml.xml);
     acbrCte1.Conhecimentos.GerarCTe;
     ACBrCTeDACTeRL1.MostraPreview:=true;
     AcbrCte1.Conhecimentos.Items[0].Imprimir;
  end;

end;

end.
