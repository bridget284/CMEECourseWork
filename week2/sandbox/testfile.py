#lists
MyList = [3,2.44,"green",True]
MyList.append("a new item")
%whos
print(type(MyList))
del MyList[2]

#tuples
MyTuple = ("a", "b", "c")
print(MyTuple)
type(MyTuple)
MyTuple[0]
len(MyTuple)

#sets
a = [5,6,7,7,7,8,9,9]
b = set(a)
c = set([3,4,5,6])
b & c
b | c

#deep copy
c = [[1,2], [3,4]]
d = copy.deepcopy(c)
c[0][1] = 22

