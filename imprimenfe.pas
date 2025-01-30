unit imprimenfe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ControllerImpressaoNFe, ACBrDFeReport,
  ACBrBase, ACBrDFe,
  ACBrDFeDANFeReport, ACBrNFeDANFEClass, ACBrNFeDANFeRLClass, ACBrNFe;

type
  TFImprimeNfe = class(TForm)
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
  private
    { Private declarations }
    FControllerImpressaoNfe:TControllerImpressaoNfe;
  public
    { Public declarations }
    procedure Execute(ControllerImpressaoNfe:TControllerImpressaoNfe);
  end;

var
  FImprimeNfe: TFImprimeNfe;

implementation

{$R *.dfm}

{ TFImprimeNfe }

procedure TFImprimeNfe.Execute(ControllerImpressaoNfe: TControllerImpressaoNfe);
var arqlogo:string;
begin
  FControllerImpressaoNfe:=ControllerImpressaoNfe;
  if Trim( FControllerImpressaoNfe.Movimento.Xml.xml )<>'' then begin
     ACBrNFe1.NotasFiscais.LoadFromString(FControllerImpressaoNfe.Movimento.Xml.xml);
     acbrNfe1.NotasFiscais.GerarNFe;
     ACBrNFeDANFeRL1.MostraPreview:=true;
     arqlogo:=ExtractFilePath(Application.ExeName)+'\logo.png';
     if FileExists( arqlogo ) then ACBrNFeDANFeRL1.logo:=arqlogo;
     AcbrNfe1.NotasFiscais.Items[0].Imprimir;
  end;

end;

end.
