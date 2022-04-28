uses crt;

var ch: char;

begin
    while ch <> #27 do
    begin
        ch:=readkey;
        writeln('Key ', ch, ' = ', ord(ch));
    end;
end.