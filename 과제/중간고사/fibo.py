def fib(n):
    a,b = 1,1
    if n==1 or n==2:
        return 1
        
    for i in range(n):
        a,b = b, a+b

    return a

print(fib(1476x))