#include<stdio.h>
#include<stdlib.h>
int a[200000]={};
void quicksort(int left,int right){
    int k,l,r,i;
    if(left >= right)
        return;
    k=a[left];l=left;r=right;
    do{
        while(a[r] >= k && r>l) r--;
        a[l] = a[r];
        while(a[l] <= k && l<r) l++;
        a[r] = a[l];
    }while(l<r);
    a[l]=k;
    quicksort(left,r-1);
    quicksort(l+1,right);
    return;
}
int main(){
    int n,i;
    scanf("%d",&n);
    for(i = 1;i <= n;i++){
        scanf("%d",&a[i]);
    }
    quicksort(1,n);
    for(i = 1;i <= n;i++){
        printf("%d ",a[i]);
    }
    return 0;
}