%% 1
sum = 0
F1 = 1;
F2 = 1;
F3 = F1 + F2;
while F3 <= 2000000
    if mod(F3, 2) == 0
        sum += F3;
    end
    F1 = F2;
    F2 = F3;
    F3 = F1+ F3;

end

sum

%% 2


%% function 2
function n = Fibonachi(N)
    
end