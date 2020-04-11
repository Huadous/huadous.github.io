---
title: "Data Structures and Algorithm Analysis in C"
date: 2020-04-11 14:38:00 +0800
categories: [Learning, Self-study]
tags: [Data Structures, Algorithm, C]
---
## Data Structures and Algorithm Analysis in C

### Chapter 1 Introduction

###### Recursion

well, in this chapter, it's kind of happy to review these knowledge and still find some parts not familier with. Particularly in recursion, my undergraduate treacher did't make a clear definition about it and only use examples to illustrate it. Thus, this is a good chance for me to understance this conception logically.

When writing recursive routines, it is crucial to keep in mind the four basic rules of recursion:
	
1. *Base cases*. You must always have some base cases, which can be solved without recursion.
2. *Making progress*. For the cases that are to be solved recursively, the recursive call must always be to a case that makes progress toward a base case.
3. *Design rule*. Assume that all the recursive calls work.
4. *Compound interest rule*. Never duplicate work by solving the same instance of a problem in separate recursive calls.