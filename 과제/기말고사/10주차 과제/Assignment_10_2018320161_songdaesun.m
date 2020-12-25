clear; clc;
S0 = 20;
Su = 22;
Sd = 18;
K = 21;
T = 3/12;
fu = max(Su-K,0);
fd = max(Sd-K,0);

delta = (fu-fd)/(Su-Sd)
r = 0.12;

f = S0*delta-(Su*delta-fu)*exp(-r*T)
%% European One Period
S0 = 20; Su = 22; Sd = 18;
K = 21; T = 3/12; r = 0.12;

u = Su/S0
d = Sd/S0

p = (exp(r*T)-d)/(u-d)

fu = max(Su-K, 0)
fd = max(Sd-K, 0)

f = (p*fu + (1-p)*fd)*exp(-r*T)

%% European Two Period
S0 = 20; Su = 22; Sd = 18; Suu = 24.2; Sud = 19.8; Sdd = 16.2;
K = 21; dt = 3/12; r =0.12; N = 2;

T = dt*N

u = Su/S0
d = Sd/S0

p = (exp(r*dt)-d)/(u-d)

fuu = max(Suu-K, 0)
fud = max(Sud-K, 0)
fdd = max(Sdd-K, 0)

fu = (p*fuu + (1-p)*fud)*exp(-r*dt)
fd = (p*fud + (1-p)*fdd)*exp(-r*dt)

f = (p*fu + (1-p)*fd)*exp(-r*dt)

%% American Two Period
S0 = 50; Su = 60; Sd = 40; Suu = 72; Sud = 48; Sdd = 32;
u = 1.2; d = 0.8;
K = 52; dt = 1; r = 0.05; N = 2; %% American Two Period

T = dt*N

p = (exp(r*dt)-d)/(u-d)

fuu = max(K-Suu,0)
fud = max(K-Sud,0)
fdd = max(K-Sdd,0)

fu = (p*fuu + (1-p)*fud)*exp(-r*dt)
fd = (p*fud + (1-p)*fdd)*exp(-r*dt)

fu = (p*fu + (1-p)*fd)*exp(-r*dt)

%% American Two period
S0 = 50; Su = 60; Sd = 40; Suu = 72; Sud = 48; Sdd = 32;
u=1.2; d = 0.8;

T = dt*N

p = (exp(r*dt) - d)/(u-d)

fuu = max(K-Suu,0)
fud = max(K-Sud,0)
fdd = max(K-Sdd,0)


fu1 = (p*fuu + (1-p)*fud)*exp(-r*dt)
fu = max(fu1, K-Su);

fd1 = (p*fud + (1-p)*fdd)*exp(-r*dt)
fd = max(fd1, K-Sd);

f1= (p*fu + (1-p)*fd)*exp(-r*dt)
f = max(f1, K-S0)

%%
S0=50;K=52;r=0.05;T=2;dt=1;N=2;sigma=0.3;

u = exp(sigma*sqrt(dt))
d =1/u

Su = S0*u;Sd=S0*d;Suu=Su*u;Sud=Su*d;Sdd=Sd*d;

p = (exp(r*dt) - d)/(u-d)

fuu = max(K-Suu,0)
fud = max(K-Sud,0)
fdd = max(K-Sdd,0)


fu1 = (p*fuu + (1-p)*fud)*exp(-r*dt);
fu = max(fu1, K-Su)

fd1 = (p*fud + (1-p)*fdd)*exp(-r*dt);
fd = max(fd1, K-Sd)

f1= (p*fu + (1-p)*fd)*exp(-r*dt);
f = max(f1, K-S0)

%% European N Period
clear; clc;
S0=20; K=21; r=0.12; T=1; %u=1.1; d=0.9;
N=1000;
dt = T/N;
sigma = 0.3;

u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));

p = (exp(r*dt)-d)/(u-d);
dt
p

% Calculate Suu, Sud, Sdd
% St(1)=Suu, St(2)=Sud, St(3)=Sdd
for i=0:N
    St(i+1)=S0*u^(N-i)*d^(i);
end
St

% Calculate fuu, fud, fdd
% ft(1)=fuu, ft(2)=fud, ft(3)=fdd
for i=0:N
    ft(i+1)=max(St(i+1)-K, 0);
end
ft

for j=0:N-1
    for i=1:N-j
        ft(i) = exp(-r*dt)*(p*ft(i) + (1-p)*ft(i+1));
    end
    
end

%for i=1:1
%    ft(i) = exp(-r*dt)*(p*ft(i) + (1-p)*ft(i+1));
%end
ft(1)

%% American Call Option N Period
clear; clc;
S0=20; K=21; r=0.12; T=1; %u=1.1; d=0.9;
N=1000;
dt = T/N;
sigma = 0.3;

u = exp(sigma*sqrt(dt));
d = exp(-sigma*sqrt(dt));

p = (exp(r*dt)-d)/(u-d);

