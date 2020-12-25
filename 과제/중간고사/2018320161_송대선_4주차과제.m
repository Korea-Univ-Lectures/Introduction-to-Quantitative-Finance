%% 1

clear;

F = 0;        % 원리합계 변수
for i = 1:60
   F = F + 100; % 
   F = F * (1 + 0.005);
end
F % 출력

%% 2
clear;

F = 0;
n = 0;
while F < 7000 % 7000만원 제한
    n = n + 1;
    F = F + 100;
    F = F*(1 + 0.005);
end
F
n
%% 3 - main

% 함수는 맨 하단에 있습니다.

clear;

[S, n] = fund(100, 0.005,7000)

%% 4
clear;

N = 1000;
sn = zeros(1,N);
for k = 1:N
    for i = 1:N
        if mod(i, k) == 0
            sn(k) = sn(k) + i;
        end
    end
end
sn % output
figure(1)
plot(1:N, sn) % 그래프로 확인

%% 5
clear;

figure(2)
x = linspace(-2*pi, 2*pi);
y1 = 2*cos(x); % y1을 계산
y2 = sin(2*x); % y2을 계산

plot(x, y1) % 그래프 그리기
hold on % 그래프 고정

plot(x, y2) % 그래프 그리기
legend("y1 = 2cos(x)", "y2 = sin(2x)")
hold off % 그래프 고정 해제

%% 6
clear;

figure(3)

theta = linspace(0, 10*pi);
x = cos(theta);
y = sin(theta);
z = theta.^2 + 1;
plot3(x,y,z) % 3차원 그래프 그리기
 

%% 3 - fuction
clear;

function [S, n] = fund(a,r,b)
    S = 0;
    n = 0;
    while S < b
        n = n + 1;
        S = S + a;
        S = S * (1+r);
    end
end