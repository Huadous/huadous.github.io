---
title: Boyer-Moore algorithm(string match)
date: 2020-08-22 01:23:00 +0800
categories: [Learning, leetcode]
tags: [GitHub, String, Algorithm]
seo:
  date_modified: 2020-08-22 01:33:56 +0800
---
# Boyer-Moore algorithm

## Main features

---

* performs the comparisons from right to left;
* preprocessing phase in $O(m+\sigma)$ time and space complexity;
* searching phase in $O(mn)$ time complexity;
* $3n$ text character comparisons in the worst case when searching for a non periodic pattern;
* $O(n/m)$best performance.

## Description

---

The Boyer-Moore algorithm is considered as the most efficient string-matching algorithm in usual applications. A simplified version of it or the entire algorithm is often implemented in text editors for the «search» and «substitute» commands.

The algorithm scans the characters of the pattern from right to left beginning with the rightmost one. In case of a mismatch (or a complete match of the whole pattern) it uses two precomputed functions to shift the window to the right. These two shift functions are called the ***good-suffix shift*** (also called matching shift and the ***bad-character shift*** (also called the occurrence shift).

Assume that a mismatch occurs between the character $\mathtt{x[i]=a}$ of the pattern and the character $\mathtt{y[i+j]=b}$ of the text during an attempt at position $\mathtt{j}$.
Then, $\mathtt{x[i+1,\dots,m-1]=y[j+i+1,\dots,j+m-1]=u}$ and $\mathtt{x[i]\neq y[j+i]}$. The good-suffix shift consists in aligning the segment $\mathtt{y[j+i+1,\dots,j+m-1]=x[i+1,\dots,m-1]}$ with its rightmost occurrence in $\mathtt{x}$ that is preceded by a character different from $\mathtt{x[i]}$ (*see figure 13.1*).

![bmgs1](http://www-igm.univ-mlv.fr/~lecroq/string/images/bmgs1.gif)

<center>Figure 13.1. The good-suffix shift, u re-occurs preceded by a character c different from a.</center>

If there exists no such segment, the shift consists in aligning the longest suffix $\mathtt{v}$ of $\mathtt{y[j+i+1,\dots,j+m-1]}$ with a matching prefix of $\mathtt{x}$ (*see figure 13.2*).

![bmgs2](http://www-igm.univ-mlv.fr/~lecroq/string/images/bmgs2.gif)

<center>Figure 13.2. The good-suffix shift, only a suffix of u re-occurs in x.</center>

The bad-character shift consists in aligning the text character $\mathtt{y[j+i]}$ with its rightmost occurrence in $\mathtt{x[0,\dots,m-2]}$. (*see figure 13.3*)

![bmbc1](http://www-igm.univ-mlv.fr/~lecroq/string/images/bmbc1.gif)

<center>Figure 13.3. The bad-character shift, a occurs in x.</center>

If $\mathtt{y[j+i]}$ does not occur in the pattern $\mathtt{x}$, no occurrence of $\mathtt{x}$ in $\mathtt{y}$ can include $\mathtt{y[j+i]}$, and the left end of the window is aligned with the character immediately after $\mathtt{y[j+i]}$, namely $\mathtt{y[j+i+1]}$ (*see figure 13.4*).

![bmbc2](http://www-igm.univ-mlv.fr/~lecroq/string/images/bmbc2.gif)

<center>Figure 13.4. The bad-character shift, b does not occur in x.</center>

Note that the bad-character shift can be negative, thus for shifting the window, the Boyer-Moore algorithm applies the maximum between the the good-suffix shift and bad-character shift. More formally the two shift functions are defined as follows.

The good-suffix shift function is stored in a table *bmGs* of size *m*+1.

- Let us define two conditions:

	![img](http://www-igm.univ-mlv.fr/~lecroq/string/images/hand.gif) $Cs(i, s)$: for each $k$ such that $i < k < m$, $s \geq k$ or $x[k-s]=x[k]$ and

	![img](http://www-igm.univ-mlv.fr/~lecroq/string/images/hand.gif) $Co(i, s)$: if $s <i$ then $x[i-s] \neq x[i]$

Then, for $0 \leq i < m: bmGs[i+1]=min\{s>0 : Cs(i, s)~and~Co(i, s)~hold\}$
and we define *bmGs*[0] as the length of the period of $x$. The computation of the table *bmGs* use a table *suff* defined as follows: for $1 \leq i < m, suff[i]=max{k : x[i-k+1,\dots, i]=x[m-k,\dots,m-1]}$

The bad-character shift function is stored in a table *bmBc* of size $\sigma$. For $c$ in $\sum: bmBc[c] = min\{i : 1 \leq i <m-1~and~x[m-1-i]=c\}$ if $c$ occurs in $x$, $m$ otherwise.

Tables *bmBc* and *bmGs* can be precomputed in time $O(m+\sigma)$ before the searching phase and require an extra-space in $O(m+\sigma)$. The searching phase time complexity is quadratic but at most $3n$ text character comparisons are performed when searching for a non periodic pattern. On large alphabets (relatively to the length of the pattern) the algorithm is extremely fast. When searching for $a^{m-1}b$ in $b^n$ the algorithm makes only $O(n/m)$ comparisons, which is the absolute minimum for any string-matching algorithm in the model where the pattern only is preprocessed.

## The C code

---

```c
void preBmBc(char *x, int m, int bmBc[]) {
   int i;
 
   for (i = 0; i < ASIZE; ++i)
      bmBc[i] = m;
   for (i = 0; i < m - 1; ++i)
      bmBc[x[i]] = m - i - 1;
}
 
 
void suffixes(char *x, int m, int *suff) {
   int f, g, i;
 
   suff[m - 1] = m;
   g = m - 1;
   for (i = m - 2; i >= 0; --i) {
      if (i > g && suff[i + m - 1 - f] < i - g)
         suff[i] = suff[i + m - 1 - f];
      else {
         if (i < g)
            g = i;
         f = i;
         while (g >= 0 && x[g] == x[g + m - 1 - f])
            --g;
         suff[i] = f - g;
      }
   }
}
 
void preBmGs(char *x, int m, int bmGs[]) {
   int i, j, suff[XSIZE];
 
   suffixes(x, m, suff);
 
   for (i = 0; i < m; ++i)
      bmGs[i] = m;
   j = 0;
   for (i = m - 1; i >= 0; --i)
      if (suff[i] == i + 1)
         for (; j < m - 1 - i; ++j)
            if (bmGs[j] == m)
               bmGs[j] = m - 1 - i;
   for (i = 0; i <= m - 2; ++i)
      bmGs[m - 1 - suff[i]] = m - 1 - i;
}
 
 
void BM(char *x, int m, char *y, int n) {
   int i, j, bmGs[XSIZE], bmBc[ASIZE];
 
   /* Preprocessing */
   preBmGs(x, m, bmGs);
   preBmBc(x, m, bmBc);
 
   /* Searching */
   j = 0;
   while (j <= n - m) {
      for (i = m - 1; i >= 0 && x[i] == y[i + j]; --i);
      if (i < 0) {
         OUTPUT(j);
         j += bmGs[0];
      }
      else
         j += MAX(bmGs[i], bmBc[y[i + j]] - m + 1 + i);
   }
}
```

## The C++  code

---

```c++
//coming soon
```

## The example

Preprocessing phase

![bmtab1](http://www-igm.univ-mlv.fr/~lecroq/string/images/bmtab1.png)

<center>*bmBc* and *bmGs* tables used by Boyer-Moore algorithm</center>

Searching phase

| G    | C    | A    | T    | C    | G    | C    | A    | G    | A    | G    | A    | G    | T    | A    | T    | A    | C    | A    | G    | T    | A    | C    | G    |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|      | 1    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
| G    | C    | A    | G    | A    | G    | A    | G    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |

Shift by: 1 (*bmGs*[7]=*bmBc*[A]-8+8)

| G    | C    | A    | T    | C    | G    | C    | A    | G    | A    | G    | A    | G    | T    | A    | T    | A    | C    | A    | G    | T    | A    | C    | G    |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|      | 3    | 2    | 1    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|      | G    | C    | A    | G    | A    | G    | A    | G    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |

Shift by: 4 (*bmGs*[5]=*bmBc*[C]-8+6

| G    | C    | A    | T    | C    | G    | C    | A    | G    | A    | G    | A    | G    | T    | A    | T    | A    | C    | A    | G    | T    | A    | C    | G    |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|      | 8    | 7    | 6    | 5    | 4    | 3    | 2    | 1    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|      | G    | C    | A    | G    | A    | G    | A    | G    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |

Shift by: 7 (*bmGs*[0])

| G    | C    | A    | T    | C    | G    | C    | A    | G    | A    | G    | A    | G    | T    | A    | T    | A    | C    | A    | G    | T    | A    | C    | G    |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|      | 3    | 2    | 1    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|      | G    | C    | A    | G    | A    | G    | A    | G    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |

Shift by: 4 (*bmGs*[5]=*bmBc*[C]-8+6)

| G    | C    | A    | T    | C    | G    | C    | A    | G    | A    | G    | A    | G    | T    | A    | T    | A    | C    | A    | G    | T    | A    | C    | G    |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|      | 2    | 1    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
|      | G    | C    | A    | G    | A    | G    | A    | G    |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |

Shift by: 7 (*bmGs*[6])

The Boyer-Moore algorithm performs 17 character comparisons on the example.

