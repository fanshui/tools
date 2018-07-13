## 快速排序

* code1:

  ```java

  public class QuickSort {
      public static void quickSort(int[] arr,int start,int end) {

          /*递归终止条件*/
          if (start >= end)
              return;

          int i = start ;
          int j = end ;
          int temp = arr[i];

          while (i < j) {
              while (i < j && arr[j] >= temp)
                  j --;
              arr[i] = arr[j];

              while (i < j && arr[i] <= temp)
                  i ++;
              arr[j] = arr[i];
          }

          arr[i] = temp;
          quickSort(arr,start,i-1);
          quickSort(arr,i + 1,end);

      }

      public static void main(String[] args) {
          int[] array = {10,2,5,4,6,9,8,7,1,3};
          quickSort(array,0,array.length - 1);
          for (int i : array) {
              System.out.println(i);
          }
      }
  }
  ```

* code2:

  ```java
  public static void quickSort(int[] arr){
      qsort(arr, 0, arr.length-1);
  }
  private static void qsort(int[] arr, int low, int high){
      if (low < high){
          int pivot=partition(arr, low, high);        //将数组分为两部分
          qsort(arr, low, pivot-1);                   //递归排序左子数组
          qsort(arr, pivot+1, high);                  //递归排序右子数组
      }
  }
  private static int partition(int[] arr, int low, int high){
      int pivot = arr[low];     //枢轴记录
      while (low<high){
          while (low<high && arr[high]>=pivot) --high;
          arr[low]=arr[high];             //交换比枢轴小的记录到左端
          while (low<high && arr[low]<=pivot) ++low;
          arr[high] = arr[low];           //交换比枢轴大的记录到右端
      }
      //扫描完成，枢轴到位
      arr[low] = pivot;
      //返回的是枢轴的位置
      return low;
  }
  ```

  ​

* 非递归

```C++
void QuickSort(int *a, int left,int right)
 2 {
 3     if (a == NULL || left < 0 || right <= 0 || left>right)
 4         return;
 5     stack<int>temp;
 6     int i, j;
 7     //（注意保存顺序）先将初始状态的左右指针压栈
 8     temp.push(right);//先存右指针
 9     temp.push(left);//再存左指针
10     while (!temp.empty())
11     {
12         i = temp.top();//先弹出左指针
13         temp.pop();
14         j = temp.top();//再弹出右指针
15         temp.pop();
16         if (i < j)
17         {
18             int k = Pritation(a, i, j);
19             if (k > i)
20             {
21                 temp.push(k - 1);//保存中间变量
22                 temp.push(i);  //保存中间变量 
23             }
24             if (j > k)
25             {
26                 temp.push(j);
27                 temp.push(k + 1);
28             }
29         }
30 
31     }
32     
33 }
```

