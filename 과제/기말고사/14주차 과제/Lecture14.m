%% Monte Carlo 1 asset Step-Down ELS

% 우선 상품 설명을 해야 한다.
% line by line으로 설명하자.
% 중간에 값들을 출력해서 보여주기도 하자.

clear all; clc;
T = 3; 
oneyear = 360; 
dt=1/oneyear; 
tot_date = T*oneyear;

coupon = [0.025 0.05 0.075 0.10 0.125 0.15]; % 쿠폰에 대한 정보
dummy=0.15;

repay_n = length(coupon); % 조기 상환이 되는 경우의 갯수

check_day = tot_date * [1 2 3 4 5 6]/repay_n; % 우리가 평가하는 날짜들
%check_day
%return

strike_price = [0.9 0.9 0.9 0.8 0.85 0.85] * 100; 
Kib = 0.38 * 100;

face_value = 100; % 투자하는 단위이다.
S0 = 100; % 현재 기초자산의 종가를 의미 한다.
r = 0.03; % cd금리, 평가하는 시기의 이자율
vol = 0.3; 

payment = zeros(1, repay_n);

for j=1:repay_n
    payment(j) = face_value * (1 + coupon(j)); % 조기상환이 되는 경우, 쿠폰을 포함하여 얼마나 돌려 받게 될 것인지를 미리 계산해 놓는 것이다.
end
%payment
%return

SP = zeros(tot_date+1 ,1); % 주가 패스를 뿌린다.
SP(1) = S0;
tot_payoff = 0; % 마지막 만기 까지 갔을 때의 최종 payoff이다.
ns = 10000;

for i = 1:ns
    w = randn(1, tot_date); % 난수 생성
    
    for j=1:tot_date
        SP(j+1) = SP(j)*exp((r-vol(1)^2/2)*dt+vol(1)*sqrt(dt)*w(1,j)); % BSM로 SP를 뿌린다.
    end
    
    Price_at_check_day = SP(check_day + 1); % 6개월 후가 되는 것이다. 180일 "후"가 되는 것이다. 0부터 시작하기에 +1을 해줘야 한다. 
                                            % check day의 주가의 종가를 저장한다.
    %Price_at_check_day
    %return
                                            
    payoff(1:repay_n) = 0; % 조기 상환이 될 경우, 조기 상환으로 받는 가격이 정해져 있다. 나중에 각각 할인해 온다.
    
    repay_event = 0; % 조기 상환이 되느냐 아니냐
    
    for j=1:repay_n
        if Price_at_check_day(j) >=strike_price(j)
            payoff(j) = payment(j); 
            repay_event = 1; % 조기 상환이 되었다.
            break
        end
    end
    
    % payoff
    % repay_event
    % return
    
    if repay_event == 0 % 조기 상환이 되지 않은 경우
        if min(SP) >= Kib % 적어도 한번 낙인 베리어를 넘었는지 않았는지
            payoff(end) = face_value*(1+dummy); % 안 넘음
        else
            payoff(end) = face_value*SP(end)/100; % 넘음
        end
    end
    tot_payoff = tot_payoff + payoff; % 계속 누적 합을 계산한다.
end
tot_payoff = tot_payoff/ns; % 평균을 낸다.

for j = 1:repay_n
    disc_payoff(j) = tot_payoff(j)*exp(-r*check_day(j)/oneyear); % 그 평균을 각각 할인을 해준다.
end
% tot_payoff
% disc_payoff
% return

ELS_Price = sum(disc_payoff)
% 100보다 작다. 100보다 작은 상품을 100을 주고 파는 것이다. 그 차익에 대한 수익이 발생하는 것이다.
% 1-2차에서 상환이 되는 것이 가장 이상적임 그래야 win-win이 된다.
% 증권사에서는 1.3 정도의 수익을 가져가는 것이다.
% 구매자는 빨리 조기 상환을 받는 것이 좋다.

%% Monte Carlo 2 asset Step-Down ELS

% 우선 상품 설명을 해야 한다.
% line by line으로 설명하자.
% 중간에 값들을 출력해서 보여주기도 하자.

clear all; clc;
T = 3; 
oneyear = 360; 
dt=1/oneyear; 
tot_date = T*oneyear;

coupon = [0.025 0.05 0.075 0.10 0.125 0.15]; % 쿠폰에 대한 정보
dummy=0.15;

repay_n = length(coupon); % 조기 상환이 되는 경우의 갯수

check_day = ceil(tot_date * cumsum(ones(repay_n, 1))/repay_n); % 우리가 평가하는 날짜들
%check_day
%return

strike_price = [0.9 0.9 0.9 0.8 0.85 0.85] * 100; 
Kib = 0.38 * 100;

