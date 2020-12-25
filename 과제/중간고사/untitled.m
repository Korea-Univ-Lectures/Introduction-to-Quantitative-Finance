a =3;
if a== 3;
    b=2
end

a =3;
if a> 3
    b=1
elseif a<3
    b=2
else
    b=3
end

a = 3;
b = 3;
if a> 3
    b=1
elseif a<3
    b=2
end
b

a = 1;
for i = 1:3
    a
end

for i = [2 5 17]
    i
end

a = 1;
for i = 1:3
    a = a + 1
end

a = 1;
while a < 4
    a = a+1
end
   
a = 1;
for i = 1:10000000
    if a < 4
        a = a + 1
    end
end

a = 1:3;
max(a)

figure(1)
x = linspace(0, 2*pi, 20);
y = cos(x)
plot(x, y, 'ko--') % 순서는 상관 없다.

figure(2)
x = linspace(0, 2*pi, 20);
y1 = tan(x); % cos(x)
plot(x, y1)
hold on
y2 = sin(x)
plot(x, y2)
legend("y1 = tan(x)", "y2 = sin(x)")

figure(3) % 이렇게 하면 그래프 창을 여러개 띄울 수 있다.
x = linspace(0, 2*pi, 20);
y1 = cos(x);
subplot(1,2,1)
plot(x,y1)
y2 = sin(x);
subplot(1,2,2)
plot(x, y2)


figure(4) % 이렇게 하면 그래프 창을 여러개 띄울 수 있다.
x = linspace(0, 2*pi, 20);
y = sin(x);
subplot(2,2,1)
plot(x,y)

subplot(2,2,2)
plot(x, y)
axis([3 6 -1 0])

subplot(2,2,3)
plot(x,y)
axis image

subplot(2,2,4)
plot(x,y)
axis equal

figure(5)
x = linspace(0, 10*pi);
y = sin(x);
z = cos(x);

plot3(x,y,z, 'r^--')


x = 1:3; y = 1:4;
[X,Y] = meshgrid(x,y);

figure(6)
x = linspace(-2*pi,2*pi);
y = linspace(-2*pi, 2*pi);
[X,Y] = meshgrid(x,y);
Z = cos(X) + sin(Y)
mesh(X,Y,Z)


































Factorial(3)

function F = Factorial(n)

F = 1;
for i = 1:n
    
    F = F * i;

end
end