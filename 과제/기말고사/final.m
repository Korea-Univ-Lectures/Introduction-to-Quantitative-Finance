%% Final exam
clear all; clc; % 리셋

coupon = [0.032 0.064 0.096 0.128 0.160 0.192]; % 쿠폰에 대한 정보
lizard_coupon = [0.032 0.064];   % 리자드 조기 상환으로 인해 받을 이자율

repay_n = length(coupon); % 상환이 되는 경우의 수
lizard_repay_n = length(lizard_coupon); % 리자드 조기 상환이 되는 경우의 수

strike_price = [0.92 0.92 0.90 0.90 0.85 0.65] * 100; % 행사 가격 (비율)
lizard_strike_price = [0.85 0.75] * 100; % 리자드 행사 가격(비율)

Kib = 0.65 * 100; % 낙인 배리어

face_value = 10000; % 투자하는 단위이다. 액면가를 의미한다.

S0 = [61800/61800 10863.45/10863.45 3380.16/3380.16] * 100; % 2020년 02월 14일 최초기준가격평가일 기분 삼성전자 보통주, HSCEI, S&P500기준이다. 
                                                      % 최초기준가격/최초기준가격 * 100이다.
                                                      % 최초 기준 가격 평가일 기준의 기초자산 가격이다. 

r = 0.0142; % CD금리, 평가하는 시기의 이자율, 2020년 02월 03일 기준이다.
vol = [0.2421 0.2414 0.2244]; % 기초자산의 변동성
rho = [0.4674 0.2256 0.1279]; % 기초자산의 일별수익률 간의 상관계수들

oneyear=365; dt=1/oneyear; % 356일 기준
check_day = [datenum('2020.08.11', 'yyyy.mm.dd') - datenum('2020.02.14', 'yyyy.mm.dd'); % 6개월 뒤
    datenum('2021.02.05', 'yyyy.mm.dd') - datenum('2020.02.14', 'yyyy.mm.dd'); % 12개월 뒤
    datenum('2021.08.10', 'yyyy.mm.dd') - datenum('2020.02.14', 'yyyy.mm.dd'); % 18개월 뒤
    datenum('2022.02.09', 'yyyy.mm.dd') - datenum('2020.02.14', 'yyyy.mm.dd'); % 24개월 뒤
    datenum('2022.08.09', 'yyyy.mm.dd') - datenum('2020.02.14', 'yyyy.mm.dd'); % 30개월 뒤
    datenum('2023.02.09', 'yyyy.mm.dd') - datenum('2020.02.14', 'yyyy.mm.dd'); % 36개월 뒤 (만기)
    ]+1; % 첫번째 저장된 것은 0일이라, 하루가 지나면 1을 더해줘야 한다.

tot_date = check_day(end)-1; % tot_date는 총 ELS의 기간.

corr3 = [1 rho(1) rho(3); rho(1) 1 rho(2); rho(3) rho(2) 1]; % correlation_matrix

M = chol(corr3); % 촐레스키 분해를 사용

payment = zeros(1, repay_n); % 6가지 상황에 대해서 repay를 얼마나 받게 될 것인가?

for j=1:repay_n % 6개의 상환경우에 받게 될 금액 계산을 위해 for문 시작
    payment(j) = face_value * (1 + coupon(j)); % 상환이 되는 경우(자동조기상환+만기상환), 쿠폰을 포함하여 얼마나 돌려 받게 될 것인지를 미리 계산해 놓는 것이다.
end % for문 종료

lizard_payment = zeros(1, lizard_repay_n); % 2가지 리자드 조기 상환에서 repay를 얼마나 받게 될 것인가?

for j=1:lizard_repay_n % 리자드 상환시 받게 될 금액 계산을 위해 for문 시작
    lizard_payment(j) = face_value * (1 + lizard_coupon(j)); % 리자드 조기상환이 되는 경우, 쿠폰을 포함하여 얼마나 돌려 받게 될 것인지를 미리 계산해 놓는 것이다.
end % for 문 종료

