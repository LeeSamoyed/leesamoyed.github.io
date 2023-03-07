# 力扣（LeetCode）

### 1. 两数之和

```
func twoSum(nums []int, target int) []int {
	answer := []int{0,0}
    for i:=0; i<len(nums); i++{
        for j:=i+1; j<len(nums); j++{
            if nums[i] + nums[j] == target{
                answer[0] = i
                answer[1] = j
                return answer
            }
        }
    }
	return answer
}
```

### 9. 回文数


思考：不使用数组
各人想法：如果不使用数组，当前的数字x每次都能通过%拿到最后一位(%10)，这个位数乘以它的位数为y，x减去y，应该要和它取模y一样过程如下：

```
假设现在为12321

1. 取位数1
2. 乘以100000
3. 12321-10000为2321，12321%10000为2321。否则false
4. 之后用2321/10就能得到232
5. 递归，直到小于100，用极限条件判断即可
```

```
func isPalindrome(x int) bool {
    if x<0{
        return false
    }

    if x<10{
		return true
	}
    
    if x<100 && x>=10{
        if (x/10) == (x%10){
            return true
        }else{
            return false
        }
    }

    num := strconv.Itoa(x)
    for w := 0; w<len(num)/2; w++{
        if num[w] != num[len(num)-w-1]{
            return false
        }
    }
    return true
}
```

### 13. 罗马数字转整数

```
func romanToInt(s string) int {
    
    result := 0
    
    for x := 0; x < len(s); x++{
        switch {
            case s[x] == 'M':
                result = result + 1000
            case s[x] == 'D':
                result = result + 500
            case s[x] == 'C':
                if x == len(s)-1{
                    result = result + 100
                }else if s[x+1] == 'D'{
                    result = result + 400
                    x = x+1
                }else if s[x+1] == 'M'{
                    result = result + 900
                    x = x+1
                }else{
                    result = result + 100
                }
            case s[x] == 'L':
                result = result + 50
            case s[x] == 'X':
                if x == len(s)-1{
                    result = result + 10
                }else if s[x+1] == 'L'{
                    result = result + 40
                    x = x+1
                }else if s[x+1] == 'C'{
                    result = result + 90
                    x = x+1
                }else{
                    result = result + 10
                }
            case s[x] == 'V':
                result = result + 5
            case s[x] == 'I':
                if x == len(s)-1{
                    result = result + 1
                }else if s[x+1] == 'V'{
                    result = result + 4
                    x = x+1
                }else if s[x+1] == 'X'{
                    result = result + 9
                    x = x+1
                }else{
                    result = result + 1
                }
            default:
                return result
        }
        if x == len(s)-1{
            return result
        }
    }
    return result
}
```

### 27. 移除元素

更多在于实现方向的转变，先达成一些条件，再寻求另一些条件。不要一味的考虑到暴力求解的情况。

```
func removeElement(nums []int, val int) int {

    count := 0

    for x:= 0; x<len(nums); x++{
        if nums[x] == val{
            count = count + 1
        }else{
            temp := nums[x-count]
            nums[x-count] = nums[x]
            nums[x] = temp
        }
    }

    return len(nums) - count
}
```

### 704. 二分查找

```
func search(nums []int, target int) int {
    head := 0
    tail := len(nums)-1
    target = findTarget(head, tail, target, nums)
    return target
}

func findTarget(head int, tail int, target int, nums []int) int{
    if target < nums[head] || target > nums[tail]{
		return -1
	}
    if head==tail{
        if nums[head+(tail-head)/2]==target{
            return head+(tail-head)/2
        }else{
            return -1
        }
    }
    
    if nums[head+(tail-head)/2]==target{
        return head+(tail-head)/2
    }else if nums[head+(tail-head)/2]<target{
        return findTarget(head+(tail-head)/2+1, tail, target, nums)
    }else{
        return findTarget(head, head+(tail-head)/2-1, target, nums)
    }
    return -1
}
```

### 977. 有序数组的平方

思考：O(n)解决方案

```
func sortedSquares(nums []int) []int {
   
    for x:=0; x<len(nums); x++{
        nums[x] = nums[x]*nums[x]
    }

    for x:=0; x<len(nums)-1; x++{
        for y := 0; y<len(nums)-1-x; y++{
            if nums[y] > nums[y+1]{
                temp := nums[y+1]
                nums[y+1] = nums[y]
                nums[y] = temp
            }
        }
    }
    
    return nums    
}
```


### 盲点解析

##### No 1. 数组声明能否不固定长度后续补充？

