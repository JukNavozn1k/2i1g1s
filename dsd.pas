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
        divisor: integer;

procedure graph(mx,my: integer); forward;


procedure print_func;

begin
        write('f(x)=2x^3-2x^2+x');
end;
function fx(x: real): real;

begin
        fx:=2*x*x*x - 2*x*x + x*x;
end;
function f(x: real): real;

begin
        f:=(x*x*x*x)/2 - (x*x*x)*(2/3) + (x*x)/2;
end;


function LT(a,b: real; n: integer): real;

 var
s,h1,x:real;
i:integer;
begin
 s := 0;
 h1 := (b-a) / n;
 for i := 1 to n do
  begin
   s := s+h1*fx(a+i*h1);
   if s < 0 then
    s := 0;
  end;
 LT := s;
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
                writeln('Ввод данных');
                gotoxy(10,y+i);
                i:=i+1;
                a := -1;
                while a < 0 do begin
                write('Введите первую точку (a >= 0): ');
                read(a);
                gotoxy(10,y+i);
                i:=i+1;
                end;
                gotoxy(10,y+i);
                i:=i+1;
                b := -1;
                while (b <= a) do begin
                write('Введите вторую точку (b > a ): ');
                read(b);
                gotoxy(10,y+i);
                i:=i+1;
                end;
                 gotoxy(10,y+i);
                i:=i+1;
                check:=true
        until check=true;
                write('Введите кол-во шагов (от 1 до 32767): ');
                readln(m2);
        while (m2 <> trunc(m2)) or (m2 < 1) or (m2 > 32767) do
        begin
                gotoxy(10,y+i);
                i:=i+1;
                writeln('Число должно быть целым и [1;32767]');
                gotoxy(10,y+i);
                i:=i+1;
                write('Введите шаг (от 1 до 32767): ');
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
        // s1-s2 абсолютная 
        S1:=f(b)-f(a);
        S2:=LT(a,b,m);
        E:=S2-S1;
        print_func;
        gotoxy(10,5);
        write('Результат: ');
        writeln(S2:5:2);
        gotoxy(10,6);
        writeln('Абсолютная погрешность: ', E:0:2);
        gotoxy(10,7);
        writeln('Относительная прогрешность: ', abs((E/S1)*100):0:2, '%');
        gotoxy(10,8);
        write('Нажмите любую клавишу для выхода в главное меню');
        readln();
end;

procedure point4;

begin
        clrscr;
        gotoxy(10,5);
        writeln('Программа вычисляет площадь фигуры выше y=0 ограниченную кривой и выводит её график на координатную плосость с возможностью его масштабирования как по отдельным осям, так и всем вместе.');
        gotoxy(10,6);
        write('Нажмите клавишу <Enter> для выходв в главное меню ');
        readln;
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
                // INFO hotkeys
                OutTextXY(100,100,'scale +x - RightArrow');
                OutTextXY(100,120,'scale -x -LeftArrow');
                OutTextXY(100,140,'scale +y - UpArrow');
                OutTextXY(100,160,'scale -y -DownArrow');
                OutTextXY(100,180,'scale +x +y -*');
                 OutTextXY(100,200,'scale -x -y -/');
                 // обозначение осей
                 OutTextXY(GetMaxX-20,y0-20,'X');
                  OutTextXY(x0+20,20,'Y');
                Line(0, y0, GetMaxX-20, y0); //Ox
                Line(x0, 20, x0, GetMaxY); //Oy
                for i:=1 to 100 do
                begin
                        // P.S сделать ограничения нормальные (метод научного тыка)
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
                #75: if y1=1 then graph(mx-1,my); // лево
                #77: if y1=1 then graph(mx+1,my); // право
                #72: if y1=1 then graph(mx,my+1); // вверх
                #80: if y1=1 then graph(mx,my-1); // вниз
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
        menu[1]:='Ввод данных';
        menu[2]:='Результат вычислений';
        menu[3]:='График';
        menu[4]:='О программе';
        menu[5]:='Выход';
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
