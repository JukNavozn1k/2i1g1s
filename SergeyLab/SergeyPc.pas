uses    wincrt, crt, math, graph;
const 
        unsel=LightGray;
        sel=Green;
        n=5;
var     menu:array[1..n] of string;
        point,x,y,m,d,x0,y0,i,gd,gm,mx,my, lim: integer;
        ch,winch: char; 
<<<<<<< HEAD
        h,a,b,m2,x1,E,RE,S1,S2,dx,dy: real; 
        flag,check,gflag: boolean;
        s,area_str,interval_string,absolute_error_str,relative_error_str,temp_str: string;
=======
        h,a,b,m2,x1,E,S1,S2,dx,dy: real; 
        flag,check,gflag: boolean;
        s,interval_string,temp_str: string;
>>>>>>> 1474c27393b5f915462e3d2ba38c85040bfc9cca
procedure graph(); forward;

// ����� �������
procedure print_func;

begin
        write('f(x)=2x^3-2x^2+x');
end;
// �������
function fx(x: real): real;

begin
        fx:=2*x*x*x - 2*x*x + x*x;
end;
// ������������� �������
function f(x: real): real;

begin
        f:=(x*x*x*x)/2 - (x*x*x)*(2/3) + (x*x)/2;
end;

// ����� �������� - ����� ���������� �������
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

procedure point1; // ���� ������, ������� �� �����. �������� ������, ��� �� �� (������� �� � ���� ������ �� ������������)

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
                a := -1;
                while a < 0 do begin
                write('������� ������ ����� (a >= 0): ');
                read(a);
                gotoxy(10,y+i);
                i:=i+1;
                end;
                gotoxy(10,y+i);
                i:=i+1;
                b := -1;
                while (b <= a) do begin
                write('������� ������ ����� (b > a ): ');
                read(b);
                gotoxy(10,y+i);
<<<<<<< HEAD
                i:=i+1;    
=======
                i:=i+1;
                str(a:0:1,temp_str);
                interval_string := 'Interval: [' + temp_str + ';';
                str(b:0:1,temp_str);
                interval_string := interval_string + temp_str + ']';
>>>>>>> 1474c27393b5f915462e3d2ba38c85040bfc9cca
                end;
                 gotoxy(10,y+i);
                i:=i+1;
                check:=true
        until check=true;
                write('������� ���-�� ����� (�� 1 �� 32767): ');
                readln(m2);
        while (m2 <> trunc(m2)) or (m2 < 1) or (m2 > 32767) do
        begin
                gotoxy(10,y+i);
                i:=i+1;
                writeln('����� ������ ���� ����� � [1;32767]');
                gotoxy(10,y+i);
                i:=i+1;
                write('������� ��� (�� 1 �� 32767): ');
                read(m2);
                
        end;
        m:=trunc(m2);
<<<<<<< HEAD
        
                // ������ ���������
                str(a:0:1,temp_str);
                interval_string := 'Interval: [' + temp_str + ';';
                str(b:0:1,temp_str);
                interval_string := interval_string + temp_str + ']';
                // ����ר� ������������, ����� � ������
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
=======
        flag:=true;
>>>>>>> 1474c27393b5f915462e3d2ba38c85040bfc9cca
end;

procedure point2; // ����� ������� � ������������ �� ����� �������

begin
        if flag <> true then
                point1;
        clrscr;
<<<<<<< HEAD
        print_func;
        gotoxy(10,5);
        write(area_str);
        writeln();
        gotoxy(10,6);
        writeln(absolute_error_str);
        gotoxy(10,7);
        writeln(relative_error_str);
=======
        // s1-s2 ���������� 
        S1:=f(b)-f(a);
        S2:=LT(a,b,m);
        E:=S2-S1;
        print_func;
        gotoxy(10,5);
        write('���������: ');
        writeln(S2:5:2);
        gotoxy(10,6);
        writeln('���������� �����������: ', E:0:2);
        gotoxy(10,7);
        writeln('������������� ������������: ', abs((E/S1)*100):0:2, '%');
>>>>>>> 1474c27393b5f915462e3d2ba38c85040bfc9cca
        gotoxy(10,8);
        write('������� ����� ������� ��� ������ � ������� ����');
        readln();
end;

procedure point4; // ����� ���������� � ��������� (�����������)

begin
        clrscr;
        gotoxy(10,5);
        writeln('��������� ��������� ������� ������ ���� y=0 ������������ ������ � ������� � ������ �� ������������ �������� � ������������ ��� ��������������� ��� �� ��������� ����, ��� � ���� ������.');
        gotoxy(10,6);
        write('������� ������� <Enter> ��� ������ � ������� ���� ');
        readln;
end;



procedure graph();

var y1,m,sx,sy: integer;
    cache,x,y: real;
begin
        winch:=' ';
         
        while winch <> #27 do
        begin
                // �������� �� ��������� ����� + ������ ��� ������ ��������� dx ��� dy, �� � �� ��������� ������ ��� 2 ����������, ����� ������� ��.
                if dy <= 0 then dy := dy + 1;
                if dx <= 0 then dx := dx + 1;
                ClearDevice;
                // INFO hotkeys
