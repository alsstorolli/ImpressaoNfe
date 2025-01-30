unit ClasseMovimento;

interface

uses System.Generics.Collections,
//     ClassePedidoVC,
//     ClassePedidoVD,
     SFZeosDao,
     SFEngine,
     SFZeosQuery,
     ClasseXml,
     StormInterfaces;

type TClasseMovimento=class
  private
    FDao:ISFDAO;
    FEngine:TSFEngine;
//    FCabecalho: TClassePedidoVC;
//    FProdutos: TObjectList<TClassePedidoVD>;
    FXml: TClasseXml;
//    procedure SetCabecalho(const Value: TClassePedidoVC);
//    procedure SetProdutos(const Value: TObjectList<TClassePedidoVD>);
    procedure SetXml(const Value: TClasseXml);
//    procedure SetCabecalho(const Value: TClassePedidoVC);
//    procedure SetProdutos(const Value: TObjectList<TClassePedidoVD>);
  public
    constructor Create(Dao:ISFDao;Engine:TSFEngine);
    destructor Destroy;override;
//    property Cabecalho:TClassePedidoVC read FCabecalho write SetCabecalho;
//    property Produtos:TObjectList<TClassePedidoVD> read FProdutos write SetProdutos;
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
//  FCabecalho:=TClassePedidoVC.Create;
//  FProdutos:=TObjectList<TClassePedidoVD>.Create;
end;

destructor TClasseMovimento.Destroy;
begin
{
  if Assigned(FCabecalho) then
    FreeAndNil(FCabecalho);
  if Assigned(FProdutos) then begin
    FProdutos.Clear;
    FreeAndNil(FProdutos);
  end;
  }
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

{
procedure TClasseMovimento.SetCabecalho(const Value: TClassePedidoVC);
begin
  FCabecalho := Value;
end;
}

procedure TClasseMovimento.SetXml(const Value: TClasseXml);
begin
   FXml:=Value;
end;

end.