face_value = 100; % 투자하는 단위이다.
S0 = [100 100]; % 현재 기초자산의 종가를 의미 한다.
r = 0.03; % cd금리, 평가하는 시기의 이자율
vol = [0.3 0.3]; 
rho = 0.5;

corr2 = [1, rho ; rho, 1];
M = chol(corr2);

payment = zeros(1, repay_n);

for j=1:repay_n
    payment(j) = face_value * (1 + coupon(j)); % 조기상환이 되는 경우, 쿠폰을 포함하여 얼마나 돌려 받게 될 것인지를 미리 계산해 놓는 것이다.
end
%payment
%return

SP1 = zeros(tot_date+1, 1); 
SP2 = zeros(tot_date+1, 1); 

SP1(1) = S0(1);
SP2(1) = S0(2);

tot_payoff = 0; % 마지막 만기 까지 갔을 때의 최종 payoff이다.
ns = 10000;

for i = 1:ns
    w0 = randn(2, tot_date); % 난수 생성
    w = M*w0;
    %w
    
    
    for j=1:tot_date
        SP1(j+1) = SP1(j)*exp((r-vol(1)^2/2)*dt+vol(1)*sqrt(dt)*w(1,j)); % BSM로 SP를 뿌린다.
        SP2(j+1) = SP2(j)*exp((r-vol(2)^2/2)*dt+vol(2)*sqrt(dt)*w(2,j)); % BSM로 SP를 뿌린다.
    end
    %SP1
    %SP2
    %SP1(530)
    %SP2(324)
    WP = min(SP1, SP2); % 각 시점의 Worst Performer를 추출한다. 둘 중 낮은 것으로 평가를 한다.
    %WP(324)
    
    Price_at_check_day = WP(check_day + 1); % 6개월 후가 되는 것이다. 180일 "후"가 되는 것이다. 0부터 시작하기에 +1을 해줘야 한다. 
                                            % check day의 주가의 종가를 저장한다.
    %Price_at_check_day
    %return
                                            
    payoff(1:repay_n) = 0; % 조기 상환이 될 경우, 조기 상환으로 받는 가격이 정해져 있다. 나중에 각각 할인해 온다.
    
    repay_event = 0; % 조기 상환이 되느냐 아니냐
    
    for j=1:repay_n
        if Price_at_check_day(j) >=strike_price(j)
            payoff(j) = payment(j); 
            repay_event = 1; % 조기 상환이 되었다.
            break
        end
    end
    
    % payoff
    % repay_event
    % return
    
    if repay_event == 0 % 조기 상환이 되지 않은 경우
        if min(WP) >= Kib % 적어도 한번 낙인 베리어를 넘었는지 않았는지
            payoff(end) = face_value*(1+dummy); % 안 넘음
        else
            payoff(end) = face_value*WP(end)/100; % 넘음
        end
    end
    tot_payoff = tot_payoff + payoff; % 계속 누적 합을 계산한다.
end
tot_payoff = tot_payoff/ns; % 평균을 낸다.

for j = 1:repay_n
    disc_payoff(j) = tot_payoff(j)*exp(-r*check_day(j)/oneyear); % 그 평균을 각각 할인을 해준다.
end
% tot_payoff
% disc_payoff
% return

ELS_Price = sum(disc_payoff)
% 100보다 작다. 100보다 작은 상품을 100을 주고 파는 것이다. 그 차익에 대한 수익이 발생하는 것이다.
% 1-2차에서 상환이 되는 것이 가장 이상적임 그래야 win-win이 된다.
% 증권사에서는 1.3 정도의 수익을 가져가는 것이다.
% 구매자는 빨리 조기 상환을 받는 것이 좋다.

% 담주는 수시로 메일을 주는 것으로 일주일간 프로젝트에 대해서 

% 동영상은 얼굴 1번 확인하자. 학번과 이름을 말하자.

%% Monte Carlo 3 asset Step-Down ELS
clear all; clc;
T = 3; 
oneyear = 360; 
dt=1/oneyear; 
tot_date = T*oneyear;

coupon = [0.025 0.05 0.075 0.10 0.125 0.15]; % 쿠폰에 대한 정보
dummy=0.15;

repay_n = length(coupon); % 조기 상환이 되는 경우의 갯수

check_day = ceil(tot_date * cumsum(ones(repay_n, 1))/repay_n) + 1; % 우리가 평가하는 날짜들
%check_day
%return

strike_price = [0.9 0.9 0.9 0.8 0.85 0.85] * 100; 
Kib = 0.38 * 100;

