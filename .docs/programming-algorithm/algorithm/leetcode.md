# 力扣（LeetCode）

## LeetCode

### 1. 两数之和 - go限制解释

!!! tip "思路"
    两层循环暴力破解

!!! warning "go语言与其他语言不同的在于返回会很受限制"

    例如下面这个返调用会报错：cannot use str_ (type [5]int) as type []int in argument to re

    ```go
    package main

    func main() {
        str_in := [5]int{1,2,3,4,5}
        re(str_in)
    }

    func re(str_in []int) []int{
        return str_in
    }
    ```

    同理，下面这个返回会报错：cannot use re(str_in) (type []int) as type [5]int in assignment

    ```go
    package main

    func main() {
        str_in := []int{1,2,3,4,5}
        var str_out [5]int
        str_out = re(str_in)
    }

    func re(str_in []int) []int{
        return str_in
    }
    ```

    数组声明能否不固定长度后续补充？


=== "go"

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

=== "c"

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

=== "c++"

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

=== "java"

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

### 3. 无重复字符的最长子串

!!! tip "思路"
    掐头去尾
    abcde 遇到 c
    abcde -> cdec -> dec
    如果直接写 len(str)[index+1:]（index指c是在最长子串abcde中的位置），可能由于index只有一个导致报错，所以先加上最后一个，在用[1:]区分
    很直接的暴力思路
    
=== "go"

    ```go
    func lengthOfLongestSubstring(s string) int {
        if len(s)<=1{
            return len(s)
        }
        str := string(s[0])
        ans := 1
        flag := 0
        index := 0
        for i:=1; i<len(s); i++{
            for j:=0; j<len(str); j++{
                if str[j] == s[i]{
                    flag = 1
                    index = j
                }
            }
            if flag == 0{
                str = str + string(s[i])
                if len(str) > ans{
                    ans = len(str)
                }
            }else{
                str = (str[index:] + string(s[i]))[1:]
                flag = 0
            }
        }
        return ans
    }
    ```

### 7. 整数反转 - 整数题思路

!!! tip "思路"
    整数变字符串变整数

!!! warning "整数思路"
    整数多考虑使用余数和除法，别老考虑使用字符串

    可以使用int来赋值进行try catch

    看看多年前的Java，再看看现在，啧啧啧

=== "go"

    ```go
    func reverse(x int) int {

        length := int(len(strconv.Itoa(x)))
        sum := 0

        if x < 0{
            x = -x
            for i:=0; i<length-1; i++{
                sum = sum + x % int(math.Pow(10, float64(i+1))) / int(math.Pow(10, float64(i))) * int(math.Pow(10, float64(length-i-2)))
                x = x - x % int(math.Pow(10, float64(i+1)))
                if sum > int(math.Pow(2, float64(31)))-1 || sum < -int(math.Pow(2, float64(31))){
                    return 0
                }
            }
            return -sum
        }else{
            for i:=0; i<length; i++{
                sum = sum + x % int(math.Pow(10, float64(i+1))) / int(math.Pow(10, float64(i))) * int(math.Pow(10, float64(length-i-1)))
                if sum > int(math.Pow(2, float64(31)))-1 || sum < -int(math.Pow(2, float64(31))){
                    return 0
                }
            }
            return sum
        }
        return sum
    }
    ```

=== "java"

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

!!! tip "思路"
    先排出一位数，两位数的情况

    其余情况，转化成字符串

    按着第一位是否和最后一位相等判断

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

=== "go"

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

=== "java"

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

!!! tip "思路"

    if-else按着%算就行

    注意变化始终在特定某一个字母在另一个特定字符左边的时候（左闭右开考虑即可）

=== "go"

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

=== "java"

    ```java
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
    ```



### 14. 最长公共前缀

!!! tip "思路"
    两层循环暴力求解（毕竟是前缀，不是最长公共字符串）


=== "go"

    ```go
    func longestCommonPrefix(strs []string) string {
    
        short := 201
        index := -1

        for x:=0; x<len(strs); x++{
            if len(strs[x]) < short{
                short = len(strs[x])
                index = x
            }
        }

        if short < 0{
            return ""
        }

        result := ""

        for x:=0; x<len(strs[index]); x++{
            prefix := strs[index][:x+1]
            for y :=0; y<len(strs); y++{
                if prefix != strs[y][:x+1]{
                    return result
                }
            }
            result = prefix
        }
        return result
    }
    ```  

### 19. 删除链表的倒数第N个结点

!!! tip "思路"

    反转之后正向删除，再反转回来

=== "go"

    ```
    /**
    * Definition for singly-linked list.
    * type ListNode struct {
    *     Val int
    *     Next *ListNode
    * }
    */
    func removeNthFromEnd(head *ListNode, n int) *ListNode {
        
        var ans *ListNode
        head = reverseList(head)
        ans = head
        n = n-1
        if n == 0{
            head = head.Next
            head = reverseList(head)
            return head
        }
        for i:=1; i<n; i++{
            head = head.Next
        }
        if head.Next.Next == nil{
            head.Next = nil
        }else{
            head.Next = head.Next.Next
        }
        ans = reverseList(ans)
        return ans
    }

    func reverseList(head *ListNode) *ListNode {

        if head == nil || head.Next == nil{
            return head
        }
        
        var pre, cur *ListNode
        pre = nil
        cur = head
        for (cur != nil) {
            nex := cur.Next;
            cur.Next = pre;
            pre = cur;
            cur = nex;
        }
        return pre;

    }
    ```

### 20. 有效的括号 - ||和&&注意事项

!!! tip "思路"
    排出特殊情况之后，用字符串构造一个假的栈

!!! warning "if判断的时候||和&&"
    || 有一个1则过

    && 有一个0则不过

    例如下面这一句话中如果len(s_)<0，则不会判断后面s_[len(s_)-1]=='('，因此不必担心len(s_)-1为-1的情况

    ```go
    if s[x]==')' && len(s_)>0 && s_[len(s_)-1]=='('
    ```

