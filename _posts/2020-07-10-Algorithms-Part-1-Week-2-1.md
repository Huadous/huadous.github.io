---
title: "<Algorithms Part 1 week 2> 1.3 Bags, Queues, and Stacks"
date: 2020-07-10 01:11:00 +0800
categories: [Learning, Self-study]
tags: [Algorithms, Java]
---
# 1.3 BAGS, QUEUES, AND STACKS

## 1.3.1 stacks

**Client, implementation, interface**

---

**Client:** program using operations defined in interface.

**Implementation:** actual code implementing operatioins.

**Interface:** description of data type, basic operations.

&emsp;

**Stack API**

---

**Warmup API.** Stack of strings data type.

![image-20200708225736267](https://huadous.com/assets/img/sample/image-20200708225736267.png)

**Warmup client.** Reverse sequence of strings from standard input.

&emsp;

**Stack test client**

---

Read strings from standard input.

* If string equals "-", pop string from stack and print.
* Otherwise, push string onto stack.

```java
public static void main(String[] args)
{
		StackOfString stack = new StackOfStrings();
		while (!StdIn.isEmpty())
		{
				String s = StdIn.readString();
				if (s.equals("-")) StdOut.print(stack.pop());
				else	stack.push(s);
		}
}
```

```shell
% more tobe.txt
to be or not to - be - - that - - - is

% java StackOfStrings < tobe.txt
to be not that or be
```

&emsp;

**Stack: linked-list representation**

---

Maintain pointer to first node in a linked list; insert/remove from front.

![image-20200708230536537](https://huadous.com/assets/img/sample/image-20200708230536537.png)

&emsp;

**Stack pop: linked-list implementation**

---

![image-20200708230708444](https://huadous.com/assets/img/sample/image-20200708230708444.png)

&emsp;

**Stack push: linked-list implementation**

---

![image-20200708230809066](https://huadous.com/assets/img/sample/image-20200708230809066.png)

&emsp;

**Stack: linked-list implementation in Java**

---

```java
public class LinkedStackOfStrings
{
     private Node first = null;
     
     private class Node							// private inner class
     {															// (access modifiers don't matter)
         String item;
         Node next;
     }

     public boolean isEmpty()
     {	 return first == null; }
     public void push(String item)
     {
         Node oldfirst = first;
         first = new Node();
         first.item = item;
         first.next = oldfirst;
     }
     public String pop()
     {
         String item = first.item;
         first = first.next;
         return item;
     }
}
```

&emsp;

**Stack: lined-list implementation performance**

---

**Propositioin.** Every operation takes constant time in the worst case.

**Proposition.** A stack with $N$ items uses $\sim40N$ bytes.

![image-20200708231535889](https://huadous.com/assets/img/sample/image-20200708231535889.png)

**Remark.** This accounts for the memory for the stack (but not the memory for strings themselves, which the client owns).

&emsp;

**Stack: array implementation**

---

**Array implementation of a stack.**

* Use array $s[~]$ to store $N$ items on stack.
* $push(~)$: add new item at $s[N]$.
* $pop(~)$: remove item from $s[N-1]$.

**Defect.** Stack overflows when $N$ exceeds capacity. [stay tuned]

&emsp;

**Stack: array implementation**

---

```java
public class FixedCapacityStackOfStrings
{
     private String[] s;
     private int N = 0;

     public FixedCapacityStackOfStrings(int capacity)		// a cheat(stay tuned)
     { s = new String[capacity]; } 

     public boolean isEmpty()
     { return N == 0; }

     public void push(String item)
     { s[N++] = item; }						// use to index into array; then increment N

     public String pop()
     { return s[--N]; }						// decrement N; then use to index into array
}
```

&emsp;

**Stack considerations**

---

**Overflow and underflow.**

* Underflow: throw exception if pop from an empty stack.
* Overflow: use resizing array for array implementation. [stay tuned]

**Null items.** We allow null items to be inserted.

**Loitering.** Holding a reference to an object when it is no longer needed.

``` java
public String pop()
{		return s[--N];	}			// loitering
```

```java
public String pop()
{
		String item = s[--N];
		s[N] = null;
		return item;
}// this version aviods "loitering": garbage collector can reclaim memory only if no outstanding references
```

&emsp;

## 1.3.2 resizing arrays

**Stack: resizing-array implementation**

---

**Problem.** Requiring client to provide capacity does not implementation API!

**Q.** How to grow and shrink array?

**First try.**

* $\mathtt{push[~]}$: increase size of array $\mathtt{s[~]}$ by 1.
* $\mathtt{pop[~]}$: decrease size of array $\mathtt{s[~]}$ by 1.

**Too expensive.**

* Need to copy all items to a new array.
* Inserting first $N$ items takes time proportional to $1+2+\dots+N\sim\frac{N^2}{2}$.(infeasible for large N)

**Challenge.** Ensure that array resizing happens infrequently.

&emsp;

**Q.** How to grow array?

**A.**If array is full, create a new array of **twice** ("repeated doubling") the size, and copy items.

```java
public ResizingArrayStackOfStrings()
{	s = new String[1]; } 
 		
public void push(String item)
{
 		if (N == s.length) resize(2 * s.length);
		s[N++] = item;
}
 		
private void resize(int capacity)
{
 		String[] copy = new String[capacity];
 		for (int i = 0; i < N; i++)
 		copy[i] = s[i];
 		s = copy;
}
```

**Consequence.** Inserting first $N$ items takes time proportional to $N$ (not $N^2$).

&emsp;

**Stack: amortized cost of adding to a stack**

---

**Cost of inserting first N items.** $N+(2+4+8+\dots+N)\sim 3N$($N$ for 1 array access per push; $(2+4+8+\dots+N)$ for k array accesses to double to size k (ignore cost to create new array)).

$$\displaystyle\sum_{i=1}^{N}2^i=2^{N+1}-2$$

$$(2+4+8+\dots+N)=2^1+2^2+2^3+\dots+2^{\log_2^N}=2^{\log_2^N+1}-2=2N-2$$

Thus, $N+(2+4+8+\dots+N)\sim 3N$

![image-20200709000154080](https://huadous.com/assets/img/sample/image-20200709000154080.png)

&emsp;

**Stack: resizing-array implementation**

---

**Q.** How to shrink array?

**First try.**

* $\mathtt{push()}$: double size of array $\mathtt{s[~]}$ when array is full.
* $\mathtt{pop()}$: halve size of array $\mathtt{s[~]}$ when array is **one-half full**. 

**Too expensive in worst case.**

* Consider push-pop-push-pop-... sequence when array is full.
* Each operation takes time proportional to $N$.

![image-20200709000733827](https://huadous.com/assets/img/sample/image-20200709000733827.png)

**Efficient solution.**

* $\mathtt{push()}$: double size of array $\mathtt{s[~]}$ when array is full.
* $\mathtt{pop()}$: halve size of array $\mathtt{s[~]}$ when array is **one-quarter full**.

```java
public String pop()
{
    String item = s[--N];
    s[N] = null;
    if (N > 0 && N == s.length/4) resize(s.length/2);
    return item;
}
```

**Invariant.** Array is between 25% and 100% full.

&emsp;

**Stack: resizing-array implementation trace**

---

![image-20200709001348252](https://huadous.com/assets/img/sample/image-20200709001348252.png)

&emsp;

**Stack resizing-array implementation: performance**

---

**Amortized analysis.** Average running time per operation over a worst-case sequence of operations.

**Proposition.** Starting from an empty stack, any sequence of $M$ push and pop operations takes time proportional to $M$.

![image-20200709001634910](https://huadous.com/assets/img/sample/image-20200709001634910.png)

&emsp;

**Stack resizing-array implementation: memory usage**

---

**Proposition.** Uses between $\sim8N$ and $\sim32N$ bytes to represent a stack with $N$ items.

* $\sim8N$ when full.
* $\sim32N$ when one-quarter full.

```java
public class ResizingArrayStackOfStrings		// 8 bytes(reference to array)
{																						// 24 bytes(array overhead)
    private String[] s;											// 8 bytes × array size
    private int N = 0;											// 4 bytes (int)
    …																				// 4 bytes (padding)
}
```

**Remark.** This accounts for the memory for the stack (but not the memory for strings themselves, which the client owns.)

&emsp;

**Stack implementations: resizing array vs. linked list**

---

**Tradeoffs.** Can implement a stack with either resizing array or linked list;

client can use interchangeably. which one is better?

**Linked-list implementation.**

* Every operation takes constant constant time in the **worst case**.
* Uses extra time and space to deal with the links.

**Resizing-array implementation.**

* Every operation takes constant **amortized** time.
* Less wasted space.

&emsp;

## 1.3.3 queues

**Queue API**

---

![image-20200709002740105](https://huadous.com/assets/img/sample/image-20200709002740105.png)

&emsp;

**Queue: linked-list representation**

---

Maintain pointer to first and last nodes in a linked list;

insert/remove from opposite ends.

![image-20200709002921609](https://huadous.com/assets/img/sample/image-20200709002921609.png)

&emsp;

**Queue dequeue: linked-list implementation**

---

![image-20200709003022517](https://huadous.com/assets/img/sample/image-20200709003022517.png)

**Remark.** Identical code to linked-list stack $\mathtt{pop()}$.

&emsp;

**Queue enqueue: linked-list implementation**

---

![image-20200709003205625](https://huadous.com/assets/img/sample/image-20200709003205625.png)

&emsp;

**Queue: linked-list implementation in Java**

---

```java
public class LinkedQueueOfStrings
{
     private Node first, last;

     private class Node
     { /* same as in StackOfStrings */ }

     public boolean isEmpty()
     { return first == null; } 

     public void enqueue(String item)
     {
         Node oldlast = last;
         last = new Node();
         last.item = item;
         last.next = null;
         if (isEmpty()) first = last;				// special cases for empty queue
         else oldlast.next = last;
     }

     public String dequeue()
     {
         String item = first.item;
         first = first.next;
         if (isEmpty()) last = null;				// special cases for empty queue
         return item;
     }
}
```

&emsp;

**Queue: resizing array implementation**

---

**Array implementation of a queue.**

* Use array $\mathtt{q[~]}$ to store items in queue.
* $\mathtt{enqueue()}$: add new item at $\mathtt{q[tail]}$.
* $\mathtt{dequeue()}$: remove item from $\mathtt{q[head]}$.
* Update head and tail modulo the capacity.
* Add resizing array.(HOW)

 &emsp;

## 1.3.4 generics

**Parameterized stack**

---

**We implemented:** StackOfStrings.

**We also want:** StackOfUrls, StackOfInts, StackOfVans, ...

&emsp;

**Attempt 1.** Implement a separate stack class for each type.(most reasonable approach until Java 1.5.)

* Rewriting code is tedious and error-prone.
* Maintaining cut-and-pasted code is tedious and error-prone.

**Attempt 2.** Implement a stack with items of type Object.

* Casting is required in client.
* Casting is error-prone: run-time error if types mismatch.

```java
StackOfObjects s = new StackOfObjects();
Apple a = new Apple();
Orange b = new Orange();
s.push(a);
s.push(b);
a = (Apple) (s.pop());				// run-time error
```

**Attempt 3.** Java generics.

* Avoid casting in client.
* Discover type mismatch errors at complie-time instead of run-time.

```java
Stack<Apple> s = new Stack<Apple>();		// <Apple> is type parameter
Apple a = new Apple();
Orange b = new Orange();
s.push(a);
s.push(b);															// compile-time error
a = s.pop();
```

**Guiding principles.** Welcome compile-time errors; avoid run-time errors.

&emsp;

**Generic stack: linked-list implementation**

---

![image-20200710000554299](https://huadous.com/assets/img/sample/image-20200710000554299.png)

&emsp;

**Generic stack: array implementation**

---

![image-20200710000630908](https://huadous.com/assets/img/sample/image-20200710000630908.png)

![image-20200710000641810](https://huadous.com/assets/img/sample/image-20200710000641810.png)

&emsp;

**Unchecked cast**

---

```shell
% javac FixedCapacityStack.java
Note: FixedCapacityStack.java uses unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.

% javac -Xlint:unchecked FixedCapacityStack.java
FixedCapacityStack.java:26: warning: [unchecked] unchecked cast
found : java.lang.Object[]
required: Item[]
 			a = (Item[]) new Object[capacity];
 										^
1 warning
```

&emsp;

**Generic data types: autoboxing**

---

**Q.** what to do about primitive types?

**Wrapper type.**

* Each primitive type has a **wrapper** object type.
* Ex: $\mathtt{Integer}$ is wrapper type for $\mathtt{int}$.

**Autoboxing.** Automatic cast between a primitive type and its wrapper.

```java
Stack<Integer> s = new Stack<Integer>();
s.push(17); 											// s.push(Integer.valueOf(17));
int a = s.pop(); 									// int a = s.pop().intValue();
```

**Bottom line.** Client code can use generic stack for **any** type of data.

&emsp;

## 1.3.5 iterators

**Iteration**

---

**Design challenge.** Support iteration over stack items by client, without revealing the internal representation of the stack.

![image-20200710001521223](https://huadous.com/assets/img/sample/image-20200710001521223.png)

**Java solution.** Make stack implement the $\mathtt{java.lang.Iterable}$ interface.

&emsp;

**Iterators**

---

**Q.** What is an **Iterable**?

```java
// Iterable interface
public interface Iterable<Item>
{
		Iterator<Item> iterator();
}
```

**A.** Has a method that returns an **Iterator**.

&emsp;

**Q.** What is an **Iterator**?

```java
// Iterator interface
public interface Iterator<Item>
{
    boolean hasNext();
    Item next();
    void remove();
}
```

**A.** Has methods **hasNext( )** and **next( )**.

&emsp;

**Q.** Why make data structures **Iterable**?

```java
// "foreach" statement (shorthand)
for (String s : stack)
		StdOut.println(s);
```

```java
// equivalent code (longhand)
Iterator<String> i = stack.iterator(); 
while (i.hasNext())
{
    String s = i.next();
    StdOut.println(s);
}
```

**A.** Java supports elegant client code.

&emsp;

**Stack iterator: linked-list implementation**

---

![image-20200710002545529](https://huadous.com/assets/img/sample/image-20200710002545529.png)

&emsp;

**Stack iterator: array implementatioin**

---

![image-20200710002620891](https://huadous.com/assets/img/sample/image-20200710002620891.png)

&emsp;

**Bag API**

---

**Main application.** Adding items to collection and iterating (when order doesn't matter).

![image-20200710002804821](https://huadous.com/assets/img/sample/image-20200710002804821.png)

**Implementation.** Stack (without pop) or queue (without dequeue).

&emsp;

## 1.3.6 applications

**Java collections library**

---

**List interface.** $\mathtt{java.util.List}$ is API for an sequence of items.

![image-20200710003055621](https://huadous.com/assets/img/sample/image-20200710003055621.png)

**Implementations.** $\mathtt{java.util.ArrayList}$ uses resizing array; $\mathtt{java.util.LinkedLists}$ uses linked list. (caveats: only some operations are efficient)

&emsp;

**java.util.Stack.**

* Supports $\mathtt{push()},pop()$ and so on and iteration.
* Extends $\mathtt{java.util.Vector}$, which implements $\mathtt{java.util.List}$ interface from previous slide, including, $\mathtt{get()}$ and $\mathtt{remove()}$.
* Bloated and poorly-designed API(why?).

**java.util.Queue.** An interface, not an implementation of a queue.

**Best practices.** Use our implementations of Stack, Queue, and Bag.

&emsp;

**War story (from Assignment 1)**

---

Generate random open sits in an $N-by-N$ percolation system.

![image-20200710003957898](https://huadous.com/assets/img/sample/image-20200710003957898.png)

**Lesson.** Don't use a library until you understand its API!

**This course.** Can't use a library until we've implemented it in class.

&emsp;

**Function calls**

---

**How a compiler implements a function.**

* Function call: **push** local environment and return address.
* Return: **pop** return address and local environment.

**Recursive function.** Function that calls itself.

**Note.** Can always use an explicit stack to remove recursion.

![image-20200710004400330](https://huadous.com/assets/img/sample/image-20200710004400330.png)

&emsp;

**Arithmetic expression evaluation**

---

**Goal.** Evaluate infix expressions.

$(1+((2+3)*(4*5)))$

**Two-stack algorithm.**[E. W. Dijkstra]

* Value: push onto the value stack.
* Operator: push onto the operator stack.
* Left parenthesis: ignore.
* Right parenthesis: pop operator and two values; push the result of applying that operator to those values onto the operand stack.

**Context.** An interpreter!

![image-20200710004801692](https://huadous.com/assets/img/sample/image-20200710004801692.png)

&emsp;

```java
public class Evaluate
{
    public static void main(String[] args)
    { 
        Stack<String> ops = new Stack<String>();
        Stack<Double> vals = new Stack<Double>();
        while (!StdIn.isEmpty()) {
            String s = StdIn.readString();
            if (s.equals("(")) ;
            else if (s.equals("+")) ops.push(s);
            else if (s.equals("*")) ops.push(s);
            else if (s.equals(")"))
            {
                String op = ops.pop();
                if (op.equals("+")) vals.push(vals.pop() + vals.pop());
                else if (op.equals("*")) vals.push(vals.pop() * vals.pop());
            }
            else vals.push(Double.parseDouble(s));
        }
        StdOut.println(vals.pop());
    }
}
```

```shell
% java Evaluate
( 1 + ( ( 2 + 3 ) * ( 4 * 5 ) ) )
101.0
```

&emsp;

**Correctness**

---

**Q.** Why correct?

**A.** when algorithm encounters an operator surrounded by two values within parentheses, it leaves the result on the value stack.

$$(1+((2+3)*(4*5)))$$

as if the original input were:

$$(1+(5*(4*5)))$$

Repeating the argument:

$$(1+(5*20))$$

$$(1+100)$$

$$101$$

**Extensions.** More ops, precedence order, associativity.

&emsp;

**Stack-based programming languages**

---

**Observation 1.** Dijkstra's two-stack algorithm computes the same value if the operator occurs **after** the two values.

$(1~~((2~~3+)(4~~5*)*)+)$

**Observation 2.** All of the parentheses are redundant!

$1~~2~~3+4~~5**+$

**Bottom line.** Postfix or "reverse Polish" notation.

**Applications.** Postscript, Forth, calculators, Java virtual machine, ...

&emsp;

## 1.3.7 Interview Questions

**Queue with two stacks**

---

Implement a queue with two stacks so that each queue operations takes a constant amortized number of stack operations.

> *Hint*: If you push elements onto a stack and then pop them all, they appear in reverse order. If you repeat this process, they're now back in order.

**Solution:** The two stacks can be deployed like this: the 1st stack can be used to store the input one by one, and its aim is to fulfill the requirements of the dequeue method. 1st stack always contains the Last In data. The 2nd stack is for the enqueue function, and it pushes data when there is no data containing in it from 1st stack. The sort of it just turn out to be the first to the last.

&emsp;

**Stack with max**

---

Create a data structure that efficiently supports the stack operations (push and pop) and also a return-the-maximum operation. Assume the elements are real numbers so that you can compare them.

> *Hint:* Use two stacks, one to store all of the items and a second stack to store the maximums.

**Solution:** we can add another stack to store the index of the current max item when it changes.

&emsp;

**Java generics**

---

Explain why Java prohibits generic array creation.

> *Hint:* to start, you need to understand that Java arrays are *covariant* but Java generics are not: that is, $\mathtt{String[]}$is a subtype of $\mathtt{Object[]}$, but $\mathtt{Stack<String>}$ is not a subtype of $\mathtt{Stack<Object>}$.

**Solution:** It's because Java's arrays (unlike generics) contain, at runtime, information about its component type. So you must know the component type when you create the array. Since you don't know what T is at runtime, you can't create the array.

&emsp;

## 1.3.8 Programming Assignment: Deques and Randomized Queues

Assignment requirements can be reach at Princeton's web page: [QUEUES](https://coursera.cs.princeton.edu/algs4/assignments/queues/specification.php).

There are two three classes as following.

**Deque.java**

```java
import edu.princeton.cs.algs4.StdOut;

import java.util.Iterator;
import java.util.NoSuchElementException;


public class Deque<Item> implements Iterable<Item> {
    private Node first;
    private Node last;
    private int account;


    private class Node {
        Item item;
        Node pre;
        Node next;
    }

    // construct an empty deque
    public Deque() {
        first = null;
        last = null;
        account = 0;
    }

    // is the deque empty?
    public boolean isEmpty() {
        return account == 0;
    }

    // return the number of items on the deque
    public int size() {
        return account;
    }

    // add the item to the front
    public void addFirst(Item item) {
        if (item == null) {
            throw new IllegalArgumentException("Input is null.");
        }
        Node addfirst = new Node();
        addfirst.item = item;
        addfirst.pre = null;
        addfirst.next = first;
        if (isEmpty()) {
            last = addfirst;
            first = addfirst;
        } else {
            first.pre = addfirst;
            first = addfirst;
        }
        account++;
    }

    // add the item to the back
    public void addLast(Item item) {
        if (item == null) {
            throw new IllegalArgumentException("Input is null.");
        }
        Node addlast = new Node();
        addlast.item = item;
        addlast.pre = last;
        addlast.next = null;
        if (isEmpty()) {
            last = addlast;
            first = addlast;
        } else {
            last.next = addlast;
            last = addlast;
        }
        account++;
    }

    // remove and return the item from the front
    public Item removeFirst() {
        if (isEmpty()) {
            throw new NoSuchElementException("The queue is empty!");
        }
        Item item = first.item;
        first = first.next;
        account--;
        if (!isEmpty()) first.pre = null;
        else last = null;
        return item;
    }

    // remove and return the item from the back
    public Item removeLast() {
        if (isEmpty()) {
            throw new NoSuchElementException("The queue is empty!");
        }
        Item item = last.item;
        last = last.pre;
        account--;
        if (!isEmpty()) last.next = null;
        else first = null;
        return item;
    }

    // return an iterator over items in order from front to back
    public Iterator<Item> iterator() {
        return new ListIterator();
    }

    private class ListIterator implements Iterator<Item> {
        private Node current = first;

        public boolean hasNext() {
            return current != null;
        }

        public void remove() {
            throw new UnsupportedOperationException("Unsupported operation!");
        }

        public Item next() {
            if (!hasNext())
                throw new NoSuchElementException("The deque is empty!");
            Item item = current.item;
            current = current.next;
            return item;
        }
    }


    // unit testing (required)
    public static void main(String[] args) {
        Deque<Integer> deque = new Deque<Integer>();
        StdOut.println(deque.isEmpty());
        deque.addFirst(2);
        for (Integer i : deque) {
            StdOut.println(i);
        }
        StdOut.println(deque.isEmpty());
        deque.addFirst(3);
        deque.addFirst(4);
        for (Integer i : deque) {
            StdOut.println(i);
        }
        StdOut.println(deque.isEmpty());
        deque.addFirst(6);
        deque.addFirst(7);
        deque.addFirst(8);
        for (Integer i : deque) {
            StdOut.println(i);
        }
        StdOut.println(deque.isEmpty());
        deque.removeLast();
        for (Integer i : deque) {
            StdOut.println(i);
        }
        StdOut.println(deque.isEmpty());
        deque.addFirst(9);
        for (Integer i : deque) {
            StdOut.println(i);
        }
        StdOut.println(deque.isEmpty());
    }
}
```

**RandomizedQueue.java**

```java
import edu.princeton.cs.algs4.StdOut;
import edu.princeton.cs.algs4.StdRandom;

import java.util.Iterator;
import java.util.NoSuchElementException;

public class RandomizedQueue<Item> implements Iterable<Item> {

    private Item[] randomizedQueue;
    private int n;

    // construct an empty randomized queue
    public RandomizedQueue() {
        randomizedQueue = (Item[]) new Object[2];
        n = 0;
    }

    // is the randomized queue empty?
    public boolean isEmpty() {
        return n == 0;
    }

    // return the number of items on the randomized queue
    public int size() {
        return n;
    }

    private void resize(int capacity) {
        Item[] temp = (Item[]) new Object[capacity];
        for (int i = 0; i < n; i++) {
            temp[i] = randomizedQueue[i];
        }
        randomizedQueue = temp;
    }

    // add the item
    public void enqueue(Item item) {
        if (item == null)
            throw new IllegalArgumentException();
        if (n == randomizedQueue.length)
            resize(2 * randomizedQueue.length);
        randomizedQueue[n++] = item;
    }

    // remove and return a random item
    public Item dequeue() {
        if (isEmpty())
            throw new NoSuchElementException();
        int num = StdRandom.uniform(n);
        Item item = randomizedQueue[num];
        if (num != n - 1)
            randomizedQueue[num] = randomizedQueue[n - 1];
        randomizedQueue[n - 1] = null;
        n--;
        if (n > 0 && n == randomizedQueue.length / 4)
            resize(randomizedQueue.length / 2);
        return item;
    }

    // return a random item (but do not remove it)
    public Item sample() {
        if (isEmpty())
            throw new NoSuchElementException();
        return randomizedQueue[StdRandom.uniform(n)];
    }

    // return an independent iterator over items in random order
    public Iterator<Item> iterator() {
        return new ArrayIterator();
    }

    private class ArrayIterator implements Iterator<Item> {
        private int index = 0;
        private final Item[] items;

        public ArrayIterator() {
            items = (Item[]) new Object[n];
            for (int i = 0; i < n; i++) {
                items[i] = randomizedQueue[i];
            }
            StdRandom.shuffle(items);

        }

        public boolean hasNext() {
            return index < n;
        }

        public void remove() {
            throw new UnsupportedOperationException("Unsupported operation!");
        }

        public Item next() {
            if (!hasNext())
                throw new NoSuchElementException("The RandomizedQueue is empty!");
            return items[index++];
        }
    }

    // unit testing (required)
    public static void main(String[] args) {
        RandomizedQueue<String> randomizedQueue = new RandomizedQueue<String>();
        StdOut.println("size:" + randomizedQueue.size());
        randomizedQueue.enqueue("Hello");
        StdOut.println("size:" + randomizedQueue.size());
        randomizedQueue.enqueue("World");
        StdOut.println("size:" + randomizedQueue.size());
        randomizedQueue.enqueue("!");
        StdOut.println("size:" + randomizedQueue.size());
        StdOut.println(randomizedQueue.sample());
        randomizedQueue.dequeue();
        StdOut.println("size:" + randomizedQueue.size());
        Iterator<String> it = randomizedQueue.iterator();
        while (it.hasNext()) {
            String elt = it.next();
            System.out.print(elt + " ");
        }
    }
}
```

**Permutation.java**

```java
import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.StdOut;


public class Permutation {
    public static void main(String[] args) {
        RandomizedQueue<String> client = new RandomizedQueue<>();
        int num = Integer.parseInt(args[0]);


        while (!StdIn.isEmpty()) {
            client.enqueue(StdIn.readString());
        }

        for (String s : client) {
            if (num ==0) break;
            StdOut.println(s);
            num--;
        }
    }
}
```

&emsp;