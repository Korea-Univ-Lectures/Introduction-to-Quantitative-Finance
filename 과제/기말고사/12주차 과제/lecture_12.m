%% ITM, ATM, OTM
clear; clc
ST = 0:60; K = 30; c1 = 3; p1 = 3;

figure(1);clf;
Call_payoff = max(ST-K, 0)-c1;
plot(ST, Call_payoff, 'k-')

figure(2);clf;
Put_payoff = max(K-ST, 0)-p1;
plot(ST, Put_payoff, 'k-')

%% 콜옵션
clear; clc;
S0 = 40; c1 = 3; K = 30;
sigma = 0.1; r = 0.1;
T = 1; dt = 1/3565; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

St = zeros(1, N+1);
for i=N:-1:0
    St(i+1) = S0*u^(N-i)*d^(i);
end

Ct = zeros(1, N+1);
for i=N:-1:0
    Ct(i+1) = max(St(i+1)-K, 0)-c1; % 만기의 payoff가 들어간다.
end

for j=N:-1:1
    for i = 1:j
        Ct(i) = exp(-r*dt)*(p*Ct(i)+(1-p)*Ct(i+1));
    end
end
eC = Ct(1)

%% 콜옵션 그래프
clear; clc;
S0 = 0:60; c1 = 3; K = 30;
sigma = 0.1; r = 0.1;
T = 1; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);


for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    Ct = zeros(1, N+1);
    for i=N:-1:0
        Ct(i+1) = max(St(i+1)-K, 0)-c1; % 만기의 payoff가 들어간다.
    end
    
    for j=N:-1:1
        for i = 1:j
            Ct(i) = exp(-r*dt)*(p*Ct(i)+(1-p)*Ct(i+1));
        end
    end
    eC(n) = Ct(1);
    
end

figure(3); clf; hold on
plot(S0, eC, 'r-')
payoff = max(S0-K, 0)-c1;
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean(max(S-K, 0)-c1)*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 풋옵션 그래프
clear; clc;
S0 = 0:60; p1 = 3; K = 30;
sigma = 0.1; r = 0.1;
T = 1; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    Pt = zeros(1, N+1);
    for i=N:-1:0
        Pt(i+1) = max(K-St(i+1), 0)-p1; % 만기의 payoff가 들어간다.
    end
    
    for j=N:-1:1
        for i = 1:j
            Pt(i) = exp(-r*dt)*(p*Pt(i)+(1-p)*Pt(i+1));
        end
    end
    eP(n) = Pt(1);
end

figure(3); clf; hold on
plot(S0, eP, 'r-')
payoff = max(K-S0, 0)-p1;
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean(max(K-S, 0)-p1)*exp(-r*T);
end

plot(S0, BSM, 'b*')

