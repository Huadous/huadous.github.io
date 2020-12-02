---
title: '[Algorithms P1] 2.1 Elementary Sorts'
date: 2020-07-14 02:22:00 +0800
categories: [Learning, Coursera]
tags: [Algorithms, Java]
---
# 2.1 ELEMENTARY SORTS

## 2.1.1  rules of the game

**Sort cost model**

---

> When studying sorting algorithms, we count *compares* and *exchanges.* For algorithms that do not use exchanges, we count *array accesses.*

**Certification.** Does the sort implementation always put the array in order, no matter what the initial order? As a conservative practice, we include the statement assert $\mathtt{isSorted(a)}$; in our test client to certify that array entries are in order after the sort. It is reasonable to include this statement in *every* sort implementation, even though we normally test our code and develop mathematical arguments that our algorithms are correct. Note that this test is sufficient only if we use $\mathtt{exch()}$ exclusively to change array entries. When we use code that stores values into the array directly, we do not have full assurance (for example, code that destroys the original input array by setting all values to be the same would pass this test).

**Running time.** We also test algorithm *performance*. We start by proving facts about the number of basic operations (compares and exchanges, or perhaps the number of times the array is accessed, for read or write) that the various sorting algorithms perform for various natural input models. Then we use these facts to develop hypotheses about the comparative performance of the algorithms and present tools that you can use to experimentally check the validity of such hypotheses. We use a consistent coding style to facilitate the development of valid hypotheses about performance that will hold true for typical implementations.

**Extra memory.** The amount of extra memory used by a sorting algorithm is often as important a factor as running time. The sorting algorithms divide into two basic types: those that sort *in place* and use no extra memory except perhaps for a small function-call stack or a constant number of instance variables, and those that need enough extra memory to hold another copy of the array to be sorted.

**Types of data.** Our sort code is effective for any item type that implements the Comparable interface. Adhering to Java’s convention in this way is convenient because many of the types of data that you might want to sort implement Comparable. For example, Java’s numeric wrapper types such as Integer and Double implement Comparable, as do String and various advanced types such as File or URL. Thus, you can just call one of our sort methods with an array of any of these types as argument. For example, the code at right uses quicksort (see Section 2.3) to sort N random Double values. When we create types of our own, we can enable client code to sort that type of data by implementing the Comparable interface. To do so, we just need to implement a $\mathtt{compareTo()}$ method that defines an ordering on objects of that type known as the *natural*.

**Callbacks**

---

**Goal.** Sort **any** type of data.

**Q.** How can $\mathtt{sort()}$ know how to compare data of type $\mathtt{Double}$, $\mathtt{String}$, and $\mathtt{java.io.File}$ without any information about the type of an item's key?

**Callback = reference to executable code.**

* Client passes array of objects to $\mathtt{sort()}$ function.
* The $\mathtt{sort()}$ function calls back object's $\mathtt{compareTo()}$ method as needed.

**Implementing callbacks.**

* Java: **interfaces.**
* C: function pointers.
* C++: class-type functors.
* C#: delegates.
* Python, Perl, Ml, Javascript: first-class functions.

**Callbacks: roadmap**

---

