uses    wincrt, crt, math, graph;
const 
        unsel=LightGray;
        sel=Green;
        n=5;
var     menu:array[1..n] of string;
        point,x,y,m,d,x0,y0,i,dx,dy,gd,gm,mx,my, lim: integer;
        ch,winch: char;
        h,a,b,m2,x1,E,S1,S2: real;
        flag,check,gflag: boolean;
        s: string;

procedure graph(mx,my: integer); forward;

procedure print_func;

begin
        write('f(x)=X^3+0*x^2+4*x+11');
end;

function f(l: real): real;

begin
        f:=power(l,4)/4+2*power(l,2)+11*l;
end;

function LT(a,b: real; m: integer): real;

var     i: integer;
        s,l: real;

begin
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
                writeln('???? ??????');
                gotoxy(10,y+i);
                i:=i+1;
                write('??????? ?????? ?????: ');
                read(a);
                if (a < -1.64240517074131) then a:=-1.64240517074131;
                gotoxy(10,y+i);
                i:=i+1;
                write('??????? ?????? ?????: ');
                read(b);
                if (b < -1.64240517074131) then b:=-1.64240517074131;
                gotoxy(10,y+i);
                i:=i+1;
                if b < a then
                        writeln('?????? ????? ?????? ???? ?????? ???????')
                else
                        check:=true
        until check=true;
                write('??????? ???-?? ????? (?? 1 ?? 32767): ');
                readln(m2);
        while (m2 <> trunc(m2)) or (m2 < 1) do
        begin
                gotoxy(10,y+i);
                i:=i+1;
                writeln('????? ?????? ???? ????? ? ?????? 0!');
                gotoxy(10,y+i);
                i:=i+1;
                write('??????? ??? (?? 1 ?? 32767): ');
                read(m2);
        end;
        m:=trunc(m2);
        flag:=true;
end;

procedure point2;

begin
        if flag <> true then
                point1;
        clrscr;
        S1:=f(b)-f(a);
        S2:=LT(a,b,m);
        E:=S1-S2;
        print_func;
        gotoxy(10,5);
        write('?????????: ');
        writeln(S2:5:2);
        gotoxy(10,6);
        writeln('?????????? ???????????: ', E:5:2);
        gotoxy(10,7);
        writeln('????????????? ????????????: ', (E/S1)*100:5:0, '%');
        gotoxy(10,8);
        write('??????? ????? ??????? ??? ?????? ? ??????? ????');
        readln();
end;

procedure point4;

begin
        clrscr;
        gotoxy(10,5);
        writeln('????????? ????????? ??????? ?????? ???? y=0 ???????????? ?????? ? ??????? ? ?????? ?? ???????????? ???????? ? ???????????? ??? ??????????????? ??? ?? ????????? ????, ??? ? ???? ??????.');
        gotoxy(10,6);
        write('??????? ??????? <Enter> ??? ?????? ? ??????? ???? ');
        readln;
end;

function fx(x: real): real;

begin
        fx:=x*x*x+4*x+11;
end;

procedure graph(mx,my: integer);

var y1,m: integer;
    cache: real;

begin
        winch:=' ';
        if mx > my then m:=mx else m:=my;
        if mx > 30000 then mx := mx -1;
        if mx < 30 then mx := mx + 1;
        if my > 30000 then my := my -1;
        if my < 1 then my := my + 1;
        while winch <> #27 do
        begin
                ClearDevice;
                Line(0, y0, GetMaxX-20, y0); //Ox
                Line(x0, 20, x0, GetMaxY); //Oy
                for i:=1 to 100 do
                begin
                        // P.S ??????? ??????????? ?????????? (????? ???????? ????)
                        Line(x0+round(mx*i), y0-3, x0+round(mx*i), y0+3);
                        Line(x0-3, y0-round(my*i*10), x0+3, y0-round(my*i*10));
                        str(dx*i, s);
                        OutTextXY(x0+mx*i+5, y0+10, s);
                        if i > 0 then
                        begin
                                str(dy*i, s);
                                OutTextXY(x0-60, y0+my*10*(-i), s);
                         end;
                end;
                x1:=a;
                cache := a;
                while x1 <= b-0.001 do
                begin
                         SetColor(12);
                        PutPixel(x0+round(x1*mx), (y0-round(fx(x1)*my)), 12);
                        
                       if (((x1-cache) >= round(abs(b-a)/m2)) and gflag and (x1 <= b)) or ((x1 = a) and gflag)  then begin
                       SetColor(2);
                       Line(x0+round(x1*mx),(y0-round(fx(x1)*my)),x0+round(x1*mx),y0);
                       cache := x1;
                       end;
                        x1:=x1+0.01;
                        end;
                if gflag then begin
                SetColor(2);
                Line(x0+round(x1*mx),(y0-round(fx(x1)*my)),x0+round(x1*mx),y0);
                end;
                SetColor(15);
                winch:=wincrt.readkey;
                if winch=#0 then y1:=1;
                case winch of
                #75: if y1=1 then graph(mx-1,my); // ????
                #77: if y1=1 then graph(mx+1,my); // ?????
                #72: if y1=1 then graph(mx,my+1); // ?????
                #80: if y1=1 then graph(mx,my-1); // ????
                #43: graph(mx+1,my+1);
                #45: graph(mx-1,my-1);
                #49: gflag := not gflag;
                end;
        end;
        CloseGraph;
end;

procedure IntGraph;

begin
        if flag=false then point1;
        dx:=1;
        dy:=10;
        gd:=detect;
        gm:=0;
        InitGraph(gd, gm, '');
        y0:=GetMaxY div 2;
        x0:=GetMaxX div 2;
        gflag:=false;
        graph(40,5);
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
        menu[1]:='???? ??????';
        menu[2]:='????????? ??????????';
        menu[3]:='??????';
        menu[4]:='? ?????????';
        menu[5]:='?????';
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