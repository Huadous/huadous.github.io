---
title: "[Algorithms P1] 1.5 Union-find"
date: 2020-07-05 12:19:00 +0800
categories: [Learning, Coursera, Algorithms(Princeton)]
tags: [Algorithms, Java]
---
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

![image-20200703145248251](https://huadous.com/assets/img/sample/image-20200703145248251.png)

A.Yes.

&emsp;

**Modeling the connections**

---

We assume "is connected to" is an equivalence relation:

* **Reflexive**: $p$ is connected to $p$.
* **Symmetric**: if $p$ is connected to $q$, then $q$ is connected to $p$.
* **Transitive**: if $p$ is connected to $q$ and $q$ is connected to $r$, then $p$ is connected to $r$.

**Connected components.** Maximal set of objects that are mutually connected.

![image-20200703145940341](https://huadous.com/assets/img/sample/image-20200703145940341.png)

&emsp;

**Implementing the operations**

---

**FInd query.** Check if two objects are in the same component.

**Union command.** Replace components containing two objects with their union.

![image-20200703150120177](https://huadous.com/assets/img/sample/image-20200703150120177.png)

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

![image-20200703152714014](https://huadous.com/assets/img/sample/image-20200703152714014.png)

**Find.** Check if $p$ and $q$ have the same id, i.e. id[6] = 0; id[1] =1, thus, 6 and 1 are not connected.

**Union.** To merge components containing $p$ and $q$, change all entries whose id equals id[p] to id[q]. **Problem: many values can change**

&emsp;

**Quick-find demo**

---

**Quick-find overview**

![image-20200703161547340](https://huadous.com/assets/img/sample/image-20200703161547340.png)

**Quick-find trace**

![image-20200703161448353](https://huadous.com/assets/img/sample/image-20200703161448353.png)

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

![image-20200703160843769](https://huadous.com/assets/img/sample/image-20200703160843769.png)

**Find.** Check if $p$ and $q$ have the same root.

**Union.** To merge components containing $p$ and $q$, set the id of $p$'s root to the id of $q$'s root.

&emsp;

**Quick-union demo**

---

![image-20200703161726907](https://huadous.com/assets/img/sample/image-20200703161726907.png)

**Quick-union trace**

![image-20200703161823608](https://huadous.com/assets/img/sample/image-20200703161823608.png)

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

![image-20200703165433362](https://huadous.com/assets/img/sample/image-20200703165433362.png)

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

![image-20200703175339554](https://huadous.com/assets/img/sample/image-20200703175339554.png)

&emsp;

**Weighted quick-union demo**

---

![image-20200703205326809](https://huadous.com/assets/img/sample/image-20200703205326809.png)

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

![image-20200703220521715](https://huadous.com/assets/img/sample/image-20200703220521715.png)

**Quick-union and weighted quick-union(100 sites, 88 union( ) operations)**

![image-20200703215926138](https://huadous.com/assets/img/sample/image-20200703215926138.png)

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