![image-20200710211334534](https://huadous.com/assets/img/sample/image-20200710211334534.png)

&emsp;

**Total order**

---

A **total order** is a binary relation $\le$ that satisfies:

* Antisymmetry: if $v\le w$ and $w\le v$, then $v=w$.
* Transitivity: if $v\le w$ and $w\le x$, then $v\le x$.
* Totality: either $v\le w$ or $w\le v$ or both.

&emsp;

**Comparable API**

---

**Implement** $\mathtt{compareTo()}$ **so that** $\mathtt{v.compareTo(w)}$

* Is a total order.
* Returns a negative integer, zero, or positive integer if $v$  is less than, equal to, or greater than $w$, respectively.
* Throws an exception if incompatible types (or either is $\mathtt{null}$).

![image-20200710225326305](https://huadous.com/assets/img/sample/image-20200710225326305.png)

**Built-in comparable types.** $\mathtt{Integer}$, $\mathtt{Double}$, $\mathtt{String}$, $\mathtt{Date}$, $\mathtt{File}$, ...

**User-defined comparable types.** Implement the $\mathtt{Comparable}$ interface.

&emsp;

**Implementing the Comparable interface**

---

**Data data type.** Simplified version of $\mathtt{java.util.Date.}$

```java
public class Date implements Comparable<Date>			// only compare dates to other dates
{
     private final int month, day, year;
     
     public Date(int m, int d, int y)
     {
           month = m; 
           day = d;
           year = y;
     }
     public int compareTo(Date that)
     {
           if (this.year < that.year ) return -1;
           if (this.year > that.year ) return +1;
           if (this.month < that.month) return -1;
           if (this.month > that.month) return +1;
           if (this.day < that.day ) return -1;
           if (this.day > that.day ) return +1;
           return 0;
     }
}
```



**Two useful sorting abstractions**

---

**Helper functions.** Refer to data through compares and exchanges.

**Less.** Is item $\mathtt{v}$ less than $\mathtt{w}$?

```java
private static boolean less(Comparable v, Comparable w)
{ return v.compareTo(w) < 0; }
```

**Exchange.** Swap item in array $\mathtt{a[~]}$ at index $\mathtt{i}$ with the one at index $\mathtt{j}$.

```java
private static void exch(Comparable[] a, int i, int j)
{
     Comparable swap = a[i];
     a[i] = a[j];
     a[j] = swap;
}
```

&emsp;

**Testing**

---

**Goal.** Test if an array is sorted.

```java
private static boolean isSorted(Comparable[] a)
{
     for (int i = 1; i < a.length; i++)
     			if (less(a[i], a[i-1])) return false;
     return true;
}
```

&emsp;

## 2.1.2 selection sort

**Selection sort demo**

---

* In iteration $\mathtt{i}$, find index $\mathtt{min}$ of smallest remaining entry.
* Swap $\mathtt{a[i]}$ and $\mathtt{a[min]}$.

&emsp;

**Selection sort**

---

**Algorithm.** $\uparrow$ scans from left to right.

**Invariants.**

* Entries the left of $\uparrow$ (including $\uparrow$) fixed and in ascending order.
* No entry to right of $\uparrow$ is smaller than any any entry to the left of $\uparrow$.

![image-20200710232810758](https://huadous.com/assets/img/sample/image-20200710232810758.png)

&emsp;

**Selection sort inner loop**

---

![image-20200710232955429](https://huadous.com/assets/img/sample/image-20200710232955429.png)

&emsp;

**Selection sort: Java implementation**

---

```java
public class Selection
{
    public static void sort(Comparable[] a) 
    { // Sort a[] into increasing order.
        int N = a.length;
        for (int i = 1; i < N; i++)
        { // Insert a[i] among a[i-1], a[i-2], a[i-3]... ..
        		for (int j = i; j > 0 && less(a[j], a[j-1]); j--) 
            		exch(a, j, j-1);
        } 
    }
    // See page 245 for less(), exch(), isSorted(), and main().
    private static boolean less(Comparable v, Comparable w)
    { /* as before */ }
    private static void exch(Comparable[] a, int i, int j)
    { /* as before */ }
}
```

&emsp;

**Selection sort: mathematical analysis**

---

**Proposition.** Selection sort uses $(N-1)+(N-2)+\dots+1+0\sim\frac{N^2}{2}$ compares and $N$ exchanges.

![image-20200710233723413](https://huadous.com/assets/img/sample/image-20200710233723413.png)

**Running time insensitive to input.** Quadratic time, even if input is sorted.

**Data movement is minimal.** Linear number of exchanges.

>**Proposition A.** Selection sort uses 􏰐$\sim\frac{N^2}{2}$ compares and $N$ exchanges to sort an array of length $N$.
>
>**Proof:** You can prove this fact by examining the trace, which is an $N$-by-$N$ table in which unshaded letters correspond to compares. About one-half of the entries in the table are unshaded—those on and above the diagonal. The entries on the diagonal each correspond to an exchange. More precisely, examination of the code reveals that,for each $i$ from $0$ to $N-􏰀1$,there is one exchange and $N-􏰀1-􏰀i$ compares, so the totals are $N$ exchanges and $(N-1)+(N􏰀-2)+\dots+2+1+0=\frac{N(N -􏰀 1)}{2}\sim\frac{N^2}{2}$ compares.

&emsp;

## 2.1.3 insertion sort

**Insertion sort demo**

---

* In iteration $\mathtt{i}$, swap $\mathtt{a[i]}$ with each larger entry to its left.

&emsp;

**Insertion sort**

---

**Algorithm.** $\uparrow$ scans from left to right.

**Invariants.**

* Entries to the left of $\uparrow$ (including $\uparrow$) are in ascending order.
* Entries to the right of $\uparrow$ have not yet been seen.

![image-20200711000053496](https://huadous.com/assets/img/sample/image-20200711000053496.png)

&emsp;

**Insertion sort inner loop**

---

![image-20200711000147886](https://huadous.com/assets/img/sample/image-20200711000147886.png)

&emsp;

**Insertion sort: Java implementation**

---

```java
public class Selection
{
		public static void sort(Comparable[] a) { // Sort a[] into increasing order.
		int N = a.length; // array length
		for (int i = 0; i < N; i++)
		{ // Exchange a[i] with smallest entry in a[i+1...N).
				int min = i; // index of minimal entr. for (int j = i+1; j < N; j++)
        		if (less(a[j], a[min])) min = j;
        exch(a, i, min);
		} 
// See page 245 for less(), exch(), isSorted(), and main().
    private static boolean less(Comparable v, Comparable w)
    { /* as before */ }
    private static void exch(Comparable[] a, int i, int j)
    { /* as before */ }
}
```

&emsp;

**Insertion sort: mathematical analysis**

---

**Proposition.** To sort a randomly-ordered array with distinct keys, insertion sort uses $\sim\frac{1}{4}{N^2}$ compares and $\sim\frac{1}{4}{N^2}$ exchanges on average.

**Pf.** Expect each entry to move halfway back.

![image-20200711001217687](https://huadous.com/assets/img/sample/image-20200711001217687.png)

>**PropositionB.** Insertion sort uses􏰐 $\sim\frac{1}{4}{N^2}$ compares and􏰐 $\sim\frac{1}{4}{N^2}$ exchanges to sort a randomly ordered array of length $N$ with distinct keys, on the average. The worst case is $\sim\frac{N^2}{2}$ compares and 􏰐$\sim\frac{N^2}{2}$ exchanges and the best case is $N-1$ compares and $0$ exchanges.
>
>**Proof:** Just as for $\mathtt{Proposition~A}$,the number of compares and exchanges is easy to visualize in the $N$-by-$N$ diagram that we use to illustrate the sort. We count entries below the diagonal—all of them, in the worst case, and none of them, in the best case. For randomly ordered arrays, we expect each item to go about halfway back, on the average, so we count one-half of the entries below the diagonal.
>
>The number of compares is the number of exchanges plus an additional term equal to $N$ minus the number of times the item inserted is the smallest so far. In the worst case (array in reverse order), this term is negligible in relation to the total; in the best case (array in order) it is equal to $N-1$.

&emsp;

**Insertion sort: trace**

---

![image-20200711002240597](https://huadous.com/assets/img/sample/image-20200711002240597.png)

&emsp;

**Insertion sort: partially-sorted arrays**

---

**Def.** An **inversion** is a pair of keys that are out of order.

![image-20200711002824060](https://huadous.com/assets/img/sample/image-20200711002824060.png)

**Def.** An array is **Partially sorted** if the number of inversion of inversions is $\le cN$.

* Ex 1. A subarray of size $10$ appended to a sorted subarray of size $N$.
* Ex 2. An array of size $N$ with only $10$ entries out of place.

**Proposition.** For partially-sorted arrays, insertion sort runs in linear time.

**Pf.** Number of exchanges equals the number of inversions.(number of compares = exchanges +(N - 1))

&emsp;

## 2.1.4 shellsort

**Shellsort overview**

---

**Idea.** Move entries more than one position at a tme by **h-sorting** the array.

![image-20200711003621868](https://huadous.com/assets/img/sample/image-20200711003621868.png)

**Shellsort.** [Shell 1959] **h-sort** array for decreasing sequence of values of $h$.

![image-20200711003751388](https://huadous.com/assets/img/sample/image-20200711003751388.png)

&emsp;

**h-sorting**

---

**How to h-sort an array**?  Insertion sort, with stride length h.

![image-20200711003913598](https://huadous.com/assets/img/sample/image-20200711003913598.png)

**Why insertion sort?**

* Big increments $\Rightarrow$ small subarray.
* Small increments $\Rightarrow$ nearly in order. [stay tuned]

&emsp;

**Shellsort example: increments 7, 3, 1**

---

![image-20200711004138085](https://huadous.com/assets/img/sample/image-20200711004138085.png)

&emsp;

**Shellsort: intuition**

---

**Proposition.** A g-sorted array remains g-sorted  after h-sorting it.

![image-20200711004506016](https://huadous.com/assets/img/sample/image-20200711004506016.png)

**Reason.** the $L$ is no doubt can never be moved to the left side and it's only direction is moving left. And it's the same for $R$. Thinking thoroughly, the pairs which have been g-sorted still follow the rule smaller to the left and bigger to the right. Thus, the number fill in the pairs place still only could be $L<R$.

&emsp;

**Shellsort: which increment sequence to use?**

---

1. **Powers of two.** $1,2,4,8,16,32,\dots$**[No.]**
2. **Powers of two minus one.** $1,3,7,15,31,63,\dots$**[Maybe.]**
3. **3x+1.** $1,4,13,40,121,364,\dots$**[OK.]** Easy to compute.
4. **Sedgewick.** $1,5,19,41,109,209,505,929,2161,3905,\dots$**[Good.]** Tough to beat in empirical studies.(merge of $(9\times4^i)-(9\times2^i)+1$ and $4^i-(3\times2^i)+1$)

&emsp;

**Shellsort: Java implementation**

---

```java
public class Shell
{
    public static void sort(Comparable[] a) 
    { // Sort a[] into increasing order.
        int N = a.length;
        int h = 1;
        while (h < N/3) h = 3*h + 1; // 1, 4, 13, 40, 121, 364, 1093, ... while (h >= 1)
        { // h-sort the array.
            for (int i = h; i < N; i++)
            { // Insert a[i] among a[i-h], a[i-2*h], a[i-3*h]... .
            		for (int j = i; j >= h && less(a[j], a[j-h]); j -= h) 
            				exch(a, j, j-h);
            }
            h = h/3; }
        }
    }
    // See page 245 for less(), exch(), isSorted(), and main().
    private static boolean less(Comparable v, Comparable w)
    { /* as before */ }
    private static void exch(Comparable[] a, int i, int j)
    { /* as before */ }
}
```

&emsp;

**Shellsort: visual trace**

---

![image-20200711010023654](https://huadous.com/assets/img/sample/image-20200711010023654.png)

&emsp;

**Shellsort: analysis**

---

**proposition.** The worst-case number of compares used by shellsort with the $\mathtt{3x+1}$ increments is $O(N^\frac{3}{2})$.

**Property.** Number of compares used by shellsort with the $\mathtt{3x+1}$ increments is at most by a small multiple of $N$ times the # of increments used.

![image-20200711010349944](https://huadous.com/assets/img/sample/image-20200711010349944.png)

**Remark.** Accurate model has not yet been discovered(!)

&emsp;

**Why are we interested in shellsort?**

---

**Example of simple idea leading to substantial performance gains.

**Useful in practice.**

* Fast unless array size is huge (used for small subarrays). $\mathtt{bzip2,/linux/kernel/groups.c}$
* Tiny, fixed footprint for code (used in some embedded systems). $\mathtt{uClibc}$
* Hardware sort prototype.

**Simple algorithm, nontrivial performance, interesting questions.**

* Asymptotic growth rate?
* Best sequence of increments? $\leftarrow$ open problem: find a better increment sequence
* Average-case performance?

**Lesson.** Some good algorithms are still waiting discovery.

&emsp;

## 2.1.5 shuffling

**How to shuffle an array**

---

**Goal.** Rearrange array so that result is a uniformly random permutation.

* Generate a random real number for each array entry. (useful for shuffling columns in a spreadsheet)
* Sort the array.

![image-20200712001746621](https://huadous.com/assets/img/sample/image-20200712001746621.png)

![image-20200712001804824](https://huadous.com/assets/img/sample/image-20200712001804824.png)

**Proposition.** Shuffle sort produces a uniformly random permutation of the input array, provided no duplicate values.(assuming real numbers uniformly at random)

&emsp;

**Knuth shuffle demo**

---

* In iteration $\mathtt{i}$, pick integer $\mathtt{r}$ between $\mathtt{0}$ and $\mathtt{i}$ uniformly at random.
* Swap $\mathtt{a[i]}$ and $\mathtt{a[r]}$.

**Proposition.** [Fisher-Yates 1938] Knuth shuffling algorithm produces a uniformly random permutation of the input array in linear time. (assuming integers uniformly at random)

```java
public class StdRandom
{
    ...
    public static void shuffle(Object[] a)
    {
        int N = a.length;
        for (int i = 0; i < N; i++)
        {
            int r = StdRandom.uniform(i + 1);
            exch(a, i, r);
        }
    }
}
```

&emsp;

**War story(online poker)**

---

**Shuffling algorithm in FAQ at www.planetpoker.com**

```javascript
for i := 1 to 52 do begin
    r := random(51) + 1;
    swap := card[r];
    card[r] := card[i];
    card[i] := swap;
end;
```

**Bug 1.** Random number r never 52 $\Rightarrow$ $52^{nd}$ card can't end up in $52^{nd}$ place.  

**Bug 2.** Shuffle not uniform (should be between 1 and i).

**Bug 3.** $\mathtt{random()}$ uses 32-bit seed $\Rightarrow$ $2^{32}$ possible shuffles. (52 cards needs $52!$ possibility)

**Bug 4.** Seed = milliseconds since midnight $\Rightarrow$ 8.64 million shuffles. (Seed can be set by the milliseconds since midnight to simulate random process but still have repeated situation)

> "The generation of random numbers is too important to be left to chance"
>
> -Robert R.Coveyou

&emsp;

## 2.1.6 convex hull

**Convex hull**

---

The **convex hull** of a set of $N$ points is the smallest permeter fence enclosing the points.

![image-20200714000044752](https://huadous.com/assets/img/sample/image-20200714000044752.png)

**Equivalent definitions.**

* Smallest convex set containing all the points.
* Smallest area convex polygon enclosing the points.
* Convex polygon enclosing the points, whose vertices are points in set.

![image-20200714000324608](https://huadous.com/assets/img/sample/image-20200714000324608.png)

**Convex hull output.** Sequence of vertices in counterclockwise order.

&emsp;

**Convex hull: mechanical algorithm**

---

**Mechanical algorithm.** Hammer nails perpendicular to plane; stretch elastic rubber band around points.

![image-20200714000746444](https://huadous.com/assets/img/sample/image-20200714000746444.png)

&emsp;

**Convex hull application: motion planning**

---

**Robot motion planning.** Find shortest path in the plane from $s$ to $t$ that avoids a polygonal obstacle.

![image-20200714001212254](https://huadous.com/assets/img/sample/image-20200714001212254.png)

**Fact.** Shortest path is either straight line from $s$ to $t$ or it is one of two polgonal chains of convex hull.

&emsp;

**Convex hull application: farthest pair**

----

**Farthest pair porblem.** Given $N$ points in the plane, find a pair of points with largest Euclidean distance between them.

![image-20200714001624121](https://huadous.com/assets/img/sample/image-20200714001624121.png)

**Fact.** Farthest pair of points are extreme points on convex hull.

&emsp;

**Convex hull: geometric properties**

---

**Fact.** Can traverse the convex hull by making only counterclockwise turns.

**Facts.** The vertices of convex hull appear in increasing order of polar angle with respect to point $p$ with lowest $y-$coordinate.

![image-20200714002253583](https://huadous.com/assets/img/sample/image-20200714002253583.png)

&emsp;

**Graham scan demo**

---

* Choose point $p$ with smallest $y-$coordinate.
* Sort points by polar angle with $p$.
* Consider points in order; discard unless it create a ccw turn.

![image-20200714002802403](https://huadous.com/assets/img/sample/image-20200714002802403.png)

&emsp;

**Graham scan: implementation challenges**

---

**Q.** How to find point *p* with smallest *y*-coordinate?

**A.** Define a total order, comparing by *y*-coordinate. [next lecture]

&emsp;

**Q.** How to sort points by polar angle with respect to *p* ?

**A.** Define a total order for each point *p*. [next lecture]

&emsp;

**Q.** How to determine whether *p*1→ *p*2→ *p*3 is a counterclockwise turn?

**A.** Computational geometry. [next two slides]

&emsp;

**Q.** How to sort efficiently?

**A.** Mergesort sorts in *N* log *N* time. [next lecture]

&emsp;

**Q.** How to handle degeneracies (three or more points on a line)?

**A.** Requires some care, but not hard. [see booksite]

&emsp;

**Implementing ccw**

---

**CCW.** Given three points *a*, *b*, and *c*, is *a* $\rightarrow$ *b* $\rightarrow$ *c* a counterclockwise turn? $\Leftrightarrow$ is *c* to the left of the ray *a* $\rightarrow$ *b*

![image-20200714003254817](https://huadous.com/assets/img/sample/image-20200714003254817.png)

**Lesson.** Geometric primitives are tricky to implement.

* Dealing with degenerate cases.
* Coping with floating-point precision.

&emsp;

**CCW.** Given three points *a*, *b*, and *c*, is *a* $\rightarrow$ *b* $\rightarrow$ *c* a counterclockwise turn? $\Leftrightarrow$ is *c* to the left of the ray *a* $\rightarrow$ *b*

* Determinant (or cross product) gives 2x signed area of planar triangle.

$$2\times Area(a,b,c)=\begin{vmatrix}a_x&a_y&1\\b_x&b_y&1\\c_x&c_y&1\\\end{vmatrix}=(b_x-a_x)(c_y-a_y)-(b_y-a_y)(c_x-a_x)$$

* If signed area > 0, then *a*$\rightarrow$ *b*$\rightarrow$ *c* is counterclockwise.
* If signed area < 0, then *a*$\rightarrow$ *b*$\rightarrow$ *c* is clockwise.
* If signed area = 0, then *a*$\rightarrow$ *b*$\rightarrow$ *c* are collinear.

![image-20200714004207231](https://huadous.com/assets/img/sample/image-20200714004207231.png)

> **Proof.** Define $k_c=\frac{c_y-a_y}{c_x-a_x}$, $k_b=\frac{b_y-a_y}{b_x-a_x}$. Thus, $(b_x-a_x)(c_y-a_y)-(b_y-a_y)(c_x-a_x)=c_xb_x(k_c-k_b)$( make $a_x$ as the $(0,0)$) Also, $\frac{(b_x-a_x)(c_y-a_y)-(b_y-a_y)(c_x-a_x)=c_xb_xk_ck_b}{c_xb_x}=k_c-k_b$
>
> $\Rightarrow\begin{cases}c_x>0,b_x>0\begin{cases}k_c>0,k_b>0\Rightarrow 1st ~Quadrant,k_c>k_b, Counterclockwise\\k_c>0,k_b<0\Rightarrow 1st,4th ~Quadrant,k_c<k_b, Clockwise\\k_c<0,k_b>0\Rightarrow 1st,4th ~Quadrant,k_c<k_b, Clockwise\\k_c<0,k_b<0\Rightarrow 4th ~Quadrant,k_c>k_b, Counterclockwise\\\end{cases}\\c_x>0,b_x<0\begin{cases}k_c>0,k_b>0\Rightarrow 1st,3rd ~Quadrant,k_c<k_b, Counterclockwise\\k_c>0,k_b<0\Rightarrow 1st,2nd ~Quadrant,k_c>k_b, Clockwise\\k_c<0,k_b>0\Rightarrow 3nd,4th ~Quadrant,k_c>k_b, Clockwise\\k_c<0,k_b<0\Rightarrow 2nd,4th ~Quadrant,k_c<k_b, Counterclockwise\\\end{cases}\\c_x<0,b_x>0\begin{cases}k_c>0,k_b>0\Rightarrow 1st,3nd ~Quadrant,k_c<k_b, Counterclockwise\\k_c>0,k_b<0\Rightarrow 3nd,4th ~Quadrant,k_c>k_b, Clockwise\\k_c<0,k_b>0\Rightarrow 1st,2nd ~Quadrant,k_c>k_b, Clockwise\\k_c<0,k_b<0\Rightarrow 2nd,4th ~Quadrant,k_c<k_b, Counterclockwise\\\end{cases}\\c_x<0,b_x<0\begin{cases}k_c>0,k_b>0\Rightarrow 3rd ~Quadrant,k_c>k_b, Counterclockwise\\k_c>0,k_b<0\Rightarrow 2nd,3rd ~Quadrant,k_c<k_b, Clockwise\\k_c<0,k_b>0\Rightarrow 2nd,3rd ~Quadrant,k_c<k_b, Clockwise\\k_c<0,k_b<0\Rightarrow 2nd ~Quadrant,k_c>k_b, Counterclockwise\\\end{cases}\\\end{cases}$
>
> ![220px-Trigonometric_function_quadrant_sign.svg](https://huadous.com/assets/img/sample/220px-Trigonometric_function_quadrant_sign.svg.png)

&emsp;

**Immutable point data type**

---

```java
public class Point2D 
{ 
    private final double x;
    private final double y;
    public Point2D(double x, double y)
    {
        this.x = x;
        this.y = y;
    } 
    ...
    public static int ccw(Point2D a, Point2D b, Point2D c)
    {
        double area2 = (b.x-a.x)*(c.y-a.y) - (b.y-a.y)*(c.x-a.x);	// danger of floating-																																		point roundoff error
        if (area2 < 0) return -1; // clockwise
        else if (area2 > 0) return +1; // counter-clockwise
        else return 0; // collinear
    }
}
```

&emsp;

## 2.1.7 Interview Question: Stacks and Queues

**Intersection of two sets.**

---

Given two arrays $\mathtt{a[]}$ and $\mathtt{b[]}$, each containing $n$ distinct 2D points in the plane, design a subquadratic algorithm to count the number of points that are contained both in array $\mathtt{a[]}$ and array $\mathtt{b[]}$.

>*Hint:* shellsort (or any other subquadratic sort).

**Answer.** we can select points from array a[] one by one and use selection sort liked algorithm to find the same points.

&emsp;

**Permutation.**

---

Given two integer arrays of size n*n*, design a subquadratic algorithm to determine whether one is a permutation of the other. That is, do they contain exactly the same entries but, possibly, in a different order.

> *Hint:* sort both arrays.

**Answer.** we can select points from array a[] one by one and use selection sort liked algorithm to find the same points. we can use two shell sort and then compare two sorted arrays if they are the same sequence.

&emsp;

**Dutch national flag.**

---

Given an array of $n$ buckets, each containing a red, white, or blue pebble, sort them by color. The allowed operations are:

- $swap(i, j)$: swap the pebble in bucket $i$ with the pebble in bucket $j$.
- $color(i)$: determine the color of the pebble in bucket $i$.

The performance requirements are as follows:

- At most $n$ calls to $color()$.
- At most $n$ calls to $swap()$.
- Constant extra space.

> *Hint:* 3-way partitioning.
>
> For more details, can see this [wekipedia](https://en.wikipedia.org/wiki/Dutch_national_flag_problem)
>
> ### Pseudocode[[edit](https://en.wikipedia.org/w/index.php?title=Dutch_national_flag_problem&action=edit&section=2)]
>
> The following [pseudocode](https://en.wikipedia.org/wiki/Pseudocode) for three-way partitioning which assumes zero-based array indexing was proposed by Dijkstra himself.[[2\]](https://en.wikipedia.org/wiki/Dutch_national_flag_problem#cite_note-:0-2) It uses three indices *i*, *j* and *k*, maintaining the [invariant](https://en.wikipedia.org/wiki/Loop_invariant) that *i* ≤ *j* ≤ *k*.
>
> - Entries from 0 up to (but not including) *i* are values less than *mid*,
> - entries from *i* up to (but not including) *j* are values equal to *mid*,
> - entries from *j* up to (but not including) *k* are values not yet sorted, and
> - entries from *k* to the end of the array are values greater than *mid*.
>
> ```java
> procedure three-way-partition(A : array of values, mid : value):
>     i ← 0
>     j ← 0
>     k ← size of A
> 
>     while j < k:
>         if A[j] < mid:
>             swap A[i] and A[j]
>             i ← i + 1
>             j ← j + 1
>         else if A[j] > mid:
>             k ← k - 1
>             swap A[j] and A[k]
>             
>         else:
>             j ← j + 1
> ```

**Answer.** color(i) by color, if it's red put it at the front of the array, if it's white, stay, or if it's blue, put it at the back of the array.



&emsp;