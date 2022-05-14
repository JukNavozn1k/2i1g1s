uses    wincrt, crt, math, graph;
const 
    unsel=LightGray;
    sel=Green;
    n=5;
var menu:array[1..n] of string;
    point,x,y,m,x0,y0,i,gd,gm: integer;
    ch,winch: char; 
    h,a,b,m2,E,RE,S1,S2,dx,dy: real; 
    flag,check,gflag: boolean;
    s,area_str,interval_string,absolute_error_str,relative_error_str,temp_str: string;
procedure graph(); forward;

procedure print_func;

begin
        write('f(x)=X^3+0*x^2+4*x+11');
end;

function fx(x: real): real;

begin
    fx:=x*x*x+4*x+11;
end;

function f(l: real): real;

begin
    f:=power(l,4)/4+2*power(l,2)+11*l;
end;

function LT(a,b: real; m: integer): real;

var     i: integer;
        s,l: real;

begin
    s:=0;
    l:=a;
    h:=(b-a)/m;
    for i:=0 to m-1 do
    begin
        s:=s+power(l,3)+0*power(l,2)+4*l+11;
        l:=l+h;
    end;
    LT:=s*h;
end;

procedure point1;

var     i: integer;

begin
    i:=1;
    y:=5;
    check:=false;
    clrscr;
    print_func;
    repeat
        gotoxy(10,y);
        writeln('���� ������');
        gotoxy(10,y+i);
        i:=i+1;
        a:=-1.64240517074131;
        while a < -1.64240517074131 do 
        begin
            write('������� ������ ����� (a >= -1.64): ');
            read(a);
            gotoxy(10,y+i);
            i:=i+1;
            end;
            b:=a-1;
            while (b < a) do begin
                write('������� ������ ����� (b > a ): ');
                read(b);
                gotoxy(10,y+i);
                i:=i+1;    
            end;
            check:=true
        until check=true;
            write('������� ���-�� ����� [1;32767]: ');
            readln(m2);
        while (m2 <> trunc(m2)) or (m2 < 1) or (m2 > 32767) do
        begin
            gotoxy(10,y+i);
            i:=i+1;
            writeln('����� ������ ���� ����� � [1;32767]');
            gotoxy(10,y+i);
            i:=i+1;
            write('������� ���-�� ����� [1;32767]: ');
            read(m2);  
        end;
        m:=trunc(m2);
            str(a:0:1,temp_str);
            interval_string:='Interval: [' + temp_str + ';';
            str(b:0:1,temp_str);
            interval_string:=interval_string + temp_str + ']';
            S1:=f(b)-f(a);
            S2:=LT(a,b,m);
            E:=S2-S1;
            RE:=abs(E/S1)*100;
            str(E:0:2,temp_str);
            absolute_error_str:='���������� �����������: ' + temp_str;
            str(RE:0:2,temp_str);
            relative_error_str:='������������� �����������: ' + temp_str + '%';
            str(S2:0:2,temp_str);
            area_str:='���������: ' + temp_str; 
    flag:=true;
end;

procedure point2;

begin
    if flag <> true then
        point1;
    clrscr;
    print_func;
    gotoxy(10,5);
    write(area_str);
    writeln();
    gotoxy(10,6);
    writeln(absolute_error_str);
    gotoxy(10,7);
    writeln(relative_error_str);
    gotoxy(10,8);
    write('������� ����� ������� ��� ������ � ������� ����');
    readln();
end;

procedure point4;

begin
    clrscr;
    gotoxy(10,5);
    writeln('��������� ��������� ������� ������ ���� y=0 ������������ ������ � ������� � ������ �� ������������ �������� � ������������ ��� ��������������� ��� �� ��������� ����, ��� � ���� ������.');
    gotoxy(10,6);
    write('������� ����� ������� ��� ������ � ������� ���� ');
    readln;
end;



procedure graph();

var y1,sx,sy: integer;
    x,y: real;
