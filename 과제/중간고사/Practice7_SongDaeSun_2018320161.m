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
F = (Su*delta-fu)*exp(-r*T)
f = S0*delta-F
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

fu= (p*fu + (1-p)*fd)*exp(-r*dt)

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