% 블랙숄츠머튼 (몬테카를로 시뮬레이션)
clear;clc;
randn('seed',1);Ns = 1.0e2;
S0 = 100;T = 1;dt=1/365;N = floor(T/dt);r = 0.1;
S1 = zeros(Ns,N+1); S1(:,1) = S0;sigma1 = 0.1;
S2 = zeros(Ns,N+1); S2(:,1) = S0;sigma2 = 0.1;
for ns=1:Ns
    e1 = randn(1,N);  e2 = randn(1,N);
    for n=1:N
        S1(ns,n+1) = S1(ns,n)*exp((r-0.5*sigma1^2)*dt+sigma1*sqrt(dt)*e1(n));
        S2(ns,n+1) = S2(ns,n)*exp((r-0.5*sigma2^2)*dt+sigma2*sqrt(dt)*e2(n));
    end
end
t = 0:dt:T;
figure(1);clf;hold on
plot(t,mean(S1,1),'r-')
plot(t,mean(S2,1),'b-')
%% 
clear;clc;
randn('seed',1);Ns = 1.0e2;
S0 = 100;T = 1;dt=1/365;N = floor(T/dt);r = 0.1;
S1 = zeros(Ns,N+1); S1(:,1) = S0; sigma1 = 0.1;
S2 = zeros(Ns,N+1); S2(:,1) = S0; sigma2 = 0.5;
for ns=1:Ns
    e1 = randn(1,N);  e2 = randn(1,N);
    for n=1:N
        S1(ns,n+1) = S1(ns,n)*exp((r-0.5*sigma1^2)*dt+sigma1*sqrt(dt)*e1(n));
        S2(ns,n+1) = S2(ns,n)*exp((r-0.5*sigma2^2)*dt+sigma2*sqrt(dt)*e2(n));
    end
end
t = 0:dt:T;
figure(1);clf;hold on
plot(t,mean(S1,1),'r-')
plot(t,mean(S2,1),'b-')
%% 
clear;clc;
randn('seed',1);Ns = 1.0e2;
S0 = 100;T = 1;dt=1/365;N = floor(T/dt);r = 0.1;
S1 = zeros(Ns,N+1); S1(:,1) = S0; sigma1 = 0.02;
S2 = zeros(Ns,N+1); S2(:,1) = S0; sigma2 = 0.02;
rho = -1.0;correlation_matrix = [1 rho;rho,1];
for ns=1:Ns
    e1 = randn(1,N);  e2 = randn(1,N);
    E1 = e1; E2 = rho*e1 + sqrt(1-rho^2)*e2;
    for n=1:N
        S1(ns,n+1) = S1(ns,n)*exp((r-0.5*sigma1^2)*dt+sigma1*sqrt(dt)*E1(n));
        S2(ns,n+1) = S2(ns,n)*exp((r-0.5*sigma2^2)*dt+sigma2*sqrt(dt)*E2(n));
    end
end
t = 0:dt:T;
figure(1);clf;hold on
plot(t,mean(S1,1),'r-')
plot(t,mean(S2,1),'b-')


%%
clear;clc
randn('seed',1);Ns = 1.0e6;
rho = -1.0;
 e1 = randn(1,Ns);  e2 = randn(1,Ns);
    E1 = e1; E2 = rho*e1 + sqrt(1-rho^2)*e2;
    
mean(E2)
std(E2)