begin
    winch:=' ';   
    while winch <> #27 do
    begin
        if dy <= 0 then dy := dy + 10;
        if dx <= 0 then dx := dx + 1;
        ClearDevice;
        OutTextXY(GetMaxX-250,100,'Zoom out x-axis -> RightArrow');
        OutTextXY(GetMaxX-250,120,'Zoom x-axis -> LeftArrow');
        OutTextXY(GetMaxX-250,140,'Zoom out y-axis -> UpArrow');
        OutTextXY(GetMaxX-250,160,'Zoom y-axis -> DownArrow');
        OutTextXY(GetMaxX-250,180,'Zoom out x-axis and y-axis -> +');
        OutTextXY(GetMaxX-250,200,'Zoom x-axis and y-axis -> -');
        OutTextXY(GetMaxX-250,220,'Shade area -> 1');
        OutTextXY(GetMaxX-250,240,'f(x)=X^3+0*x^2+4*x+11');
        OutTextXY(GetMaxX-250,260,area_str);
        OutTextXY(GetMaxX-250,280,absolute_error_str);
        OutTextXY(GetMaxX-250,300,relative_error_str);
        OutTextXY(GetMaxX-250,320,'Absolute error:');
        OutTextXY(GetMaxX-250,340,'Relative error:');
        OutTextXY(GetMaxX-250,360,interval_string);
        OutTextXY(GetMaxX-20,y0-20,'X');
        OutTextXY(x0+20,20,'Y');
        OutTextXY(x0-20,y0+10,'0');
        Line(0, y0, GetMaxX-20, y0); //Ox
        Line(x0, 20, x0, GetMaxY); //Oy
        sx:=GetMaxX div 24;
        sy:=GetMaxY div 24;
        for i := 1 to 22 do
        begin
            Line(x0+round(sx*i), y0-3, x0+round(sx*i), y0+3);
            Line(x0-round(sx*i), y0-3, x0-round(sx*i), y0+3);
            str((dx*i):0:0, s);
            OutTextXY(x0+sx*i+5, y0+10, s);
            str(-1*dx*i:0:0, s);
            OutTextXY(x0-sx*i+5, y0+10, s);
            Line(x0-3, y0-sy*i, x0+3, y0-sy*i);
            Line(x0-3, y0+sy*i, x0+3, y0+sy*i);
            str(dy*i:0:0, s);
            OutTextXY(x0-60, y0+sy*-i, s);
            str(-1*dy*i:0:0, s);
            OutTextXY(x0-60, y0-sy*-i, s);
        end;
        SetColor(12);
        x:=-1.64240517074131;
        y:=0;
        while x < x0 do 
        begin 
            if (round(y0-sy*(y/(dy))) > -1.64240517074131) then
            begin
                PutPixel(x0+round(sx*(x/(dx))),round(y0-sy*(y/(dy))),12);
            end;
            if (x >= a-0.00001) and (x <= b+0.00001) and gflag then 
            begin
                SetColor(2);
                if (round(y0-sy*(y/(dy))) < 0) then Line(x0+round(sx*(x/(dx))),y0,x0+round(sx*(x/(dx))),0)
            else 
                Line(x0+round(sx*(x/(dx))),y0,x0+round(sx*(x/(dx))),round(y0-sy*(y/(dy))));
                SetColor(12);
            end;
            x:=x+0.01;
            y:=fx(x);
        end;
        SetColor(15);
        winch:=wincrt.readkey;
        if winch=#0 then y1:=1;
        case winch of
        #75: if y1=1 then dx:=dx-1; // +zoomX
        #77: if y1=1 then dx:=dx+1; // -zoomX
        #72: if y1=1 then dy:=dy+10; // -zoomY
        #80: if y1=1 then dy:=dy-10; // +zoomY
        #43: begin dx:=dx+1; dy:=dy+1; end; // +zoomBoth
        #45: begin dx:=dx-1;dy:=dy-1; end; // -zoomBoth
        #49: gflag:=not gflag;
        end;
    end;
    CloseGraph;
end;

procedure IntGraph;

begin
       
    if flag=false then point1;
    dx:=1;dy:=10;
    gd:=detect;
    gm:=0;
    InitGraph(gd, gm, '');
    y0:=GetMaxY - 50;
    x0:=GetMaxX div 10;
    gflag:=false;
    graph();
end;

procedure printmenu;

var i:integer;

begin
    clrscr;
    print_func;
    for i:=1 to n do
    begin
        gotoxy(x,y+i-1);
        write(menu[i]);
    end;
    textattr:=sel;
    gotoxy(x,y+point-1);
    write(menu[point]);
    textattr:=unsel;
end;

begin
    menu[1]:='���� ������';
    menu[2]:='��������� ����������';
    menu[3]:='������';
    menu[4]:='� ���������';
    menu[5]:='�����';
    point:=1;
    x:=10;
    y:=5;
    textattr:=unsel;
    printmenu;
    repeat
        ch:=readkey;
        if ch=#0 then
        begin
                ch:=readkey;
                case ch of
                #80:
                    if point < n then
                    begin
                        gotoxy(x,y+point-1);
                        write(menu[point]);
                        point:=point+1;
                        textattr:=sel;
                        gotoxy(x,y+point-1);
                        write(menu[point]);
                        textattr:=unsel;
                    end;
                #72:
                    if point > 1 then
                    begin
                        gotoxy(x,y+point-1);
                        write(menu[point]);
                        point:=point-1;
                        textattr:=sel;
                        gotoxy(x,y+point-1);
                        write(menu[point]);
                        textattr:=unsel;
                    end;
                end;
            end
            else
                if ch=#13 then
                begin
                    case point of
                    1: point1;
                    2: point2;
                    3: IntGraph;
                    4: point4;
                    5: ch:=#27;
                end;
            printmenu;
        end;
    until ch=#27;
    clrscr;
end.