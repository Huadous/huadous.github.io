---
title: "Algorithms Part 1 week 1"
date: 2020-07-07 14:144:00 +0800
categories: [Learning, Self-study]
tags: [Algorithms, Java]
---
# 1.4 ANALYSIS OF ALGORITHMS

## 1.4.1 introduction

**Cast of characters**

---

**Programmer** needs to develop a working solution.

**Client** wants to solve problem efficiently.

**Theoretician** wants to understand.

Basic **blocking and tackling** is sometimes necessary.

&emsp;

**Scientific method applied to analysis of algorithms**

---

A framework for predicting performance and comparing algorithms.

**Scientific method.**

* **Observe** some feature of the natural world.
* **Hypothesize** a model that is consistent with the observations.
* **Predict** events using the hypothesis.
* **Verify** the predictions by making further observations.
* **Validate** by repeating until the hypothesis and observations agree.

**Principles.**

* Experiments must be **reproducible.**
* Hypotheses must be **falsifiable**.

&emsp;

## 1.4.2 observation

**Example: 3-SUM**

---

**3-SUM.** Given $N$ distinct integers, how many triples sum to exactly zero?

```shell
% more 8ints.txt
8
30 -40 -20 -10 40 0 10 5

% java ThreeSum 8ints.txt
4
```

| a[i] | a[j] | a[k] | sum  |
| :--: | :--: | :--: | :--: |
|  30  | -40  |  10  |  0   |
|  30  | -20  | -10  |  0   |
| -40  |  40  |  0   |  0   |
| -10  |  0   |  10  |  0   |

**brute-force algorithm (slow)**

```java
public class ThreeSum
{
     public static int count(int[] a)
     {
         int N = a.length;
         int count = 0;
         for (int i = 0; i < N; i++) 
             for (int j = i+1; j < N; j++)
                 for (int k = j+1; k < N; k++)			// check each triple
                     if (a[i] + a[j] + a[k] == 0)		// for simplicity, ignore integer overflow
                         count++;
         return count;
     }
     public static void main(String[] args)
     {
         int[] a = In.readInts(args[0]);
         StdOut.println(count(a));
     }
}
```

&emsp;

**Analysis of experimental data.**

---

The diagrams below show the result of plotting the data, both on a normal and on a log-log scale, with the problem size $N$ on the $x-axis$ and the running time $T(N)$ on the $y-axis$. The log-log plot immediately leads to a hypothesis about the running time—the data fits a straight line of slope 3 on the log-log plot. The equation of such a line is 

$$\lg(T(N))=3\lg(N)+\lg(a)$$

(where $a$ is a constant) which is equivalent to

$$T(N)=aN^3$$

> A straight line in equivalent to the hypothesis that the data fits the equation $T(N)=aN^b$. Such a fit is known as a *power law*. A great many natural and synthetic phenomena are described by power law, and it is reasonable to hypothesis that the running time of a program does, as well.

![image-20200705183129824](huadous.com/assets/img/sample/image-20200705183129824.png)

> **log-log plot** is that the scale of the two coordinate axes of the graph are logarithmic scales. In this way, the exponential curve in the form of $y=ax^b$ appears as a straight line in the log-log plot , $b$ is the slope of this line.
>
> Taking both sides of $y=ax^b$ logarithmically, we get: $\lg(y) = \lg(a) + b\lg(x)$, let $y'= \lg(y)$, $x'= \lg(x)$ , Then in the log-log plot, what you get is a straight line with $y'= a'+ bx'$, the length unit of the number axis uses the units of $y'$and $x'$.

&emsp;

**Doubling hypothesis**

---

**Doubling hypothesis.** Quick way to estimate $b$ in a power-law relationship.

Run program, doubling the size of the input.

| $N$  | time(second)$^†$ | ratio |                   $\lg$ ratio                    |
| :--: | :--------------: | :---: | :----------------------------------------------: |
| 250  |       0.0        |       |                        —                         |
| 500  |       0.0        |  4.8  |                       2.3                        |
| 1000 |       0.1        |  6.9  |                       2.8                        |
| 2000 |       0.8        |  7.7  |                       2.9                        |
| 4000 |       6.4        |  8.0  |                       3.0                        |
| 8000 |       51.1       |  8.0  | 3.0(seems to converge to a constant $b\approx3$) |

