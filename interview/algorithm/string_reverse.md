## 翻转字符串

* **charry array**

  ```java
      public static String strReverseWithArray(String string){
          if(string==null||string.length()==0)return string;
          int length = string.length();
          char [] array = string.toCharArray();
          for(int i = 0;i<length;i++){
              array[i] = string.charAt(length-1-i);
          }
          return new String(array);
      }
  ```

* **array charat()**

  ```java
      public static String strReverseWithArray2(String string){
          if(string==null||string.length()==0)return string;
          int length = string.length();
          char [] array = string.toCharArray();
          for(int i = 0;i<length/2;i++){
              array[i] = string.charAt(length-1-i);
              array[length-1-i] = string.charAt(i);
          }
          return new String(array);
      }
  ```

* **stack**

  ```java
      public static String strReverseWithStack(String string){
          if(string==null||string.length()==0)return string;
          Stack<Character> stringStack = new Stack<>();
          char [] array = string.toCharArray();
          for(Character c:array){
              stringStack.push(c);
          }
          int length = string.length();
          for(int i= 0;i<length;i++){
              array[i] = stringStack.pop();
          }
          return new String(array);
      }
  ```

* **StringBuilder**

  ```java
      public static String strReverseWithReverseLoop(String string){
          if(string == null || string.length() == 0) return string;
          StringBuilder sb = new StringBuilder();
          for (int i = string.length() - 1;i >= 0;i --){
              sb.append(string.charAt(i));
          }
          return  sb.toString();
      }
  ```

---

* 利用 subString()递归