face_value = 10000; % 투자하는 단위이다.
S0 = [100 100 100]; % 현재 기초자산의 종가를 의미 한다.
r = 0.03; % cd금리, 평가하는 시기의 이자율
vol = [0.3 0.3 0.3]; 
rho = [0.5 0.5 0.5];

oneyear=365; dt=1/oneyear;
check_day = [datenum('2017.10.10') - datenum('2017.04.13');
    datenum('2018.04.10') - datenum('2017.04.13');
    datenum('2018.10.05') - datenum('2017.04.13');
    datenum('2019.10.05') - datenum('2017.04.13');
    datenum('2019.10.04') - datenum('2017.04.13');
    datenum('2020.04.08') - datenum('2017.04.13');
    ]+1;

tot_date = check_day(end)-1;

corr3 = [1 rho(1) rho(3); 
    rho(1) 1 rho(2); 
    rho(3) rho(2) 1];
M = chol(corr3);

payment = zeros(1, repay_n);

for j=1:repay_n
    payment(j) = face_value * (1 + coupon(j)); % 조기상환이 되는 경우, 쿠폰을 포함하여 얼마나 돌려 받게 될 것인지를 미리 계산해 놓는 것이다.
end
%payment
%return

SP1 = zeros(tot_date+1, 1); 
SP2 = zeros(tot_date+1, 1);
SP3 = zeros(tot_date+1, 1); 

SP1(1) = S0(1);
SP2(1) = S0(2);
SP3(1) = S0(3);

tot_payoff = 0; % 마지막 만기 까지 갔을 때의 최종 payoff이다.
ns = 10000;

for i = 1:ns
    w0 = randn(3, tot_date); % 난수 생성
    w = M*w0;
    
    %w
    
    for j=1:tot_date
        SP1(j+1) = SP1(j)*exp((r-vol(1)^2/2)*dt+vol(1)*sqrt(dt)*w(1,j)); % BSM로 SP를 뿌린다.
        SP2(j+1) = SP2(j)*exp((r-vol(2)^2/2)*dt+vol(2)*sqrt(dt)*w(2,j)); % BSM로 SP를 뿌린다.
        SP3(j+1) = SP3(j)*exp((r-vol(3)^2/2)*dt+vol(3)*sqrt(dt)*w(3,j)); % BSM로 SP를 뿌린다.
    end
    %SP1
    %SP2
    %SP1(530)
    %SP2(324)
    WP = min(min(SP1, SP2), SP3); % 각 시점의 Worst Performer를 추출한다. 둘 중 낮은 것으로 평가를 한다.
    %WP(324)
    
    Price_at_check_day = WP(check_day); % 6개월 후가 되는 것이다. 180일 "후"가 되는 것이다. 0부터 시작하기에 +1을 해줘야 한다. 
                                            % check day의 주가의 종가를 저장한다.
    %Price_at_check_day
    %return
                                            
    payoff(1:repay_n) = 0; % 조기 상환이 될 경우, 조기 상환으로 받는 가격이 정해져 있다. 나중에 각각 할인해 온다.
    
    repay_event = 0; % 조기 상환이 되느냐 아니냐
    
    for j=1:repay_n
        if Price_at_check_day(j) >=strike_price(j)
            payoff(j) = payment(j); 
            repay_event = 1; % 조기 상환이 되었다.
            break
        end
    end
    
    % payoff
    % repay_event
    % return
    
    if repay_event == 0 % 조기 상환이 되지 않은 경우
        if min(WP) >= Kib % 적어도 한번 낙인 베리어를 넘었는지 않았는지
            payoff(end) = face_value*(1+dummy); % 안 넘음
        else
            payoff(end) = face_value*WP(end)/100; % 넘음
        end
    end
    tot_payoff = tot_payoff + payoff; % 계속 누적 합을 계산한다.
end
tot_payoff = tot_payoff/ns; % 평균을 낸다.

for j = 1:repay_n
    disc_payoff(j) = tot_payoff(j)*exp(-r*check_day(j)/oneyear); % 그 평균을 각각 할인을 해준다.
end
% tot_payoff
% disc_payoff
% return

ELS_Price = sum(disc_payoff)
% 100보다 작다. 100보다 작은 상품을 100을 주고 파는 것이다. 그 차익에 대한 수익이 발생하는 것이다.
% 1-2차에서 상환이 되는 것이 가장 이상적임 그래야 win-win이 된다.
% 증권사에서는 1.3 정도의 수익을 가져가는 것이다.
% 구매자는 빨리 조기 상환을 받는 것이 좋다.

% 담주는 수시로 메일을 주는 것으로 일주일간 프로젝트에 대해서 

% 동영상은 얼굴 1번 확인하자. 학번과 이름을 말하자.

