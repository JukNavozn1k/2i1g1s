uses    wincrt, crt, math, graph;
const 
        unsel=LightGray;
        sel=Green;
        n=5;
var     menu:array[1..n] of string;
        point,x,y,m,d,x0,y0,i,gd,gm,mx,my, lim: integer;
        ch,winch,tmpW: char; 
        h,a,b,m2,x1,E,RE,S1,S2,dx,dy: real; 
        flag,check,gflag,isGood: boolean;
        s,area_str,interval_string,absolute_error_str,relative_error_str,temp_str: string;
procedure graph(); forward;

// Вывод функции
procedure print_func;

begin
        write('f(x)=2x^3-2x^2+x');
end;
// Функция
function fx(x: real): real;

begin
        fx:=2*x*x*x - 2*x*x + x*x;
end;
// Первообразная функции
function f(x: real): real;

begin
        f:=(x*x*x*x)/2 - (x*x*x)*(2/3) + (x*x)/2;
end;

// Метод симпсона - метод вычисления площади
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
                while (a < 0) or (a >= 10) do begin
                write('Введите первую точку (a >= 0) и (a < 10): ');
                read(a);
                gotoxy(10,y+i);
                i:=i+1;
                end;
                gotoxy(10,y+i);
                i:=i+1;
                b := -1;
                while (b <= a) or (b >10) do begin
                write('Введите вторую точку (b > a ) и (b <= 10): ');
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
        
                // СТРОКА ИНТЕРВАЛА
                str(a:0:1,temp_str);
                interval_string := 'Interval: [' + temp_str + ';';
                str(b:0:1,temp_str);
                interval_string := interval_string + temp_str + ']';
                // ПОДСЧЁТ ПОГРЕШНОСТЕЙ, ВЫВОД В СТРОКУ
                 S1:=f(b)-f(a);
                 S2:=LT(a,b,m);
                 E:=S2-S1;
                 RE := abs(E/S1)*100;
                 str(E:0:2,temp_str);
                 absolute_error_str := 'Absolute error: ' + temp_str;
                 str(RE:0:2,temp_str);
                 relative_error_str := 'Relative error: ' + temp_str + '%';
                 str(S2:0:2,temp_str);
                 area_str := 'Sifted Area: ' + temp_str; 
                flag:=true;
end;

procedure point2; // Вывод площади и погрешностей на экран консоли

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
        write('Нажмите любую клавишу для выхода в главное меню');
        readln();
end;

procedure point4; // Вывод информации о программе (удивительно)

begin
        clrscr;
        gotoxy(10,5);
        writeln('Программа вычисляет площадь фигуры выше y=0 ограниченную кривой и выводит её график на координатную плосость с возможностью его масштабирования как по отдельным осям, так и всем вместе.');
        gotoxy(10,6);
        write('Нажмите клавишу <Enter> для выходв в главное меню ');
        readln;
end;



procedure graph();

var y1,m,sx,sy: integer;
    cache,x,y,step: real;