**Hypothesis.** Running time is about $aN^b$ with $b=\lg$ ratio​

>Let $y'=\lg{T(N)}$, $x'=\lg(N)$. Thus, $T(N)=aN^b\Leftrightarrow y'=bx'+\lg(a)$, $\lg{T(N)}=ax+b\Leftrightarrow T(N)=2^{bx'+lg(a)}$.
>
>$$lg~ratio=\lg{\frac{T(N_2)}{T(N_1)}}=\lg{\frac{2^{bx_2'+lg{a}}}{2^{bx_1'+lg{a}}}}=lg2^{b(x_2'-x_1')}=b(x_2'-x_1')=b$$

**How to estimate** $a$ **(assuming we know** $b$ **)?**

Run the program(for a sufficient large value of $N$) and solve for $a$.

| $N$  | time (seconds)$^†$ |
| :--: | :----------------: |
| 8000 |        51.1        |
| 8000 |        51.0        |
| 8000 |        51.1        |

$$ 51.1=a\times8000^3 \Rightarrow a=0.998\times10^{-10}$$

**Hypothesis.** Running time is about $0.998\times10^{-10}\times N^3$seconds.

&emsp;

**Experimental algorithmics**

---

>**Determines constant **$a$ **in power law**
>
>*System dependent effects.*
>
>* Hardware: CPU, memory, cache, ...
>* Software: compiler, interpreter, garbage collector, ...
>* System: operating system, network, other apps, ...
>
>> **Determines exponent** $b$ **in power law**
>>
>> *System independent effects.*
>>
>> * Algorithm,
>> * Input data.

**Bad news.** Difficult to get precise measurements.

**Good news.** Much easier and cheaper than other sciences. i.e., can run huge number of experiments.

&emsp;

## 1.4.3 mathematical models

**Cost of basic operations**

---

|        operation        |      example       | nanoseconds$^†$ |
| :---------------------: | :----------------: | :-------------: |
|       integer add       |       $a+b$        |       2.1       |
|    integer multiply     |    $a\times b$     |       2.4       |
|     integer divide      |     $a\div b$      |       5.4       |
|   floating-point add    |       $a+b$        |       4.6       |
| floating-point multiply |    $a\times b$     |       4.2       |
|  floating-point divide  |     $a\div b$      |      13.5       |
|          sine           | $Math.sin(\theta)$ |      91.3       |
|       arctangent        | $Math.atan2(y,x)$  |      129.0      |
|           ...           |        ...         |       ...       |

$†$ Running OS X on Macbook Pro 2.2GHz with 2GB RAM

| operation            | example              | nanoseconds |
| -------------------- | -------------------- | ----------- |
| variable declaration | $int~a$              | $c_1$       |
| assignment statement | $a = b$              | $c_2$       |
| integer compare      | $a < b$              | $c_3$       |
| array element access | $a[ i ]$             | $c_4$       |
| array length         | $a.length$           | $c_5$       |
| 1D array allocation  | $new~int[N]$         | $c_6N$      |
| 2D array allocation  | $new~int[N][N]$      | $c_7N^2$    |
| string length        | $s.length(~)$        | $c_8$       |
| substring extraction | $s.substring(N/2,N)$ | $c_9$       |
| string concatenation | $s+t$                | $c_{10}N$   |

**Novice mistake.** Abusive string concatenation.

&emsp;

**Examples**

---

**1-SUM**

```java
int count = 0;
for (int i = 0; i < N; i++)
 		if (a[i] == 0)
 				count++;
```

|      operation       | frequency |
| :------------------: | :-------: |
| variable declaration |    $2$    |
| assignment statement |    $2$    |
|  less than compare   |   $N+1$   |
|   equal to compare   |    $N$    |
|     array access     |    $N$    |
|      increment       | $N~to~2N$ |

&emsp;

**2-SUM**

```java
int count = 0;
for (int i = 0; i < N; i++)
 		for (int j = i+1; j < N; j++)
 				if (a[i] + a[j] == 0)					//array access is the most important part.
 						count++;
```

$$0+1+2+\dots+(N-1)=\frac{1}{2}N(N-1)=\begin{pmatrix}N\\2\\\end{pmatrix}$$

|      operation       |           frequency           |
| :------------------: | :---------------------------: |
| variable declaration |             $N+2$             |
| assignment statement |             $N+2$             |
|  less than compare   |    $\frac{1}{2}(N+1)(N+2)$    |
|   equal to compare   |      $\frac{1}{2}N(N+1)$      |
|     array access     |           $N(N+1)$            |
|      increment       | $\frac{1}{2}N(N-1)~to~N(N-1)$ |

It's tedious to count exactly for the latter four items.

&emsp;

**Simplification 1: cost model**

---

**Cost model.** Use some basic operation as a proxy for running time.

**2-SUM**

```java
int count = 0;
for (int i = 0; i < N; i++)
 		for (int j = i+1; j < N; j++)
 				if (a[i] + a[j] == 0)					//cost model
 						count++;
```

$$0+1+2+\dots+(N-1)=\frac{1}{2}N(N-1)=\begin{pmatrix}N\\2\\\end{pmatrix}$$

|      operation       |           frequency           |
| :------------------: | :---------------------------: |
| variable declaration |             $N+2$             |
| assignment statement |             $N+2$             |
|  less than compare   |    $\frac{1}{2}(N+1)(N+2)$    |
|   equal to compare   |      $\frac{1}{2}N(N+1)$      |
| **array access**$^†$ |           $N(N+1)$            |
|      increment       | $\frac{1}{2}N(N-1)~to~N(N-1)$ |

$†$ cost model = array accesses(we assume compiler/JVM do not optimize array accesses away!)

&emsp;

**Simplification 2: tilde notation**

---

* Estimate running time (or memory) as a function of input size $N$.

* Ignore lower order terms.

	—when $N$ is large, terms are negligible

	—when $N$ is small, we don't care

Ex 1. $\frac{1}{6}N^3+20N+16~\sim~\frac{1}{6}N^3$

Ex 2. $\frac{1}{6}N^3+100N^{\frac{4}{3}}+56~\sim~\frac{1}{6}N^3$

Ex 3. $\frac{1}{6}N^3-\frac{1}{2}N^2+\frac{1}{3}N~\sim~\frac{1}{6}N^3$

![image-20200705215817162](huadous.com/assets/img/sample/image-20200705215817162.png)

**Technical definition.** $f(N)\sim g(N)$ means $\displaystyle\lim_{N\to\infty}\frac{f(N)}{g(N)}=1$

&emsp;

**Example: 3-SUM**

---

**Q.** Approximately how many array accesses as a function of input size $N$?

```java
int count = 0;
for (int i = 0; i < N; i++)
 		for (int j = i+1; j < N; j++)
 				for (int k = j+1; k < N; k++)
 						if (a[i] + a[j] + a[k] == 0)		// inner loop
 								count++;
```

$$\begin{pmatrix}N\\3\\\end{pmatrix}=\frac{N(N-1)(N-2)}{3!}\sim\frac{1}{6}N^3$$

**A.** $\sim\frac{1}{6}N^3\times 3=\frac{1}{2}N^3$ array accesses.

&emsp;

**Estimating a discrete sum**

---

**Q.** How to estimate a discrete sum?

**A1.** Take discrete mathematics course.

**A2.** Replace the sum with an integral, and us calculus!

Ex 1. $1+2+\dots+N.$											$\displaystyle\sum_{i=1}^N\sim\int_{x=2}^{N}{xdx}\sim\frac{1}{2}N^2$

Ex 2. $1^k+2^k+\dots+N^k$										$\displaystyle\sum_{i=1}^{N}i^k\sim\int_{x=1}^{N}x^kdx\sim\frac{1}{k+1}N^{k+1}$

Ex 3. $1+\frac{1}{2}+\frac{1}{3}+\dots+\frac{1}{N}$ 									$\displaystyle\sum_{i=1}^{N}\frac{1}{i}\sim\int_{x=1}^{N}\frac{1}{x}ds=\ln N$

Ex 4. 3-sum triple loop.											$$\displaystyle\sum_{i=1}^{N}\sum_{j=i}^{N}\sum_{k=j}^{N}1\sim\int_{x=1}^N\int_{y=x}^N\int_{z=y}^Ndzdydx\sim\frac{1}{6}N^3$$

&emsp;

**Mathematical models for running time**

---

**In principle,** accurate methematical models are available.

**In practice,**

* Formulas can be complicated.
* Advanced mathematics might be required
* Exact models best left for experts.

$$T_N=c_1A+c_2B+c_3C+c_4D+c_5E$$

**costs**(depend on machine, compiler)**:** $c_1$,$c_2$,$c_3$,$c_4$,$c_5$

**frequencies**(depend on algorithm, input)**:**

$$A=array~access$$

$$B=integer~add$$

$$C=interger~compare$$

$$D=increment$$

$$E=variable~assignment$$

&emsp;

**Summary**

---

For many programs, developing a mathematical model of running time reduces to the following steps:

* Develop an **input model**, including a definition of the problem size.
* Identify the **inner loop**.
* Define a **cost model** that includes operations in the inner loop.
* Determine the frequency of execution of those operations for the given input.

&emsp;

## 1.4.4 order-of-growth classifications

 **Information used in mathematical analysis**

---

**Commonly encountered functions in the analysis of algorithms**

|       description        |        notation        |                          definition                          |
| :----------------------: | :--------------------: | :----------------------------------------------------------: |
|          floor           |  $\lfloor{x}\rfloor$   |             largest integer not greater than $x$             |
|         ceiling          |   $\lceil{x}\rceil$    |            smallest integer not smaller than $x$             |
|    natural logarithm     |        $\ln N$         |            $\log_e{N}$ ( $x$ such that $e^x=N$ )             |
|     binary logarithm     |        $\lg{N}$        |            $\log_2{N}$ ( $x$ such that $2^x=N$ )             |
| integer binary logarithm | $\lfloor\lg{N}\rfloor$ | largest integer not greater than $\lg{N}$ (# bits in binary representation of $N$) -1 |
|     harmonic number      |         $H_N$          |  $1+\frac{1}{2}+\frac{1}{3}+\frac{1}{4}+\dots+\frac{1}{N}$   |
|        factorial         |          $N!$          |         $1\times2\times3\times4\times\dots\times N$          |

**Useful approximations for the analysis of algorithms**

|       description        |                        approximation                         |
| :----------------------: | :----------------------------------------------------------: |
|       harmonic sum       | $H_N=1+\frac{1}{2}+\frac{1}{3}+\frac{1}{4}+\dots+\frac{1}{N}\sim\ln N$ |
|      triangular sum      |              $1+2+3+4+\dots+N\sim\frac{N^2}{2}$              |
|      geometric sum       |          $1+2+4+8+\dots+N=2N-1\sim2N$ when $N=2^N$           |
| stirling's approximation |     $\lg{N!}=\lg1+\lg2+\lg3+\lg4+\dots+\lg N\sim N\lg N$     |
|  binomial coefficients   | $\begin{pmatrix}N\\k\\\end{pmatrix}\sim\frac{N^k}{k!}$ when $k$ si a small constant |
|       exponential        |              $(1-\frac{1}{x})^x\sim\frac{1}{e}$              |

&emsp;

**Common order-of-growth classifications**

---

**Good news.** the small set of functions

$$1,~\log{N},~N,~N\log{N},~N^2,~N^3,~and~2^N$$

suffices to describe order-of-growth of typical algorithms.

![image-20200706004700131](huadous.com/assets/img/sample/image-20200706004700131.png)

| order of growth |    name     |                    typical code framework                    |    description     |      example      | T(2N)/T(N) |
| :-------------: | :---------: | :----------------------------------------------------------: | :----------------: | :---------------: | :--------: |
|       $1$       |  constant   |                          a = b + c                           |     statement      |  add two numbers  |    $1$     |
|    $\log{N}$    | logarithmic |                while (N > 1) {N = N / 2; ...}                |   divide in half   |   binary search   |  $\sim1$   |
|       $N$       |   linear    |               for (int i = 0; i < N; i++){...}               |        loop        | find the maximum  |    $2$     |
|   $N\log{N}$    | linearithic |                   [see mergesort lecture]                    | divide and conquer |     mergesort     |  $\sim2$   |
|      $N^2$      |  quadratic  | for (int i = 0; i < N; i++)for (int j = 0; j < N; j++){...}  |    double loop     |  check all pairs  |    $4$     |
|      $N^3$      |    cubic    | for (int i = 0; i < N; i++)for (int j = 0; j < N; j++)for (int k = 0; k < N; k++){...} |    triple loop     | check all triples |    $8$     |
|      $2^N$      | exponential |              [see combinatorial search lecture]              | exhaustive search  | check all subsets |    T(N)    |

&emsp;

**Binary search: Java implementatioin**

---

**Trivial to implement?**

* First binary search published in 1946; first bug-free one in 1962.
* Bug in Java's Arrays.binarySearch( ) discovered in 2006.

```java
public static int binarySearch(int[] a, int key)
{		
     int lo = 0, hi = a.length-1;
     while (lo <= hi)
     {
         int mid = lo + (hi - lo) / 2;
         if (key < a[mid]) hi = mid - 1;					// one "3-way compare"
         else if (key > a[mid]) lo = mid + 1;			//
         else return mid;													//
     }
     return -1;
}
```

**Invariant.** If key appears in the array $a[~]$, then $a[lo]\leq key\leq a[hi]$.

&emsp;

**Binary search: mathematical analysis**

---

**Proposition.** Binary search uses at most $1+\lg{N}$ key compares to search in a sorted array of size $N$.

**Def.** $T(N)\equiv$ # key compares to binary search a sorted subarray of size $\leq N$.

**Binary search recurrence.** $T(N)\leq T(\frac{N}{2})+1$ for $N>1$, with $T(1)=1$.

​		                     	$T(\frac{N}{2})$: left or right half	$+1$: possible to implement with one 2-way compare ( instead of 3-way )

**Pf sketch.**

$1$				  		$T(N)\leq T({\frac{N}{2}})+1$														given

$2$									$\leq T({\frac{N}{4}})+1+1$								apply recurrence to first term

$3$									$\leq T({\frac{N}{8}})+1+1+1$						  apply recurrence to first term

​													$\dots$

$\lg N$								$\leq T({\frac{N}{N}})+1+1+\dots+1$				 stop applying, T(1) = 1

​										$=1+\lg{N}$

&emsp;

**An** $N^2\log{N}$ **algorithm for 3-SUM**

---

**Sorting-based algorithm.**

* Step 1: **Sort** the $N$ (distinct) numbers.
* Step 2: For each pair of numbers $a[i]$ and $a[j]$($\sim N^2$), **binary search** for $-(a[i]+a[j])$($\sim \lg{N}$).

**Analysis.** Order of growth is $N^2\lg{N}$.

* Step 1: $N^2$ with insertion sort.
* Step 2 $N^2\log{N}$ with binary search.

![image-20200706143603681](huadous.com/assets/img/sample/image-20200706143603681.png)

**Guiding principle.** Typically, better order of growth $\Rightarrow$ faster in practice.

&emsp;

## 1.4.5 theory of algorithms

**Types of analyses**

---

**Best case.** Lower bound on cost.

* Determined by "easiest" input.
* Provides a goal for all inputs.

**Worst case.** Upper bound on cost.

* Determined by "most difficult" input.
* Provides a guarantee for all inputs.

**Average case.** Expected cost for random input.

* Need a model for "random" input.
* Provides a way to predict performance.

> Ex 1. Array accesses for brute-force 3-SUM.
>
> Best:				$\sim\frac{1}{2}N^3$
>
> Average:			$\sim\frac{1}{2}N^3$
>
> Worst:				$\sim\frac{1}{2}N^3$

> Ex 2. Compares for binary search.
>
> Best:				$\sim1$
>
> Average:			$\sim\lg{N}$
>
> worst:				$\sim\lg{N}$

**Actual data might not match input model?**

* Need to understand input to effectively process it.
* Approach 1: design for the worst case.
* Approach 2: randomize, depend on probabilistic guarantee.

&emsp;

**Theory of algorithms**

---

**Goals.**

* Establish "difficulty" of a problem.
* Develop "optimal" algorithms.

**Approach.**

* Suppress details in anaylsis: analyze "to within a constant factor".
* Eiminate variability in input model by focusing on the worst case.

**Optimal algorithm.**

* Performance guarantee ( to within a constant factor ) for any input.
* No algorithm can provide a better performance guarantee.

&emsp;

**Commonly-used notations**

---

| notation  | provides                  | example       | shorthand for                            | used to                   |
| --------- | ------------------------- | ------------- | ---------------------------------------- | ------------------------- |
| Tilde     | leading term              | $\sim10N^2$   | $10N^2,10N^2+22N\log{N},10N^2+2N+37$     | provide approximate model |
| Big Theta | asymptotic growth rate    | $\Theta(N^2)$ | $\frac{1}{2}N^2,10N^2,5N^2+22\log{N+3N}$ | classify algorithms       |
| Big Oh    | $\Theta(N^2)$ and smaller | $O(N^2)$      | $10N^2,100N,22N\log{N}+3N$               | develop upper bounds      |
| Big Omega | $\Theta(N^2)$ and larger  | $\Omega(N^2)$ | $\frac{1}{2}N^2,N^5,N^3+22N\log{N}+3N$   | develop lower bounds      |

&emsp;

**Theory of algorithms: example 1**

---

**Goals.**

* Establish "difficulty" fo a problem and develop "optimal" algorithms.
* Ex. 1-SUM = "*Is there a 0 in the array?*"

**Upper bound.** A specific algorithm.

* Ex. Brute-force algorithm for 1-SUM: look at every entry.
* Running time of the optimal algorithm for 1-SUM is $O(N)$.

**Lower bound.** Rroof that no algorithm can do better.

* Ex. Have to examine all $N$ entries (any unexamined one might be 0).
* Running time of the optimal algorithm for 1-SUM is $\Omega(N)$.

**Optimal algorithm.**

* Lower bound equals upper bound (to within a constant factor).
* Ex. Brute-force algorithm for 1-SUM is optimal: its running time is $\Theta(N)$.

&emsp;

**Theory of algorithms: example 2**

---

**Goals.**

* Establish "difficulty" of a problem and develop "optimal" algorithms.
* Ex. 3-SUM.

**Upper bound.** A specific algorithm.

* Ex. Brute-force algorithm for 3-SUM.
* Running time of the optimal algorithm for 3-SUM is $O(N^3)$.
* Ex. Improved algorithm for 3-SUM.
* Running time of the optimal algorithm for 3-SUM is $O(N^2\log{N})$.

**Lower bound.** Proof that no algorithm can do better.

* Ex. Have to examine all $N$ entries to solve 3-SUM.
* Running time of the optimal algorithm for solving 3-SUM is $\Omega(N)$.

**Open problems.**

* Optimal algorithm for 3-SUM?
* Subquadratic algorithm for 3-SUM?
* Quadratic lower bound for 3-SUM?

&emsp;

**Algorithm design approach**

---

**Start.**

* Develop an algorithm.
* Prove a lower bound.

**Gap?**

* Lower the upper bound ( discover a new algorithm ).
* Raise the lower bound ( more difficult ).

**Golden Age of Algorithm Design.**

* 1970s-
* Steadily decreasing upper bounds for many important problems.
* Many known optimal algorithms.

**Caveats**

* Overly pessimistic to focus on worst case?
* Need better than "to within a constant factor" to predict performance.

**Common mistake.** Interpreting big-Oh as an approximate model.

**This course.** Focus on approximate models: use Tilde-notation.

&emsp;

## 1.4.6 memory

**Basics**

---

**Bit.** 0 or 1.

**Byte.** 8 bits.

**Megabyte(MB).** 1 million or $2^{20}$ bytes.

**Gigabyte(GB).** 1 billion or $2^{20}$ bytes.

​								$\uparrow$ NIST	$\uparrow$most computer scientists

**64-bit machine.** We assume a 64-bit machine with **8 byte pointers**.

* Can address more memory.
* Pointers use more space.

&emsp;

**Typical memory usage for primitive types and arrays.**

---

**for primitive types**

|  type   | bytes |
| :-----: | :---: |
| boolean |   1   |
|  byte   |   1   |
|  char   |   2   |
|   int   |   4   |
|  float  |   4   |
|  long   |   8   |
| double  |   8   |

**for one-dimensional arrays**

|   type    | bytes |
| :-------: | :---: |
|  char[ ]  | 2N+24 |
|  int[ ]   | 4N+24 |
| double[ ] | 8N+24 |

**for two-dimensional arrays**

| type           | bytes     |
| -------------- | --------- |
| char [ ] [ ]   | $\sim2MN$ |
| int [ ] [ ]    | $\sim4MN$ |
| double [ ] [ ] | $\sim8MN$ |

&emsp;

**Typical memory usage for objects in Java**

---

**Object overhead.** 16 bytes.

**Reference.** 8 bytes.

**Padding.** Each object uses a multiple of 8 bytes.

![image-20200707130733573](huadous.com/assets/img/sample/image-20200707130733573.png)

![image-20200707130824239](huadous.com/assets/img/sample/image-20200707130824239.png)

**Total memory usage for a data type value:**

* Primitive type: 4 bytes for int, 8 bytes for double,...
* Object reference: 8 bytes.
* Array: 24 bytes + memory for each array entry.
* Object: 16 bytes + memory for each instance variable + 8 bytes if inner class (for pointer to enclosing class).
* Padding: round up to multiple of 8 bytes.

**Shallow memory usage:** Don't count referenced objects.

**Deep memory usage:** If array entry or instance variable is a reference, add memory (recursively) for referenced object.

&emsp;

**Example**

---

**Q.** How much memory does *WeightedQuick UnionUF* use as a function of $N$?\

(Use tilde notation to simplify your answer)

```java
public class WeightedQuickUnionUF						// 16 bytes(object overhead)
{
		private int[] id;												// 8+(4N+24) each
 		private int[] sz;												// reference + int[ ] array
 		private int count;											// 4 bytes (int)
 																						// 4 bytes (padding)
 		public WeightedQuickUnionUF(int N)
 		{
 				id = new int[N];
 				sz = new int[N];
 				for (int i = 0; i < N; i++) id[i] = i;
 				for (int i = 0; i < N; i++) sz[i] = 1; 
 		}
 		...
}
```

**A.** $8N+88\sim8N$ bytes

&emsp;

## 1.4.7 Practice Quiz

**3-SUM in quadratic time.**

---

Design an algorithm for the 3-SUM problem that takes time proportional to $n^2$ in the worst case. You may assume that you can sort the $n$ integers in time proportional to $n^2$ or better.

> *Hints*: given an integer $\mathtt{x}$ and a sorted array $\mathtt{a[ ]}$ of $n$ distinct integers, design a linear-time algorithm to determine if there exists two distinct indices $\mathtt{i}$ and $\mathtt{j}$ such that $\mathtt{a[i] + a[j] == x}$.

```java
import java.util.Arrays;
import java.util.HashMap;

public class threeSum {
    public static int count(int[] a, int target) {
        System.out.println(Arrays.toString(a));
        int cnt = 0;
        int n = a.length;
        HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
        for (int i = 0; i < n; i++) {
            map.put(a[i], i);
        }
        for (int i = 0; i < n - 1; i++) {
            for (int j = i + 1; j < n; j++) {
                int smallValue = a[i] + a[j];
                if (smallValue > target)
                    break;
                int bigValue = target-smallValue;
                Integer bigIndex = map.get(bigValue);
                if (bigIndex != null && bigIndex > j) {
                    System.out.println(
                            "[" + i + "]=" + a[i] + ",[" + j + "]" + a[j] + ",[" + bigIndex + "]" + (bigValue));
                    cnt++;
                }
            }
        }
        return cnt;
    }

    public static void main(String[] args) {
        int[] a = { -40, -20, -10, 0, 5, 10, 30, 40 };
        System.out.println(count(a,0));
    }
}
```

&emsp;

**Search in a bitonic array.**

---

An array is *bitonic* if it is comprised of an increasing sequence of integers followed immediately by a decreasing sequence of integers. Write a program that, given a bitonic array of $n$ distinct integer values, determines whether a given integer is in the array.

- Standard version: Use $\sim 3 \lg n$ compares in the worst case.
- Signing bonus: Use $\sim 2 \lg n$ compares in the worst case (and prove that no algorithm can guarantee to perform fewer than $\sim 2 \lg n$ compares in the worst case).

> *Hints*: Standard version. First, find the maximum integer using $\sim 1 \lg n$ compares—this divides the array into the increasing and decreasing pieces.
>
> Signing bonus. Do it without finding the maximum integer.

**Solution:** The standard solution here is very easy to implement. First use the binary search to find the maximum value of the array, and then perform a binary search on the left and right. It is easy to get the number of comparisons of $\sim3\lg n$. For a more efficient search method, here I choose not to find the maximum value. The specific recursive implementation is described as follows:

* Find mid first, compare it with key, and return true if they are equal, otherwise proceed to the next step;
* Compare the mid value with the left and right values to determine whether mid is on the left or right of the mountain peak or the peak;
* **If it is the top of the peak**, take the binary search on the left and right sides; **if it is the left of the peak**, then determine the relative size of the key value and the mid value. **If the key value is greater than the mid value**, then you can know that the key value is on the right side of the mid, and recursive $bitonicSearch(mid +1, hi, key)$ directly; **if the key value is less than the mid value**, you need to perform a binary search on the left and a recursive search on the right; the same is true for the case where mid is on the right of the peak.

&emsp;

**Egg drop.**

---

Suppose that you have an $n$-story building (with floors 1 through $n$) and plenty of eggs. An egg breaks if it is dropped from floor $T$ or higher and does not break otherwise. Your goal is to devise a strategy to determine the value of $T$ given the following limitations on the number of eggs and tosses:

- Version 0: 1 egg, $\le T$ tosses.
- Version 1: $\sim 1 \lg n$ eggs and $\sim 1 \lg n$ tosses.
- Version 2: $\sim \lg T$ eggs and $\sim 2 \lg T$ tosses.
- Version 3: $2$ eggs and $\sim 2 \sqrt n$ tosses.
- Version 4: $2$ eggs and $\le c \sqrt T$ tosses for some fixed constant $c$.

>*Hints:*
>
>- Version 0: sequential search.
>- Version 1: binary search.
>- Version 2: find an interval containing $T$ of size $\le 2T$, then do binary search.
>- Version 3: find an interval of size $\sqrt n$, then do sequential search. Note: can be improved to $\sim \sqrt{2n}$ tosses.
>- Version 4: $1 + 2 + 3 + \ldots + t \; \sim ~ \frac{1}{2} t^2$. Aim for $c = 2 \sqrt{2}$

**version 0:** You can throw an egg from $1$ to $n$ in order, and it will break when you reach floor $T$, so the complexity is $\le T$

**version 1:** Use binary search, first throw from the $\frac{n}{2}$ layer:

```						java
						if (egg broken) {
						Throw from (n/2)/2 floor;
						}
						else {
						Throw from n/2+(n/2)/2 floor;
						}
```

​				requires $\sim \lg n$ eggs and try $\sim \lg n$ times

**version 2:** Start tossing from $1, 2, 4, 8, 16, 32,\dots 2^k$ in sequence, if the egg is broken at $2^k$, then $2^{k-1}\le T\le 2^k$, then the $\lg T$ substep has been used, then It takes $\lg T$ steps to perform the version 1 binary search method in the $[2^{k-1}+1,2^k)$ interval. These two operations add up to a total of $2\lg T$ steps.

**version 3:** Divide the $0\sim n$ floors into [1, $ \sqrt{n} $-1], [$ \sqrt{n} $, 2 $ \sqrt{n} $-1], [2$ \sqrt {n} $,3 $ \sqrt{n} $-1]...[k$ \sqrt{n} $, (k+1)$ \sqrt{n} $-1]. intervals, use An egg distribution starts from 1 and is thrown at the starting floor of each section. If it is broken at the k$ \sqrt{n} $ layer, then it will be thrown layer by layer from (k-1)$ \sqrt{n} $+1 . In the first step interval selection, the complexity of $ \sqrt{n} $ was used, and in the second step interval, the egg was thrown inside the $ \sqrt{n} $ complexity, a total of 2$ \sqrt{n} $.

**version 4:** Try to throw eggs from $1, 4, 9, 16, 25,\dots(k-1)^2, k^2\dots$ floor, add eggs and break on floor $k^2$, which means $(k-1)^2 \le T\le k^2$, this step tried $ \sqrt{T} $ times (k=$ \sqrt{T} $). Then throw from floor $(k-1)^2+1$ layer by layer, at most try until the end of $k^2-1$, this step needs to try $(k^2-1)-[(k-1)^2+1]=2 \sqrt{T} - 3 $times. Total shared 3$ \sqrt{T} -3$ times.