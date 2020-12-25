% review

%Artithemtic_operator_Variable  
a = 2; b=3;
Addition = a+b
Subtraction = a-b
Multiplication = a*b
Power = a^b
Division = a/b

% Arithmethic_operator_Matrix
a = [10 20; 30 40]; b = [1 2; 3 4];
Addition  = a +b
Subtraction = a-b
Multiplication_matrix = a*b
Multiplication_element = a.*b
Power_element = a.^b
Division_element = a./b

% Reallocation
a = [1 2 3; 4 5 6]
a(2, 2) = 9

% Element_delete
a = [1 2 3 4]
a(2) = []

% Print_matrix
a = [1 2 3 4; 5 6 7 8; 9 0 1 2];
a(1,2)
a(2, 2:3)
a(3, 1:end)

% Colon
x1 = 1; x2 = 6
x1:x2
d=2;
x1:d:x2

% Linspace
x1 = 1; x2 = 5;
n=5;
linspace(x1,x2,n)

% ones
n=2;m=3;
ones(n,m)

% Zeros
n=2; m=3;
zeros(n,m)

% Length
a = 4:10;
length(a)

% size
a = [1 2 3; 4 5 6];
size(a)

% 흐름제어문

% Relational_operator
x=3; y=5;
x==y % 0
x~=y % 1
x>y  % 0
x<y  % 1
x>=y % 0
x<=y % 1

% Logical_And_operator
0&&0 % 0
1&&0 % 0
0&&1 % 0
1&&1 % 1

% Logical_Or_operation
0||0 % 0
1||0 % 1
0||1 % 1
1||1 % 1

% if
a = 3;
if a==3
    b=2
end

% if_else
a = 3;
if a>3
    b=1
elseif a<3
    b=2
else
    b=3    % 이것이 선택된다.
end

%For1
a = 1;
for i = 1:3
    a
end
% 1;1;1;


%For2
for i= [2 5 17]
    i
end
% 2;5;17

%While
a = 1;
while a < 4
    a = a+1 % 1+1=2, 2+1=3, 3+1=4
end

% 그래프

% plot(x, y, 그래프 속성)
% plot(x,t,'s') % x-> 입력값, y -> 출력 값, 's' -> 자료기호, 선 형태, 색상 지정

% Plot_xy
x = linspace(0,2*pi,20);
y = cos(x);
plot(x, y)

%Plot_Linspec
x =linspace(0, 2*pi, 20);
y = cos(x);
plot(x,y,'ko--')

%plot(x1, y1, x2, y2)
%
%       ==
%
% plot(x1, y1) <- plot(x1, y1, 'k-', '', '', ...(기타 정보들) )
%   hold on
% plot(x2, y2)

%Hold_on
x = linspace(0, 2*pi, 20);
y1 = cos(x);
plot(x, y1)
hold on       % <-> hold of
y2 = sin(x);
plot(x, y2)

% figure(n) 여려 그래프를 각각 다른 그림 창에 그리기 위해 그림 창을 생성
% title('text') 그래프 제목 지정

% Title
figure(1); clf
FigTitle = sprintf('pi = %f', pi); % %f에는 3.14592...가 들어간다. 
title(FigTitle)

% subplot
% subplot(mnp)
% plot(x1, y1, x2, y2)
% hold on 
% subplot(2,2,1)
% plot(x1, y1, x2, y2)

% subplot(2,2,4)
% plot(x1, y1, x2, y2)

% subplot(1,3,2)
% plot(x, y)

%Subplot
x = linspace(0, 2*pi, 20);
y1 = cos(x);

subplot(1,2,1)
plot(x,y1)

y2 = sin(x)
subplot(1,2,2)
plot(x, y2)

x = linspace(0, 2*pi, 20);
y = sin(x);
subplot(2,2,1)
plot(x, y)

subplot(2,2,2)
plot(x,y)
axis([3 6 -1 0]) % 그래프의 최소 최대 크기

subplot(2,2,3)
plot(x, y)
axis image % x, y축의 비율을 동일하게

subplot(2,2,4)
plot(x,y)
axis equal % 이미지상의 길이를 동일하게

% Grid
x = linspace(0, 2*pi, 20);
y = cos(x)
line(x, y) % == plot (x, y)
grid on
% grid off -> 모눈이 지워짐

%  legend('s1', 's2', ... , location)
%
%t = 0:0.1:10;
%plot(t, y(1:101,1), 'r-');
%hold;
%plot(t, y(1:101,2), 'b-');
%legend('\zeta=0.0', '\zeta=0.2', '\zeta=0.5', '\zeta=0.8', '\zeta=1.0', 4);% 4사분면 위치에 legend가 있다.

subplot(1,1,1)

% Plot3
x = linspace(0, 10*pi);
y = sin(x);
z = cos(x);
plot3(x, y, z, 'r^--') % r : RED, ^ : marker(세모), -- : bash 

% Meshgrid      % x, y 축을 행렬로 넣어서 면에 대한 정보를 생성하게 한다.
x = 1:3; y = 1:4;
[X, Y] = meshgrid(x, y)
% 선이 이어져서 면이되는 것이다.

% mesh
x = linspace(-2*pi, 2*pi);
y = linspace(-2*pi, 2*pi);
[X, Y] = meshgrid(x, y);
Z = cos(X) + sin(Y);
mesh(X,Y,Z)

% doc

Factorial(5)
Factorial(10)
Factorial(20)

% Factorial
function F = Factorial(n)
F = 1;
for i=1:n    
    F = F*i; % 1*1=1, 2*1=2, 3*2=6,6*4=24, 24*5=120
end
end

% Factorial(5) -> 120
% Factorial(10) -> 3628800
% Factorial(20) -> 2.4329e+18 