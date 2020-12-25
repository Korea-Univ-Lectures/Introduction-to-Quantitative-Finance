%% 이분법
clear; clc;
a = 0;
b = 10;
f = @(x) x^2-4;
%f(1)

while b - a > 0.0001
    c = 0.5*(a+b);
    if f(a)*f(c) < 0
        b = c;
    else
        a = c;
    end
    %[a,b]
end
sol = c

% 이분법이 직관적이지만 코스트가 많다.

%% 뉴튼 랩슨법
clear; clc;
x = 10;
f = @(x) x^2-4;
df = @(x) 2*x;
tol = 0.0001;

while abs(f(x)) > tol
    x = x-f(x)/df(x);
    sol = x
end

%% 뉴튼 랩슨법 with 평균변화율
clear; clc;
x = 10;
f = @(x) x^2-4;
h = 0.0001;

tol = 0.0001;

while abs(f(x)) > tol
    dP = (f(x+h)-f(x-h))/(2*h)
    x = x-f(x)/dP;
    sol = x
end

%% 뉴튼 랩슨법을 이용한 유로피언 콜 옵션 가치 평가
clear; clc;
x = 0.5;
Vm = 3;
h = 0.0001;

tol = 0.0001;

while abs(BSM(x)-Vm) > tol
    dP = (BSM(x+h)-BSM(x-h))/(2*h);
    x = x-(BSM(x)-Vm)/dP;
    sol = x
end

% Vm이 3을 가지게하는 변동성은 0.0176이라는 것을 알 수 있다.
% vol값은 크기만을 표시하기에 양수만이 나와야 한다.
% 뉴턴 랩슨법의 단점이 이것이다. 뉴튼 랩슨법은 초기 값이 중요하다.
% vol이 커질수록 Vm이 커진다. 

%% 이분법을 이용한 유로피언 콜 옵션 가치 평가
clear; clc;
a = 0;
b = 10;
tol = 0.0001;
Vm = 3;

while b - a > tol
    c = 0.5*(a+b);
    if (BSM(a)-Vm)*(BSM(c)-Vm) < 0
        b = c;
    else
        a = c;
    end
    %[a,b]
end
sol = c


%% 유로피언 콜 옵션 가치 평가 함수 with BSM
function price = BSM(vol)
    S0=100; K=100; r=0.03; T=1;q=0;
    randn('seed', 1);
    ns = 1.0e5;
    S = S0*exp((r-0.5*vol^2)*T+vol*sqrt(T)*randn(ns,1));
    price = mean(max(S-K,0)*exp(-r*T));
end