=== "go"

    ``` go
    func isValid(s string) bool {
        var s_ string
        s_ = ""
        if len(s)==0{
            return true
        }

        for x:=0; x<len(s); x++{

            if s[x]=='(' || s[x]=='[' || s[x]=='{'{
                s_ = s_+s[x:x+1]
            }else if s[x]==')' && len(s_)>0 && s_[len(s_)-1]=='(' {
                s_ = s_[:len(s_)-1]
            }else if s[x]==']'  && len(s_)>0 && s_[len(s_)-1]=='['{
                s_ = s_[:len(s_)-1]
            }else if s[x]=='}'  && len(s_)>0 && s_[len(s_)-1]=='{'{
                s_ = s_[:len(s_)-1]
            }else{
                return false
            }
        }
        if s_==""{
            return true
        }
        return false
        
    }   
    ```

### 24. 两两交换链表中的节点 - 腾讯笔试升级版

!!! tip "思路"

    直接换

=== "go"

    ```
    /**
    * Definition for singly-linked list.
    * type ListNode struct {
    *     Val int
    *     Next *ListNode
    * }
    */
    func swapPairs(head *ListNode) *ListNode {
        // write code here
        if head == nil || head.Next == nil {
            return head
        }
        
        var first, second *ListNode
        
        first, second = head, head.Next
        first.Next = swapPairs(second.Next)
        second.Next = first 
        return second 
        
    }
    ```

=== go(升级版)

    ```
    package main
    import . "nc_tools"

    /*
    * type ListNode struct{
    *   Val int
    *   Next *ListNode
    * }
    */

    /**
    * 代码中的类名、方法名、参数名已经指定，请勿修改，直接返回方法规定的值即可
    * 
    * @param head ListNode类 
    * @return ListNode类
    */
    func reorderList( head *ListNode ) *ListNode {
        // write code here
        if head == nil || head.Next == nil || head.Next.Next == nil{
            return head
        }
        
        var first, second, third, fourth *ListNode
        
        if head.Next.Next.Next != nil{
            first, second, third, fourth = head, head.Next , head.Next.Next, head.Next.Next.Next
            second.Next = reorderList(fourth.Next)
            fourth.Next = first 
            return third 
        }else{
            first, second, third = head, head.Next , head.Next.Next
            second.Next = third.Next
            third.Next = first
            return third
        }
        
        
    }
    ```

### 26. 删除有序数组中的重复项 - Attention

!!! tip "思路"

    遇到第几个不同的，数组的第几个位置就行（他只需要返回前面不同的，后面的完全不在意，直接覆盖就好）

!!! warning "思考的思路"

    在解题之前可以先观察一下，它的标准答案，例如第一次循环的答案，第二次循环的答案（简单的思考）。就可以获得高效的答案

=== "go"

    ```go
    func removeDuplicates(nums []int) int {
        
        nums_now := 10001
        new := 0

        if len(nums)==0{
            return 0
        }

        for i:=0; i<len(nums); i++{
            
            if nums_now != nums[i]{
                nums_now = nums[i]
                nums[new] = nums_now
                new = new+1
            }
        }

        return new
        
    }
    ```

### 27. 移除元素

!!! tip "思路"

    先确定要移除多少元素（最后剩下多场），之后平移就行（因为一定会把所有匹配的元素都向后挪，每一次都保证匹配的元素在后面的话，那么久能始终知道要将不匹配的元素向前挪动多少）

    更多在于实现方向的转变，先达成一些条件，再寻求另一些条件。不要一味的考虑到暴力求解的情况。

=== "go"

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

### 35. 搜索插入的位置

!!! tip "思路"
    正常按着条件走，同时在一开始排出两个极端情况即可

=== "go"

    ```go
    func searchInsert(nums []int, target int) int {
        if nums[0] > target{
                return 0
            }
        if nums[len(nums)-1]<target{
            return len(nums)
        }
        
        for x:=0; x<len(nums); x++{
            if nums[x] == target{
                return x
            }
            if nums[x] < target && nums[x+1] > target{
                return x+1
            }
        }
        return 0
    }
    ```

### 58. 最后一个单词的长度
!!! tip "思路"
    简单的切割，极致的享受（但是系统方法一般不是最优解）

=== "go"

    ```go
    func lengthOfLastWord(s string) int {
        arr := strings.Split(s," ")

        for x:=len(arr)-1;x>=0;x--{
            if len(arr[x])>0{
                return len(arr[x])
            } 
        }

        return 0
    }
    ```

### 59. 螺旋矩阵II - 数组声明

!!! tip "思路"
    两个flag，一个记录已经转了几圈，一个记录方向（逻辑顺畅即可）

    不过记得每转一圈，就会减少2的行列

!!! warning "数组声明"
    go中类似C++声明空的数组很麻烦（不用:=进行赋值的话）

    需要申请多维数组的一维，然后再其中在申请数组，方式如下

    ```go
    result := make([][]int, n)
    for i := range result {
        result[i] = make([]int, n)
    }
    ```

    同时需要注意数组是一个完整的连续的内存地址，以Java为例，3*3的二维数组应该是4条完整的空间（索引+3个内容）

=== "go"

    ```go
    func generateMatrix(n int) [][]int {
        result := make([][]int, n)
        for i := range result {
            result[i] = make([]int, n)
        }
        nums := 0
        forward := 0
        count := 1
        for {
            switch{
                case forward==0: {
                    for y:=0; y<n-nums*2; y++{
                        result[nums][y+nums] = count
                        count = count+1
                        if count == n*n+1{
                            return result
                        } 
                    }  
                    forward = 1 
                }
                case forward==1: {
                    for y:=0; y<n-nums*2-1; y++{
                        result[y+nums+1][n-nums-1] = count
                        count = count+1
                        if count == n*n+1{
                            return result
                        }
                    }
                    forward = 2
                    
                }
                case forward==2: {
                    for y:=0; y<n-nums*2-1; y++{
                        result[n-nums-1][n-nums-2-y] = count
                        count = count+1
                        if count == n*n+1{
                            return result
                        }
                    }
                    forward = 3 
                }
                case forward==3: {
                    for y:=0; y<n-nums*2-2; y++{
                        result[n-2-nums-y][nums] = count
                        count = count+1
                        if count == n*n+1{
                            return result
                        }
                    }
                    forward = 0
                    nums = nums+1
                }
            }
        }
        return result
    }
    ```