begin
        winch:=' ';
        tmpW := ' ';
        
        while isGood do
        begin
                // ограничения по зуму
                if dy <= 10 then dy := dy + 10;
                if dx <= 0 then dx := dx + 1;
                if dy >= 500 then dy := dy - 10;
                if dx >= 5 then dx := dx -1; 
                ClearDevice;
         
                OutTextXY(100,100,'Zoom out x-axis -> RightArrow');
                OutTextXY(100,120,'Zoom x-axis -> LeftArrow');
                OutTextXY(100,140,'Zoom out y-axis -> UpArrow');
                OutTextXY(100,160,'Zoom y-axis -> DownArrow');
                OutTextXY(100,180,'Zoom out x-axis and y-axis -> +');
                OutTextXY(100,200,'Zoom x-axis and y-axis -> -');
                OutTextXY(100,220,'Shade area -> 1');
                // Вывод основной информации на график
                 OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 - 20,'f(x)=2x^3-2x^2+x');
                  OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2-40,area_str);
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2,absolute_error_str);
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 + 20,relative_error_str);
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2,'Absolute error:');
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 + 20,'Relative error:');
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 + 40,interval_string);
                 // обозначение осей,точки 0
                 OutTextXY(GetMaxX-20,y0-20,'X');
                 OutTextXY(x0+20,20,'Y');
                 OutTextXY(x0-20,y0+10,'0');
                Line(0, y0, GetMaxX-20, y0); //Ox
                Line(x0, 20, x0, GetMaxY); //Oy
                // sx,sy -расстояние от центра до оси
                sx := GetMaxX div 12;
                sy := GetMaxY div 12;
                for i := 1 to 10 do  // to ..., где ... максимальное количество делений
                begin
                // Засечки,деления,скейл,сжатие,расстяжение OX
                Line(x0+round(sx*i), y0-3, x0+round(sx*i), y0+3);
                Line(x0-round(sx*i), y0-3, x0-round(sx*i), y0+3);
                str((dx*i):0:2, s);
                OutTextXY(x0+sx*i+5, y0+10, s);
                str(-1*dx*i:0:2, s);
                OutTextXY(x0-sx*i+5, y0+10, s);
                // Засечки,деления,скейл,сжатие,расстяжение OY
                 Line(x0-3, y0-sy*i, x0+3, y0-sy*i);
                 Line(x0-3, y0+sy*i, x0+3, y0+sy*i);
                 str(dy*i:0:0, s);
                 OutTextXY(x0-60, y0+sy*-i, s);
                 str(-1*dy*i:0:0, s);
                 OutTextXY(x0-60, y0-sy*-i, s);
                end;
                // График
                SetColor(12);
                x := 0;y := 0; // Стартовые координаты
                step := x;
                while x < x0 do 
                begin
                      // Рисование основной функции  
                      if (round(y0-sy*(y/(dy))) > 0)  then begin
                      PutPixel(x0+round(sx*(x/(dx))),round(y0-sy*(y/(dy))),12); // График нечётной функции с переводом пикселей в координаты OX >= 0
                      PutPixel(x0-round(sx*(x/(dx))),round(y0+sy*(y/(dy))),12); // График нечётной функции с переводом пикселей в координаты OX <= 0
                      end;
                      // Рисование штриховки [a;b]
                      if (x >= a-0.00001) and (x <= b+0.00001) and gflag then 
                      begin
                         SetColor(2);
                        if (x- step > 0.25) then begin
                       if (round(y0-sy*(y/(dy))) < 0) then Line(x0+round(sx*((x)/(dx))),y0,x0+round(sx*(x/(dx))),0)
                       else Line(x0+round(sx*(x/(dx))),y0,x0+round(sx*(x/(dx))),round(y0-sy*(y/(dy))));
                       step := x;
                       end;
                       if (round(y0-sy*(fx(b)/(dy))) < 0) then Line(x0+round(sx*((b)/(dx))),y0,x0+round(sx*(b/(dx))),0)
                       else Line(x0+round(sx*(b/(dx))),y0,x0+round(sx*(b/(dx))),round(y0-sy*(fx(b)/(dy))));
                       SetColor(12);
                      end;
                      x := x + 0.01; // Шаг рисования, чем больше тем болше лагает,но тем более красивое
                      y := fx(x); // функция, которая зависит от независимого x
                end;
                 // KEY-BINDS - клавиши, необходимые для взаимодействия пользователя с графиком функции
                SetColor(15);
                tmpW:=wincrt.readkey;
                if tmpW = #0 then begin
                winch := wincrt.readkey;
                case winch of
                #75:  dx := dx -1; // +zoomX
                #77:  dx := dx + 1; // -zoomX
                #72:  dy := dy + 10; // -zoomY
                #80: dy := dy -10; // +zoomY
                end;
                end
                else 
                begin
                case tmpW of
                 '+':begin dx := dx + 1;dy:= dy+10; end;
                '-': begin dx:=dx-1;dy:=dy-10;end;
                '1': gflag := not gflag;
                #27: isGood := false;
                end;
                 end;
             
                
               
        end;
        CloseGraph;
end;

procedure IntGraph;

begin
       
        if flag=false then point1; 
        dx:=1;dy:=10;
        isGood := true;
        gd:=detect;gm:=0;InitGraph(gd, gm, '');
        // ---------------
        y0:=GetMaxY div 2;x0:=GetMaxX div 2;// центр координат
        gflag:=false; // Штриховка
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
