unit ClasseMovimento;

interface

uses System.Generics.Collections,
     SFZeosDao,
     SFEngine,
     SFZeosQuery,
     ClasseXml,
     StormInterfaces;

type TClasseMovimento=class
  private
    FDao:ISFDAO;
    FEngine:TSFEngine;
    FXml: TClasseXml;
    procedure SetXml(const Value: TClasseXml);
  public
    constructor Create(Dao:ISFDao;Engine:TSFEngine);
    destructor Destroy;override;
    property xml:TClasseXml read Fxml write Setxml;
    procedure GeraMovimento(Protocolo:String);
end;

implementation

uses
  System.SysUtils,
  SFFunc;

{ TClasseMovimento }

constructor TClasseMovimento.Create(Dao:ISFDao;Engine:TSFEngine);
begin
  FDao:=Dao;
  FEngine:=Engine;
  FXml:=TClassexml.create;
end;

destructor TClasseMovimento.Destroy;
begin
  if Assigned(FXml) then
    FreeAndNil(FXml);
  inherited;
end;

procedure TClasseMovimento.GeraMovimento(Protocolo: String);
var Query:ISFQuery;
begin
  Query:=FDao.Fields('nfex_xml')
             .From('nfexml')
             .Where('nfex_protocolo='+Func.AddQuote(Protocolo))
             .ExecQuery;
  FXml.xml:='';
  if not Query.isempty then FXml.xml:=Query.GetString('nfex_xml');
  Query.Close;
end;


procedure TClasseMovimento.SetXml(const Value: TClasseXml);
begin
   FXml:=Value;
end;

end.