### 69. x的平方根

!!! tip "思路"
    二分查找

    注意(head+tail)/2的时候很可能遇到小数，然后向下去整之后就小于了，例如 例如x为17,head为3，tail为5如果取整，head就是3，tail就是4，但是期待的结果是head为4，tail为5，因此要加个限制，如下

    ```go
    if (head+tail)/2 * (head+tail)/2 > x{
                tail = (head+tail)/2
                if tail*tail < x{
                    tail = tail + 1
                }
            }else{
                head = (head+tail)/2
            }
    ```

=== "go"

    ```go
    func mySqrt(x int) int {
        head := 0
        tail := x
        for i:=0;i>-1;i++{

            if head*head == x{
                return head
            }

            if tail*tail == x{
                return tail
            }

            if tail == head + 1{
                return head
            }

            if (head+tail)/2 * (head+tail)/2 > x{
                tail = (head+tail)/2
                if tail*tail < x{
                    tail = tail + 1
                }
            }else{
                head = (head+tail)/2
            }
        }
        return 0
    }
    ```

### 83. 删除排序链表中的重复元素

!!! tip "思路"
    把头部存下来

    如果重复则Next直接等于Next的Next或者nil（倒数第二个元素和对应最后一个元素相同）

    循环一直跑就行

=== "go"

    ```go
    /**
    * Definition for singly-linked list.
    * type ListNode struct {
    *     Val int
    *     Next *ListNode
    * }
    */
    func deleteDuplicates(head *ListNode) *ListNode {
        var head_head *ListNode
        head_head = head

        if head == nil{
            return head
        }

        num_now := head.Val
        for head.Next != nil{
            if head.Next.Val == num_now{
                if head.Next.Next != nil{
                    head.Next = head.Next.Next
                }else{
                    head.Next = nil
                }
                
            }else{
                num_now = head.Next.Val
                head = head.Next
            }
        }
        return head_head
    }
    ```

### 118. 杨辉三角

!!! tip "思路"
    正常解答即可

=== "go"

    ```go
    func generate(numRows int) [][]int {
        
        total:=0
        result := make([][]int, numRows)
        for i:=1; i<=numRows; i++{
            total = total+i
            result[i-1] = make([]int, i)
            result[i-1][0]=1
            result[i-1][len(result[i-1])-1]=1
        }
        if numRows>2{
            for i:=2; i<numRows; i++{
                for j:=1; j<len(result[i])-1; j++{
                    result[i][j] = result[i-1][j]+result[i-1][j-1]
                }
            }
        }
        return result
    }
    ```

### 119. 杨辉三角 II

!!! tip "思路"
    正常解答即可

=== "go"

    ```go
    func getRow(rowIndex int) []int {
        total:=0
        result := make([][]int, rowIndex+1)
        for i:=1; i<=rowIndex+1; i++{
            total = total+i
            result[i-1] = make([]int, i)
            result[i-1][0]=1
            result[i-1][len(result[i-1])-1]=1
        }
        if rowIndex>=2{
            for i:=2; i<rowIndex+1; i++{
                for j:=1; j<len(result[i])-1; j++{
                    result[i][j] = result[i-1][j]+result[i-1][j-1]
                }
            }
        }
        return result[rowIndex]
    }
    ```

### 121. 买股票的最佳时机

!!! tip "思路"
    如果当前价格是不是最小的，不是则用最小的替换
    
    否则判断当前的价格减去最小的价格是不是利润最大的，是则替换

    理解贪心、动态规划之类的思想！！！

=== "go"

    ```go
    func maxProfit(prices []int) int {
        profit := 0
        price := prices[0]

        if len(prices)<2{
            return 0
        }

        for i:=1; i<len(prices); i++{
            if price > prices[i]{
                price = prices[i]
            }else if prices[i]-price > profit{
                profit = prices[i]-price
            }
        }

        if profit==0{
            return 0
        }

        return profit
    }
    ```
=== "go爆破——会超时"

    ```go
    func maxProfit(prices []int) int {
        maxprice:=0
        for i:=0; i<len(prices)-1; i++{
            for j:=i+1; j<len(prices); j++{
                if prices[j]-prices[i] > maxprice{
                    maxprice = prices[j]-prices[i]
                }
            }
        }
        if maxprice == 0{
            return 0
        }
        return maxprice
    }
    ```

### 125. 验证回文串 - 正则

!!! tip "思路"
    正则表达式+全小写

!!! warning "正则表达式"

    保留字母数字案例：

    ```go
    reg, _ := regexp.Compile("[^a-zA-Z0-9]+")
        s = reg.ReplaceAllString(s, "")
    ```

=== "go"

    ```go
    func isPalindrome(s string) bool {      
        if len(s) == 0{
            return false
        }

        reg, _ := regexp.Compile("[^a-zA-Z0-9]+")
        s = reg.ReplaceAllString(s, "")
        s = strings.ToLower(s)
        for i:=0; i<len(s)/2; i++{
            if s[i] != s[len(s)-1-i]{
                return false
            }
        }

        return true
    }
    ```

### 136. 只出现一次的数字

!!! tip "思路"
    正常做，（注意两次都要全部遍历，但是注意i!=j）

=== "go"

    ```go
    func singleNumber(nums []int) int {
        if len(nums)<2{
            return nums[0]
        }
        target := nums[0]
        flag := 0
        for i:=0; i<len(nums);i++{
            target = nums[i]
            flag = 0
            for j:=0; j<len(nums);j++{
                if i!=j && nums[j] == target{
                    flag = 1
                    break
                }
            }
            if flag == 0{
                return target
            }
        }
        return target
    }
    ```

### 142. 环形链表II

