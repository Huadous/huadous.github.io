---
title: "Algorithms Part 1 week 1"
date: 2020-07-05 12:19:00 +0800
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

# 1.5 UNION-FIND

For details, the course pdf of [UNION-FIND](https://huadous.com/pdf/coursera/algorithmsPrincetonP1/courseraAlgorithmsUnionFind.pdf) is avaliable (provided by coursera Princeton).

## 1.5.1 dynamic connectivity

**What is Dynamic connectivity?**

---

* Union command: connect two objects.
* Find/connected query: is there a path connecting the two objects?

i.e. union(3,4) $\Rightarrow$ union the site 3 and 4 together. connected(3,4) $\Rightarrow$ test whether site 3 and 4 is connected.

&emsp;

**Connectivity example**

---

Q. Is there a path connecting $p$ and $q$?

![image-20200703145248251](huadous.com/assets/img/sample/image-20200703145248251.png)

A.Yes.

&emsp;

**Modeling the connections**

---

We assume "is connected to" is an equivalence relation:

* **Reflexive**: $p$ is connected to $p$.
* **Symmetric**: if $p$ is connected to $q$, then $q$ is connected to $p$.
* **Transitive**: if $p$ is connected to $q$ and $q$ is connected to $r$, then $p$ is connected to $r$.

**Connected components.** Maximal set of objects that are mutually connected.

![image-20200703145940341](huadous.com/assets/img/sample/image-20200703145940341.png)

&emsp;

**Implementing the operations**

---

**FInd query.** Check if two objects are in the same component.

**Union command.** Replace components containing two objects with their union.

![image-20200703150120177](huadous.com/assets/img/sample/image-20200703150120177.png)

&emsp;

**Union-find data type(API)**

---

**Goal.** Design efficient data structure for union-find,

* Number of objects $N$ can be huge.
* Number of operations $M$ can be huge.
* Find queries and union commands may be intermixed,

**Union-find implementation**

```java
import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.StdOut;

public class UF
{
    private int[] id;     // access to component id (site indexed)
    private int count;    // number of components
    public UF(int N)
    { // Initialize component id array.
        count = N;
        id = new int[N];
        for (int i = 0; i < N; i++)
            id[i] = i;
    }

    public int count()
    {
        return count;
    }
    
    public boolean connected(int p, int q)
    {
        return find(p) == find(q);
    }
    public int find(int p);
    public void union(int p, int q);
    // add quick-find, quick-union or weighted, etc.
    
    public static void main(String[] args)
    { //Solve dynamic connectivity problem on StdIn.
        int N = StdIn.readInt();                // Read number of sites.
        UF uf = new UF(N);                      // Initialize N components.
        while (!StdIn.isEmpty())      
        {
            int p = StdIn.readInt();            
            int q = StdIn.readInt();            // Read pair to connect.
            if (uf.connected(p, q)) continue;   // Ignore if connected.
            uf.union(p, q);                     // Combine components.
            StdOut.println(p + " " + q);        // and print connections.
        }
        StdOut.println(uf.count() + " components");
    }
}
```

&emsp;

## 1.5.2 quick find

**Quick-find   [eager approach]**

---

**Data structure**

* Interger array id[ ] of length N.
* Interpretation: $p$ and $q$ are connected iff (if and only if) they have same id.

![image-20200703152714014](huadous.com/assets/img/sample/image-20200703152714014.png)

**Find.** Check if $p$ and $q$ have the same id, i.e. id[6] = 0; id[1] =1, thus, 6 and 1 are not connected.

**Union.** To merge components containing $p$ and $q$, change all entries whose id equals id[p] to id[q]. **Problem: many values can change**

&emsp;

**Quick-find demo**

---

**Quick-find overview**

![image-20200703161547340](huadous.com/assets/img/sample/image-20200703161547340.png)

**Quick-find trace**

![image-20200703161448353](huadous.com/assets/img/sample/image-20200703161448353.png)

&emsp;

**Quick-find: Java implementation**

---

```java
public class QuickFindUF {
    private int[] id;
    
    public QuickFindUF(int N){
        id = new int[N];
        for (int i = 0; i < N; i++){                // set id of each object to itself
            id[i] = i;                              // (N array accesses)
        }
    }
    
    public boolean connected( int p, int q){        // check whether p and q
        return id[p] == id[q];                      // are in the same component
    }                                               // (2 array accesses)
    
    public void union( int p, int q){               // change all entries with id[p] to id[q]
        int pid = id[p];                            // 1 time
        int qid = id[q];                            // 1 time
        for (int i = 0; i < id.length; i++){        // best: only change 1 site plus N times(for)
            if (id[i] == pid) id[i] = qid;          // worst: change n-1 sites plus N times(for)
        }                                           // the range is [ N + 3, 2N + 2}
    }
}
```

&emsp;

**Quick-find analysis**.

---

> **Proposition F.** The quick-find algorithm uses one array access for each call to $find(~)$ and between $N+3$ and $2N+1$ array accesses for each call to $union(~)$ that combines two components.
>
> **Proof:** Immediate from the code. Each call to $connected(~)$ tests two entries in the $id[~]$ array, one for each of the two calls to $find(~)$. Each call to $union(~)$ that combines two components does so by making two calls to $find(~)$, testing each of the $N$ entries in the $id[~]$ array, and changing between $1$ and $N-1$ of them. 

&emsp;

**Quick-find is too slow**

---

**Cost model.** Number of array accesses (for read or write).

| algorithm  | initialize | union | find |
| :--------: | :--------: | :---: | :--: |
| quick-find |     N      |   N   |  1   |

**Union is too expensive.** It takes $N^2$ array accesses to process a sequence of $N$ union commands on $N$ objects.

In particular, suppose that we use quick-find for the dynamic connectivity problem and wind up with a single component. This requires at least $N-1$ calls to $union(~)$, and, consequently, at least $(N+3)(N-1)\sim N^2$ array access—we are led immediately to the hypothesis that dynamic connectivity with quick-find can be a *quadratic*-time process.

&emsp;

## 1.5.3 quick union

**Quick-union   [lazy approach]**

---

**Data structure.**

* Integer array id[] of length N.
* Interpretation: id[i] is parent of i.
* **Root** of i is $id[id[id[...id[i]...]]]$. (keep going until it doesn't change algorithm ensures no cycles) 

![image-20200703160843769](huadous.com/assets/img/sample/image-20200703160843769.png)

**Find.** Check if $p$ and $q$ have the same root.

**Union.** To merge components containing $p$ and $q$, set the id of $p$'s root to the id of $q$'s root.

&emsp;

**Quick-union demo**

---

![image-20200703161726907](huadous.com/assets/img/sample/image-20200703161726907.png)

**Quick-union trace**

![image-20200703161823608](huadous.com/assets/img/sample/image-20200703161823608.png)

&emsp;

**Quick-union: Java implementation**

---

```java
public class QuickUnionUF
{
		private int[] id;
		
  	public QuickUnionUF(int N)										// set id of each objects to itself
 		{																							// (N array accesses)
 				id = new int[N];
 		for (int i = 0; i < N; i++) id[i] = i;
 		}
  
 		private int root(int i)												// chase parent pointers until reach root
 		{																							// (depth of i array accesses)
 				while (i != id[i]) i = id[i];
 				return i;
 		}
  
 		public boolean connected(int p, int q)				// check if p and q have same root
 		{																							// (depth of p and q array accesses)
 				return root(p) == root(q);
 		}
  
 		public void union(int p, int q)								// change root of p to point to root of q
 		{																							// (depth of p and q array accesses)
 				int i = root(p);
 				int j = root(q);
 				id[i] = j;
 		}
}
```

&emsp;

**Quick-union analysis**

---

**Quick-union worst case**

![image-20200703165433362](huadous.com/assets/img/sample/image-20200703165433362.png)

>**Definition.** The size of a tree is its number of nodes. The depth of a node in a tree is the number of links on the path from it to the root. The height of a tree is the maximum depth among its nodes.

> **Proposition G.** The number of array accesses used by $find(~)$ in quick-union is 1 plus the twice the depth of the node corresponding to the given site. The number of array accesses used by $union(~)$ and $connected(~)$ is the cost the two $find(~)$ operation (plus 1 for $union(~)$ if the given sites are in different trees).
>
> **Proof:** Immediate from the code.

&emsp;

**Quick-union is also too slow**

---

**Cost model.** Number of array accesses (for read or write).

|        algorithm        | initialize | union | find |
| :---------------------: | :--------: | :---: | :--: |
|       quick-find        |     N      |   N   |  1   |
| quick-union(worst case) |     N      | N$^†$ |  N   |

$†$  includes cost of finding roots

 **Quick-find defect.**

* Union too expensive ( $N$ array accesses).
* Trees are flat, but too expensive to keep them flat.

**Quick-union defect.**

* Trees can get tall.
* Find too expensive ( could be $N$ array accesses).

&emsp;

## 1.5.4 improvements

**Improvement 1: weighting**

---

**Weighted quick-union.**

* Modify quick-union to avoid tall trees.
* Keep track of size of each tree (number of objects).
* Balance by linking root of smaller tree to root of **larger tree** (reasonable alternatives: union by height or "rank").

![image-20200703175339554](huadous.com/assets/img/sample/image-20200703175339554.png)

&emsp;

**Weighted quick-union demo**

---

![image-20200703205326809](huadous.com/assets/img/sample/image-20200703205326809.png)

&emsp;

**Weighted quick-union: Java implementatioin**

---

```java
public class WeightedQuickUnionUF
{
		private int[] id;														// parent link (site indexed)
		private int[] sz;														// size of component for roots (site indexed)
		private int count;													// number of components

		public WeightedQuickUnionUF(int N)
		{
   			count = N;
   			id = new int[N];
   			for (int i = 0; i < N; i++) id[i] = i;
   			sz = new int[N];
   			for (int i = 0; i < N; i++) sz[i] = 1;
		}

		public int count()
		{  return count;  }

		public boolean connected(int p, int q)
		{  return find(p) == find(q);  }

		private int find(int p)
		{ // Follow links to find a root.
   			while (p != id[p]) p = id[p];
				return p; 
		}

		public void union(int p, int q)
		{
   			int i = find(p);
   			int j = find(q);
   			if (i == j) return;
				// Make smaller root point to larger one.
				if (sz[i] < sz[j]) 	{ id[i] = j; sz[j] += sz[i]; }
        else		 	        	{ id[j] = i; sz[i] += sz[j]; }
        count--;
		} 	
}
```

>This code is best understood in terms of the forest-of-trees representation described in the text. We add a site-indexed array $sz[~]$ as an instance variable so that $union(~)$ can link the root of the smaller tree to the root of the larger tree. This addition makes it feasible to address large problems.

&emsp;

**Weighted quick-union analysis**

---

**Running time.**

* Find: takes time proportional to depth of $p$ and $q$.
* Union: takes constant time, given roots.

**Proposition.** Depth of any node $x$ is at most $\log_{2}{N}$ ($base-2~~logarithm$)

> **Proposition H.** The depth of any node in a forest built by weight quick-union for $N$ sites is  at most $\log_{2}{N}$.
>
> **Proof.** We prove a stronger fact by (strong) induction: The height of every tree of size $k$ in the forest is at most $\log_{2} {k}$. The base case follows from the fact that the tree height is 0 when $k$ is 1. By the inductive hypothesis, assume that the tree height of a tree of size $i$ is at most $\log_{2}{i}$ for all $i<k$. When we combine a tree of size $i$ with a tree of size $j$ with $i\leq j$ and $i+j=k$, we increase the depth of each node in the smaller set by 1, but they are now in a tree of size $i+j=k$, so the property is preserved because:
>
> $$1+\log_{2}{i}=\log_{2}{i+i}\leq\log_{2}{i+j}=\log_{2}{k}$$

![image-20200703220521715](huadous.com/assets/img/sample/image-20200703220521715.png)

**Quick-union and weighted quick-union(100 sites, 88 union( ) operations)**

![image-20200703215926138](huadous.com/assets/img/sample/image-20200703215926138.png)

> **Corollary.** For weighted quick-union with **N** sites, the worst-case order of growth of the cost of $find(~)$, $connected(~)$, and $union(~)$ is $\log_{2}{N}$.
>
> **Proof.** Each operation does at most a constant number of array accesses for each node on the path from a node to a root in the forest.

| algorithm   | initialize | unioin          | connected     |
| ----------- | ---------- | --------------- | ------------- |
| quick-find  | N          | N               | 1             |
| quick-union | N          | N$^†$           | N             |
| weighted QU | N          | $\log_{2}{N}^†$ | $\log_{2}(N)$ |

$†$  includes cost of finding roots

&emsp;

**Improvement 2: path compression**

---

**Quick union with path compression.** Just after computing the root of $p$, set the id of each examined node to point to that root.

&emsp;

**Quick union with path compression demo**

---

![D3FCE03725DCFCCF1AAC4C90078A182A](/Users/huadous/Library/Containers/com.tencent.qq/Data/Library/Caches/Images/D3FCE03725DCFCCF1AAC4C90078A182A.jpg)

&emsp;

**Path compression: Java implementation**

---

1. **Two-pass implementation:** add second loop to $root(~)$ to set the $id[~]$ of each examined node to the root.
2. **Simpler one-pass variant implementation:** Make every other node in path point to its grandparent (thereby halving path length).

```java
private int root(int i)
{
 		while (i != id[i])
 		{
 				id[i] = id[id[i]];						//only one extra line of code!
 				i = id[i];
 		}
 		return i;
}
```

**In practice.** No reason not to! Keeps tree almost completely flat.

&emsp;

**Weighted quick-union with path compression: amortized analysis**

---

**Proposition.** [Hopcroft-UIman, Tarjan]  Starting from an empty data structure, any sequence of $M$ union-find ops on $N$ objects makes $\leq c(N+M\lg^* N)$ array accesses.

* Analysis can be improved to $N+M\alpha(M,N)$.
* Simple algorithm with fascinating mathematics.

**iterate log function: **

|      N      | $\log_{2}^*{N}$ |
| :---------: | :-------------: |
|      1      |        0        |
|      2      |        1        |
|      4      |        2        |
|     16      |        3        |
|    65536    |        4        |
| $2^{65536}$ |        5        |

**Linear-time algorithm for** $M$ **union-find ops on** $N$ **objects?**

* Cost within constant factor of reading in the data.
* In theory, WQUPC is not quite linear.
* In practice, WQUPC is linear.

**Amazing fact.** [Fredman-Saks] No linear-time algorithm exists.(in "cell-probe" model of computation)

&emsp;

**Summary**

---

**Bottom line.** Weighted quick union (with path compression) makes it possible to solve problems that could not otherwise be addressed.

**M union-find operations on a set of N objects**

|           algorithm            |   worst-case time    |
| :----------------------------: | :------------------: |
|           quick-find           |     $M\times N$      |
|          quick-union           |     $M\times N$      |
|          weighted QU           |   $N+M\log_{2}{N}$   |
|      QU+ path compression      |   $N+M\log_{2}{N}$   |
| weighted QU + path compression | $N+M\log_{2}^{*}{N}$ |

**Performance characteristics of union-find algorithms**

|                 algorithm                  | constructor |    union    |    find     |
| :----------------------------------------: | :---------: | :---------: | :---------: |
|                 quick-find                 |     $N$     |     $N$     |      1      |
|                quick-union                 |     $N$     | tree height | tree height |
|            weighted quick-union            |     $N$     |  $\lg{N}$   |  $\lg{N}$   |
| weighted quick-union with path compression |     $N$     | $\approx1$  | $\approx1$  |
|                 impossible                 |     $N$     |      1      |      1      |

&emsp;

## 1.5.5 Practice Quiz

**1. Social network connectivity.**

---

Given a social network containing $n$ members and a log file containing $m$ timestamps at which times pairs of members formed friendships, design an algorithm to determine the earliest time at which all members are connected (i.e., every member is a friend of a friend of a friend ... of a friend). Assume that the log file is sorted by timestamp and that friendship is an equivalence relation. The running time of your algorithm should be $m\log{n}$ or better and use extra space proportional to $n$.

The requirement is the running time of your algorithm should be $m\log{n}$ or better. Thus, my choice is to use weighted union-find with path compression.

```java
import java.util.Scanner;

public class SocialNetworkConnectivity {
    int[] id;
    int[] sz;
    int count;

    public SocialNetworkConnectivity(int N) {
        id = new int[N];
        sz = new int[N];
        count = N;
        for (int i = 0; i < N; i++) {
            id[i] = i;
            sz[i] = 1;
        }

        for (int i = 0; i < N; i++) {
            sz[i] = 1;
        }
    }

    public void union(int q, int p) {
        int rootA = root(q);
        int rootB = root(p);
        if (rootA == rootB) return;

        if (sz[rootA] < sz[rootB]) {
            id[rootA] = id[rootB];
            sz[rootB] += sz[rootA];
        } else {
            id[rootB] = id[rootA];
            sz[rootA] += sz[rootB];
        }
        count--;
    }

    public int root(int i)
    {
        while (i != id[i]) {
            id[i] = id[id[i]];
            i = id[i];
        }
        return i;
    }

    public static void main(String[] args) {
        SocialNetworkConnectivity so = new SocialNetworkConnectivity(10);
        int count = 1;
        while (true) {
            Scanner scanner = new Scanner(System.in);
            int q = scanner.nextInt();
            int p = scanner.nextInt();
            so.union(q, p);
            if (so.count == 1) {
                System.out.println("all ids connected in log " + count);
                break;
            }
            System.out.println(so.count);
            count++;
        }
    }
}
```

&emsp;

**2. Union-find with specific canonical element.**

---

Add a method $find(~)$ to the union-find data type so that $find(i)$ returns the largest element in the connected component containing $i$. The operations, $union(~)$, $connected(~)$, and $find(~)$ should all take logarithmic time or better.

For example, if one of the connected components is $\{1,2,6,9\}$, then the $find(~)$ method should return $9$ for each of the four elements in the connected components.

*Hint:* maintain an extra array to the weighted quick-union data structure that stores for each root $i$ the large element in the connected component containing $i$.

```java
import java.util.Arrays;
import java.util.Scanner;

public class UnionFind {
    int[] id;
    int[] sz;
    int[] max;
    int count;

    public UnionFind(int N) {
        id = new int[N];
        sz = new int[N];
        max = new int[N];
        count = N;
        for (int i = 0; i < N; i++) {
            id[i] = i;
            sz[i] = 1;
            max[i] = i;
        }

    }

    public void union(int q, int p) {
        int rootA = root(q);
        int rootB = root(p);
        if (rootA == rootB) return;
        if (max[rootA] > max[rootB]){
            max[rootB] = max[rootA];
        }else{
            max[rootA] = max[rootB];
        }
        if (sz[rootA] < sz[rootB]) {
            id[rootA] = id[rootB];
            sz[rootB] += sz[rootA];
        } else {
            id[rootB] = id[rootA];
            sz[rootA] += sz[rootB];
        }
        count--;
    }

    public int root(int i)
    {
        while (i != id[i]) {
            id[i] = id[id[i]];
            i = id[i];
        }
        return i;
    }

    public int find(int i)
    {
        while (i != id[i]){
            i = id[i];
        }
        return max[i];
    }

    public static void main(String[] args) {
        UnionFind so = new UnionFind(10);
        int count = 1;
        while (true) {
            Scanner scanner = new Scanner(System.in);
            int q = scanner.nextInt();
            int p = scanner.nextInt();
            so.union(q, p);
            if (so.count == 1) {
                System.out.println("all ids connected in log " + count);
                break;
            }
            System.out.println(so.count);
            System.out.println(Arrays.toString(so.id));
            System.out.println(Arrays.toString(so.sz));
            System.out.println(Arrays.toString(so.max));
            System.out.println(so.find(p));
            System.out.println(so.find(q));
            count++;
        }
    }
}
```

&emsp;

**3. Successor with delete.**

---

Given a set of n*n* integers $S = \{ 0, 1, ... , n-1 \}$ and a sequence of requests of the following form:

- Remove $x$ from $S$
- Find the *successor* of $x$: the smallest $y$ in $S$ such that $y\geq x$.

design a data type so that all operations (except construction) take logarithmic time or better in the worst case.

*Hint*: use the modification of the union−find data discussed in the previous question.

```java
import java.util.Arrays;
import java.util.Scanner;

public class SuccessorWithDelete {
    private int[] id;
    private int[] sz;
    private int[] max;
    private int count;
    private boolean[] status;

    public SuccessorWithDelete(int N) {
        id = new int[N];
        sz = new int[N];
        max = new int[N];
        status = new boolean[N];										//The boolean value starts with false 
        count = N;
        for (int i = 0; i < N; i++) {
            id[i] = i;
            sz[i] = 1;
            max[i] = i;
            status[i] = true;
        }

    }


    public void union(int q, int p) {
        int rootA = root(q);
        int rootB = root(p);
        if (rootA == rootB) return;
        if (max[rootA] > max[rootB]){
            max[rootB] = max[rootA];
        }else{
            max[rootA] = max[rootB];
        }
        if (sz[rootA] < sz[rootB]) {
            id[rootA] = id[rootB];
            sz[rootB] += sz[rootA];
        } else {
            id[rootB] = id[rootA];
            sz[rootA] += sz[rootB];
        }
        count--;
    }

    public int root(int i)
    {
        while (i != id[i]) {
            id[i] = id[id[i]];
            i = id[i];
        }
        return i;
    }

    public int find(int i)
    {
        while (i != id[i]){
            i = id[i];
        }
        return max[i];
    }

    public void remove(int i){
        status[i] = false;
        if(!status[i+1]){
            union(i,i+1);
        }
        if(!status[i-1]){
            union(i,i-1);
        }
    }

    public static void main(String[] args) {
        SuccessorWithDelete so = new SuccessorWithDelete(10);
        int count = 1;
        Scanner scanner = new Scanner(System.in);
        while (true) {
            int input = scanner.nextInt();
            so.remove(input);
            if (so.count == 1) {
                System.out.println("over");
                break;
            }
            System.out.println(so.find(input)+1);
            System.out.println(Arrays.toString(so.status));
            count++;
        }
    }
}
```

&emsp;

## 1.5.6 Programming Assignment: Pecolation

Assignment requirements can be reach at Princeton's web page: [PERCOLATION](https://coursera.cs.princeton.edu/algs4/assignments/percolation/specification.php).

There are two java classes as following.

**Percolation.java**

```java
import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.StdOut;
import edu.princeton.cs.algs4.WeightedQuickUnionUF;

public class Percolation {
    private boolean [] arrAysite;
    private  int n;
    private int numOpenSites;
    private WeightedQuickUnionUF topBotWeightedQuickUnionUF;
    private WeightedQuickUnionUF topWeightedQuickUnionUF;
    private int virtualTop;
    private int virtualBot;

    public Percolation(int n)
    {
        numOpenSites = 0;
        if (n <= 0)
        {
            throw new IllegalArgumentException("n0");
        }
        else
        {
            this.n = n;
            virtualTop = 0;
            virtualBot = n*n +1;

            arrAysite = new boolean [n*n +2];
            arrAysite[virtualTop] = true;
            arrAysite[virtualBot] = true;

            topBotWeightedQuickUnionUF = new WeightedQuickUnionUF(n*n +2);
            topWeightedQuickUnionUF = new WeightedQuickUnionUF(n*n +1);
        }
    }
    private int rowCol(int row, int col) {
        if (row < 1 || row > n || col < 1 || col > n)
        {
            throw new IllegalArgumentException("The scope of is row or colw is wrong");
        }
        return (row-1)*n + col;
    }

    public void open(int row, int col)
    {
        if (!isOpen(row, col))
        {
            int rowcol = rowCol(row, col);
            arrAysite[(row-1)*n +col] = true;
            numOpenSites++;
            if (row == 1)
            {
                topBotWeightedQuickUnionUF.union(rowcol, virtualTop);
                topWeightedQuickUnionUF.union(rowcol, virtualTop);
            }
            if (row == n)
            {
                topBotWeightedQuickUnionUF.union(rowcol, virtualBot);
            }

            //上
            if (row > 1 && isOpen(row-1, col)) {
                topBotWeightedQuickUnionUF.union(rowcol, rowCol(row-1, col));
                topWeightedQuickUnionUF.union(rowcol, rowCol(row-1, col));
            }
            //下
            if (row < n && isOpen(row+1, col)) {
                topBotWeightedQuickUnionUF.union(rowcol, rowCol(row+1, col));
                topWeightedQuickUnionUF.union(rowcol, rowCol(row+1, col));
            }
            //左
            if (col > 1 && isOpen(row, col-1)) {
                topBotWeightedQuickUnionUF.union(rowcol, rowCol(row, col-1));
                topWeightedQuickUnionUF.union(rowcol, rowCol(row, col-1));
            }
            //右
            if (col < n && isOpen(row, col+1)) {
                topBotWeightedQuickUnionUF.union(rowcol, rowCol(row, col+1));
                topWeightedQuickUnionUF.union(rowcol, rowCol(row, col+1));
            }
        }

    }

    public boolean isOpen(int row, int col)
    {
        return arrAysite[rowCol(row, col)];
    }


    public boolean isFull(int row, int col)
    {
        return topWeightedQuickUnionUF.find(rowCol(row, col)) == topWeightedQuickUnionUF.find(virtualTop);
    }

    public  int numberOfOpenSites()
    {
        return numOpenSites;
    }

    public boolean percolates()
    {
        return topBotWeightedQuickUnionUF.find(virtualTop) == topBotWeightedQuickUnionUF.find(virtualBot);
    }

    public static void main(String[] args)
    {
        int nn = StdIn.readInt();
        Percolation myPercolation = new Percolation(nn);
        while (!StdIn.isEmpty()) {
            int row = StdIn.readInt();
            int col = StdIn.readInt();
            myPercolation.open(row, col);
            StdOut.println(myPercolation.isFull(row, col));
        }
        System.out.println(myPercolation.percolates());
        System.out.println(myPercolation.numberOfOpenSites());
    }
}
```

**PercolationStats.java**

```java
import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.StdOut;
import edu.princeton.cs.algs4.StdRandom;
import edu.princeton.cs.algs4.StdStats;

public class PercolationStats  {
    private static final double COFFIX =  1.96;
    private final double []arryp;
    private final int trails;

    public PercolationStats(int n, int trials)
    {
        Percolation testPercolation;
        if (n < 1 || trials < 1) {
            throw new IllegalArgumentException("The scope of is n or trials is wrong");
        }
        this.trails = trials;
        arryp = new double[trials];
        for (int i = 0; i < trials; i++) {
            testPercolation = new Percolation(n);
            while (!testPercolation.percolates()) {
                int row = StdRandom.uniform(1, n+1);
                int col = StdRandom.uniform(1, n+1);
                testPercolation.open(row, col);
            }
            int nunOS = testPercolation.numberOfOpenSites();
            arryp[i] = (double) nunOS/(n*n);
        }

    }

    public double mean()
    {
        return StdStats.mean(arryp);
    }
    public double stddev()
    {
        return StdStats.stddev(arryp);

    }
    public double confidenceLo()
    {

        return mean()-COFFIX*stddev()/Math.sqrt(trails);

    }
    public double confidenceHi()
    {

        return mean()+COFFIX*stddev()/Math.sqrt(trails);
    }


    public static void main(String[] args)
    {
        int n = StdIn.readInt(), trialNum = StdIn.readInt();
        PercolationStats ps = new PercolationStats(n, trialNum);
        StdOut.println("grid size :" + n+"*"+n);
        StdOut.println("trial times :" + trialNum);
        StdOut.println("mean of p :"+ ps.mean());
        StdOut.println("standard deviation :"+ps.stddev());
        StdOut.println("confidence interval low :"+ps.confidenceLo());
        StdOut.println("confidence interval high :"+ps.confidenceHi());
    }

}
```



