---
title: "Data Structures and Algorithm Analysis in C"
date: 2020-04-11 14:38:00 +0800
categories: [Learning, Self-study]
tags: [Data Structures, Algorithm, C]
---
# Chapter 1 Introduction
***
## 1.1 Mathematics Review

The easist  formulas to remember are

$$\sum_{i=0}^{N}2^i=2^{N+1}-1$$

and the companion,

$$\sum_{i=0}^{N}A^{i}=\frac{A^{N+1}-1}{A-1}$$

In the latter formula, if $0<A<1$, then

$$\sum_{i=0}^{N}A^i\leq\frac{1}{1-A}$$

and as $N$ tends to $\infty$, the sum approaches $\frac{1}{1-A}$. These are the "geometric series" formulas.

 

$$2=1+\frac{1}{2}+\frac{1}{2^2}+\frac{1}{2^3}+\frac{1}{2^4}+\frac{1}{2^5}+\cdots$$

The details and explaination about it show in the book page 4. Another type of common series in analysis is the arithmetic series, Any such series can be evaluated from basic formula.

$$\sum_{i=1}^{N}i=\frac{N(N+1)}{2}\approx\frac{N^2}{2}$$

The next two formulas pop up now and then but are fairly uncommon.

$$\sum_{i=1}^{N}i^2=\frac{N(N+1)(N+2)}{6}\approx\frac{N^3}{3}$$

$$\sum_{i=1}^{N}\approx\frac{N^{K+1}}{|k+1|}\qquad k\neq-1$$

There two formulas are just general algebraic manipulations.

$$\sum_{i=1}^{N}f(N)=Nf(N)$$

$$\sum_{i=n_o}^{N}f(i)=\sum_{i=1}^{N}f{i}-\sum_{i=1}^{n_0-1}f(i)$$ 

## 1.2 Recursion

When writing recursive routines, it is crucial to keep in mind the four basic rules of recursion:    

1. **Base cases**. You must always have some base cases, which can be solved without recursion.

2. **Making progress**. For the cases that are to be solved recursively, the recursive call must always be to a case that makes progress toward a base case.

3. **Design rule**. Assume that all the recursive calls work.

4. **Compound interest rule**. Never duplicate work by solving the same instance of a problem in separate recursive calls.