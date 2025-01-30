unit ClasseXml;

interface

type TClassexml=class
     private
     Fxml:widestring;
     procedure SetXml(const Value: WideString);
     public
     property xml:WideString read Fxml write Setxml;
end;

implementation

{ TClassexml }

procedure TClassexml.SetXml(const Value: WideString);
begin
   FXml := value;
end;

end.