<<<<<<< HEAD
                OutTextXY(100,100,'Zoom out x-axis -> RightArrow');
                OutTextXY(100,120,'Zoom x-axis -> LeftArrow');
                OutTextXY(100,140,'Zoom out y-axis -> UpArrow');
                OutTextXY(100,160,'Zoom y-axis -> DownArrow');
                OutTextXY(100,180,'Zoom out x-axis and y-axis -> +');
                OutTextXY(100,200,'Zoom x-axis and y-axis -> -');
                OutTextXY(100,220,'Shade area -> 1');
                // ����� �������� ���������� �� ������
                 OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 - 20,'f(x)=2x^3-2x^2+x');
                  OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2-40,area_str);
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2,absolute_error_str);
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 + 20,relative_error_str);
=======
                OutTextXY(100,100,'zoom -x - RightArrow');
                OutTextXY(100,120,'zoom +x -LeftArrow');
                OutTextXY(100,140,'zoom -y - UpArrow');
                OutTextXY(100,160,'zoom +y -DownArrow');
                OutTextXY(100,180,'zoom +x +y -+');
                OutTextXY(100,200,'zoom -x -y --');
                // ����� �������� ���������� �� ������
                 OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 - 20,'f(x)=2x^3-2x^2+x');
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2,'Absolute error:');
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 + 20,'Relative error:');
>>>>>>> 1474c27393b5f915462e3d2ba38c85040bfc9cca
                OutTextXY((GetMaxX+x0)div 2,(GetMaxY+y0)div 2 + 40,interval_string);
                 // ����������� ����,����� 0
                 OutTextXY(GetMaxX-20,y0-20,'X');
                 OutTextXY(x0+20,20,'Y');
                 OutTextXY(x0-20,y0+10,'0');
                Line(0, y0, GetMaxX-20, y0); //Ox
                Line(x0, 20, x0, GetMaxY); //Oy
                // sx,sy -���������� �� ������ �� ���
                sx := GetMaxX div 12;
                sy := GetMaxY div 12;
                for i := 1 to 10 do  // to ..., ��� ... ������������ ���������� �������
                begin
                // �������,�������,�����,������,����������� OX
                Line(x0+round(sx*i), y0-3, x0+round(sx*i), y0+3);
                Line(x0-round(sx*i), y0-3, x0-round(sx*i), y0+3);
                str((dx*i):0:2, s);
                OutTextXY(x0+sx*i+5, y0+10, s);
                str(-1*dx*i:0:2, s);
                OutTextXY(x0-sx*i+5, y0+10, s);
                // �������,�������,�����,������,����������� OY
                 Line(x0-3, y0-sy*i, x0+3, y0-sy*i);
                 Line(x0-3, y0+sy*i, x0+3, y0+sy*i);
                 str(dy*i:0:0, s);
                 OutTextXY(x0-60, y0+sy*-i, s);
                 str(-1*dy*i:0:0, s);
                 OutTextXY(x0-60, y0-sy*-i, s);
                end;
                // ������
                SetColor(12);
                x := 0;y := 0; // ��������� ����������
                while x < x0 do 
                begin
                      // ��������� �������� �������  
                      if (round(y0-sy*(y/(dy))) > 0)  then begin
                      PutPixel(x0+round(sx*(x/(dx))),round(y0-sy*(y/(dy))),12); // ������ �������� ������� � ��������� �������� � ���������� OX >= 0
                      PutPixel(x0-round(sx*(x/(dx))),round(y0+sy*(y/(dy))),12); // ������ �������� ������� � ��������� �������� � ���������� OX <= 0
                      end;
                      // ��������� ��������� [a;b]
                      if (x >= a-0.00001) and (x <= b+0.00001) and gflag then 
                      begin
                       SetColor(2);
                       if (round(y0-sy*(y/(dy))) < 0) then Line(x0+round(sx*(x/(dx))),y0,x0+round(sx*(x/(dx))),0)
                       else Line(x0+round(sx*(x/(dx))),y0,x0+round(sx*(x/(dx))),round(y0-sy*(y/(dy))));
                       SetColor(12);
                      end;
<<<<<<< HEAD
                      x := x + 0.01; // ��� ���������, ��� ������ ��� ����� ������,�� ��� ����� ��������
=======
                      x := x + 0.1; // ��� ���������, ��� ������ ��� ����� ������,�� ��� ����� ��������
>>>>>>> 1474c27393b5f915462e3d2ba38c85040bfc9cca
                      y := fx(x); // �������, ������� ������� �� ������������ x
                end;
                 // KEY-BINDS - �������, ����������� ��� �������������� ������������ � �������� �������
                SetColor(15);
                winch:=wincrt.readkey;
                if winch=#0 then y1:=1;
                case winch of
                #75: if y1=1 then dx := dx -1; // +zoomX
                #77: if y1=1 then dx := dx + 1; // -zoomX
                #72: if y1=1 then dy := dy + 1; // -zoomY
                #80: if y1=1 then dy := dy -1; // +zoomY
                #43:begin dx := dx + 1;dy:= dy+1; end;
                #45: begin dx:=dx-1;dy:=dy-1;end;
                #49: gflag := not gflag;
                end;
        end;
        CloseGraph;
end;

procedure IntGraph;

begin
       
        if flag=false then point1; // �������� �� ��������� ���� �� ����� �������
        dx:=1;dy:=1;
        // �� �������
        gd:=detect;gm:=0;InitGraph(gd, gm, '');
        // ---------------
        y0:=GetMaxY div 2;x0:=GetMaxX div 2;// ����� ���������
        gflag:=false; // ���������
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
