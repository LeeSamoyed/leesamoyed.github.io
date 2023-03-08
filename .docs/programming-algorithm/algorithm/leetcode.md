# 力扣（LeetCode）

### 1. 两数之和

=== 'go'

    ```go
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

=== 'c'

    ```c
    int* twoSum(int* nums, int numsSize, int target, int* returnSize){
        for (int i = 0; i < numsSize; ++i) {
            for (int j = i + 1; j < numsSize; ++j) {
                if (nums[i] + nums[j] == target) {
                    int* ret = malloc(sizeof(int) * 2);
                    ret[0] = i, ret[1] = j;
                    *returnSize = 2;
                    return ret;
                }
            }
        }
        *returnSize = 0;
        return NULL;
    }
    ```

=== 'c++'

    ```c++
    class Solution {
    public:
        vector<int> twoSum(vector<int>& nums, int target) {
            int n = nums.size();
            for (int i = 0; i < n; ++i) {
                for (int j = i + 1; j < n; ++j) {
                    if (nums[i] + nums[j] == target) {
                        return {i, j};
                    }
                }
            }
            return {};
        }
    };
    ```

=== 'java'

    ```java
    class Solution {
        public int[] twoSum(int[] nums, int target) {
            for(int i=0;i<nums.length;i++){
                for(int j=0;j<nums.length;j++){
                    if(j != i && (nums[j]+nums[i]) == target){
                        return new int[]{i,j};
                    }
                }
            }
            return null;
        }    
    }
    ```

### 7. 整数反转

=== 'java'

    ```java
    class Solution {
        public int reverse(int x) {
            try {
                int Fx;
                String s = String.valueOf(x);
                String Fs = "";
                for (int i = s.length() - 1; i >= 0; i--) {
                    if (s.charAt(i) == '-') {
                        Fs = s.charAt(i) + Fs;
                    } else {
                        Fs = Fs + s.charAt(i);
                    }
                }
                Fx = Integer.valueOf(Fs);
                return Fx;
            }catch (Exception e){return 0;}

        }
    }
    ```


### 9. 回文数

!!! note "不使用数组"
        各人想法：如果不使用数组，当前的数字x每次都能通过%拿到最后一位(%10)，这个位数乘以它的位数为y，x减去y，应该要和它取模y一样过程如下：

```
假设现在为12321

1. 取位数1
2. 乘以100000
3. 12321-10000为2321，12321%10000为2321。否则false
4. 之后用2321/10就能得到232
5. 递归，直到小于100，用极限条件判断即可
```

=== 'go'

    ```go
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

=== 'java'

    ```java
    class Solution {
        public boolean isPalindrome(int x) {
            try {
                int Fx;
                String s = String.valueOf(x);
                String Fs = "";
                for (int i = s.length() - 1; i >= 0; i--) {
                    if (s.charAt(i) == '-') {
                        return false;
                    } else {
                        Fs = Fs + s.charAt(i);
                    }
                }
                Fx = Integer.valueOf(Fs);
                return Fx==x;
            }catch (Exception e){return false;}

        }
    }
    ```

### 13. 罗马数字转整数

=== 'go'
    ```go
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

=== 'java'

    '''java
    class Solution {
        public static int romanToInt(String s) {
            try {
                int roman = 0;
                s = s + "  ";

                for (int i = 0; i < s.length() - 1; ) {
                    // I
                    if (s.substring(i, i + 1).equals("I") && !s.substring(i + 1, i + 2).equals("V") && !s.substring(i + 1, i + 2).equals("X")) {
                        roman = roman + 1;
                        i = i + 1;
                    } else if (s.substring(i, i + 1).equals("I") && s.substring(i + 1, i + 2).equals("V")) {
                        roman = roman + 4;
                        i = i + 2;
                    } else if (s.substring(i, i + 1).equals("I") && s.substring(i + 1, i + 2).equals("X")) {
                        roman = roman + 9;
                        i = i + 2;
                    }
                    // V
                    if (s.substring(i, i + 1).equals("V")) {
                        roman = roman + 5;
                        i = i + 1;
                    }
                    // X
                    if (s.substring(i, i + 1).equals("X") && !s.substring(i + 1, i + 2).equals("L") && !s.substring(i + 1, i + 2).equals("C")) {
                        roman = roman + 10;
                        i = i + 1;
                    } else if (s.substring(i, i + 1).equals("X") && s.substring(i + 1, i + 2).equals("L")) {
                        roman = roman + 40;
                        i = i + 2;
                    } else if (s.substring(i, i + 1).equals("X") && s.substring(i + 1, i + 2).equals("C")) {
                        roman = roman + 90;
                        i = i + 2;
                    }
                    // L
                    if (s.substring(i, i + 1).equals("L")) {
                        roman = roman + 50;
                        i = i + 1;
                    }
                    // C
                    if (s.substring(i, i + 1).equals("C") && !s.substring(i + 1, i + 2).equals("D") && !s.substring(i + 1, i + 2).equals("M")) {
                        roman = roman + 100;
                        i = i + 1;
                    } else if (s.substring(i, i + 1).equals("C") && s.substring(i + 1, i + 2).equals("D")) {
                        roman = roman + 400;
                        i = i + 2;
                    } else if (s.substring(i, i + 1).equals("C") && s.substring(i + 1, i + 2).equals("M")) {
                        roman = roman + 900;
                        i = i + 2;
                    }
                    // D
                    if (s.substring(i, i + 1).equals("D")) {
                        roman = roman + 500;
                        i = i + 1;
                    }
                    // M
                    if (s.substring(i, i + 1).equals("M")) {
                        roman = roman + 1000;
                        i = i + 1;
                    }

                    if (s.substring(i, i + 1).equals(" ")) {
                        return roman;
                    }
                }

                return roman;
            }catch(Exception e){
                return 0;
            }
        }
    }
    '''

### 27. 移除元素

更多在于实现方向的转变，先达成一些条件，再寻求另一些条件。不要一味的考虑到暴力求解的情况。

```go
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