!!! tip "思路"

    成环的话，结点是确定不会变的，因此用一个list去已经遍历过的结点

=== "go"
    
    ```go
    /**
    * Definition for singly-linked list.
    * type ListNode struct {
    *     Val int
    *     Next *ListNode
    * }
    */
    func detectCycle(head *ListNode) *ListNode {
        var cur *ListNode
        var loc []*ListNode
        if head ==nil || head.Next == nil{
            return nil
        }
        cur = head
        loc = append(loc, cur)
        for cur.Next != nil{
            cur = cur.Next
            for i:=0; i<len(loc); i++{
                if cur == loc[i]{
                    return cur
                }
            }
            loc = append(loc, cur)
        }
        return nil
    }
    ```

### 182. 查找重复的电子邮箱 - SQL
!!! tip "思路"
    SQL

=== "sql"

    ```sql
    # Write your MySQL query statement below

    select email from Person group by email having count(email) > 1
    ```

### 195. 第十行 - Linux
!!! tip "思路"
    linux命令

=== "sh"

    ```sh
    #/bin/bash
    # 统计文件行数
    num=`cat file.txt | wc -l`
    # head 显示前几个 | tail 显示后几个 意思为显示前十个的最后一个
    ans=`cat file.txt | head -10 | tail -1`
    # 左边是否小于右边
    if [ $num -lt 10 ]
    then 
        echo ""
    else echo $ans
    fi
    ```

### 202. 快乐数 - Pow

!!! tip "思路"

    记住Pow

=== "go"

    ```go
    func res(n int) int{
        res:=0
        for n >= 1{
            res = res + int(math.Pow(float64(n%10),2))
            n=n/10
        }
        return res
    }

    func isHappy(n int) bool {
        repeat := [1000]int{0}
        for n != 1{
            n = res(n)
            if repeat[n] != 0{
                return false
            }else{
                repeat[n] = 1
            }
        }
        return true
    }
    ```

### 203. 移除链表元素 - 链表赋值过程

!!! tip "思路"
    正常判断即可

!!! warning "注意链表的赋值过程等"

=== "go"

    ```go
    /**
    * Definition for singly-linked list.
    * type ListNode struct {
    *     Val int
    *     Next *ListNode
    * }
    */
    func removeElements(head *ListNode, val int) *ListNode {
        if head == nil{
            return head
        }
        
        var ans *ListNode
        ans = head

        for head.Val == val{
            if head.Next != nil{
                head = head.Next
            }else{
                head = nil
                return head
            }
        }

        for ans.Next != nil{
            
            if ans.Next.Val != val{
                ans = ans.Next
            }else{
                if ans.Next.Next != nil{
                    ans.Next = ans.Next.Next
                }else{
                    ans.Next = nil
                    return head
                }
            }
            if ans.Next == nil{
                return head
            }
        }
        return head
    }
    ```

### 206. 反转链表 - 究极基本功

!!! tip "思路"

    直接将链表的连接反转过来，不用考虑把链表拔出来之类的（思路很重要）

=== "go"

    ```go
    /**
    * Definition for singly-linked list.
    * type ListNode struct {
    *     Val int
    *     Next *ListNode
    * }
    */

    func reverseList(head *ListNode) *ListNode {

        if head == nil || head.Next == nil{
            return head
        }
        
        var pre, cur *ListNode
        pre = nil
        cur = head
        for (cur != nil) {
            nex := cur.Next;
            cur.Next = pre;
            pre = cur;
            cur = nex;
        }
        return pre;

    }
    ```

=== "c++"

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

### 209. 长度最小的子数组

!!! tip "思路"
    先排出特殊情况：
    
    - 没有数组
    - 数组为1
    - 数组第一个大于target

    剩下的就是不够就加，大了就尝试减少（因为要连续）

    这中间判断一下当前长度和最短长度的关系

=== "go"

    ```go
    func minSubArrayLen(target int, nums []int) int {
        
        if len(nums) == 0{
            return 0
        }
        
        if len(nums) == 1 {
            if nums[0] > target{
                return 1
            }else{
                return 0
            }
            return 0
        }

        if nums[0] > target{
            return 1
        }

        length := 1
        length_shortest := 100001
        sum := nums[0]
        
        for x := 1; x<len(nums); x++{
            flag := 0
            length, length_shortest, sum, flag = shortest(target, nums, length, length_shortest, sum, x, flag)
        }
        
        if length_shortest == 100001{
            return 0
        }
        

        return length_shortest
    }

    func shortest(target int, nums []int, length int, length_shortest int, sum int, x int, flag int) (int, int, int, int){

        if flag == 0{
            length = length + 1
            sum = sum + nums[x]
            if sum >= target{
                if length < length_shortest{
                    length_shortest = length
                }
                length, length_shortest, sum, flag = shortest(target, nums, length, length_shortest, sum, x, 1)
            }
        }else{
            sum = sum - nums[x-length+1]
            if sum >= target{
                length = length -1
                if length < length_shortest{
                    length_shortest = length
                }
                length, length_shortest, sum, flag = shortest(target, nums, length, length_shortest, sum, x, 1)
            }else{
                sum = sum + nums[x-length+1]
            }
            return length, length_shortest, sum, flag
        }
        
        return length, length_shortest, sum, flag
    }
    ```

### 217. 存在重复元素
!!! tip "思路"

    排序

    遍历

=== "go"

    ```go
    func containsDuplicate(nums []int) bool {
        if len(nums) < 2{
            return false
        }
        sort.Ints(nums)
        index := nums[0]
        for i:=0; i<len(nums)-1; i++{
            if nums[i] == nums[i+1]{
                return true
            }
            if nums[i] != index{
                index = nums[i]
            }
        }
        return false
    }
    ```
### 225. 用队列实现栈 - 究极基本功

!!! tip "思路"

    用数组实现主队列和辅助队列
    
    一个队列为主队列，一个为辅助队列，当入栈操作时，我们先将主队列内容导入辅助队列，然后将入栈元素放入主队列队头位置，再将辅助队列内容，依次添加进主队列即可。

