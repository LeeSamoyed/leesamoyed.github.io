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


### 盲点解析

##### No 1. 数组声明能否不固定长度后续补充？