### 206. 反转链表

=== 'c++'

    ```c++
    /**
    * Definition for singly-linked list.
    * struct ListNode {
    *     int val;
    *     ListNode *next;
    *     ListNode() : val(0), next(nullptr) {}
    *     ListNode(int x) : val(x), next(nullptr) {}
    *     ListNode(int x, ListNode *next) : val(x), next(next) {}
    * };
    */
    class Solution {
    public:
        ListNode* reverseList(ListNode* head) {
            ListNode* prev = nullptr;
            ListNode* curr = head;
            while (curr){
                ListNode* next = curr->next;
                curr->next = prev;
                prev = curr;
                curr = next;
            }
            return prev;
        }
    };
    ```

### 704. 二分查找

```go
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

!!! note "O(n)时间限制"

```go
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

### 1365. 有多少小于当前数字的数字

=== 'python'

    ```python
    class Solution(object):

        def smallerNumbersThanCurrent(self, nums):
            """
            :type nums: List[int]
            :rtype: List[int]
            """
            self.nums = nums
            count = 0
            list = []
            for i in self.nums:
                for j in self.nums:
                    if i > j:
                        count = count + 1
                list.append(count)
                count = 0
            return list
    ```

### 1217. 玩筹码

=== 'java'

    ```java
    class Solution {
        public static int minCostToMoveChips(int[] chips) {
            int cost = 0;
            int costone = 0;

            for(int i=0;i<chips.length;i++){
                if(chips[i] % 2 == 0){
                    cost = cost + 1;
                }else{
                    costone = costone + 1;
                }
            }
            if(cost > costone){
                return costone;
            }
            return cost;
        }
    }
    ```

### LCP 01. 猜数字

=== 'java'

    ```java
    class Solution {
        public int game(int[] guess, int[] answer) {
            int count = 0;

            for(int i=0;i<3;i++){
                if(guess[i] == answer[i]){
                    count = count + 1;
                }
            }

            return count;
        }
    }
    ```

### LCP 02. 分式化简

=== 'java'

    ``` java
    class Solution {
            public static int[] fraction(int[] cont) {
            int m[] = new int[2];

            int mother = cont[cont.length - 1];
            int son = 1;
            int temp;

            if(cont.length == 1){
                m[0] = cont[0];
                m[1] = 1;
                return m;
            }

            for (int i = cont.length - 2; i > 0; i--) {
                son = cont[i]*mother + son;
                if(i!=0) {
                    temp = son;
                    son = mother;
                    mother = temp;
                }
            }
            son = cont[0] * mother + son;

            int s = getGCD1(mother,son);
            mother = mother/s;
            son = son/s;

            m[0] = Math.abs(son);
            m[1] = Math.abs(mother);


            for(int j=0;j<2;j++){
                System.out.println(m[j]);
            }

            return m;
        }

        public static int getGCD1(int num1, int num2) {
            num1 = Math.abs(num1);
            num2 = Math.abs(num2);
            while (num2 != 0) {
                int remainder = num1 % num2;
                num1 = num2;
                num2 = remainder;
            }

            return num1;
        }

    }
    ```

### 盲点解析

##### No 1. 数组声明能否不固定长度后续补充？

