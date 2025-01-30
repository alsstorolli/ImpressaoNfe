unit ClasseDependencias;

interface

implementation

uses SysUtils, Windows, ActiveX, XMLDoc, XMLDom, XMLIntf, Classes, Forms, Variants, Dialogs;

var DependencyDoc: TXMLDocument;
    ModuleNode,ContNode,ReqNode:IXMLNode;

procedure GetInfoPackage(const Name: String; NameType: TNameType; Flags: Byte; Param: Pointer);
begin
  case NameType of
    ntContainsUnit: begin
      ContNode:=ContNode.AddChild('Unit');
      ContNode.Attributes['name']:=Name;
      ContNode:=ContNode.ParentNode;
    end;
    ntRequiresPackage: begin
      ReqNode:=ReqNode.AddChild('Package');
      ReqNode.Attributes['name']:=Name;
      ReqNode:=ReqNode.ParentNode;
    end;
  end;
end;

function GetInfoModule(HInstance: Longint; Data: Pointer): Boolean;
var Flags: Integer;
    ModulePath, ModuleName:String;
begin
  //Extrai os dados do módulo
  SetLength (ModuleName, 200);
  GetModuleFileName(HInstance,PChar(ModuleName),Length(ModuleName));
  ModulePath:=PChar(ModuleName);
  ModuleName:=ExtractFileName(ModulePath);
  //Cria o nó referente ao módulo atual e adiciona suas propriedades
  ModuleNode:=ModuleNode.AddChild('Module');
  ModuleNode.Attributes['name']:=ModuleName;
  ModuleNode.Attributes['location']:=ModulePath;
  ModuleNode.Attributes['description']:=GetPackageDescription(PChar(ModuleName));
  if Flags and pfDesignOnly=pfDesignOnly then begin
    ModuleNode.Attributes['type']:='DesignTime';
  end;
  if Flags and pfRunOnly=pfRunOnly then begin
    ModuleNode.Attributes['type']:='RumTime';
  end;
  //Cria os nós Contains e Requires
  ContNode:=ModuleNode.AddChild('Contains');
  ReqNode:=ModuleNode.AddChild('Requires');
  //Adiciona informações do pacote
  GetPackageInfo(HInstance,nil,Flags,GetInfoPackage);
  //Retorna ao módulo principal para a adição de um novo filho
  ModuleNode:=ModuleNode.ParentNode;
  Result:=True;
end;

procedure PrepareXMLDoc;
begin
  //Prepara o documento XML
  DependencyDoc:=TXMLDocument.Create(Application);
  DependencyDoc.DOMVendor:=GetDOMVendor('MSXML');
  DependencyDoc.Options:=[doNodeAutoCreate,doAttrNull,doAutoPrefix,doNamespaceDecl];
  DependencyDoc.XML.Clear;
  DependencyDoc.Active:=True;
  DependencyDoc.CreateElement('xml', '');
  DependencyDoc.Version:='1.0';
  DependencyDoc.Encoding:='UTF-8';
  ModuleNode:=DependencyDoc.AddChild('ModulesList');
end;

procedure SaveDependencyFile(Arquivo:String);
begin
  DependencyDoc.SaveToFile(extractfilepath(Arquivo)+'DependencyList.xml');
  DependencyDoc.Destroy;
end;

procedure CopyFiles(const Path: String);
var Cont:Integer;
begin
  if Not(DirectoryExists(Path)) then begin
    CreateDir(Path);
  end;
  for Cont:=1 to ModuleNode.ChildNodes.Count-1 do begin
    CopyFile(PChar(Variants.VarToStr(ModuleNode.ChildNodes[Cont].Attributes['location'])), PChar(Variants.VarToStr(Path + '\' + ModuleNode.ChildNodes[Cont].Attributes['name'])), False);
  end;
end;

function DLLFileName:String;
begin
  SetLength(Result,MAX_PATH);
  GetModuleFileName(HInstance,PCHar(Result),MAX_PATH);
  SetLength(Result,StrLen(PChar(Result)));
end;

initialization
//{$DEFINE packagesdefinition} // para gerar os dados dos pacotes remover o comentário desta linha
{$IFDEF packagesdefinition}
  CoInitialize(nil);
  PrepareXMLDoc;
  EnumModules(TEnumModuleFunc(@GetInfoModule),Nil);
  CopyFiles(ExtractFilePath(DLLFileName)+'Runtime_Packages');
  SaveDependencyFile(DLLFileName);
{$ENDIF}

finalization
  CoUninitialize;

end.