% 현재시점에서 1일이 지나면 2개의 데이터가 존재한다. 따라서 tot_date+1을 해주는 것이다.
% 0시점이 있다는 것이다.
SP1 = zeros(tot_date+1, 1); SP1(1) = S0(1); % 삼성전자 보통주에 대한 주가 패스 초기화
SP2 = zeros(tot_date+1, 1); SP2(1) = S0(2); % HSCEI에 대한 주가 패스 초기화
SP3 = zeros(tot_date+1, 1); SP3(1) = S0(3); % S&P500에 대한 주가 패스 초기화

tot_payoff = 0; % 마지막 만기 까지 갔을 때의 최종 payoff가 저장되는 공간.
ns = 10000; % Monte Carlo 시행을 반복할 횟수

for i = 1:ns % Monte Carlo simulation 시작
    w0 = randn(3, tot_date); % 난수 생성
    w = M*w0; % 난수 생성에 있어서 서로 연관성이 있다는 것으로 만든다.
    
    for j=1:tot_date % 주가 패스 그리기를 위한 for문 시작
        SP1(j+1) = SP1(j)*exp((r-vol(1)^2/2)*dt+vol(1)*sqrt(dt)*w(1,j)); % 블랙쇼츠머튼 모형으로 삼성전자 보통주 SP를 뿌린다.
        SP2(j+1) = SP2(j)*exp((r-vol(2)^2/2)*dt+vol(2)*sqrt(dt)*w(2,j)); % 블랙쇼츠머튼 모형으로 HSCEI SP를 뿌린다.
        SP3(j+1) = SP3(j)*exp((r-vol(3)^2/2)*dt+vol(3)*sqrt(dt)*w(3,j)); % 블랙쇼츠머튼 모형으로 S&P500 SP를 뿌린다.
    end % for문 종료

    WP = min(min(SP1, SP2), SP3); % 각 시점마다 낮은 가격, 즉 Worst Performer를 추출한다. 셋 중 가장 낮은 것으로 평가를 한다.
    
    Price_at_check_day = WP(check_day); % check day의 주가의 종가를 저장한다.
                                            
    payoff(1:repay_n) = 0; % 현재 시점으로 할인 할 때 기간 별로 다르게 할인하기 위해 공간을 따로 초기화 해준다. 
    
    for j=1:repay_n % Payoff 계산을 위한 for문 시작
        if Price_at_check_day(j) >= strike_price(j) % 모든 기초자산의 자동조기상환평가가격(1:5) + 만기평가가격(6)이 각 행사가격의 이상인 경우
            payoff(j) = payment(j); % payment를 준다.
            break % Payoff 계산이 끝났음
            
        elseif j==1 || j==2 % 만일 조기 상환이 되지 않았다면, 리자드 조기 상환이 가능한지 여부를 상펴본다.
            if min(WP(1:check_day(j))) >= lizard_strike_price(j) % 해당 check_day까지 리자드 행사가격 미만으로 떨어진 적이 없다면,
                payoff(j) = lizard_payment(j); % payoff를 lizard coupon으로 준다. 
                break % Payoff 계산이 끝났음. 조기상환 됨
            end % if 문 종료
            
        elseif j==6 % 만기평가일에도 상환을 받지 못했다면,
            if Price_at_check_day(j) < Kib % 그리고 만기평가일에 기초자산 중 어느 하나라도 낙인배리어보다 작으면,
                payoff(end) = face_value*WP(end)/100; % 손해를 보게 된다.
                break % Payoff 계산이 끝났음
            end % if문 종료
        end % if-elsif-elseif 문 종료
    end % Payoff 계산을 위한 for문 종료
   
    tot_payoff = tot_payoff + payoff; % 계속 누적 합을 계산한다.
end % Monte Carlo Simulation 종료

tot_payoff = tot_payoff/ns; % 평균을 낸다.

for j = 1:repay_n % 현재 시점으로의 할인을 위한 for문 시작
    disc_payoff(j) = tot_payoff(j)*exp(-r*check_day(j)/oneyear); % 그 평균을 각각 현재시점으로 할인을 해준다.
end % for문 종료

ELS_Price = sum(disc_payoff) % ELS 가격 평가

