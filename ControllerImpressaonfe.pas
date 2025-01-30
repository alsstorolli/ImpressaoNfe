unit ControllerImpressaonfe;

interface

uses SFEdit,
     System.Generics.Collections,
     SFZeosDao,
     SFEngine,
     SFZeosQuery,
     StormInterfaces,
     System.Generics.Defaults,
     System.SysUtils,
     ClasseMovimento;

type TControllerImpressaoNfe=class
  private
    FDao:ISFDao;
    FEngine:TSFEngine;
    FMovimento:TClasseMovimento;
  public
    constructor Create(Dao:ISFDao;Engine:TSFEngine);
    destructor Destroy;override;
    property Movimento:TClasseMovimento read FMovimento write FMovimento;
    procedure GeraMovimento(Protocolo:String);
end;

implementation


{ TControllerImpressaoNfe }

constructor TControllerImpressaoNfe.Create(Dao: ISFDao; Engine: TSFEngine);
begin
  FDao:=Dao;
  FEngine:=Engine;
  FMovimento:=TClasseMovimento.Create(Dao,Engine);
end;

destructor TControllerImpressaoNfe.Destroy;
begin
  if Assigned(FMovimento) then begin
    FreeAndNil(FMovimento);
  end;
  inherited;
end;

procedure TControllerImpressaoNfe.GeraMovimento(Protocolo: String);
begin
  FMovimento.GeraMovimento(Protocolo);

end;

end.