=== "go"

    ```go
    type MyStack struct {
        queue1, queue2 []int
    }


    func Constructor() (ans MyStack) {
        return
    }


    func (this *MyStack) Push(x int)  {
        this.queue2 = append(this.queue2, x)
        for len(this.queue1) > 0 {
            this.queue2 = append(this.queue2, this.queue1[0])
            this.queue1 = this.queue1[1:]
        }
        this.queue1, this.queue2 = this.queue2, this.queue1

    }


    func (this *MyStack) Pop() int {
        ans := this.queue1[0]
        this.queue1 = this.queue1[1:]
        return ans
    }


    func (this *MyStack) Top() int {
        return this.queue1[0]
    }


    func (this *MyStack) Empty() bool {
        return len(this.queue1) == 0
    }


    /**
    * Your MyStack object will be instantiated and called as such:
    * obj := Constructor();
    * obj.Push(x);
    * param_2 := obj.Pop();
    * param_3 := obj.Top();
    * param_4 := obj.Empty();
    */
    ```

### 232. 用栈实现队列 - 究极基本功

!!! tip "思路"

    用数组实现入栈和出栈实现

=== "go"

    ```go
    type MyQueue struct {
        inStack, outStack []int
    }


    func Constructor() MyQueue {
        return MyQueue{}
    }


    func (this *MyQueue) Push(x int)  {
        this.inStack = append(this.inStack, x)
    }

    func (this *MyQueue) in2out() {
        for len(this.inStack) > 0 {
            this.outStack = append(this.outStack, this.inStack[len(this.inStack)-1])
            this.inStack = this.inStack[:len(this.inStack)-1]
        }
    }

    func (this *MyQueue) Pop() int {
        if len(this.outStack) == 0 {
            this.in2out()
        }
        x := this.outStack[len(this.outStack)-1]
        this.outStack = this.outStack[:len(this.outStack)-1]
        return x
    }


    func (this *MyQueue) Peek() int {
        if len(this.outStack) == 0 {
            this.in2out()
        }
        return this.outStack[len(this.outStack)-1]
    }

    func (this *MyQueue) Empty() bool {
        return len(this.inStack) == 0 && len(this.outStack) == 0
    }


    /**
    * Your MyQueue object will be instantiated and called as such:
    * obj := Constructor();
    * obj.Push(x);
    * param_2 := obj.Pop();
    * param_3 := obj.Peek();
    * param_4 := obj.Empty();
    */
    ```

### 242. 有效的字母异位词

!!! tip "思路"

    因为只有小写字母可以直接储存（用数组，int('b'-'a')）这种方式

=== "go"

    ```go
    func isAnagram(s string, t string) bool {
        list_s := [26]int{0}
        list_t := [26]int{0}
        if len(s) != len(t) || len(s)<=0 || len(t)<=0{
            return false
        }
        for i:=0; i<len(s); i++{
            list_s[int(s[i]-'a')] = list_s[int(s[i]-'a')]+1
        }
        for i:=0; i<len(t); i++{
            list_t[int(t[i]-'a')] = list_t[int(t[i]-'a')]+1
        }
        for i:=0; i<len(list_s); i++{
            if(list_s[i] != list_t[i]){
                return false
            }
        }
        return true
    }
    ```

### 344. 反转字符串

!!! tip "思路"
    正常交换最后一个和第一个

=== "go"

    ```go
    func reverseString(s []byte)  {
        var temp byte
        if len(s)>1{
            for i:=0; i<len(s)/2; i++{
                temp = s[i]
                s[i] = s[len(s)-i-1]
                s[len(s)-i-1] = temp
            }
        }
    }
    ```

### 347. 前K个高频元素 - Bug

!!! tip "思路"

    桶排序或者Hash在第一时间没想到怎么用Go复现，给顶了0～100000的长度，就直接建立了200000的计数表(排除负数的情况，但是这里其实有个大Bug，就是给定的数不可以太大，不然表会非常大)

    然后建立了两个长度为K的数组，分别记录高频元素和其出现的次数。遍历时候对计数表进行++，找到最小的次数，如果这个出现的次数大于这个次数，则替换。当然这里要判断这个数字是否已经在这个列表中了，如果在，则直接对出现次数进行添加即可
    
    题目做下来的时间复杂度为O+K（感觉很快，但有Bug）
    
=== "go"

    ```go
    func topKFrequent(nums []int, k int) []int {
    
        count := [200000]int{0}
        ans_count := make([]int, k)
        ans := make([]int, k)
        index := -1

        for i:=0; i<len(nums); i++{
            ans_count, index = findMin(ans, ans_count, nums[i])
            count[nums[i]+100000] = count[nums[i]+100000]+1
            if count[nums[i]+100000] > ans_count[index]{  
                ans_count[index] = count[nums[i]+100000]
                ans[index] = nums[i]
            }
            
        }

        return ans
    }

    func findMin(ans []int, ans_count []int, nums int) ([]int, int){
        min := 100000
        index := -1
        for i:=0; i<len(ans_count); i++{
            if ans[i] == nums{
                min = ans_count[i]
                index = i
                return ans_count, index
            }
            if ans_count[i] < min{
                min = ans_count[i]
                index = i
            }

        }
        return ans_count, index
    }
    ```

### 349. 两个数组的交集

!!! tip "思路"

    送分题，可以参考1002解法

=== "go"

    ```go
    func intersection(nums1 []int, nums2 []int) []int {
        common := [1000]int{0}
        var ans []int
        for i:=0; i<len(nums1); i++{
            common[nums1[i]] = 1
        }
        for i:=0; i<len(nums2); i++{
            if common[nums2[i]] == 1{
                ans = append(ans, nums2[i])
                common[nums2[i]] = 2
            }
        }
        return ans
    }
    ```

### 383. 救赎信

!!! tip "思路"

    送分题

