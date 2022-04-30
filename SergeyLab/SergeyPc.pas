uses crt;
procedure arrowkeytest;
    var ch: char;
    y1: integer;
        begin
            while ch <> #27 do
            begin
                ch:=readkey;
                if (ch = #75) and (y1 = 1) then
                   writeln('лево') //graph(mx-1,my); 
                else
                    if (ch = #77) and (y1 = 1) then
                    writeln('право')    //graph(mx+1,my)
                    else
                        if (ch = #72) and (y1 = 1) then
                        writeln('вверх')  //graph(mx,my+1); 
                        else
                            if (ch = #80) and (y1 = 1) then
                            writeln('вниз')  //graph(mx,my-1);
                            else
                                if (ch = #43) then
                                writeln('+')  //graph(mx+1,my+1);
                                else
                                    if (ch = #45) then
                                    writeln('-')  //graph(mx-1,my-1);
                        else
                        write('неподходящий символ');
                y1 := 0;
                    if ch = #0 then y1 := 1;

            end;
        end.