%% 강세스프레드(콜1 - 콜2)
clear; clc;
S0 = 0:60; c1 = 3; c2 = 1;
K1 = 30; K2 = 35;
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    C1t = zeros(1, N+1);
    C2t = zeros(1, N+1);
    Ct = zeros(1, N+1);
    for i=N:-1:0
        C1t(i+1) = max(St(i+1)-K1, 0)-c1; % 만기의 payoff가 들어간다.
        C2t(i+1) = max(St(i+1)-K2, 0)-c2; % 만기의 payoff가 들어간다.
        Ct(i+1) = C1t(i+1) - C2t(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            Ct(i) = exp(-r*dt)*(p*Ct(i)+(1-p)*Ct(i+1));
        end
    end
    eC(n) = Ct(1);
end

figure(3); clf; hold on
plot(S0, eC, 'r-')
payoff = (max(S0-K1, 0)-c1) - (max(S0-K2, 0)-c2);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean((max(S-K1, 0)-c1) - (max(S-K2, 0)-c2))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 강세스프레드(풋1 - 풋2)
clear; clc;
S0 = 200:260; p1 = 1.15; p2 = 1.53;
K1 = 235; K2 = 237.5;
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    P1t = zeros(1, N+1);
    P2t = zeros(1, N+1);
    Pt = zeros(1, N+1);
    for i=N:-1:0
        P1t(i+1) = max(K1-St(i+1), 0)-p1; % 만기의 payoff가 들어간다.
        P2t(i+1) = max(K2-St(i+1), 0)-p2; % 만기의 payoff가 들어간다.
        Pt(i+1) = P1t(i+1) - P2t(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            Pt(i) = exp(-r*dt)*(p*Pt(i)+(1-p)*Pt(i+1));
        end
    end
    eP(n) = Pt(1);
end

figure(3); clf; hold on
plot(S0, eP, 'r-')
payoff = (max(K1-S0, 0)-p1) - (max(K2-S0, 0)-p2);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean((max(K1-S, 0)-p1) - (max(K2-S, 0)-p2))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 약세스프레드(풋2 - 풋1)
clear; clc;
S0 = 0:60; p1 = 1; p2 = 3;
K1 = 30; K2 = 35;
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    P1t = zeros(1, N+1);
    P2t = zeros(1, N+1);
    Pt = zeros(1, N+1);
    for i=N:-1:0
        P1t(i+1) = max(K1-St(i+1), 0)-p1; % 만기의 payoff가 들어간다.
        P2t(i+1) = max(K2-St(i+1), 0)-p2; % 만기의 payoff가 들어간다.
        Pt(i+1) = P2t(i+1) - P1t(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            Pt(i) = exp(-r*dt)*(p*Pt(i)+(1-p)*Pt(i+1));
        end
    end
    eP(n) = Pt(1);
end

figure(3); clf; hold on
plot(S0, eP, 'r-')
payoff = (max(K2-S0, 0)-p2)-(max(K1-S0, 0)-p1);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean((max(K2-S, 0)-p2)-(max(K1-S, 0)-p1))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 약세스프레드(콜2 - 콜1)
clear; clc;
S0 = 220:280; c1 = 3.61; c2 = 2.48;
K1 = 247.5; K2 = 250;
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    C1t = zeros(1, N+1);
    C2t = zeros(1, N+1);
    Ct = zeros(1, N+1);
    for i=N:-1:0
        C1t(i+1) = max(St(i+1)-K1, 0)-c1; % 만기의 payoff가 들어간다.
        C2t(i+1) = max(St(i+1)-K2, 0)-c2; % 만기의 payoff가 들어간다.
        Ct(i+1) = C2t(i+1) - C1t(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            Ct(i) = exp(-r*dt)*(p*Ct(i)+(1-p)*Ct(i+1));
        end
    end
    eC(n) = Ct(1);
end

figure(3); clf; hold on
plot(S0, eC, 'r-')
payoff = (max(S0-K2, 0)-c2) - (max(S0-K1, 0)-c1);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean((max(S-K2, 0)-c2) - (max(S-K1, 0)-c1))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 박스스프레드(콜강세 + 풋약세)
clear; clc;
c1 = 2.44; c2 = 1.4;
p1 = 3.26; p2 = 4.67;
K1 = 235; K2 = 237.5;

S0 = 200:260; 
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    C1t = zeros(1, N+1);
    C2t = zeros(1, N+1);
    Ct = zeros(1, N+1);
    P1t = zeros(1, N+1);
    P2t = zeros(1, N+1);
    Pt = zeros(1, N+1);
    Bt = zeros(1, N+1);
    for i=N:-1:0
        C1t(i+1) = max(St(i+1)-K1, 0)-c1; % 만기의 payoff가 들어간다.
        C2t(i+1) = max(St(i+1)-K2, 0)-c2; % 만기의 payoff가 들어간다.
        Ct(i+1) = C1t(i+1) - C2t(i+1);
        P1t(i+1) = max(K1-St(i+1), 0)-p1; % 만기의 payoff가 들어간다.
        P2t(i+1) = max(K2-St(i+1), 0)-p2; % 만기의 payoff가 들어간다.
        Pt(i+1) = P2t(i+1) - P1t(i+1);
        Bt(i+1) = Ct(i+1) + Pt(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            Bt(i) = exp(-r*dt)*(p*Bt(i)+(1-p)*Bt(i+1));
        end
    end
    eB(n) = Bt(1);
end

figure(3); clf; hold on
plot(S0, eB, 'r-')
payoff = (max(S0-K1, 0)-c1) - (max(S0-K2, 0)-c2) - (max(K1-S0, 0)-p1) + (max(K2-S0, 0)-p2);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean((max(S-K1, 0)-c1) - (max(S-K2, 0)-c2) - (max(K1-S, 0)-p1) + (max(K2-S, 0)-p2))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 박스스프레드(콜약세 + 풋강세)
clear; clc;
c1 = 3.99; c2 = 2.44;
p1 = 2.25; p2 = 3.26;
K1 = 232.5; K2 = 235;

S0 = 200:260; 
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    C1t = zeros(1, N+1);
    C2t = zeros(1, N+1);
    Ct = zeros(1, N+1);
    P1t = zeros(1, N+1);
    P2t = zeros(1, N+1);
    Pt = zeros(1, N+1);
    Bt = zeros(1, N+1);
    for i=N:-1:0
        C1t(i+1) = max(St(i+1)-K1, 0)-c1; % 만기의 payoff가 들어간다.
        C2t(i+1) = max(St(i+1)-K2, 0)-c2; % 만기의 payoff가 들어간다.
        Ct(i+1) = C2t(i+1) - C1t(i+1);
        P1t(i+1) = max(K1-St(i+1), 0)-p1; % 만기의 payoff가 들어간다.
        P2t(i+1) = max(K2-St(i+1), 0)-p2; % 만기의 payoff가 들어간다.
        Pt(i+1) = P1t(i+1) - P2t(i+1);
        Bt(i+1) = Ct(i+1) + Pt(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            Bt(i) = exp(-r*dt)*(p*Bt(i)+(1-p)*Bt(i+1));
        end
    end
    eB(n) = Bt(1);
end

figure(3); clf; hold on
plot(S0, eB, 'r-')
payoff = -(max(S0-K1, 0)-c1) + (max(S0-K2, 0)-c2) + (max(K1-S0, 0)-p1) - (max(K2-S0, 0)-p2);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean(-(max(S0-K1, 0)-c1) + (max(S0-K2, 0)-c2) + (max(K1-S0, 0)-p1) - (max(K2-S0, 0)-p2))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 나비형스프레드 (콜1 -2*콜2 +콜3)
clear; clc;
c1 = 10; c2 = 7; c3 = 5;
K1 = 55; K2 = 60; K3 = 65;

S0 = 20:100; 
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    C1t = zeros(1, N+1);
    C2t = zeros(1, N+1);
    C3t = zeros(1, N+1);
    Ct = zeros(1, N+1);
    for i=N:-1:0
        C1t(i+1) = max(St(i+1)-K1, 0)-c1; % 만기의 payoff가 들어간다.
        C2t(i+1) = max(St(i+1)-K2, 0)-c2; % 만기의 payoff가 들어간다.
        C3t(i+1) = max(St(i+1)-K3, 0)-c3;
        Ct(i+1) = C1t(i+1) -2*C2t(i+1) + C3t(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            Ct(i) = exp(-r*dt)*(p*Ct(i)+(1-p)*Ct(i+1));
        end
    end
    eC(n) = Ct(1);
end

figure(3); clf; hold on
plot(S0, eC, 'r-')
payoff = (max(S0-K1, 0)-c1) -2*(max(S0-K2, 0)-c2) + (max(S0-K3, 0)-c3);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean((max(S-K1, 0)-c1) -2*(max(S-K2, 0)-c2) + (max(S-K3, 0)-c3))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 나비형스프레드 (풋1 -2*픗2 +풋3)
clear; clc;
p1 = 2.29; p2 = 3.16; p3 = 4.32;
K1 = 240; K2 = 242.5; K3 = 245;

S0 = 200:280; 
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    P1t = zeros(1, N+1);
    P2t = zeros(1, N+1);
    P3t = zeros(1, N+1);
    Pt = zeros(1, N+1);
    for i=N:-1:0
        P1t(i+1) = max(K1-St(i+1), 0)-p1; % 만기의 payoff가 들어간다.
        P2t(i+1) = max(K2-St(i+1), 0)-p2; % 만기의 payoff가 들어간다.
        P3t(i+1) = max(K3-St(i+1), 0)-p3;
        Pt(i+1) = P1t(i+1) + (-2*P2t(i+1)) + P3t(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            Pt(i) = exp(-r*dt)*(p*Pt(i)+(1-p)*Pt(i+1));
        end
    end
    eP(n) = Pt(1);
end

figure(1); clf; hold on
plot(S0, eP, 'r-')
payoff = (max(K1-S0, 0)-p1) -2*(max(K2-S0, 0)-p2) + (max(K3-S0, 0)-p3);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean((max(K1-S, 0)-p1) -2*(max(K2-S, 0)-p2) + (max(K3-S, 0)-p3))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 스트래들(콜 + 풋)
clear; clc;
c1 = 2.44; p1 = 1.4; K = 230;

S0 = 200:260; 
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    Ct = zeros(1, N+1);
    Pt = zeros(1, N+1);
    STt = zeros(1, N+1);
    for i=N:-1:0
        Ct(i+1) = max(St(i+1)-K, 0)-c1;
        Pt(i+1) = max(K-St(i+1), 0)-p1;
        STt(i+1) = Ct(i+1) + Pt(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            STt(i) = exp(-r*dt)*(p*STt(i)+(1-p)*STt(i+1));
        end
    end
    eST(n) = STt(1);
end

figure(3); clf; hold on
plot(S0, eST, 'r-')
payoff = (max(S0-K, 0)-c1) + (max(K-S0, 0)-p1);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean((max(S-K, 0)-c1) + (max(K-S, 0)-p1))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 스트랭글(콜2 + 풋1)
clear; clc;
c1 = 2.44; p1 = 1.4; 
K1 = 230; K2 = 240;

S0 = 200:260; 
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    Ct = zeros(1, N+1);
    Pt = zeros(1, N+1);
    STt = zeros(1, N+1);
    for i=N:-1:0
        Ct(i+1) = max(St(i+1)-K2, 0)-c1;
        Pt(i+1) = max(K1-St(i+1), 0)-p1;
        STt(i+1) = Ct(i+1) + Pt(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            STt(i) = exp(-r*dt)*(p*STt(i)+(1-p)*STt(i+1));
        end
    end
    eST(n) = STt(1);
end

figure(3); clf; hold on
plot(S0, eST, 'r-')
payoff = (max(S0-K2, 0)-c1) + (max(K1-S0, 0)-p1);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean((max(S-K2, 0)-c1) + (max(K1-S, 0)-p1))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 스트랩(2*콜 + 풋)
clear; clc;
c1 = 2.44; p1 = 1.4; K = 230;

S0 = 200:260; 
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    Ct = zeros(1, N+1);
    Pt = zeros(1, N+1);
    STt = zeros(1, N+1);
    for i=N:-1:0
        Ct(i+1) = max(St(i+1)-K, 0)-c1;
        Pt(i+1) = max(K-St(i+1), 0)-p1;
        STt(i+1) = 2*Ct(i+1) + Pt(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            STt(i) = exp(-r*dt)*(p*STt(i)+(1-p)*STt(i+1));
        end
    end
    eST(n) = STt(1);
end

figure(3); clf; hold on
plot(S0, eST, 'r-')
payoff = 2*(max(S0-K, 0)-c1) + (max(K-S0, 0)-p1);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean(2*(max(S-K, 0)-c1) + (max(K-S, 0)-p1))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 스트립(콜 + 2*풋)
clear; clc;
c1 = 2.44; p1 = 1.4; K = 230;

S0 = 200:260; 
sigma = 0.1; r = 0.1;
T = 1/12; dt = 1/365; N = floor(T/dt);
u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));
p = (exp(r*dt)-d)/(u-d);

for n=1:length(S0)
    St = zeros(1, N+1);
    for i=N:-1:0
        St(i+1) = S0(n)*u^(N-i)*d^(i);
    end
    
    Ct = zeros(1, N+1);
    Pt = zeros(1, N+1);
    STt = zeros(1, N+1);
    for i=N:-1:0
        Ct(i+1) = max(St(i+1)-K, 0)-c1;
        Pt(i+1) = max(K-St(i+1), 0)-p1;
        STt(i+1) = Ct(i+1) + 2*Pt(i+1);
    end
    
    for j=N:-1:1
        for i = 1:j
            STt(i) = exp(-r*dt)*(p*STt(i)+(1-p)*STt(i+1));
        end
    end
    eST(n) = STt(1);
end

figure(3); clf; hold on
plot(S0, eST, 'r-')
payoff = (max(S0-K, 0)-c1) + 2*(max(K-S0, 0)-p1);
plot(S0, payoff, 'k-')

BSM = zeros(1, length(S0));
randn('seed', 1); Ns = 1.0e4;
for n=1:length(S0)
    ss0 = S0(n);
    S = ss0*exp((r-0.5*sigma^2)*T+sigma*sqrt(T)*randn(Ns,1));
    BSM(n) = mean((max(S-K, 0)-c1) + 2*(max(K-S, 0)-p1))*exp(-r*T);
end
plot(S0, BSM, 'b*')

%% 블랙숄츠머튼 (몬테카를로 시뮬레이션)
clear; clc;
randn('seed', 1); Ns = 1.0e2;
S0 = 100; T = 1; dt = 1/365; N = floor(T/dt); r = 0.1;
S1 = zeros(Ns, N+1); S1(:, 1)=S0; sigma1 = 0.1;
S2 = zeros(Ns, N+1); S2(:, 1)=S0; sigma2 = 0.1;
for ns=1:Ns
    e1 = randn(1,N); e2 = randn(1,N);
    for n=1:N
        S1(ns, n+1) = S1(ns, n)*exp((r-0.5*sigma1^2)*dt+sigma1*sqrt(dt)*e1(n));
        S2(ns, n+1) = S2(ns, n)*exp((r-0.5*sigma2^2)*dt+sigma2*sqrt(dt)*e2(n));
    end
end
t = 0:dt:T;
figure(1);clf;hold on
plot(t, mean(S1, 1), 'r-')
plot(t, mean(S2, 1), 'b-')

%% 블랙숄츠머튼 (몬테카를로 시뮬레이션), sigma의 역할?
clear; clc;
randn('seed', 1); Ns = 1.0e2;
S0 = 100; T = 1; dt = 1/365; N = floor(T/dt); r = 0.1;
S1 = zeros(Ns, N+1); S1(:, 1)=S0; sigma1 = 0.1;
S2 = zeros(Ns, N+1); S2(:, 1)=S0; sigma2 = 1.0;
for ns=1:Ns
    e1 = randn(1,N); e2 = randn(1,N);
    for n=1:N
        S1(ns, n+1) = S1(ns, n)*exp((r-0.5*sigma1^2)*dt+sigma1*sqrt(dt)*e1(n));
        S2(ns, n+1) = S2(ns, n)*exp((r-0.5*sigma2^2)*dt+sigma2*sqrt(dt)*e2(n));
    end
end
t = 0:dt:T;
figure(1);clf;hold on
plot(t, mean(S1, 1), 'r-')
plot(t, mean(S2, 1), 'b-')

%% 블랙숄츠머튼 (몬테카를로 시뮬레이션), rho의 역할?
clear; clc;
randn('seed', 1); Ns = 1.0e2;
S0 = 100; T = 1; dt = 1/365; N = floor(T/dt); r = 0.1;
S1 = zeros(Ns, N+1); S1(:, 1)=S0; sigma1 = 0.02;
S2 = zeros(Ns, N+1); S2(:, 1)=S0; sigma2 = 0.02;

rho = -1.0;
correlation_matrix = [1 rho; rho 1];

for ns=1:Ns
    e1 = randn(1,N); e2 = randn(1,N);
    E1 = e1;
    E2 = rho*e1 + sqrt(1-rho^2)*e2;
    for n=1:N
        S1(ns, n+1) = S1(ns, n)*exp((r-0.5*sigma1^2)*dt+sigma1*sqrt(dt)*e1(n));
        S2(ns, n+1) = S2(ns, n)*exp((r-0.5*sigma2^2)*dt+sigma2*sqrt(dt)*e2(n));
    end
end
t = 0:dt:T;
figure(1);clf;hold on
plot(t, mean(S1, 1), 'r-')
plot(t, mean(S2, 1), 'b-')

%% E2는 표준 정규분포를 따르는가?
clear; clc;
randn('seed', 1); Ns = 1.0e8;

rho = -1.0;
correlation_matrix = [1 rho; rho 1];

e1 = randn(1,Ns); e2 = randn(1,Ns);
E1 = e1;
E2 = rho*e1 + sqrt(1-rho^2)*e2;
mean(E1)
mean(E2)

std(E1)
std(E2)


