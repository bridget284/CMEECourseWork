i = 1
x = 0
for i in range(10):
    x+=1
print(i)
print(x)

i = 1 
x = 0
def a_function(y):
    x=0
    for i in range(y):
        x +=1
    return x
a_function(10)
print(i)
print(x)


















_a_global = 10 #a global variable

if _a_global >= 5:
    _b_global = _a_global + 5 

print("Before calling a function, outside the function, the value of _a_global is", _a_global)
print("Before calling a function, outside the function, the value of _b_global is", _b_global)

def a_function():
    _a_global = 4

    if _a_global >= 4:
        _b_global = _a_global + 5

    _a_local = 3

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)

a_function()

print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
print("After calling a_function, outside the function, the value of _b_global is (still)", _b_global)
print("After calling a_function, outside the function, the value of _a_local is ", _a_local)
        



def modify_list_1(some_list):
    print("got", some_list)
    some_list = [1, 2, 3, 4]
    print("set to", some_list)

my_list = [1,2,3]
print("before, my list =", my_list)
modify_list_1(my_list)
print("after, my list =", my_list)