=== "go"

    ```go
    func canConstruct(ransomNote string, magazine string) bool {
        nums_ransomNote := [26]int{0}
        nums_magazine := [26]int{0}

        for i:=0; i<len(ransomNote);i++{
            nums_ransomNote[int(ransomNote[i]-'a')] = nums_ransomNote[int(ransomNote[i]-'a')]+1
        }
        for i:=0; i<len(magazine);i++{
            nums_magazine[int(magazine[i]-'a')] = nums_magazine[int(magazine[i]-'a')]+1
        }

        for i:=0; i<26;i++{
            if nums_ransomNote[i] > nums_magazine[i]{
                return false
            }
        }
        return true
    }
    ```

### 454. 两数相加

!!! tip "思路"

    由于存储大小有限制，所以不用考虑数组了，用Map直接做

=== "go"

    ```go
    // 暴力
    // func fourSumCount(nums1 []int, nums2 []int, nums3 []int, nums4 []int) int {
    //     ans := 0
    //     for num1:=0; num1<len(nums1); num1++{
    //         for num2:=0; num2<len(nums2); num2++{
    //             for num3:=0; num3<len(nums3); num3++{
    //                 for num4:=0; num4<len(nums4); num4++{
    //                     if nums1[num1] + nums2[num2] + nums3[num3] + nums4[num4] == 0{
    //                         count = count+1
    //                     }
    //                 }
    //             }
    //         }
    //     }
    //     return ans
    // }

    func fourSumCount(nums1 []int, nums2 []int, nums3 []int, nums4 []int) int {

        nums := map[int]int{}
        ans := 0

        for i:=0; i<len(nums1); i++{
            for j:=0; j<len(nums2); j++{
                nums[nums1[i]+nums2[j]] = nums[nums1[i]+nums2[j]] + 1
            }
        }

        fmt.Println(nums)

        for i:=0; i<len(nums3); i++{
            for j:=0; j<len(nums4); j++{
                ans = ans + nums[-nums3[i]-nums4[j]]
            }
        }

        return ans

    }
    ```

### 459. 重复的字符串

!!! tip "思路"

    爆破思路如上所示，但是超时

    把字符串扩充一倍，然后从头开始截取和原字符串一样长的字符串，如果原字符串能够重复，那么中间截取出来的某一个字符串一定能和原字符串相等

    假设原字符串为S1+S2（两倍情况），扩充之后为S1+S2+S1+S2，如果S1和S2不相等，那么S2+S1是不等于S1+S2的，反之则成立。

=== "go"

    ```go
    // func repeatedSubstringPattern(s string) bool {
    //     var sub string
    //     var ans string
    //     for i:=0; i<len(s); i++{
    //         for j:=1; i+j<len(s); j++{
    //             sub = s[i:i+j]
    //             ans = ""
    //             if len(s)%len(sub) == 0{
    //                 for x:=0; x<len(s)/len(sub); x++{
    //                     ans = ans + sub
    //                 }
    //                 if ans == s{
    //                     return true
    //                 }
    //             }
    //         }
    //     }
    //     return false
    // }

    func repeatedSubstringPattern(s string) bool {
        var com string
        ss := s+s
        for i:=1;i+len(s)<len(ss);i++{
            com = ss[i:i+len(s)]
            if com == s{
                return true
            }
        }
        return false
    }
    ```

### 541. 反转字符串II

!!! tip "思路"

    送分题，注意审题

=== "go"

    ```go
    func reverseStr(s string, k int) string {
        var ans string
        for len(s) >= k{
            var trans string
            if len(s) >= 2*k{
                trans = s[:2*k]
                s = s[2*k:]
            }else{
                trans = s[:len(s)]
                s = s[len(s):]
            }
            for i:=0; i<k; i++{
                ans = ans + string(trans[k-i-1:k-i])
            }
            ans = ans + trans[k:]
        }
        for i:=0; i<len(s); i++{
            ans = ans + string(s[len(s)-i-1:len(s)-i])
        }
        return ans
    }
    ```

### 704. 二分查找

!!! tip "思路"
    基本功

=== "go"

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

### 707. 设计链表 - 究极基本功

!!! tip "思路"

    基本功，多回忆，多练练

=== "go"

    ```go
    type MyLinkedList struct {
        head *ListNode
        size int
    }


    func Constructor() MyLinkedList {
        var myLinkedList MyLinkedList
        var head *ListNode
        size := 0
        myLinkedList.head = head
        myLinkedList.size = size
        return myLinkedList
    }


    func (this *MyLinkedList) Get(index int) int {
        
        if index < 0 || index >= this.size{
            return -1
        }else{
            var head *ListNode
            head = this.head
            for i:=0; i<index; i++{
                head = head.Next
            }
            return head.Val
        }
        return -1
    }


    func (this *MyLinkedList) AddAtHead(val int)  {
        this.AddAtIndex(0, val)
        
    }


    func (this *MyLinkedList) AddAtTail(val int)  {
        this.AddAtIndex(this.size, val)
    }


    func (this *MyLinkedList) AddAtIndex(index int, val int)  {

        if(this.size < index){
            return
        }
        if(index == 0){
            var _head ListNode
            _head.Val = val
            _head.Next = this.head
            this.head = &_head
            this.size = this.size + 1
        }else{
            var head *ListNode
            head = this.head
            for i:=0; i<index-1; i++{
                head = head.Next
            }
            var tail ListNode
            tail.Val = val
            tail.Next = head.Next
            head.Next = &tail
            this.size = this.size + 1
        }
        
    }


    func (this *MyLinkedList) DeleteAtIndex(index int)  {

        if(this.size <= index){
            return
        }else if(index == 0 && this.size > 1){
            this.head = this.head.Next
            this.size = this.size-1
        }else if(index == 0 && this.size == 1){
            var head *ListNode
            size := 0
            this.head = head
            this.size = size
            this.size = this.size-1
        }else if(index == this.size -1){
            var head *ListNode
            head = this.head
            for i:=0; i<index-1; i++{
                head = head.Next
            }
            head.Next = nil
            this.size = this.size-1
        }else if(this.size > index){
            var head *ListNode
            head = this.head
            for i:=0; i<index-1; i++{
                head = head.Next
            }

            head.Next = head.Next.Next
            this.size = this.size-1
        }
        return

    }


    /**
    * Your MyLinkedList object will be instantiated and called as such:
    * obj := Constructor();
    * param_1 := obj.Get(index);
    * obj.AddAtHead(val);
    * obj.AddAtTail(val);
    * obj.AddAtIndex(index,val);
    * obj.DeleteAtIndex(index);
    */
    ```

