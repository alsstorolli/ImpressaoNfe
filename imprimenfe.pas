unit imprimenfe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ControllerImpressaoNFe, ACBrDFeReport,
  ACBrBase, ACBrDFe,Winapi.ShellAPI,
  ACBrDFeDANFeReport, ACBrNFeDANFEClass, ACBrNFeDANFeRLClass, ACBrNFe,
  ACBrDANFCeFortesFr, ACBrNFeDANFeESCPOS, ACBrNFCeDANFeFPDF, ACBrNFeDANFeFPDF;

type
  TFImprimeNfe = class(TForm)
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    ACBrNFeDANFeFPDF1: TACBrNFeDANFeFPDF;
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
//     if FileExists( arqlogo ) then ACBrNFeDANFeFPDF1.logo:=arqlogo;
     AcbrNfe1.NotasFiscais.Items[0].Imprimir;
//     AcbrNfe1.NotasFiscais.Items[0].ImprimirPDF;
//     ShellExecute(handle,'open',PChar(ACBrNFeDANFeFPDF1.ArquivoPDF), '','',SW_SHOWMAXIMIZED);

  end;

end;

end.
