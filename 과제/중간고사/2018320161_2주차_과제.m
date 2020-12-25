% 전체 화면 구성 예시
a = 20
b = [1 2 3]
c = a + b

help sin % sin 함수에 대한 간략한 설명을 알려준다.

doc sin % sin 함수에 대한 더 자세한 설명과 예제

lookfor sine % 함수명이 생각이 안 날때 사용한다.

% 주석! %은 주석을 의미한다. %이후는 무시한다. 한줄에만 적용이 된다.

int_a = 1; % int _a에 1 지정
int_b = 2; % int _b에 2 지정
sum = int_a + int_b; %두 변수의 합을 sum에 지정한다.

%배열과 변수

3+4 % ans = 7

3-4 % ans = -1

12/4 % 오른쪽 나눗셈
2\10 % 왼쪽 나눗 -> 행렬 연산에 사용된다.

2^5 % 지수승
exp(-2) % 지수 함

% ()의 사용법
% 함수명 (), 연산의 우선순위 ()


% 변수
% 변수명 = 지정할 값
x = 1
y = x % y = 1
x = 2*3
x = 3-2

% 단위 변수
% ans : 수식 결과를 자동으로 저장
3 - 7
x = 1

% eps : 부동 소수점 정밀도
% pi : 원주율
% Inf : 무한대
% NaN : 0/0 연산 불가

program = 'MATLAB'
a = 1
a = 1.5
a = -1.5
a = 's'

% 내장 함수
sin(pi/2)
cos(pi)
sqrt(4)
abs(-1)
log(exp(10)) % log = ln
log10(1e+2) % 1e+2 = 100 = 10^2


% 배열
x = [1 2; 3 4];
x = [1,2;3,4]; 
a = 1
a = [1 2] %대괄호
a = [1, 2]
a = [12]
a = [1,2;3,4]

x = 1 % 출력이 된다.
x = 1; %불필요한 출력물에 대해서는 ;를 붙여주자

eye(2)  
eye(3) 
eye(3,2)

zeros(2)
ones(2)

% 배역 원소 다루기
v = [1,2,3,4,5]
v(3)
v(5)
v(3:5)

% n:m -> n,n+1,n+2,...m
v = [1,2;3,4]
v(2,2) % 4
v= [1,2,3;4,5,6]
v(2,2) % 4
v(2,3) % 6

v =[1,2;3,4]
v(:,2) %2;4
v(1, :) % 1,2

a = [1,2,3;4,5,6]
a(1,2:3) %2,3
a(1:2, 3) % 3;6 
a(2,3) = 10 % [1,2,3;4,5,10]

a = [1 2]' % [1;2]
a = [1 1;2 2]' % [1,2;1,2]
a = [1 2 3; 4 5 6; 7 8 9'] % [1 4 7; 2 5 8; 3 6 9]

% 콜론 연산자 -> 등차수열 같은 것이다.
% x = i:j = i i+1 i+2 ... j
% x = i:j:k = i, i+j,i+2j,...,k
% 2:5 -> 2 3 4 5
% 2:2:6 -> 2,4,6
% 2:-1:6 -> []
% 6:-1:2 -. 6,5,4,3,2
% 2:2:5 -> 2 4


linspace(1,3,5) %linspace(최종 값, 최종 값, 초기 값과 최종 값 사이의 원소 갯수)
% 증분 = x(2) - x(1)

% 배열 연산자
a = [1 1; 1 1]
b = [2 2; 2 2]
a+b % [3 3; 3 3]
b-a % [1 1; 1 1]

A = [2 4 6], B = [1 2 3];
% . -> 항목별 계산
A.*B % [2 8 18]
A./B % [2 2 2]
A.\B % [0.5 0.5 0.5]
A.^B % [2 16 216]

A = [1 2;3 4]
A(3, :) = [5 6]
A(3, :) = []
A(2, :) = [5 6]

A = [1 2; 3 4]
A(:, 3) = [5;6]
A = [1 2; 3 4]
A(2, :) = []
A(2, :) = [5 6]

A=[0 1;2 3]; B=[4 5; 6 7]; C=[8 9]';
D=[A, B], E= [A;B]
F = [A,C]
% F= [A;C]-> 에러

A = [0 0 0 1 0]
find(A) % 4

size(A) % n m
length(A) % 1xm -> m