for j=0:N-1
    for i=0:N-j
        St(i+1)=S0*u^(N-j-i)*d^(i);
    end
    
    if j==0
        for i=0:N
            ft(i+1)=max(St(i+1)-K, 0);
        end
  
    else
        for i=1:N-j
            ft(i) = max(exp(-r*dt)*(p*ft(i) + (1-p)*ft(i+1)), St(i)-K);
        end
    end
end

%for i=1:1
%    ft(i) = exp(-r*dt)*(p*ft(i) + (1-p)*ft(i+1));
%end
ft(1)


%% 주사위 1
clear; clc;
tic
% 몬테카를로 시뮬래이션은 횟수가 많아지면 속도가 느려진다는 단점이 있다.
Dice = zeros(6, 1); ns=1.0e7;
for iteration = 1:ns
    Random_number = rand(1,1)*6;
    if Random_number < 1
        Dice(1) = Dice(1)+1;
    elseif Random_number < 2
        Dice(2) = Dice(2)+1;
    elseif Random_number < 3
        Dice(3) = Dice(3)+1;
    elseif Random_number < 2
        Dice(4) = Dice(4)+1;
    elseif Random_number < 2
        Dice(5) = Dice(5)+1;
    elseif Random_number < 2
        Dice(6) = Dice(6)+1;
    end
end

Probaility = Dice/ns
1/6
toc

%% 주사위2
clear; clc;
tic
Dice = zeros(6, 1); ns=1.0e7;
for iteration = 1:ns
    Random_number = rand(1,1)*6;
    for i=1:6
        if Random_number < i && Random_number > i-1
            Dice(i) = Dice(i)+1;
            break
        end
    end
end

Probaility = Dice/ns
1/6
toc
%% 주사위 3
clear; clc;
tic
Dice = zeros(6,1);ns=1.0e7;
Random_number=rand(ns, 1)*6;
for i = 1:6
    Dice(i) = Dice(i) + sum((Random_number>i-1).*(Random_number<i));
end
Probaility = Dice/ns
1/6
toc

%% 원주율(적분)
clear; clc; hold on; axis square;
theta = linspace(0, 2*pi);
plot(cos(theta), sin(theta), 'k-')

%% 원주율(적분)
clear; clc;
ns = 1.0e7;
count = 0;
for iter = 1:ns
    x = rand(1)*2-1;
    y = rand(1)*2-1;
    d = sqrt(x^2+y^2);
    
    if d<1
        count = count + 1;
    end
end

PI = 4*count/ns %원 안에 들어갈 확률*4 = 원주율

%% 원주율(적분)
clear; clc;
for k=2:7
    count = 0;
    ns = 10^k;
    for iter = 1:ns
        x = rand(1)*2-1;
        y = rand(1)*2-1;
        d = sqrt(x^2+y^2);
        
        if d<1
            count = count + 1;
        end
    end
    
    PI = 4*count/ns
end
%% 원주율(적분)
% 굳이 몰라도 된다.
clear; clc;hold on; axis square;
theta = linspace(0, 2*pi);
plot(cos(theta), sin(theta), 'k-')


count = 0;
ns = 1.0e3;
Random = rand(ns, 2)*2-1;
r = sqrt(Random(:,1).^2+Random(:,2).^2);

for iter = 1:ns
    if r(iter) < 1
        count = count + 1;
        plot(Random(iter, 1),Random(iter,2),'r*')
    else
        plot(Random(iter, 1),Random(iter,2),'b*')
    end
    drawnow limitrate
end

PI = 4*count/ns
%% 주가 경로 생성
clear;clc;
oneyear = 365; T = 1; Nt = T*oneyear; dt = T/Nt;
r = 0.03; vol = 0.03;
S0 = 100;
S1 = S0*exp((r-0.5*vol^2)*dt+vol*sqrt(dt)*randn(1,1))

%%
clf;hold on;
S = zeros(1, Nt+1); S(1)=S0; t = 0:dt:T;
for i = 1:Nt
    S(i+1) = S(i)*exp((r-0.5*vol^2)*dt+vol*sqrt(dt)*randn());
end
plot(t,S)

%%
clf;hold on;
t = 0:dt:T; ns = 1000;
for iter=1:ns
    S = zeros(1,Nt+1);
    S(1)=S0;
    w=randn(1, Nt+1);
    
    for i = 1:Nt
        S(i+1) = S(i)*exp((r-0.5*vol^2)*dt+vol*sqrt(dt)*w(i));
    end
    plot(t,S)
    drawnow
end

%%
K=90; Price=0; t = 0:dt:T; ns = 10000;
for iter=1:ns
    S = zeros(1,Nt+1);
    S(1)=S0;
    w=randn(1, Nt+1);
    
    for i = 1:Nt
        S(i+1) = S(i)*exp((r-0.5*vol^2)*dt+vol*sqrt(dt)*w(i));
    end
    CallPayoff = max(S(end)-K,0);
    Price = Price + CallPayoff;
end
Price = Price*exp(-r*T)/ns