### 912. 排序数组 - Bug

!!! tip "排序整理"

    快速排序

=== "go标答"

    ```go
    import "math/rand"

    func sortArray(nums []int) []int {
    quick(&nums, 0, len(nums) - 1)
    return nums
    }

    func quick(arr *([]int), i, j int) {
    if i >= j {return}
    mid := partition(arr, i, j)
    quick(arr, i, mid - 1)
    quick(arr, mid + 1, j)
    }

    func partition(arr *([]int), i int, j int) int {
    p := rand.Intn(j - i + 1) + i  // 随机选取“支点”
    nums := *arr
    nums[i], nums[p]  = nums[p], nums[i]
    for i < j {
        for nums[i] < nums[j] && i < j { j-- }  // 修改原来的 nums[j] >= nums[i]，增加交换频率
        if (i < j) {
        nums[i], nums[j] = nums[j], nums[i]
        i++
        }
        for nums[i] < nums[j] && i < j { i++ }  // 修改原来的 nums[j] >= nums[i]，增加交换频率
        if i < j {
        nums[i], nums[j] = nums[j], nums[i]
        j--
        }
    }
    return i
    }
    ```

=== "go自己"

    ```go
    func sortArray(nums []int) []int {
        return quickSort(nums, 0, len(nums)-1)
    }

    func partition(nums []int, head int, tail int) int {

        base := nums[head]
        for head < tail{
            for head<tail && nums[tail] >= base{
                tail = tail -1
            }
            nums[head] = nums[tail]
            for head<tail && nums[head] <= base{
                head = head + 1
            }
            nums[tail] = nums[head]
        }
        nums[head] = base

        return head
    }

    func quickSort(nums []int, head int, tail int) []int {
        if tail > head{
            base := partition(nums, head, tail)
            quickSort(nums, head, base-1)
            quickSort(nums, base+1, tail)
        }
        return nums
    }
    ```

### 977. 有序数组的平方

!!! tip "思路"
    先平方
    
    然后冒泡

!!! note "O(n)时间限制"

=== "go"

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

### 1002. 查找公用字符

!!! tip "思路"

    这个题要是不统计重复会简单很多，开始统计重复就给人一种不是简单的题
    
    暴力的美，统计每个字符中a~z出现的次数，取公共都有的且最小的出现次数最少的为基准进行添加
    
    解释，a在每个字符串中都出现了，但是最少的是一次，那么就添加一个a进ans数组

=== "go"

    ```go
    func commonChars(words []string) []string {

        common := make([][]int, len(words))
        for i:=0; i<len(words); i++{
            common[i] = make([]int, 26)
        }

        for i:=0; i<len(words); i++{
            for j:=0; j<len(words[i]); j++{
                common[i][int(words[i][j]-'a')] = common[i][int(words[i][j]-'a')]+1
            }
        }

        var ans []string

        for i:=0; i<26; i++{
            min := 100
            flag := 0
            for j:=0 ; j<len(common); j++{
                if common[j][i] == 0{
                    flag = 1
                    j = j+26
                }else if common[j][i] < min{
                    min = common[j][i]
                }
            }
            if flag == 0{
                for x:=0; x<min; x++{
                    ans = append(ans, string('a'+i))
                }
            }
        }

        return ans
    }
    ```

=== "go(不统计重复)"

    func commonChars(words []string) []string {
        common := [26]int{0}

        for i:=0; i<len(words); i++{
            for j:=0; j<len(words[i]); j++{
                index := int(words[i][j]-'a')
                if common[index] == i{
                    common[index] = common[index] + 1
                }
            }
        }

        var ans []string

        for i:=0; i<len(common); i++{
            if common[i] == len(words){
                ans = append(ans, string('a'+i))
            }  
        }

        return ans
    }

### 1047. 删除字符串中的所有相邻重复项

!!! tip "思路"

    堆栈

=== "go"

    ```go
    func removeDuplicates(s string) string {
        var waitcom string
        for i:=0; i<len(s); i++{
            if len(waitcom) == 0{
                waitcom = waitcom+string(s[i:i+1])
            }else if string(s[i:i+1]) == waitcom[len(waitcom)-1:]{
                waitcom = waitcom[:len(waitcom)-1]
            }else{
                waitcom = waitcom+string(s[i:i+1])
            }
        }
        return waitcom
    }
    ```

### 1213. 三个有序数组的交集

=== "java"

    ```java
    class Solution {
        public static List<Integer> arraysIntersection(int[] arr1, int[] arr2, int[] arr3) {

            List<Integer> list = new LinkedList<>();

            int answer[] = new int[2001];
            for(int i=0;i<=2000;i++){
                answer[i] = 0;
            }

            for(int i=0;i<arr1.length;i++){
                answer[arr1[i]] = answer[arr1[i]] + 1;
            }
            for(int i=0;i<arr2.length;i++){
                answer[arr2[i]] = answer[arr2[i]] + 1;
            }
            for(int i=0;i<arr3.length;i++){
                answer[arr3[i]] = answer[arr3[i]] + 1;
            }

            for(int i=0;i<=2000;i++){
                if(answer[i] == 3){
                    list.add(i);
                }
            }

            return list;
        }
    }
    ```

### 1214. 查找两棵二叉搜索树之和

