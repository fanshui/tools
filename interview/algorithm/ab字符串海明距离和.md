## 3.22 美团笔试

1.  a b 字符串

   > 给定由 a和b组成的字符串S 和 T，|S| >= |T|
   >
   > 在S中有|S| - |T| + 1个与T长度相同的子串，计算T串与这些子串的海明距离的和

   ```c
   /*S中与T对应的第1个子串和第2个子串有|T|-2个字符的公共部分，字符非a 即 b 。从此入手*/
   //eg. S : aabac
   /*	  T : abc
   	  aabac
   	  abc
   	   abc
   	    abc
   */
   #include<stdio.h>
   #include<string.h> 
   #include<iostream>
   #define N 100005
   using namespace std;
   int main() {
   	char S[N],T[N];
   	int ss,tt,i,j;
   	long long ans[N],result;
   	scanf("%s %s",S,T);
   	ss = strlen(S);
   	tt = strlen(T);
   	ans[0] = result = (long long)0;
   	for(i=0;i<=ss-tt;i++) ans[0] += (S[i]=='a');
   	for(i=1;i<tt;i++) {
   		ans[i] = ans[i-1];
   		if(S[i-1]=='a') ans[i]--;
   		if(S[i+ss-tt]=='a') ans[i]++; 
   	}
   	//for(i=0;i<tt;i++) printf("%lld ",ans[i]);
   	for(i=0;i<tt;i++) {
   		if(T[i]=='b') result += ans[i];
   		else result += ss-tt+1-ans[i];
   		//printf("%lld\n",result);
   	}
   	printf("%lld",result);
   	return 0;
   }
   ```

   ​

