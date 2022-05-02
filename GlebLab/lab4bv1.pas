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
procedure graph(mx,my:integer); forward;


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



procedure graph(mx,my:integer);

var y1,m: integer;
    cache: real;
    start,stop : real;
begin
        winch:=' ';
         
        while winch <> #27 do
        begin
                if my < 0 then my := my+10;
                if mx < 0 then mx := mx + 1;
                ClearDevice;
                // INFO hotkeys
                OutTextXY(100,100,'zoom -x - RightArrow');
                OutTextXY(100,120,'zoom +x -LeftArrow');
                OutTextXY(100,140,'zoom -y - UpArrow');
                OutTextXY(100,160,'zoom +y -DownArrow');
                OutTextXY(100,180,'zoom +x +y -+');
                OutTextXY(100,200,'zoom -x -y --');
                // Вывод основной информации на график
                 OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 - 20,'f(x)=2x^3-2x^2+x');
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2,'Absolute error:');
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 + 20,'Relative error:');
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 + 40,'Interval:');
                 // обозначение осей,точки 0
                 OutTextXY(GetMaxX-20,y0-20,'X');
                 OutTextXY(x0+20,20,'Y');
                 OutTextXY(x0-20,y0+10,'0');
                Line(0, y0, GetMaxX-20, y0); //Ox
                Line(x0, 20, x0, GetMaxY); //Oy
                for i := 1 to 5 do 
                begin
                        // Засечки,деления,скейл,сжатие,расстяжение OX
                        Line(x0+round((GetMaxX div 12)*i), y0-3, x0+round((GetMaxX div 12)*i), y0+3);
                        Line(x0-round((GetMaxX div 12)*i), y0-3, x0-round((GetMaxX div 12)*i), y0+3);
                        str((dx*i)+mx, s);
                        OutTextXY(x0+(GetMaxX div 12)*i+5, y0+10, s);
                        str(-mx+-1*dx*i, s);
                        OutTextXY(x0-(GetMaxX div 12)*i+5, y0+10, s);
                end;
                for i := 1 to 10 do 
                begin
                // Засечки,деления,скейл,сжатие,расстяжение OY
                 Line(x0-3, y0-(GetMaxY div 20)*i, x0+3, y0-(GetMaxY div 20)*i);
                 Line(x0-3, y0+(GetMaxY div 20)*i, x0+3, y0+(GetMaxY div 20)*i);
                 str(my+dy*i, s);
                 OutTextXY(x0-60, y0+(GetMaxY div 20)*-i, s);
                 str(-my+-1*dy*i, s);
                 OutTextXY(x0-60, y0-(GetMaxY div 20)*-i, s);
                end;
                // График
               
                SetColor(15);
                winch:=wincrt.readkey;
                if winch=#0 then y1:=1;
                case winch of
                #75: if y1=1 then graph(mx-1,my); // +zoomX
                #77: if y1=1 then graph(mx+1,my); // -zoomX
                #72: if y1=1 then graph(mx,my+10); // -zoomY
                #80: if y1=1 then graph(mx,my-10); // +zoomY
                #43: graph(mx+1,my+10);
                #45: graph(mx-1,my-10);
                #49: gflag := not gflag;
                end;
        end;
        CloseGraph;
end;

procedure IntGraph;

begin
        // убрать на релизе
        flag := true;
        a := 0; b := 5; m2 := 10;
        // всё что между этими строчками
        if flag=false then point1;
        dx:=1;
        dy:=10;
        gd:=detect;
        gm:=0;
        InitGraph(gd, gm, '');
        y0:=GetMaxY div 2;
        x0:=GetMaxX div 2;
        gflag:=false;
        graph(0,0);
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
