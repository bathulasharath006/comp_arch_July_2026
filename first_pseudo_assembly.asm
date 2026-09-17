// Add the numbers - 1..10

Initialization:
	one = 1
	index = 10
	sum = 10

// sbn = subtract and branch if negative
// sbn a, b, <line_no> // a=a-b and if a<0, then goto 2 else next instruction.

1: sbn temp, temp, 2 // temp=0
2: sbn temp,index, 3 // temp = -1*index
3: sbn sum, temp, 4  // sum += index
4: sbn index, one, exit // index -= 1
5: sbn temp, temp, 6 // temp=0
6: sbn temp, one, 1 // (0-1 < 0), hence goto 1

exit