=== "java"

    ```java
    /**
    * Definition for a binary tree node.
    * public class TreeNode {
    *     int val;
    *     TreeNode left;
    *     TreeNode right;
    *     TreeNode(int x) { val = x; }
    * }
    */
    class Solution {
        public boolean twoSumBSTs(TreeNode root1, TreeNode root2, int target){
            List<Integer> list1=new ArrayList<>();
            List<Integer> list2=new ArrayList<>();
            order(root1,list1);
            order(root2,list2);

            for(int i=0;i<list1.size();i++){
                if(list2.contains(target-list1.get(i)) == true){
                    return true;
                }
            }
            return false;
        }
        public void order(TreeNode root,List<Integer> list){
            if(root==null){
                return ;
            }
            order(root.left,list);
            list.add(root.val);
            order(root.right,list);
        }

    }
    ```

### 1217. 玩筹码

=== "java"

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

### 1365. 有多少小于当前数字的数字

=== "python"

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

### 1637. 两点之间不包含任何点的最宽垂直区域

!!! tip "思路"

    这个题和纵坐标无关，把横坐标拉出来排序，前减后求最大值即可，不过没法冒泡，后续更新快排

=== "go"

    ```go
    func partition(list []int, low, high int) int {
        pivot := list[low] //导致 low 位置值为空
        for low < high {
            //high指针值 >= pivot high指针\U0001f448移
            for low < high && pivot <= list[high] {
                high--
            }
            //填补low位置空值
            //high指针值 < pivot high值 移到low位置
            //high 位置值空
            list[low] = list[high]
            //low指针值 <= pivot low指针\U0001f449移
            for low < high && pivot >= list[low] {
                low++
            }
            //填补high位置空值
            //low指针值 > pivot low值 移到high位置
            //low位置值空
            list[high] = list[low]
        }
        //pivot 填补 low位置的空值
        list[low] = pivot
        return low
    }

    func QuickSort(list []int,low,high int)  {
        if high > low{
            //位置划分
            pivot := partition(list,low,high)
            //左边部分排序
            QuickSort(list,low,pivot-1)
            //右边排序
            QuickSort(list,pivot+1,high)
        }
    }


    func maxWidthOfVerticalArea(points [][]int) int {
        list := make([]int, len(points))
        for i:=0; i<len(points); i++{
            list[i] = points[i][0]
        }

        // for i:=0; i<len(list); i++{
        //     max := list[i]
        //     max_index := i
        //     for j:=i+1; j<len(points); j++{
        //         if list[j] > max{
        //             max = list[j]
        //             max_index = j
        //         }
        //     } 
        //     temp := list[i]
        //     list[i] = max
        //     list[max_index] = temp
        // }

        QuickSort(list,0,len(list)-1)

        max := list[1]-list[0]
        for i:=1; i<len(list)-1; i++{
            if list[i+1]-list[i] > max{
                max = list[i+1]-list[i]
            }
        }
        return max
    }
    ```

### 1641. 统计字典序元音字符串的数目

!!! tip "思路"

    递归手撕

    不过注意以下两个代码区别

    ```
    count, level = chara('a', count, level, n)
    ```

    ```
    count, level = chara('a', count, level, n)
    count, level = chara('e', count, level, n)
    count, level = chara('i', count, level, n)
    count, level = chara('o', count, level, n)
    count, level = chara('u', count, level, n)
    ```

    在于其实每一次从a开始迭就可以了，如果加上后面的就会把从e, i, o, u开始的情况也算进去，等于做了多做了四次题目第一次是a, e, i, o, u，第二次是e, i, o, u ...

=== "go"

    ```go
    func countVowelStrings(n int) int {
        count := 0
        level := 0

        count, level = chara('a', count, level, n)

        return count
    }

    func chara(character byte, count int, level int, n int) (int, int) {
        if level == n{
            count = count + 1
            return count, level
        }
        level = level + 1
        if level <= n{
            switch character{
                case 'a':
                    count,level = chara('a', count, level, n)
                    fallthrough
                case 'e':
                    count, level = chara('e', count, level, n)
                    fallthrough
                case 'i':
                    count, level = chara('i', count, level, n)
                    fallthrough
                case 'o':
                    count, level = chara('o', count, level, n)
                    fallthrough
                case 'u':
                    count, level = chara('u', count, level, n)
            }
        }
        level = level - 1
        return count, level
    }
    ```

### 2367. 算术三元组的数目

!!! tip "思路"

    正常解答

=== "go"

    ```go
    func arithmeticTriplets(nums []int, diff int) int {

        count := 0

        for i:=0; i<len(nums); i++{
            for j:=i+1; j<len(nums); j++{
                if nums[j]-nums[i] == diff{
                    for ij:=j+1; ij<len(nums); ij++{
                        if nums[ij] - nums[j] == diff{
                            count = count + 1
                        }
                        if nums[ij] - nums[j] > diff{
                            ij = ij + len(nums)
                        }
                    }
                }
                if nums[j]-nums[i] > diff{
                    j = j+len(nums)
                }
            }
        }
        return count
    }
    ```

### 2427. 公因子的数目

!!! tip "思路"

    送分题

=== "go"

    ```go
    func commonFactors(a int, b int) int {
        max := a
        if b > max{
            max = b
        }
        count := 0
        for i:=1; i<=max ;i++{
            if (a%i == 0 && b%i == 0){
                count = count+1
            }
        }
        return count
    }
    ```

### LCP 01. 猜数字

=== "java"

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

=== "java"

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

## 笔试

### SHEIN - 2023.03.29

!!! note "题目"
    
    1. 平均年龄
    2. 马挡兵路

!!! tip "思路"

    1. 乘除少做，很多时候需要用数学思路解决问题！！！
    2. 

=== "go"

    ```
    package main

    import (
        "fmt"
    )

    func main() {
        W := 0
        Y := 0
        X := 0.0
        N := 0
        for {
            n, _ := fmt.Scan(&W, &Y, &X, &N)
            if n == 0 {
                break
            } else {
                Y_ := float64(Y)
                for i:=0; i<N; i++{
                    Y_ = (Y_+1)*(1-X) + X*21.0
                }
                if Y_ > float64(int(Y_)){
                    Y=int(Y_)+1
                }else{
                    Y=int(Y_)
                }
                fmt.Println(Y)
            }
        }
    }
    ```