---
title: (ADSWP)[Introduction to Data Science in Python] week 2 Basic Data Processing
  with Pandas
date: 2020-07-14 02:30:00 +0800
categories: [Learning, Coursera]
tags: [Data Science, Python]
seo:
  date_modified: 2020-07-14 13:39:50 +0800
---

---

_You are currently looking at **version 1.0** of this notebook. To download notebooks and datafiles, as well as get help on Jupyter notebooks in the Coursera platform, visit the [Jupyter Notebook FAQ](https://www.coursera.org/learn/python-data-analysis/resources/0dhYG) course resource._

---

# The Series Data Structure


```python
import pandas as pd
pd.Series?
```


```python
animals = ['Tiger', 'Bear', 'Moose']
pd.Series(animals)
```




    0    Tiger
    1     Bear
    2    Moose
    dtype: object




```python
numbers = [1, 2, 3]
pd.Series(numbers)
```




    0    1
    1    2
    2    3
    dtype: int64




```python
animals = ['Tiger', 'Bear', None]
pd.Series(animals)
```




    0    Tiger
    1     Bear
    2     None
    dtype: object




```python
numbers = [1, 2, None]
pd.Series(numbers)
```




    0    1.0
    1    2.0
    2    NaN
    dtype: float64




```python
import numpy as np
np.nan == None
```




    False




```python
np.nan == np.nan
```




    False




```python
np.isnan(np.nan)
```




    True




```python
sports = {'Archery': 'Bhutan',
          'Golf': 'Scotland',
          'Sumo': 'Japan',
          'Taekwondo': 'South Korea'}
s = pd.Series(sports)
s
```




    Archery           Bhutan
    Golf            Scotland
    Sumo               Japan
    Taekwondo    South Korea
    dtype: object




```python
s.index
```




    Index(['Archery', 'Golf', 'Sumo', 'Taekwondo'], dtype='object')




```python
s = pd.Series(['Tiger', 'Bear', 'Moose'], index=['India', 'America', 'Canada'])
s
```




    India      Tiger
    America     Bear
    Canada     Moose
    dtype: object




```python
sports = {'Archery': 'Bhutan',
          'Golf': 'Scotland',
          'Sumo': 'Japan',
          'Taekwondo': 'South Korea'}
s = pd.Series(sports, index=['Golf', 'Sumo', 'Hockey'])
s
```




    Golf      Scotland
    Sumo         Japan
    Hockey         NaN
    dtype: object



# Querying a Series


```python
sports = {'Archery': 'Bhutan',
          'Golf': 'Scotland',
          'Sumo': 'Japan',
          'Taekwondo': 'South Korea'}
s = pd.Series(sports)
s
```




    Archery           Bhutan
    Golf            Scotland
    Sumo               Japan
    Taekwondo    South Korea
    dtype: object




```python
s.iloc[3]
```




    'South Korea'




```python
s.loc['Golf']
```




    'Scotland'




```python
s[3]
```




    'South Korea'




```python
s['Golf']
```




    'Scotland'




```python
sports = {99: 'Bhutan',
          100: 'Scotland',
          101: 'Japan',
          102: 'South Korea'}
s = pd.Series(sports)
```


```python
s[0] #This won't call s.iloc[0] as one might expect, it generates an error instead
```


    ---------------------------------------------------------------------------

    KeyError                                  Traceback (most recent call last)

    <ipython-input-19-a5f43d492595> in <module>()
    ----> 1 s[0] #This won't call s.iloc[0] as one might expect, it generates an error instead
    

    /opt/conda/lib/python3.6/site-packages/pandas/core/series.py in __getitem__(self, key)
        601         key = com._apply_if_callable(key, self)
        602         try:
    --> 603             result = self.index.get_value(self, key)
        604 
        605             if not is_scalar(result):


    /opt/conda/lib/python3.6/site-packages/pandas/indexes/base.py in get_value(self, series, key)
       2167         try:
       2168             return self._engine.get_value(s, k,
    -> 2169                                           tz=getattr(series.dtype, 'tz', None))
       2170         except KeyError as e1:
       2171             if len(self) > 0 and self.inferred_type in ['integer', 'boolean']:


    pandas/index.pyx in pandas.index.IndexEngine.get_value (pandas/index.c:3557)()


    pandas/index.pyx in pandas.index.IndexEngine.get_value (pandas/index.c:3240)()


    pandas/index.pyx in pandas.index.IndexEngine.get_loc (pandas/index.c:4279)()


    pandas/src/hashtable_class_helper.pxi in pandas.hashtable.Int64HashTable.get_item (pandas/hashtable.c:8564)()


    pandas/src/hashtable_class_helper.pxi in pandas.hashtable.Int64HashTable.get_item (pandas/hashtable.c:8508)()


    KeyError: 0



```python
s = pd.Series([100.00, 120.00, 101.00, 3.00])
s
```




    0    100.0
    1    120.0
    2    101.0
    3      3.0
    dtype: float64




```python
total = 0
for item in s:
    total+=item
print(total)
```

    324.0



```python
import numpy as np

total = np.sum(s)
print(total)
```

    324.0



```python
#this creates a big series of random numbers
s = pd.Series(np.random.randint(0,1000,10000))
s.head()
```




    0    465
    1    800
    2     10
    3    941
    4    203
    dtype: int64




```python
len(s)
```




    10000




```python
%%timeit -n 100
summary = 0
for item in s:
    summary+=item
```

    2.01 ms ± 112 µs per loop (mean ± std. dev. of 7 runs, 100 loops each)



```python
%%timeit -n 100
summary = np.sum(s)
```

    The slowest run took 8.23 times longer than the fastest. This could mean that an intermediate result is being cached.
    262 µs ± 264 µs per loop (mean ± std. dev. of 7 runs, 100 loops each)



```python
s+=2 #adds two to each item in s using broadcasting
s.head()
```




    0    467
    1    802
    2     12
    3    943
    4    205
    dtype: int64




```python
for label, value in s.iteritems():
    s.set_value(label, value+2)
s.head()
```




    0    469
    1    804
    2     14
    3    945
    4    207
    dtype: int64




```python
%%timeit -n 10
s = pd.Series(np.random.randint(0,1000,10000))
for label, value in s.iteritems():
    s.loc[label]= value+2
```

    1.32 s ± 30.9 ms per loop (mean ± std. dev. of 7 runs, 10 loops each)



```python
%%timeit -n 10
s = pd.Series(np.random.randint(0,1000,10000))
s+=2

```

    The slowest run took 25.16 times longer than the fastest. This could mean that an intermediate result is being cached.
    1.05 ms ± 1.96 ms per loop (mean ± std. dev. of 7 runs, 10 loops each)



```python
s = pd.Series([1, 2, 3])
s.loc['Animal'] = 'Bears'
s
```




    0             1
    1             2
    2             3
    Animal    Bears
    dtype: object




```python
original_sports = pd.Series({'Archery': 'Bhutan',
                             'Golf': 'Scotland',
                             'Sumo': 'Japan',
                             'Taekwondo': 'South Korea'})
cricket_loving_countries = pd.Series(['Australia',
                                      'Barbados',
                                      'Pakistan',
                                      'England'], 
                                   index=['Cricket',
                                          'Cricket',
                                          'Cricket',
                                          'Cricket'])
all_countries = original_sports.append(cricket_loving_countries)
```


```python
original_sports
```




    Archery           Bhutan
    Golf            Scotland
    Sumo               Japan
    Taekwondo    South Korea
    dtype: object




```python
cricket_loving_countries
```




    Cricket    Australia
    Cricket     Barbados
    Cricket     Pakistan
    Cricket      England
    dtype: object




```python
all_countries
```




    Archery           Bhutan
    Golf            Scotland
    Sumo               Japan
    Taekwondo    South Korea
    Cricket        Australia
    Cricket         Barbados
    Cricket         Pakistan
    Cricket          England
    dtype: object




```python
all_countries.loc['Cricket']
```




    Cricket    Australia
    Cricket     Barbados
    Cricket     Pakistan
    Cricket      England
    dtype: object



# The DataFrame Data Structure


```python
import pandas as pd
purchase_1 = pd.Series({'Name': 'Chris',
                        'Item Purchased': 'Dog Food',
                        'Cost': 22.50})
purchase_2 = pd.Series({'Name': 'Kevyn',
                        'Item Purchased': 'Kitty Litter',
                        'Cost': 2.50})
purchase_3 = pd.Series({'Name': 'Vinod',
                        'Item Purchased': 'Bird Seed',
                        'Cost': 5.00})
df = pd.DataFrame([purchase_1, purchase_2, purchase_3], index=['Store 1', 'Store 1', 'Store 2'])
df = df.append(pd.Series({'Name': 'huayu', 'Item Purchased': 'toys', 'Cost': 3.00}, name = 'Store 3'))
pd.Series({'Name': 'huayu', 'Item Purchased': 'toys', 'Cost': 3.00}, name = 'Store 3')
```




    Cost                  3
    Item Purchased     toys
    Name              huayu
    Name: Store 3, dtype: object




```python
df.loc['Store 2']
```




    Cost                      5
    Item Purchased    Bird Seed
    Name                  Vinod
    Name: Store 2, dtype: object




```python
type(df.loc['Store 2'])
```




    pandas.core.series.Series




```python
df.loc['Store 1']
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Cost</th>
      <th>Item Purchased</th>
      <th>Name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Store 1</th>
      <td>22.5</td>
      <td>Dog Food</td>
      <td>Chris</td>
    </tr>
    <tr>
      <th>Store 1</th>
      <td>2.5</td>
      <td>Kitty Litter</td>
      <td>Kevyn</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.loc['Store 1', 'Cost']
```




    Store 1    22.5
    Store 1     2.5
    Name: Cost, dtype: float64




```python
df.T
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Store 1</th>
      <th>Store 1</th>
      <th>Store 2</th>
      <th>Store 3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Cost</th>
      <td>22.5</td>
      <td>2.5</td>
      <td>5</td>
      <td>3</td>
    </tr>
    <tr>
      <th>Item Purchased</th>
      <td>Dog Food</td>
      <td>Kitty Litter</td>
      <td>Bird Seed</td>
      <td>toys</td>
    </tr>
    <tr>
      <th>Name</th>
      <td>Chris</td>
      <td>Kevyn</td>
      <td>Vinod</td>
      <td>huayu</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.T.loc['Cost']
```




    Store 1    22.5
    Store 1     2.5
    Store 2       5
    Store 3       3
    Name: Cost, dtype: object




```python
df['Cost']
```




    Store 1    22.5
    Store 1     2.5
    Store 2     5.0
    Store 3     3.0
    Name: Cost, dtype: float64




```python
df.loc['Store 1']['Cost']
```




    Store 1    22.5
    Store 1     2.5
    Name: Cost, dtype: float64




```python
df.loc[:,['Name', 'Cost']]
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Name</th>
      <th>Cost</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Store 1</th>
      <td>Chris</td>
      <td>22.5</td>
    </tr>
    <tr>
      <th>Store 1</th>
      <td>Kevyn</td>
      <td>2.5</td>
    </tr>
    <tr>
      <th>Store 2</th>
      <td>Vinod</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>Store 3</th>
      <td>huayu</td>
      <td>3.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.drop('Store 1')
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Cost</th>
      <th>Item Purchased</th>
      <th>Name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Store 2</th>
      <td>5.0</td>
      <td>Bird Seed</td>
      <td>Vinod</td>
    </tr>
    <tr>
      <th>Store 3</th>
      <td>3.0</td>
      <td>toys</td>
      <td>huayu</td>
    </tr>
  </tbody>
</table>
</div>




```python
df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Cost</th>
      <th>Item Purchased</th>
      <th>Name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Store 1</th>
      <td>22.5</td>
      <td>Dog Food</td>
      <td>Chris</td>
    </tr>
    <tr>
      <th>Store 1</th>
      <td>2.5</td>
      <td>Kitty Litter</td>
      <td>Kevyn</td>
    </tr>
    <tr>
      <th>Store 2</th>
      <td>5.0</td>
      <td>Bird Seed</td>
      <td>Vinod</td>
    </tr>
    <tr>
      <th>Store 3</th>
      <td>3.0</td>
      <td>toys</td>
      <td>huayu</td>
    </tr>
  </tbody>
</table>
</div>




```python
copy_df = df.copy()
copy_df = copy_df.drop('Store 1')
copy_df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Cost</th>
      <th>Item Purchased</th>
      <th>Name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Store 2</th>
      <td>5.0</td>
      <td>Bird Seed</td>
      <td>Vinod</td>
    </tr>
    <tr>
      <th>Store 3</th>
      <td>3.0</td>
      <td>toys</td>
      <td>huayu</td>
    </tr>
  </tbody>
</table>
</div>




```python
copy_df.drop?
```


```python
del copy_df['Name']
copy_df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Cost</th>
      <th>Item Purchased</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Store 2</th>
      <td>5.0</td>
      <td>Bird Seed</td>
    </tr>
    <tr>
      <th>Store 3</th>
      <td>3.0</td>
      <td>toys</td>
    </tr>
  </tbody>
</table>
</div>




```python
df['Location'] = None
df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Cost</th>
      <th>Item Purchased</th>
      <th>Name</th>
      <th>Location</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Store 1</th>
      <td>22.5</td>
      <td>Dog Food</td>
      <td>Chris</td>
      <td>None</td>
    </tr>
    <tr>
      <th>Store 1</th>
      <td>2.5</td>
      <td>Kitty Litter</td>
      <td>Kevyn</td>
      <td>None</td>
    </tr>
    <tr>
      <th>Store 2</th>
      <td>5.0</td>
      <td>Bird Seed</td>
      <td>Vinod</td>
      <td>None</td>
    </tr>
    <tr>
      <th>Store 3</th>
      <td>3.0</td>
      <td>toys</td>
      <td>huayu</td>
      <td>None</td>
    </tr>
  </tbody>
</table>
</div>



# Dataframe Indexing and Loading


```python
costs = df['Cost']
costs
```




    Store 1    22.5
    Store 1     2.5
    Store 2     5.0
    Store 3     3.0
    Name: Cost, dtype: float64




```python
costs+=2
costs
```




    Store 1    24.5
    Store 1     4.5
    Store 2     7.0
    Store 3     5.0
    Name: Cost, dtype: float64




```python
df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Cost</th>
      <th>Item Purchased</th>
      <th>Name</th>
      <th>Location</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Store 1</th>
      <td>24.5</td>
      <td>Dog Food</td>
      <td>Chris</td>
      <td>None</td>
    </tr>
    <tr>
      <th>Store 1</th>
      <td>4.5</td>
      <td>Kitty Litter</td>
      <td>Kevyn</td>
      <td>None</td>
    </tr>
    <tr>
      <th>Store 2</th>
      <td>7.0</td>
      <td>Bird Seed</td>
      <td>Vinod</td>
      <td>None</td>
    </tr>
    <tr>
      <th>Store 3</th>
      <td>5.0</td>
      <td>toys</td>
      <td>huayu</td>
      <td>None</td>
    </tr>
  </tbody>
</table>
</div>




```python
!cat olympics.csv
```

    0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
    ,№ Summer,01 !,02 !,03 !,Total,№ Winter,01 !,02 !,03 !,Total,№ Games,01 !,02 !,03 !,Combined total
    Afghanistan (AFG),13,0,0,2,2,0,0,0,0,0,13,0,0,2,2
    Algeria (ALG),12,5,2,8,15,3,0,0,0,0,15,5,2,8,15
    Argentina (ARG),23,18,24,28,70,18,0,0,0,0,41,18,24,28,70
    Armenia (ARM),5,1,2,9,12,6,0,0,0,0,11,1,2,9,12
    Australasia (ANZ) [ANZ],2,3,4,5,12,0,0,0,0,0,2,3,4,5,12
    Australia (AUS) [AUS] [Z],25,139,152,177,468,18,5,3,4,12,43,144,155,181,480
    Austria (AUT),26,18,33,35,86,22,59,78,81,218,48,77,111,116,304
    Azerbaijan (AZE),5,6,5,15,26,5,0,0,0,0,10,6,5,15,26
    Bahamas (BAH),15,5,2,5,12,0,0,0,0,0,15,5,2,5,12
    Bahrain (BRN),8,0,0,1,1,0,0,0,0,0,8,0,0,1,1
    Barbados (BAR) [BAR],11,0,0,1,1,0,0,0,0,0,11,0,0,1,1
    Belarus (BLR),5,12,24,39,75,6,6,4,5,15,11,18,28,44,90
    Belgium (BEL),25,37,52,53,142,20,1,1,3,5,45,38,53,56,147
    Bermuda (BER),17,0,0,1,1,7,0,0,0,0,24,0,0,1,1
    Bohemia (BOH) [BOH] [Z],3,0,1,3,4,0,0,0,0,0,3,0,1,3,4
    Botswana (BOT),9,0,1,0,1,0,0,0,0,0,9,0,1,0,1
    Brazil (BRA),21,23,30,55,108,7,0,0,0,0,28,23,30,55,108
    British West Indies (BWI) [BWI],1,0,0,2,2,0,0,0,0,0,1,0,0,2,2
    Bulgaria (BUL) [H],19,51,85,78,214,19,1,2,3,6,38,52,87,81,220
    Burundi (BDI),5,1,0,0,1,0,0,0,0,0,5,1,0,0,1
    Cameroon (CMR),13,3,1,1,5,1,0,0,0,0,14,3,1,1,5
    Canada (CAN),25,59,99,121,279,22,62,56,52,170,47,121,155,173,449
    Chile (CHI) [I],22,2,7,4,13,16,0,0,0,0,38,2,7,4,13
    China (CHN) [CHN],9,201,146,126,473,10,12,22,19,53,19,213,168,145,526
    Colombia (COL),18,2,6,11,19,1,0,0,0,0,19,2,6,11,19
    Costa Rica (CRC),14,1,1,2,4,6,0,0,0,0,20,1,1,2,4
    Ivory Coast (CIV) [CIV],12,0,1,0,1,0,0,0,0,0,12,0,1,0,1
    Croatia (CRO),6,6,7,10,23,7,4,6,1,11,13,10,13,11,34
    Cuba (CUB) [Z],19,72,67,70,209,0,0,0,0,0,19,72,67,70,209
    Cyprus (CYP),9,0,1,0,1,10,0,0,0,0,19,0,1,0,1
    Czech Republic (CZE) [CZE],5,14,15,15,44,6,7,9,8,24,11,21,24,23,68
    Czechoslovakia (TCH) [TCH],16,49,49,45,143,16,2,8,15,25,32,51,57,60,168
    Denmark (DEN) [Z],26,43,68,68,179,13,0,1,0,1,39,43,69,68,180
    Djibouti (DJI) [B],7,0,0,1,1,0,0,0,0,0,7,0,0,1,1
    Dominican Republic (DOM),13,3,2,1,6,0,0,0,0,0,13,3,2,1,6
    Ecuador (ECU),13,1,1,0,2,0,0,0,0,0,13,1,1,0,2
    Egypt (EGY) [EGY] [Z],21,7,9,10,26,1,0,0,0,0,22,7,9,10,26
    Eritrea (ERI),4,0,0,1,1,0,0,0,0,0,4,0,0,1,1
    Estonia (EST),11,9,9,15,33,9,4,2,1,7,20,13,11,16,40
    Ethiopia (ETH),12,21,7,17,45,2,0,0,0,0,14,21,7,17,45
    Finland (FIN),24,101,84,117,302,22,42,62,57,161,46,143,146,174,463
    France (FRA) [O] [P] [Z],27,202,223,246,671,22,31,31,47,109,49,233,254,293,780
    Gabon (GAB),9,0,1,0,1,0,0,0,0,0,9,0,1,0,1
    Georgia (GEO),5,6,5,14,25,6,0,0,0,0,11,6,5,14,25
    Germany (GER) [GER] [Z],15,174,182,217,573,11,78,78,53,209,26,252,260,270,782
    United Team of Germany (EUA) [EUA],3,28,54,36,118,3,8,6,5,19,6,36,60,41,137
    East Germany (GDR) [GDR],5,153,129,127,409,6,39,36,35,110,11,192,165,162,519
    West Germany (FRG) [FRG],5,56,67,81,204,6,11,15,13,39,11,67,82,94,243
    Ghana (GHA) [GHA],13,0,1,3,4,1,0,0,0,0,14,0,1,3,4
    Great Britain (GBR) [GBR] [Z],27,236,272,272,780,22,10,4,12,26,49,246,276,284,806
    Greece (GRE) [Z],27,30,42,39,111,18,0,0,0,0,45,30,42,39,111
    Grenada (GRN),8,1,0,0,1,0,0,0,0,0,8,1,0,0,1
    Guatemala (GUA),13,0,1,0,1,1,0,0,0,0,14,0,1,0,1
    Guyana (GUY) [GUY],16,0,0,1,1,0,0,0,0,0,16,0,0,1,1
    Haiti (HAI) [J],14,0,1,1,2,0,0,0,0,0,14,0,1,1,2
    Hong Kong (HKG) [HKG],15,1,1,1,3,4,0,0,0,0,19,1,1,1,3
    Hungary (HUN),25,167,144,165,476,22,0,2,4,6,47,167,146,169,482
    Iceland (ISL),19,0,2,2,4,17,0,0,0,0,36,0,2,2,4
    India (IND) [F],23,9,6,11,26,9,0,0,0,0,32,9,6,11,26
    Indonesia (INA),14,6,10,11,27,0,0,0,0,0,14,6,10,11,27
    Iran (IRI) [K],15,15,20,25,60,10,0,0,0,0,25,15,20,25,60
    Iraq (IRQ),13,0,0,1,1,0,0,0,0,0,13,0,0,1,1
    Ireland (IRL),20,9,8,12,29,6,0,0,0,0,26,9,8,12,29
    Israel (ISR),15,1,1,5,7,6,0,0,0,0,21,1,1,5,7
    Italy (ITA) [M] [S],26,198,166,185,549,22,37,34,43,114,48,235,200,228,663
    Jamaica (JAM) [JAM],16,17,30,20,67,7,0,0,0,0,23,17,30,20,67
    Japan (JPN),21,130,126,142,398,20,10,17,18,45,41,140,143,160,443
    Kazakhstan (KAZ),5,16,17,19,52,6,1,3,3,7,11,17,20,22,59
    Kenya (KEN),13,25,32,29,86,3,0,0,0,0,16,25,32,29,86
    North Korea (PRK),9,14,12,21,47,8,0,1,1,2,17,14,13,22,49
    South Korea (KOR),16,81,82,80,243,17,26,17,10,53,33,107,99,90,296
    Kuwait (KUW),12,0,0,2,2,0,0,0,0,0,12,0,0,2,2
    Kyrgyzstan (KGZ),5,0,1,2,3,6,0,0,0,0,11,0,1,2,3
    Latvia (LAT),10,3,11,5,19,10,0,4,3,7,20,3,15,8,26
    Lebanon (LIB),16,0,2,2,4,16,0,0,0,0,32,0,2,2,4
    Liechtenstein (LIE),16,0,0,0,0,18,2,2,5,9,34,2,2,5,9
    Lithuania (LTU),8,6,5,10,21,8,0,0,0,0,16,6,5,10,21
    Luxembourg (LUX) [O],22,1,1,0,2,8,0,2,0,2,30,1,3,0,4
    Macedonia (MKD),5,0,0,1,1,5,0,0,0,0,10,0,0,1,1
    Malaysia (MAS) [MAS],12,0,3,3,6,0,0,0,0,0,12,0,3,3,6
    Mauritius (MRI),8,0,0,1,1,0,0,0,0,0,8,0,0,1,1
    Mexico (MEX),22,13,21,28,62,8,0,0,0,0,30,13,21,28,62
    Moldova (MDA),5,0,2,5,7,6,0,0,0,0,11,0,2,5,7
    Mongolia (MGL),12,2,9,13,24,13,0,0,0,0,25,2,9,13,24
    Montenegro (MNE),2,0,1,0,1,2,0,0,0,0,4,0,1,0,1
    Morocco (MAR),13,6,5,11,22,6,0,0,0,0,19,6,5,11,22
    Mozambique (MOZ),9,1,0,1,2,0,0,0,0,0,9,1,0,1,2
    Namibia (NAM),6,0,4,0,4,0,0,0,0,0,6,0,4,0,4
    Netherlands (NED) [Z],25,77,85,104,266,20,37,38,35,110,45,114,123,139,376
    Netherlands Antilles (AHO) [AHO] [I],13,0,1,0,1,2,0,0,0,0,15,0,1,0,1
    New Zealand (NZL) [NZL],22,42,18,39,99,15,0,1,0,1,37,42,19,39,100
    Niger (NIG),11,0,0,1,1,0,0,0,0,0,11,0,0,1,1
    Nigeria (NGR),15,3,8,12,23,0,0,0,0,0,15,3,8,12,23
    Norway (NOR) [Q],24,56,49,43,148,22,118,111,100,329,46,174,160,143,477
    Pakistan (PAK),16,3,3,4,10,2,0,0,0,0,18,3,3,4,10
    Panama (PAN),16,1,0,2,3,0,0,0,0,0,16,1,0,2,3
    Paraguay (PAR),11,0,1,0,1,1,0,0,0,0,12,0,1,0,1
    Peru (PER) [L],17,1,3,0,4,2,0,0,0,0,19,1,3,0,4
    Philippines (PHI),20,0,2,7,9,4,0,0,0,0,24,0,2,7,9
    Poland (POL),20,64,82,125,271,22,6,7,7,20,42,70,89,132,291
    Portugal (POR),23,4,8,11,23,7,0,0,0,0,30,4,8,11,23
    Puerto Rico (PUR),17,0,2,6,8,6,0,0,0,0,23,0,2,6,8
    Qatar (QAT),8,0,0,4,4,0,0,0,0,0,8,0,0,4,4
    Romania (ROU),20,88,94,119,301,20,0,0,1,1,40,88,94,120,302
    Russia (RUS) [RUS],5,132,121,142,395,6,49,40,35,124,11,181,161,177,519
    Russian Empire (RU1) [RU1],3,1,4,3,8,0,0,0,0,0,3,1,4,3,8
    Soviet Union (URS) [URS],9,395,319,296,1010,9,78,57,59,194,18,473,376,355,1204
    Unified Team (EUN) [EUN],1,45,38,29,112,1,9,6,8,23,2,54,44,37,135
    Saudi Arabia (KSA),10,0,1,2,3,0,0,0,0,0,10,0,1,2,3
    Senegal (SEN),13,0,1,0,1,5,0,0,0,0,18,0,1,0,1
    Serbia (SRB) [SRB],3,1,2,4,7,2,0,0,0,0,5,1,2,4,7
    Serbia and Montenegro (SCG) [SCG],3,2,4,3,9,3,0,0,0,0,6,2,4,3,9
    Singapore (SIN),15,0,2,2,4,0,0,0,0,0,15,0,2,2,4
    Slovakia (SVK) [SVK],5,7,9,8,24,6,2,2,1,5,11,9,11,9,29
    Slovenia (SLO),6,4,6,9,19,7,2,4,9,15,13,6,10,18,34
    South Africa (RSA),18,23,26,27,76,6,0,0,0,0,24,23,26,27,76
    Spain (ESP) [Z],22,37,59,35,131,19,1,0,1,2,41,38,59,36,133
    Sri Lanka (SRI) [SRI],16,0,2,0,2,0,0,0,0,0,16,0,2,0,2
    Sudan (SUD),11,0,1,0,1,0,0,0,0,0,11,0,1,0,1
    Suriname (SUR) [E],11,1,0,1,2,0,0,0,0,0,11,1,0,1,2
    Sweden (SWE) [Z],26,143,164,176,483,22,50,40,54,144,48,193,204,230,627
    Switzerland (SUI),27,47,73,65,185,22,50,40,48,138,49,97,113,113,323
    Syria (SYR),12,1,1,1,3,0,0,0,0,0,12,1,1,1,3
    Chinese Taipei (TPE) [TPE] [TPE2],13,2,7,12,21,11,0,0,0,0,24,2,7,12,21
    Tajikistan (TJK),5,0,1,2,3,4,0,0,0,0,9,0,1,2,3
    Tanzania (TAN) [TAN],12,0,2,0,2,0,0,0,0,0,12,0,2,0,2
    Thailand (THA),15,7,6,11,24,3,0,0,0,0,18,7,6,11,24
    Togo (TOG),9,0,0,1,1,1,0,0,0,0,10,0,0,1,1
    Tonga (TGA),8,0,1,0,1,1,0,0,0,0,9,0,1,0,1
    Trinidad and Tobago (TRI) [TRI],16,2,5,11,18,3,0,0,0,0,19,2,5,11,18
    Tunisia (TUN),13,3,3,4,10,0,0,0,0,0,13,3,3,4,10
    Turkey (TUR),21,39,25,24,88,16,0,0,0,0,37,39,25,24,88
    Uganda (UGA),14,2,3,2,7,0,0,0,0,0,14,2,3,2,7
    Ukraine (UKR),5,33,27,55,115,6,2,1,4,7,11,35,28,59,122
    United Arab Emirates (UAE),8,1,0,0,1,0,0,0,0,0,8,1,0,0,1
    United States (USA) [P] [Q] [R] [Z],26,976,757,666,2399,22,96,102,84,282,48,1072,859,750,2681
    Uruguay (URU),20,2,2,6,10,1,0,0,0,0,21,2,2,6,10
    Uzbekistan (UZB),5,5,5,10,20,6,1,0,0,1,11,6,5,10,21
    Venezuela (VEN),17,2,2,8,12,4,0,0,0,0,21,2,2,8,12
    Vietnam (VIE),14,0,2,0,2,0,0,0,0,0,14,0,2,0,2
    Virgin Islands (ISV),11,0,1,0,1,7,0,0,0,0,18,0,1,0,1
    Yugoslavia (YUG) [YUG],16,26,29,28,83,14,0,3,1,4,30,26,32,29,87
    Independent Olympic Participants (IOP) [IOP],1,0,1,2,3,0,0,0,0,0,1,0,1,2,3
    Zambia (ZAM) [ZAM],12,0,1,1,2,0,0,0,0,0,12,0,1,1,2
    Zimbabwe (ZIM) [ZIM],12,3,4,1,8,1,0,0,0,0,13,3,4,1,8
    Mixed team (ZZX) [ZZX],3,8,5,4,17,0,0,0,0,0,3,8,5,4,17
    Totals,27,4809,4775,5130,14714,22,959,958,948,2865,49,5768,5733,6078,17579



```python
df = pd.read_csv('olympics.csv')
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      <th>10</th>
      <th>11</th>
      <th>12</th>
      <th>13</th>
      <th>14</th>
      <th>15</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>NaN</td>
      <td>№ Summer</td>
      <td>01 !</td>
      <td>02 !</td>
      <td>03 !</td>
      <td>Total</td>
      <td>№ Winter</td>
      <td>01 !</td>
      <td>02 !</td>
      <td>03 !</td>
      <td>Total</td>
      <td>№ Games</td>
      <td>01 !</td>
      <td>02 !</td>
      <td>03 !</td>
      <td>Combined total</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Afghanistan (AFG)</td>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Algeria (ALG)</td>
      <td>12</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>15</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Argentina (ARG)</td>
      <td>23</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>18</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>41</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Armenia (ARM)</td>
      <td>5</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>6</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>11</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
    </tr>
  </tbody>
</table>
</div>




```python
df = pd.read_csv('olympics.csv', index_col = 0, skiprows=1)
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>№ Summer</th>
      <th>01 !</th>
      <th>02 !</th>
      <th>03 !</th>
      <th>Total</th>
      <th>№ Winter</th>
      <th>01 !.1</th>
      <th>02 !.1</th>
      <th>03 !.1</th>
      <th>Total.1</th>
      <th>№ Games</th>
      <th>01 !.2</th>
      <th>02 !.2</th>
      <th>03 !.2</th>
      <th>Combined total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Afghanistan (AFG)</th>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Algeria (ALG)</th>
      <td>12</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>15</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
    </tr>
    <tr>
      <th>Argentina (ARG)</th>
      <td>23</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>18</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>41</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
    </tr>
    <tr>
      <th>Armenia (ARM)</th>
      <td>5</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>6</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>11</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
    </tr>
    <tr>
      <th>Australasia (ANZ) [ANZ]</th>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.columns
```




    Index(['№ Summer', '01 !', '02 !', '03 !', 'Total', '№ Winter', '01 !.1',
           '02 !.1', '03 !.1', 'Total.1', '№ Games', '01 !.2', '02 !.2', '03 !.2',
           'Combined total'],
          dtype='object')




```python
for col in df.columns:
    if col[:2]=='01':
        df.rename(columns={col:'Gold' + col[4:]}, inplace=True)
    if col[:2]=='02':
        df.rename(columns={col:'Silver' + col[4:]}, inplace=True)
    if col[:2]=='03':
        df.rename(columns={col:'Bronze' + col[4:]}, inplace=True)
    if col[:1]=='№':
        df.rename(columns={col:'#' + col[1:]}, inplace=True) 

df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th># Summer</th>
      <th>Gold</th>
      <th>Silver</th>
      <th>Bronze</th>
      <th>Total</th>
      <th># Winter</th>
      <th>Gold.1</th>
      <th>Silver.1</th>
      <th>Bronze.1</th>
      <th>Total.1</th>
      <th># Games</th>
      <th>Gold.2</th>
      <th>Silver.2</th>
      <th>Bronze.2</th>
      <th>Combined total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Afghanistan (AFG)</th>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Algeria (ALG)</th>
      <td>12</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>15</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
    </tr>
    <tr>
      <th>Argentina (ARG)</th>
      <td>23</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>18</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>41</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
    </tr>
    <tr>
      <th>Armenia (ARM)</th>
      <td>5</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>6</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>11</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
    </tr>
    <tr>
      <th>Australasia (ANZ) [ANZ]</th>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
    </tr>
  </tbody>
</table>
</div>



# Querying a DataFrame


```python
df['Gold'] > 0
```




    Afghanistan (AFG)                               False
    Algeria (ALG)                                    True
    Argentina (ARG)                                  True
    Armenia (ARM)                                    True
    Australasia (ANZ) [ANZ]                          True
    Australia (AUS) [AUS] [Z]                        True
    Austria (AUT)                                    True
    Azerbaijan (AZE)                                 True
    Bahamas (BAH)                                    True
    Bahrain (BRN)                                   False
    Barbados (BAR) [BAR]                            False
    Belarus (BLR)                                    True
    Belgium (BEL)                                    True
    Bermuda (BER)                                   False
    Bohemia (BOH) [BOH] [Z]                         False
    Botswana (BOT)                                  False
    Brazil (BRA)                                     True
    British West Indies (BWI) [BWI]                 False
    Bulgaria (BUL) [H]                               True
    Burundi (BDI)                                    True
    Cameroon (CMR)                                   True
    Canada (CAN)                                     True
    Chile (CHI) [I]                                  True
    China (CHN) [CHN]                                True
    Colombia (COL)                                   True
    Costa Rica (CRC)                                 True
    Ivory Coast (CIV) [CIV]                         False
    Croatia (CRO)                                    True
    Cuba (CUB) [Z]                                   True
    Cyprus (CYP)                                    False
                                                    ...  
    Sri Lanka (SRI) [SRI]                           False
    Sudan (SUD)                                     False
    Suriname (SUR) [E]                               True
    Sweden (SWE) [Z]                                 True
    Switzerland (SUI)                                True
    Syria (SYR)                                      True
    Chinese Taipei (TPE) [TPE] [TPE2]                True
    Tajikistan (TJK)                                False
    Tanzania (TAN) [TAN]                            False
    Thailand (THA)                                   True
    Togo (TOG)                                      False
    Tonga (TGA)                                     False
    Trinidad and Tobago (TRI) [TRI]                  True
    Tunisia (TUN)                                    True
    Turkey (TUR)                                     True
    Uganda (UGA)                                     True
    Ukraine (UKR)                                    True
    United Arab Emirates (UAE)                       True
    United States (USA) [P] [Q] [R] [Z]              True
    Uruguay (URU)                                    True
    Uzbekistan (UZB)                                 True
    Venezuela (VEN)                                  True
    Vietnam (VIE)                                   False
    Virgin Islands (ISV)                            False
    Yugoslavia (YUG) [YUG]                           True
    Independent Olympic Participants (IOP) [IOP]    False
    Zambia (ZAM) [ZAM]                              False
    Zimbabwe (ZIM) [ZIM]                             True
    Mixed team (ZZX) [ZZX]                           True
    Totals                                           True
    Name: Gold, dtype: bool




```python
only_gold = df.where(df['Gold'] > 0)
only_gold.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th># Summer</th>
      <th>Gold</th>
      <th>Silver</th>
      <th>Bronze</th>
      <th>Total</th>
      <th># Winter</th>
      <th>Gold.1</th>
      <th>Silver.1</th>
      <th>Bronze.1</th>
      <th>Total.1</th>
      <th># Games</th>
      <th>Gold.2</th>
      <th>Silver.2</th>
      <th>Bronze.2</th>
      <th>Combined total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Afghanistan (AFG)</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Algeria (ALG)</th>
      <td>12.0</td>
      <td>5.0</td>
      <td>2.0</td>
      <td>8.0</td>
      <td>15.0</td>
      <td>3.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>15.0</td>
      <td>5.0</td>
      <td>2.0</td>
      <td>8.0</td>
      <td>15.0</td>
    </tr>
    <tr>
      <th>Argentina (ARG)</th>
      <td>23.0</td>
      <td>18.0</td>
      <td>24.0</td>
      <td>28.0</td>
      <td>70.0</td>
      <td>18.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>41.0</td>
      <td>18.0</td>
      <td>24.0</td>
      <td>28.0</td>
      <td>70.0</td>
    </tr>
    <tr>
      <th>Armenia (ARM)</th>
      <td>5.0</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>9.0</td>
      <td>12.0</td>
      <td>6.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>11.0</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>9.0</td>
      <td>12.0</td>
    </tr>
    <tr>
      <th>Australasia (ANZ) [ANZ]</th>
      <td>2.0</td>
      <td>3.0</td>
      <td>4.0</td>
      <td>5.0</td>
      <td>12.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>2.0</td>
      <td>3.0</td>
      <td>4.0</td>
      <td>5.0</td>
      <td>12.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
only_gold['Gold'].count()
```




    100




```python
df['Gold'].count()
```




    147




```python
only_gold = only_gold.dropna()
only_gold.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th># Summer</th>
      <th>Gold</th>
      <th>Silver</th>
      <th>Bronze</th>
      <th>Total</th>
      <th># Winter</th>
      <th>Gold.1</th>
      <th>Silver.1</th>
      <th>Bronze.1</th>
      <th>Total.1</th>
      <th># Games</th>
      <th>Gold.2</th>
      <th>Silver.2</th>
      <th>Bronze.2</th>
      <th>Combined total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Algeria (ALG)</th>
      <td>12.0</td>
      <td>5.0</td>
      <td>2.0</td>
      <td>8.0</td>
      <td>15.0</td>
      <td>3.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>15.0</td>
      <td>5.0</td>
      <td>2.0</td>
      <td>8.0</td>
      <td>15.0</td>
    </tr>
    <tr>
      <th>Argentina (ARG)</th>
      <td>23.0</td>
      <td>18.0</td>
      <td>24.0</td>
      <td>28.0</td>
      <td>70.0</td>
      <td>18.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>41.0</td>
      <td>18.0</td>
      <td>24.0</td>
      <td>28.0</td>
      <td>70.0</td>
    </tr>
    <tr>
      <th>Armenia (ARM)</th>
      <td>5.0</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>9.0</td>
      <td>12.0</td>
      <td>6.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>11.0</td>
      <td>1.0</td>
      <td>2.0</td>
      <td>9.0</td>
      <td>12.0</td>
    </tr>
    <tr>
      <th>Australasia (ANZ) [ANZ]</th>
      <td>2.0</td>
      <td>3.0</td>
      <td>4.0</td>
      <td>5.0</td>
      <td>12.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>2.0</td>
      <td>3.0</td>
      <td>4.0</td>
      <td>5.0</td>
      <td>12.0</td>
    </tr>
    <tr>
      <th>Australia (AUS) [AUS] [Z]</th>
      <td>25.0</td>
      <td>139.0</td>
      <td>152.0</td>
      <td>177.0</td>
      <td>468.0</td>
      <td>18.0</td>
      <td>5.0</td>
      <td>3.0</td>
      <td>4.0</td>
      <td>12.0</td>
      <td>43.0</td>
      <td>144.0</td>
      <td>155.0</td>
      <td>181.0</td>
      <td>480.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
only_gold = df[df['Gold'] > 0]
only_gold.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th># Summer</th>
      <th>Gold</th>
      <th>Silver</th>
      <th>Bronze</th>
      <th>Total</th>
      <th># Winter</th>
      <th>Gold.1</th>
      <th>Silver.1</th>
      <th>Bronze.1</th>
      <th>Total.1</th>
      <th># Games</th>
      <th>Gold.2</th>
      <th>Silver.2</th>
      <th>Bronze.2</th>
      <th>Combined total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Algeria (ALG)</th>
      <td>12</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>15</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
    </tr>
    <tr>
      <th>Argentina (ARG)</th>
      <td>23</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>18</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>41</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
    </tr>
    <tr>
      <th>Armenia (ARM)</th>
      <td>5</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>6</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>11</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
    </tr>
    <tr>
      <th>Australasia (ANZ) [ANZ]</th>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
    </tr>
    <tr>
      <th>Australia (AUS) [AUS] [Z]</th>
      <td>25</td>
      <td>139</td>
      <td>152</td>
      <td>177</td>
      <td>468</td>
      <td>18</td>
      <td>5</td>
      <td>3</td>
      <td>4</td>
      <td>12</td>
      <td>43</td>
      <td>144</td>
      <td>155</td>
      <td>181</td>
      <td>480</td>
    </tr>
  </tbody>
</table>
</div>




```python
len(df[(df['Gold'] > 0) | (df['Gold.1'] > 0)])
```




    101




```python
df[(df['Gold.1'] > 0) & (df['Gold'] == 0)]
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th># Summer</th>
      <th>Gold</th>
      <th>Silver</th>
      <th>Bronze</th>
      <th>Total</th>
      <th># Winter</th>
      <th>Gold.1</th>
      <th>Silver.1</th>
      <th>Bronze.1</th>
      <th>Total.1</th>
      <th># Games</th>
      <th>Gold.2</th>
      <th>Silver.2</th>
      <th>Bronze.2</th>
      <th>Combined total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Liechtenstein (LIE)</th>
      <td>16</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>18</td>
      <td>2</td>
      <td>2</td>
      <td>5</td>
      <td>9</td>
      <td>34</td>
      <td>2</td>
      <td>2</td>
      <td>5</td>
      <td>9</td>
    </tr>
  </tbody>
</table>
</div>



# Indexing Dataframes


```python
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th># Summer</th>
      <th>Gold</th>
      <th>Silver</th>
      <th>Bronze</th>
      <th>Total</th>
      <th># Winter</th>
      <th>Gold.1</th>
      <th>Silver.1</th>
      <th>Bronze.1</th>
      <th>Total.1</th>
      <th># Games</th>
      <th>Gold.2</th>
      <th>Silver.2</th>
      <th>Bronze.2</th>
      <th>Combined total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Afghanistan (AFG)</th>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Algeria (ALG)</th>
      <td>12</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>15</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
    </tr>
    <tr>
      <th>Argentina (ARG)</th>
      <td>23</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>18</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>41</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
    </tr>
    <tr>
      <th>Armenia (ARM)</th>
      <td>5</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>6</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>11</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
    </tr>
    <tr>
      <th>Australasia (ANZ) [ANZ]</th>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
    </tr>
  </tbody>
</table>
</div>




```python
df['country'] = df.index
df = df.set_index('Gold')
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th># Summer</th>
      <th>Silver</th>
      <th>Bronze</th>
      <th>Total</th>
      <th># Winter</th>
      <th>Gold.1</th>
      <th>Silver.1</th>
      <th>Bronze.1</th>
      <th>Total.1</th>
      <th># Games</th>
      <th>Gold.2</th>
      <th>Silver.2</th>
      <th>Bronze.2</th>
      <th>Combined total</th>
      <th>country</th>
    </tr>
    <tr>
      <th>Gold</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>13</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
      <td>Afghanistan (AFG)</td>
    </tr>
    <tr>
      <th>5</th>
      <td>12</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>15</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>Algeria (ALG)</td>
    </tr>
    <tr>
      <th>18</th>
      <td>23</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>18</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>41</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>Argentina (ARG)</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>6</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>11</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>Armenia (ARM)</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
      <td>Australasia (ANZ) [ANZ]</td>
    </tr>
  </tbody>
</table>
</div>




```python
df = df.reset_index()
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Gold</th>
      <th># Summer</th>
      <th>Silver</th>
      <th>Bronze</th>
      <th>Total</th>
      <th># Winter</th>
      <th>Gold.1</th>
      <th>Silver.1</th>
      <th>Bronze.1</th>
      <th>Total.1</th>
      <th># Games</th>
      <th>Gold.2</th>
      <th>Silver.2</th>
      <th>Bronze.2</th>
      <th>Combined total</th>
      <th>country</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>13</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
      <td>Afghanistan (AFG)</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5</td>
      <td>12</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>15</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>Algeria (ALG)</td>
    </tr>
    <tr>
      <th>2</th>
      <td>18</td>
      <td>23</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>18</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>41</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>Argentina (ARG)</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>5</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>6</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>11</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>Armenia (ARM)</td>
    </tr>
    <tr>
      <th>4</th>
      <td>3</td>
      <td>2</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
      <td>Australasia (ANZ) [ANZ]</td>
    </tr>
  </tbody>
</table>
</div>




```python
df = pd.read_csv('census.csv')
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>SUMLEV</th>
      <th>REGION</th>
      <th>DIVISION</th>
      <th>STATE</th>
      <th>COUNTY</th>
      <th>STNAME</th>
      <th>CTYNAME</th>
      <th>CENSUS2010POP</th>
      <th>ESTIMATESBASE2010</th>
      <th>POPESTIMATE2010</th>
      <th>...</th>
      <th>RDOMESTICMIG2011</th>
      <th>RDOMESTICMIG2012</th>
      <th>RDOMESTICMIG2013</th>
      <th>RDOMESTICMIG2014</th>
      <th>RDOMESTICMIG2015</th>
      <th>RNETMIG2011</th>
      <th>RNETMIG2012</th>
      <th>RNETMIG2013</th>
      <th>RNETMIG2014</th>
      <th>RNETMIG2015</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>40</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>0</td>
      <td>Alabama</td>
      <td>Alabama</td>
      <td>4779736</td>
      <td>4780127</td>
      <td>4785161</td>
      <td>...</td>
      <td>0.002295</td>
      <td>-0.193196</td>
      <td>0.381066</td>
      <td>0.582002</td>
      <td>-0.467369</td>
      <td>1.030015</td>
      <td>0.826644</td>
      <td>1.383282</td>
      <td>1.724718</td>
      <td>0.712594</td>
    </tr>
    <tr>
      <th>1</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>1</td>
      <td>Alabama</td>
      <td>Autauga County</td>
      <td>54571</td>
      <td>54571</td>
      <td>54660</td>
      <td>...</td>
      <td>7.242091</td>
      <td>-2.915927</td>
      <td>-3.012349</td>
      <td>2.265971</td>
      <td>-2.530799</td>
      <td>7.606016</td>
      <td>-2.626146</td>
      <td>-2.722002</td>
      <td>2.592270</td>
      <td>-2.187333</td>
    </tr>
    <tr>
      <th>2</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>3</td>
      <td>Alabama</td>
      <td>Baldwin County</td>
      <td>182265</td>
      <td>182265</td>
      <td>183193</td>
      <td>...</td>
      <td>14.832960</td>
      <td>17.647293</td>
      <td>21.845705</td>
      <td>19.243287</td>
      <td>17.197872</td>
      <td>15.844176</td>
      <td>18.559627</td>
      <td>22.727626</td>
      <td>20.317142</td>
      <td>18.293499</td>
    </tr>
    <tr>
      <th>3</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>5</td>
      <td>Alabama</td>
      <td>Barbour County</td>
      <td>27457</td>
      <td>27457</td>
      <td>27341</td>
      <td>...</td>
      <td>-4.728132</td>
      <td>-2.500690</td>
      <td>-7.056824</td>
      <td>-3.904217</td>
      <td>-10.543299</td>
      <td>-4.874741</td>
      <td>-2.758113</td>
      <td>-7.167664</td>
      <td>-3.978583</td>
      <td>-10.543299</td>
    </tr>
    <tr>
      <th>4</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>7</td>
      <td>Alabama</td>
      <td>Bibb County</td>
      <td>22915</td>
      <td>22919</td>
      <td>22861</td>
      <td>...</td>
      <td>-5.527043</td>
      <td>-5.068871</td>
      <td>-6.201001</td>
      <td>-0.177537</td>
      <td>0.177258</td>
      <td>-5.088389</td>
      <td>-4.363636</td>
      <td>-5.403729</td>
      <td>0.754533</td>
      <td>1.107861</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 100 columns</p>
</div>




```python
df['SUMLEV'].unique()
```




    array([40, 50])




```python
df=df[df['SUMLEV'] == 50]
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>SUMLEV</th>
      <th>REGION</th>
      <th>DIVISION</th>
      <th>STATE</th>
      <th>COUNTY</th>
      <th>STNAME</th>
      <th>CTYNAME</th>
      <th>CENSUS2010POP</th>
      <th>ESTIMATESBASE2010</th>
      <th>POPESTIMATE2010</th>
      <th>...</th>
      <th>RDOMESTICMIG2011</th>
      <th>RDOMESTICMIG2012</th>
      <th>RDOMESTICMIG2013</th>
      <th>RDOMESTICMIG2014</th>
      <th>RDOMESTICMIG2015</th>
      <th>RNETMIG2011</th>
      <th>RNETMIG2012</th>
      <th>RNETMIG2013</th>
      <th>RNETMIG2014</th>
      <th>RNETMIG2015</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>1</td>
      <td>Alabama</td>
      <td>Autauga County</td>
      <td>54571</td>
      <td>54571</td>
      <td>54660</td>
      <td>...</td>
      <td>7.242091</td>
      <td>-2.915927</td>
      <td>-3.012349</td>
      <td>2.265971</td>
      <td>-2.530799</td>
      <td>7.606016</td>
      <td>-2.626146</td>
      <td>-2.722002</td>
      <td>2.592270</td>
      <td>-2.187333</td>
    </tr>
    <tr>
      <th>2</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>3</td>
      <td>Alabama</td>
      <td>Baldwin County</td>
      <td>182265</td>
      <td>182265</td>
      <td>183193</td>
      <td>...</td>
      <td>14.832960</td>
      <td>17.647293</td>
      <td>21.845705</td>
      <td>19.243287</td>
      <td>17.197872</td>
      <td>15.844176</td>
      <td>18.559627</td>
      <td>22.727626</td>
      <td>20.317142</td>
      <td>18.293499</td>
    </tr>
    <tr>
      <th>3</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>5</td>
      <td>Alabama</td>
      <td>Barbour County</td>
      <td>27457</td>
      <td>27457</td>
      <td>27341</td>
      <td>...</td>
      <td>-4.728132</td>
      <td>-2.500690</td>
      <td>-7.056824</td>
      <td>-3.904217</td>
      <td>-10.543299</td>
      <td>-4.874741</td>
      <td>-2.758113</td>
      <td>-7.167664</td>
      <td>-3.978583</td>
      <td>-10.543299</td>
    </tr>
    <tr>
      <th>4</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>7</td>
      <td>Alabama</td>
      <td>Bibb County</td>
      <td>22915</td>
      <td>22919</td>
      <td>22861</td>
      <td>...</td>
      <td>-5.527043</td>
      <td>-5.068871</td>
      <td>-6.201001</td>
      <td>-0.177537</td>
      <td>0.177258</td>
      <td>-5.088389</td>
      <td>-4.363636</td>
      <td>-5.403729</td>
      <td>0.754533</td>
      <td>1.107861</td>
    </tr>
    <tr>
      <th>5</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>9</td>
      <td>Alabama</td>
      <td>Blount County</td>
      <td>57322</td>
      <td>57322</td>
      <td>57373</td>
      <td>...</td>
      <td>1.807375</td>
      <td>-1.177622</td>
      <td>-1.748766</td>
      <td>-2.062535</td>
      <td>-1.369970</td>
      <td>1.859511</td>
      <td>-0.848580</td>
      <td>-1.402476</td>
      <td>-1.577232</td>
      <td>-0.884411</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 100 columns</p>
</div>




```python
columns_to_keep = ['STNAME',
                   'CTYNAME',
                   'BIRTHS2010',
                   'BIRTHS2011',
                   'BIRTHS2012',
                   'BIRTHS2013',
                   'BIRTHS2014',
                   'BIRTHS2015',
                   'POPESTIMATE2010',
                   'POPESTIMATE2011',
                   'POPESTIMATE2012',
                   'POPESTIMATE2013',
                   'POPESTIMATE2014',
                   'POPESTIMATE2015']
df = df[columns_to_keep]
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>STNAME</th>
      <th>CTYNAME</th>
      <th>BIRTHS2010</th>
      <th>BIRTHS2011</th>
      <th>BIRTHS2012</th>
      <th>BIRTHS2013</th>
      <th>BIRTHS2014</th>
      <th>BIRTHS2015</th>
      <th>POPESTIMATE2010</th>
      <th>POPESTIMATE2011</th>
      <th>POPESTIMATE2012</th>
      <th>POPESTIMATE2013</th>
      <th>POPESTIMATE2014</th>
      <th>POPESTIMATE2015</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>Alabama</td>
      <td>Autauga County</td>
      <td>151</td>
      <td>636</td>
      <td>615</td>
      <td>574</td>
      <td>623</td>
      <td>600</td>
      <td>54660</td>
      <td>55253</td>
      <td>55175</td>
      <td>55038</td>
      <td>55290</td>
      <td>55347</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Alabama</td>
      <td>Baldwin County</td>
      <td>517</td>
      <td>2187</td>
      <td>2092</td>
      <td>2160</td>
      <td>2186</td>
      <td>2240</td>
      <td>183193</td>
      <td>186659</td>
      <td>190396</td>
      <td>195126</td>
      <td>199713</td>
      <td>203709</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Alabama</td>
      <td>Barbour County</td>
      <td>70</td>
      <td>335</td>
      <td>300</td>
      <td>283</td>
      <td>260</td>
      <td>269</td>
      <td>27341</td>
      <td>27226</td>
      <td>27159</td>
      <td>26973</td>
      <td>26815</td>
      <td>26489</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Alabama</td>
      <td>Bibb County</td>
      <td>44</td>
      <td>266</td>
      <td>245</td>
      <td>259</td>
      <td>247</td>
      <td>253</td>
      <td>22861</td>
      <td>22733</td>
      <td>22642</td>
      <td>22512</td>
      <td>22549</td>
      <td>22583</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Alabama</td>
      <td>Blount County</td>
      <td>183</td>
      <td>744</td>
      <td>710</td>
      <td>646</td>
      <td>618</td>
      <td>603</td>
      <td>57373</td>
      <td>57711</td>
      <td>57776</td>
      <td>57734</td>
      <td>57658</td>
      <td>57673</td>
    </tr>
  </tbody>
</table>
</div>




```python
df = df.set_index(['STNAME', 'CTYNAME'])
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>BIRTHS2010</th>
      <th>BIRTHS2011</th>
      <th>BIRTHS2012</th>
      <th>BIRTHS2013</th>
      <th>BIRTHS2014</th>
      <th>BIRTHS2015</th>
      <th>POPESTIMATE2010</th>
      <th>POPESTIMATE2011</th>
      <th>POPESTIMATE2012</th>
      <th>POPESTIMATE2013</th>
      <th>POPESTIMATE2014</th>
      <th>POPESTIMATE2015</th>
    </tr>
    <tr>
      <th>STNAME</th>
      <th>CTYNAME</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="5" valign="top">Alabama</th>
      <th>Autauga County</th>
      <td>151</td>
      <td>636</td>
      <td>615</td>
      <td>574</td>
      <td>623</td>
      <td>600</td>
      <td>54660</td>
      <td>55253</td>
      <td>55175</td>
      <td>55038</td>
      <td>55290</td>
      <td>55347</td>
    </tr>
    <tr>
      <th>Baldwin County</th>
      <td>517</td>
      <td>2187</td>
      <td>2092</td>
      <td>2160</td>
      <td>2186</td>
      <td>2240</td>
      <td>183193</td>
      <td>186659</td>
      <td>190396</td>
      <td>195126</td>
      <td>199713</td>
      <td>203709</td>
    </tr>
    <tr>
      <th>Barbour County</th>
      <td>70</td>
      <td>335</td>
      <td>300</td>
      <td>283</td>
      <td>260</td>
      <td>269</td>
      <td>27341</td>
      <td>27226</td>
      <td>27159</td>
      <td>26973</td>
      <td>26815</td>
      <td>26489</td>
    </tr>
    <tr>
      <th>Bibb County</th>
      <td>44</td>
      <td>266</td>
      <td>245</td>
      <td>259</td>
      <td>247</td>
      <td>253</td>
      <td>22861</td>
      <td>22733</td>
      <td>22642</td>
      <td>22512</td>
      <td>22549</td>
      <td>22583</td>
    </tr>
    <tr>
      <th>Blount County</th>
      <td>183</td>
      <td>744</td>
      <td>710</td>
      <td>646</td>
      <td>618</td>
      <td>603</td>
      <td>57373</td>
      <td>57711</td>
      <td>57776</td>
      <td>57734</td>
      <td>57658</td>
      <td>57673</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.loc['Michigan', 'Washtenaw County']
```




    BIRTHS2010            977
    BIRTHS2011           3826
    BIRTHS2012           3780
    BIRTHS2013           3662
    BIRTHS2014           3683
    BIRTHS2015           3709
    POPESTIMATE2010    345563
    POPESTIMATE2011    349048
    POPESTIMATE2012    351213
    POPESTIMATE2013    354289
    POPESTIMATE2014    357029
    POPESTIMATE2015    358880
    Name: (Michigan, Washtenaw County), dtype: int64




```python
df.loc[ [('Michigan', 'Washtenaw County'),
         ('Michigan', 'Wayne County')] ]
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>BIRTHS2010</th>
      <th>BIRTHS2011</th>
      <th>BIRTHS2012</th>
      <th>BIRTHS2013</th>
      <th>BIRTHS2014</th>
      <th>BIRTHS2015</th>
      <th>POPESTIMATE2010</th>
      <th>POPESTIMATE2011</th>
      <th>POPESTIMATE2012</th>
      <th>POPESTIMATE2013</th>
      <th>POPESTIMATE2014</th>
      <th>POPESTIMATE2015</th>
    </tr>
    <tr>
      <th>STNAME</th>
      <th>CTYNAME</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="2" valign="top">Michigan</th>
      <th>Washtenaw County</th>
      <td>977</td>
      <td>3826</td>
      <td>3780</td>
      <td>3662</td>
      <td>3683</td>
      <td>3709</td>
      <td>345563</td>
      <td>349048</td>
      <td>351213</td>
      <td>354289</td>
      <td>357029</td>
      <td>358880</td>
    </tr>
    <tr>
      <th>Wayne County</th>
      <td>5918</td>
      <td>23819</td>
      <td>23270</td>
      <td>23377</td>
      <td>23607</td>
      <td>23586</td>
      <td>1815199</td>
      <td>1801273</td>
      <td>1792514</td>
      <td>1775713</td>
      <td>1766008</td>
      <td>1759335</td>
    </tr>
  </tbody>
</table>
</div>




```python
df = df.T
df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th>STNAME</th>
      <th colspan="10" halign="left">Alabama</th>
      <th>...</th>
      <th colspan="10" halign="left">Wyoming</th>
    </tr>
    <tr>
      <th>CTYNAME</th>
      <th>Autauga County</th>
      <th>Baldwin County</th>
      <th>Barbour County</th>
      <th>Bibb County</th>
      <th>Blount County</th>
      <th>Bullock County</th>
      <th>Butler County</th>
      <th>Calhoun County</th>
      <th>Chambers County</th>
      <th>Cherokee County</th>
      <th>...</th>
      <th>Niobrara County</th>
      <th>Park County</th>
      <th>Platte County</th>
      <th>Sheridan County</th>
      <th>Sublette County</th>
      <th>Sweetwater County</th>
      <th>Teton County</th>
      <th>Uinta County</th>
      <th>Washakie County</th>
      <th>Weston County</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>BIRTHS2010</th>
      <td>151</td>
      <td>517</td>
      <td>70</td>
      <td>44</td>
      <td>183</td>
      <td>39</td>
      <td>65</td>
      <td>317</td>
      <td>81</td>
      <td>55</td>
      <td>...</td>
      <td>6</td>
      <td>73</td>
      <td>13</td>
      <td>87</td>
      <td>34</td>
      <td>167</td>
      <td>76</td>
      <td>73</td>
      <td>26</td>
      <td>26</td>
    </tr>
    <tr>
      <th>BIRTHS2011</th>
      <td>636</td>
      <td>2187</td>
      <td>335</td>
      <td>266</td>
      <td>744</td>
      <td>169</td>
      <td>276</td>
      <td>1382</td>
      <td>401</td>
      <td>221</td>
      <td>...</td>
      <td>18</td>
      <td>299</td>
      <td>82</td>
      <td>343</td>
      <td>134</td>
      <td>640</td>
      <td>259</td>
      <td>324</td>
      <td>108</td>
      <td>81</td>
    </tr>
    <tr>
      <th>BIRTHS2012</th>
      <td>615</td>
      <td>2092</td>
      <td>300</td>
      <td>245</td>
      <td>710</td>
      <td>122</td>
      <td>241</td>
      <td>1357</td>
      <td>393</td>
      <td>245</td>
      <td>...</td>
      <td>18</td>
      <td>327</td>
      <td>93</td>
      <td>332</td>
      <td>138</td>
      <td>595</td>
      <td>230</td>
      <td>311</td>
      <td>90</td>
      <td>74</td>
    </tr>
    <tr>
      <th>BIRTHS2013</th>
      <td>574</td>
      <td>2160</td>
      <td>283</td>
      <td>259</td>
      <td>646</td>
      <td>132</td>
      <td>240</td>
      <td>1309</td>
      <td>404</td>
      <td>232</td>
      <td>...</td>
      <td>27</td>
      <td>301</td>
      <td>94</td>
      <td>306</td>
      <td>132</td>
      <td>657</td>
      <td>261</td>
      <td>316</td>
      <td>95</td>
      <td>93</td>
    </tr>
    <tr>
      <th>BIRTHS2014</th>
      <td>623</td>
      <td>2186</td>
      <td>260</td>
      <td>247</td>
      <td>618</td>
      <td>118</td>
      <td>267</td>
      <td>1355</td>
      <td>421</td>
      <td>261</td>
      <td>...</td>
      <td>27</td>
      <td>323</td>
      <td>81</td>
      <td>361</td>
      <td>122</td>
      <td>629</td>
      <td>249</td>
      <td>316</td>
      <td>96</td>
      <td>77</td>
    </tr>
    <tr>
      <th>BIRTHS2015</th>
      <td>600</td>
      <td>2240</td>
      <td>269</td>
      <td>253</td>
      <td>603</td>
      <td>123</td>
      <td>257</td>
      <td>1335</td>
      <td>429</td>
      <td>250</td>
      <td>...</td>
      <td>25</td>
      <td>313</td>
      <td>90</td>
      <td>338</td>
      <td>128</td>
      <td>620</td>
      <td>269</td>
      <td>316</td>
      <td>90</td>
      <td>79</td>
    </tr>
    <tr>
      <th>POPESTIMATE2010</th>
      <td>54660</td>
      <td>183193</td>
      <td>27341</td>
      <td>22861</td>
      <td>57373</td>
      <td>10887</td>
      <td>20944</td>
      <td>118437</td>
      <td>34098</td>
      <td>25976</td>
      <td>...</td>
      <td>2492</td>
      <td>28259</td>
      <td>8678</td>
      <td>29146</td>
      <td>10244</td>
      <td>43593</td>
      <td>21297</td>
      <td>21102</td>
      <td>8545</td>
      <td>7181</td>
    </tr>
    <tr>
      <th>POPESTIMATE2011</th>
      <td>55253</td>
      <td>186659</td>
      <td>27226</td>
      <td>22733</td>
      <td>57711</td>
      <td>10629</td>
      <td>20673</td>
      <td>117768</td>
      <td>33993</td>
      <td>26080</td>
      <td>...</td>
      <td>2485</td>
      <td>28473</td>
      <td>8701</td>
      <td>29275</td>
      <td>10142</td>
      <td>44041</td>
      <td>21482</td>
      <td>20912</td>
      <td>8469</td>
      <td>7114</td>
    </tr>
    <tr>
      <th>POPESTIMATE2012</th>
      <td>55175</td>
      <td>190396</td>
      <td>27159</td>
      <td>22642</td>
      <td>57776</td>
      <td>10606</td>
      <td>20408</td>
      <td>117286</td>
      <td>34075</td>
      <td>26023</td>
      <td>...</td>
      <td>2475</td>
      <td>28863</td>
      <td>8732</td>
      <td>29594</td>
      <td>10418</td>
      <td>45104</td>
      <td>21697</td>
      <td>20989</td>
      <td>8443</td>
      <td>7065</td>
    </tr>
    <tr>
      <th>POPESTIMATE2013</th>
      <td>55038</td>
      <td>195126</td>
      <td>26973</td>
      <td>22512</td>
      <td>57734</td>
      <td>10628</td>
      <td>20261</td>
      <td>116575</td>
      <td>34153</td>
      <td>26084</td>
      <td>...</td>
      <td>2548</td>
      <td>29237</td>
      <td>8728</td>
      <td>29794</td>
      <td>10086</td>
      <td>45162</td>
      <td>22347</td>
      <td>21022</td>
      <td>8443</td>
      <td>7160</td>
    </tr>
    <tr>
      <th>POPESTIMATE2014</th>
      <td>55290</td>
      <td>199713</td>
      <td>26815</td>
      <td>22549</td>
      <td>57658</td>
      <td>10829</td>
      <td>20276</td>
      <td>115993</td>
      <td>34052</td>
      <td>25995</td>
      <td>...</td>
      <td>2530</td>
      <td>29126</td>
      <td>8776</td>
      <td>30020</td>
      <td>10039</td>
      <td>44925</td>
      <td>22905</td>
      <td>20903</td>
      <td>8316</td>
      <td>7185</td>
    </tr>
    <tr>
      <th>POPESTIMATE2015</th>
      <td>55347</td>
      <td>203709</td>
      <td>26489</td>
      <td>22583</td>
      <td>57673</td>
      <td>10696</td>
      <td>20154</td>
      <td>115620</td>
      <td>34123</td>
      <td>25859</td>
      <td>...</td>
      <td>2542</td>
      <td>29228</td>
      <td>8812</td>
      <td>30009</td>
      <td>9899</td>
      <td>44626</td>
      <td>23125</td>
      <td>20822</td>
      <td>8328</td>
      <td>7234</td>
    </tr>
  </tbody>
</table>
<p>12 rows × 3142 columns</p>
</div>




```python
df.index
```




    Index(['BIRTHS2010', 'BIRTHS2011', 'BIRTHS2012', 'BIRTHS2013', 'BIRTHS2014',
           'BIRTHS2015', 'POPESTIMATE2010', 'POPESTIMATE2011', 'POPESTIMATE2012',
           'POPESTIMATE2013', 'POPESTIMATE2014', 'POPESTIMATE2015'],
          dtype='object')




```python
df.reset_index()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th>STNAME</th>
      <th>index</th>
      <th colspan="9" halign="left">Alabama</th>
      <th>...</th>
      <th colspan="10" halign="left">Wyoming</th>
    </tr>
    <tr>
      <th>CTYNAME</th>
      <th></th>
      <th>Autauga County</th>
      <th>Baldwin County</th>
      <th>Barbour County</th>
      <th>Bibb County</th>
      <th>Blount County</th>
      <th>Bullock County</th>
      <th>Butler County</th>
      <th>Calhoun County</th>
      <th>Chambers County</th>
      <th>...</th>
      <th>Niobrara County</th>
      <th>Park County</th>
      <th>Platte County</th>
      <th>Sheridan County</th>
      <th>Sublette County</th>
      <th>Sweetwater County</th>
      <th>Teton County</th>
      <th>Uinta County</th>
      <th>Washakie County</th>
      <th>Weston County</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>BIRTHS2010</td>
      <td>151</td>
      <td>517</td>
      <td>70</td>
      <td>44</td>
      <td>183</td>
      <td>39</td>
      <td>65</td>
      <td>317</td>
      <td>81</td>
      <td>...</td>
      <td>6</td>
      <td>73</td>
      <td>13</td>
      <td>87</td>
      <td>34</td>
      <td>167</td>
      <td>76</td>
      <td>73</td>
      <td>26</td>
      <td>26</td>
    </tr>
    <tr>
      <th>1</th>
      <td>BIRTHS2011</td>
      <td>636</td>
      <td>2187</td>
      <td>335</td>
      <td>266</td>
      <td>744</td>
      <td>169</td>
      <td>276</td>
      <td>1382</td>
      <td>401</td>
      <td>...</td>
      <td>18</td>
      <td>299</td>
      <td>82</td>
      <td>343</td>
      <td>134</td>
      <td>640</td>
      <td>259</td>
      <td>324</td>
      <td>108</td>
      <td>81</td>
    </tr>
    <tr>
      <th>2</th>
      <td>BIRTHS2012</td>
      <td>615</td>
      <td>2092</td>
      <td>300</td>
      <td>245</td>
      <td>710</td>
      <td>122</td>
      <td>241</td>
      <td>1357</td>
      <td>393</td>
      <td>...</td>
      <td>18</td>
      <td>327</td>
      <td>93</td>
      <td>332</td>
      <td>138</td>
      <td>595</td>
      <td>230</td>
      <td>311</td>
      <td>90</td>
      <td>74</td>
    </tr>
    <tr>
      <th>3</th>
      <td>BIRTHS2013</td>
      <td>574</td>
      <td>2160</td>
      <td>283</td>
      <td>259</td>
      <td>646</td>
      <td>132</td>
      <td>240</td>
      <td>1309</td>
      <td>404</td>
      <td>...</td>
      <td>27</td>
      <td>301</td>
      <td>94</td>
      <td>306</td>
      <td>132</td>
      <td>657</td>
      <td>261</td>
      <td>316</td>
      <td>95</td>
      <td>93</td>
    </tr>
    <tr>
      <th>4</th>
      <td>BIRTHS2014</td>
      <td>623</td>
      <td>2186</td>
      <td>260</td>
      <td>247</td>
      <td>618</td>
      <td>118</td>
      <td>267</td>
      <td>1355</td>
      <td>421</td>
      <td>...</td>
      <td>27</td>
      <td>323</td>
      <td>81</td>
      <td>361</td>
      <td>122</td>
      <td>629</td>
      <td>249</td>
      <td>316</td>
      <td>96</td>
      <td>77</td>
    </tr>
    <tr>
      <th>5</th>
      <td>BIRTHS2015</td>
      <td>600</td>
      <td>2240</td>
      <td>269</td>
      <td>253</td>
      <td>603</td>
      <td>123</td>
      <td>257</td>
      <td>1335</td>
      <td>429</td>
      <td>...</td>
      <td>25</td>
      <td>313</td>
      <td>90</td>
      <td>338</td>
      <td>128</td>
      <td>620</td>
      <td>269</td>
      <td>316</td>
      <td>90</td>
      <td>79</td>
    </tr>
    <tr>
      <th>6</th>
      <td>POPESTIMATE2010</td>
      <td>54660</td>
      <td>183193</td>
      <td>27341</td>
      <td>22861</td>
      <td>57373</td>
      <td>10887</td>
      <td>20944</td>
      <td>118437</td>
      <td>34098</td>
      <td>...</td>
      <td>2492</td>
      <td>28259</td>
      <td>8678</td>
      <td>29146</td>
      <td>10244</td>
      <td>43593</td>
      <td>21297</td>
      <td>21102</td>
      <td>8545</td>
      <td>7181</td>
    </tr>
    <tr>
      <th>7</th>
      <td>POPESTIMATE2011</td>
      <td>55253</td>
      <td>186659</td>
      <td>27226</td>
      <td>22733</td>
      <td>57711</td>
      <td>10629</td>
      <td>20673</td>
      <td>117768</td>
      <td>33993</td>
      <td>...</td>
      <td>2485</td>
      <td>28473</td>
      <td>8701</td>
      <td>29275</td>
      <td>10142</td>
      <td>44041</td>
      <td>21482</td>
      <td>20912</td>
      <td>8469</td>
      <td>7114</td>
    </tr>
    <tr>
      <th>8</th>
      <td>POPESTIMATE2012</td>
      <td>55175</td>
      <td>190396</td>
      <td>27159</td>
      <td>22642</td>
      <td>57776</td>
      <td>10606</td>
      <td>20408</td>
      <td>117286</td>
      <td>34075</td>
      <td>...</td>
      <td>2475</td>
      <td>28863</td>
      <td>8732</td>
      <td>29594</td>
      <td>10418</td>
      <td>45104</td>
      <td>21697</td>
      <td>20989</td>
      <td>8443</td>
      <td>7065</td>
    </tr>
    <tr>
      <th>9</th>
      <td>POPESTIMATE2013</td>
      <td>55038</td>
      <td>195126</td>
      <td>26973</td>
      <td>22512</td>
      <td>57734</td>
      <td>10628</td>
      <td>20261</td>
      <td>116575</td>
      <td>34153</td>
      <td>...</td>
      <td>2548</td>
      <td>29237</td>
      <td>8728</td>
      <td>29794</td>
      <td>10086</td>
      <td>45162</td>
      <td>22347</td>
      <td>21022</td>
      <td>8443</td>
      <td>7160</td>
    </tr>
    <tr>
      <th>10</th>
      <td>POPESTIMATE2014</td>
      <td>55290</td>
      <td>199713</td>
      <td>26815</td>
      <td>22549</td>
      <td>57658</td>
      <td>10829</td>
      <td>20276</td>
      <td>115993</td>
      <td>34052</td>
      <td>...</td>
      <td>2530</td>
      <td>29126</td>
      <td>8776</td>
      <td>30020</td>
      <td>10039</td>
      <td>44925</td>
      <td>22905</td>
      <td>20903</td>
      <td>8316</td>
      <td>7185</td>
    </tr>
    <tr>
      <th>11</th>
      <td>POPESTIMATE2015</td>
      <td>55347</td>
      <td>203709</td>
      <td>26489</td>
      <td>22583</td>
      <td>57673</td>
      <td>10696</td>
      <td>20154</td>
      <td>115620</td>
      <td>34123</td>
      <td>...</td>
      <td>2542</td>
      <td>29228</td>
      <td>8812</td>
      <td>30009</td>
      <td>9899</td>
      <td>44626</td>
      <td>23125</td>
      <td>20822</td>
      <td>8328</td>
      <td>7234</td>
    </tr>
  </tbody>
</table>
<p>12 rows × 3143 columns</p>
</div>




```python
df.index
```




    Index(['BIRTHS2010', 'BIRTHS2011', 'BIRTHS2012', 'BIRTHS2013', 'BIRTHS2014',
           'BIRTHS2015', 'POPESTIMATE2010', 'POPESTIMATE2011', 'POPESTIMATE2012',
           'POPESTIMATE2013', 'POPESTIMATE2014', 'POPESTIMATE2015'],
          dtype='object')



# Missing values


```python
df = pd.read_csv('log.csv')
df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>time</th>
      <th>user</th>
      <th>video</th>
      <th>playback position</th>
      <th>paused</th>
      <th>volume</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1469974424</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>5</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1469974454</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>6</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1469974544</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>9</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1469974574</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>10</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1469977514</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1469977544</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>1469977574</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>1469977604</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>1469974604</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>11</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>9</th>
      <td>1469974694</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>14</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>10</th>
      <td>1469974724</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>15</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>11</th>
      <td>1469974454</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>24</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>12</th>
      <td>1469974524</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>25</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>13</th>
      <td>1469974424</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>23</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>14</th>
      <td>1469974554</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>26</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>15</th>
      <td>1469974624</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>27</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>16</th>
      <td>1469974654</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>28</td>
      <td>NaN</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>17</th>
      <td>1469974724</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>29</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>18</th>
      <td>1469974484</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>7</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>19</th>
      <td>1469974514</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>8</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>20</th>
      <td>1469974754</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>30</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>21</th>
      <td>1469974824</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>31</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>22</th>
      <td>1469974854</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>32</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>23</th>
      <td>1469974924</td>
      <td>sue</td>
      <td>advanced.html</td>
      <td>33</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>24</th>
      <td>1469977424</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>True</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>25</th>
      <td>1469977454</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>26</th>
      <td>1469977484</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>27</th>
      <td>1469977634</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>28</th>
      <td>1469977664</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>29</th>
      <td>1469974634</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>12</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>30</th>
      <td>1469974664</td>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>13</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>31</th>
      <td>1469977694</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>32</th>
      <td>1469977724</td>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.fillna?
```


```python
df = df.set_index('time')
df = df.sort_index()
df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user</th>
      <th>video</th>
      <th>playback position</th>
      <th>paused</th>
      <th>volume</th>
    </tr>
    <tr>
      <th>time</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1469974424</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>5</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>1469974424</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>23</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>1469974454</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>6</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974454</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>24</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974484</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>7</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974514</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>8</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974524</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>25</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974544</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>9</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974554</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>26</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974574</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>10</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974604</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>11</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974624</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>27</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974634</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>12</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974654</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>28</td>
      <td>NaN</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>1469974664</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>13</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974694</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>14</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974724</th>
      <td>cheryl</td>
      <td>intro.html</td>
      <td>15</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974724</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>29</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974754</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>30</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974824</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>31</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974854</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>32</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974924</th>
      <td>sue</td>
      <td>advanced.html</td>
      <td>33</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977424</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>True</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>1469977454</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977484</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977514</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977544</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977574</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977604</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977634</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977664</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977694</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977724</th>
      <td>bob</td>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
df = df.reset_index()
df = df.set_index(['time', 'user'])
df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>video</th>
      <th>playback position</th>
      <th>paused</th>
      <th>volume</th>
    </tr>
    <tr>
      <th>time</th>
      <th>user</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="2" valign="top">1469974424</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>5</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>sue</th>
      <td>advanced.html</td>
      <td>23</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th rowspan="2" valign="top">1469974454</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>6</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>sue</th>
      <td>advanced.html</td>
      <td>24</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974484</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>7</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974514</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>8</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974524</th>
      <th>sue</th>
      <td>advanced.html</td>
      <td>25</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974544</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>9</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974554</th>
      <th>sue</th>
      <td>advanced.html</td>
      <td>26</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974574</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>10</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974604</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>11</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974624</th>
      <th>sue</th>
      <td>advanced.html</td>
      <td>27</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974634</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>12</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974654</th>
      <th>sue</th>
      <td>advanced.html</td>
      <td>28</td>
      <td>NaN</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>1469974664</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>13</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974694</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>14</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="2" valign="top">1469974724</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>15</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>sue</th>
      <td>advanced.html</td>
      <td>29</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974754</th>
      <th>sue</th>
      <td>advanced.html</td>
      <td>30</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974824</th>
      <th>sue</th>
      <td>advanced.html</td>
      <td>31</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974854</th>
      <th>sue</th>
      <td>advanced.html</td>
      <td>32</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469974924</th>
      <th>sue</th>
      <td>advanced.html</td>
      <td>33</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977424</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>True</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>1469977454</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977484</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977514</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977544</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977574</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977604</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977634</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977664</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977694</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1469977724</th>
      <th>bob</th>
      <td>intro.html</td>
      <td>1</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
df = df.fillna(method='ffill')
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>video</th>
      <th>playback position</th>
      <th>paused</th>
      <th>volume</th>
    </tr>
    <tr>
      <th>time</th>
      <th>user</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="2" valign="top">1469974424</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>5</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>sue</th>
      <td>advanced.html</td>
      <td>23</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th rowspan="2" valign="top">1469974454</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>6</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>sue</th>
      <td>advanced.html</td>
      <td>24</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>1469974484</th>
      <th>cheryl</th>
      <td>intro.html</td>
      <td>7</td>
      <td>False</td>
      <td>10.0</td>
    </tr>
  </tbody>
</table>
</div>


&emsp;

# Assignment 2 - Pandas Introduction

All questions are weighted the same in this assignment.
## Part 1
The following code loads the olympics dataset (olympics.csv), which was derrived from the Wikipedia entry on [All Time Olympic Games Medals](https://en.wikipedia.org/wiki/All-time_Olympic_Games_medal_table), and does some basic data cleaning. 

The columns are organized as # of Summer games, Summer medals, # of Winter games, Winter medals, total # number of games, total # of medals. Use this dataset to answer the questions below.


```python
import pandas as pd

df = pd.read_csv('olympics.csv', index_col=0, skiprows=1)

for col in df.columns:
    if col[:2]=='01':
        df.rename(columns={col:'Gold'+col[4:]}, inplace=True)
    if col[:2]=='02':
        df.rename(columns={col:'Silver'+col[4:]}, inplace=True)
    if col[:2]=='03':
        df.rename(columns={col:'Bronze'+col[4:]}, inplace=True)
    if col[:1]=='№':
        df.rename(columns={col:'#'+col[1:]}, inplace=True)

names_ids = df.index.str.split('\s\(') # split the index by '('

df.index = names_ids.str[0] # the [0] element is the country name (new index) 
df['ID'] = names_ids.str[1].str[:3] # the [1] element is the abbreviation or ID (take first 3 characters from that)

df = df.drop('Totals')
df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th># Summer</th>
      <th>Gold</th>
      <th>Silver</th>
      <th>Bronze</th>
      <th>Total</th>
      <th># Winter</th>
      <th>Gold.1</th>
      <th>Silver.1</th>
      <th>Bronze.1</th>
      <th>Total.1</th>
      <th># Games</th>
      <th>Gold.2</th>
      <th>Silver.2</th>
      <th>Bronze.2</th>
      <th>Combined total</th>
      <th>ID</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Afghanistan</th>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>13</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>2</td>
      <td>AFG</td>
    </tr>
    <tr>
      <th>Algeria</th>
      <td>12</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>15</td>
      <td>5</td>
      <td>2</td>
      <td>8</td>
      <td>15</td>
      <td>ALG</td>
    </tr>
    <tr>
      <th>Argentina</th>
      <td>23</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>18</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>41</td>
      <td>18</td>
      <td>24</td>
      <td>28</td>
      <td>70</td>
      <td>ARG</td>
    </tr>
    <tr>
      <th>Armenia</th>
      <td>5</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>6</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>11</td>
      <td>1</td>
      <td>2</td>
      <td>9</td>
      <td>12</td>
      <td>ARM</td>
    </tr>
    <tr>
      <th>Australasia</th>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>12</td>
      <td>ANZ</td>
    </tr>
  </tbody>
</table>
</div>



### Question 0 (Example)

What is the first country in df?

*This function should return a Series.*


```python
# You should write your whole answer within the function provided. The autograder will call
# this function and compare the return value against the correct solution value
def answer_zero():
    # This function returns the row for Afghanistan, which is a Series object. The assignment
    # question description will tell you the general format the autograder is expecting
    return df.iloc[0]

# You can examine what your function returns by calling it in the cell. If you have questions
# about the assignment formats, check out the discussion forums for any FAQs
answer_zero() 
```




    # Summer           13
    Gold                0
    Silver              0
    Bronze              2
    Total               2
    # Winter            0
    Gold.1              0
    Silver.1            0
    Bronze.1            0
    Total.1             0
    # Games            13
    Gold.2              0
    Silver.2            0
    Bronze.2            2
    Combined total      2
    ID                AFG
    Name: Afghanistan, dtype: object



### Question 1
Which country has won the most gold medals in summer games?

*This function should return a single string value.*


```python
def answer_one():
    return df['Gold.2'].argmax()
answer_one()
```




    'United States'



### Question 2
Which country had the biggest difference between their summer and winter gold medal counts?

*This function should return a single string value.*


```python
def answer_two():
    return (df['Gold']-df['Gold.1']).abs().argmax()
answer_two()
```




    'United States'



### Question 3
Which country has the biggest difference between their summer gold medal counts and winter gold medal counts relative to their total gold medal count? 

$$\frac{Summer~Gold - Winter~Gold}{Total~Gold}$$

Only include countries that have won at least 1 gold in both summer and winter.

*This function should return a single string value.*


```python
def answer_three():
    return ((df[(df['Gold']>0)&(df['Gold.1']>0)]['Gold']-df[(df['Gold']>0)&(df['Gold.1']>0)]['Gold.1'])/df[(df['Gold']>0)&(df['Gold.1']>0)]['Gold.2']).argmax()
answer_three()
```




    'Bulgaria'



### Question 4
Write a function that creates a Series called "Points" which is a weighted value where each gold medal (`Gold.2`) counts for 3 points, silver medals (`Silver.2`) for 2 points, and bronze medals (`Bronze.2`) for 1 point. The function should return only the column (a Series object) which you created, with the country names as indices.

*This function should return a Series named `Points` of length 146*


```python
def answer_four():
    return pd.Series(df['Gold.2']*3+df['Silver.2']*2+df['Bronze.2']*1, name = 'Points')
answer_four()
```




    Afghanistan                            2
    Algeria                               27
    Argentina                            130
    Armenia                               16
    Australasia                           22
    Australia                            923
    Austria                              569
    Azerbaijan                            43
    Bahamas                               24
    Bahrain                                1
    Barbados                               1
    Belarus                              154
    Belgium                              276
    Bermuda                                1
    Bohemia                                5
    Botswana                               2
    Brazil                               184
    British West Indies                    2
    Bulgaria                             411
    Burundi                                3
    Cameroon                              12
    Canada                               846
    Chile                                 24
    China                               1120
    Colombia                              29
    Costa Rica                             7
    Ivory Coast                            2
    Croatia                               67
    Cuba                                 420
    Cyprus                                 2
                                        ... 
    Spain                                268
    Sri Lanka                              4
    Sudan                                  2
    Suriname                               4
    Sweden                              1217
    Switzerland                          630
    Syria                                  6
    Chinese Taipei                        32
    Tajikistan                             4
    Tanzania                               4
    Thailand                              44
    Togo                                   1
    Tonga                                  2
    Trinidad and Tobago                   27
    Tunisia                               19
    Turkey                               191
    Uganda                                14
    Ukraine                              220
    United Arab Emirates                   3
    United States                       5684
    Uruguay                               16
    Uzbekistan                            38
    Venezuela                             18
    Vietnam                                4
    Virgin Islands                         2
    Yugoslavia                           171
    Independent Olympic Participants       4
    Zambia                                 3
    Zimbabwe                              18
    Mixed team                            38
    Name: Points, dtype: int64



## Part 2
For the next set of questions, we will be using census data from the [United States Census Bureau](http://www.census.gov). Counties are political and geographic subdivisions of states in the United States. This dataset contains population data for counties and states in the US from 2010 to 2015. [See this document](https://www2.census.gov/programs-surveys/popest/technical-documentation/file-layouts/2010-2015/co-est2015-alldata.pdf) for a description of the variable names.

The census dataset (census.csv) should be loaded as census_df. Answer questions using this as appropriate.

### Question 5
Which state has the most counties in it? (hint: consider the sumlevel key carefully! You'll need this for future questions too...)

*This function should return a single string value.*


```python
census_df = pd.read_csv('census.csv')
census_df.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>SUMLEV</th>
      <th>REGION</th>
      <th>DIVISION</th>
      <th>STATE</th>
      <th>COUNTY</th>
      <th>STNAME</th>
      <th>CTYNAME</th>
      <th>CENSUS2010POP</th>
      <th>ESTIMATESBASE2010</th>
      <th>POPESTIMATE2010</th>
      <th>...</th>
      <th>RDOMESTICMIG2011</th>
      <th>RDOMESTICMIG2012</th>
      <th>RDOMESTICMIG2013</th>
      <th>RDOMESTICMIG2014</th>
      <th>RDOMESTICMIG2015</th>
      <th>RNETMIG2011</th>
      <th>RNETMIG2012</th>
      <th>RNETMIG2013</th>
      <th>RNETMIG2014</th>
      <th>RNETMIG2015</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>40</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>0</td>
      <td>Alabama</td>
      <td>Alabama</td>
      <td>4779736</td>
      <td>4780127</td>
      <td>4785161</td>
      <td>...</td>
      <td>0.002295</td>
      <td>-0.193196</td>
      <td>0.381066</td>
      <td>0.582002</td>
      <td>-0.467369</td>
      <td>1.030015</td>
      <td>0.826644</td>
      <td>1.383282</td>
      <td>1.724718</td>
      <td>0.712594</td>
    </tr>
    <tr>
      <th>1</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>1</td>
      <td>Alabama</td>
      <td>Autauga County</td>
      <td>54571</td>
      <td>54571</td>
      <td>54660</td>
      <td>...</td>
      <td>7.242091</td>
      <td>-2.915927</td>
      <td>-3.012349</td>
      <td>2.265971</td>
      <td>-2.530799</td>
      <td>7.606016</td>
      <td>-2.626146</td>
      <td>-2.722002</td>
      <td>2.592270</td>
      <td>-2.187333</td>
    </tr>
    <tr>
      <th>2</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>3</td>
      <td>Alabama</td>
      <td>Baldwin County</td>
      <td>182265</td>
      <td>182265</td>
      <td>183193</td>
      <td>...</td>
      <td>14.832960</td>
      <td>17.647293</td>
      <td>21.845705</td>
      <td>19.243287</td>
      <td>17.197872</td>
      <td>15.844176</td>
      <td>18.559627</td>
      <td>22.727626</td>
      <td>20.317142</td>
      <td>18.293499</td>
    </tr>
    <tr>
      <th>3</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>5</td>
      <td>Alabama</td>
      <td>Barbour County</td>
      <td>27457</td>
      <td>27457</td>
      <td>27341</td>
      <td>...</td>
      <td>-4.728132</td>
      <td>-2.500690</td>
      <td>-7.056824</td>
      <td>-3.904217</td>
      <td>-10.543299</td>
      <td>-4.874741</td>
      <td>-2.758113</td>
      <td>-7.167664</td>
      <td>-3.978583</td>
      <td>-10.543299</td>
    </tr>
    <tr>
      <th>4</th>
      <td>50</td>
      <td>3</td>
      <td>6</td>
      <td>1</td>
      <td>7</td>
      <td>Alabama</td>
      <td>Bibb County</td>
      <td>22915</td>
      <td>22919</td>
      <td>22861</td>
      <td>...</td>
      <td>-5.527043</td>
      <td>-5.068871</td>
      <td>-6.201001</td>
      <td>-0.177537</td>
      <td>0.177258</td>
      <td>-5.088389</td>
      <td>-4.363636</td>
      <td>-5.403729</td>
      <td>0.754533</td>
      <td>1.107861</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 100 columns</p>
</div>




```python
def answer_five():
    return census_df[census_df['SUMLEV']==50].groupby(['STNAME']).count().idxmax()[1]
answer_five()
```




    'Texas'



### Question 6
**Only looking at the three most populous counties for each state**, what are the three most populous states (in order of highest population to lowest population)? Use `CENSUS2010POP`.

*This function should return a list of string values.*


```python
def answer_six():
    return  census_df[census_df['SUMLEV']==50].groupby(['STNAME'])['CENSUS2010POP'].apply(lambda x:x.nlargest(3).sum()).nlargest(3).index.tolist()
answer_six()
```




    ['California', 'Texas', 'Illinois']



### Question 7
Which county has had the largest absolute change in population within the period 2010-2015? (Hint: population values are stored in columns POPESTIMATE2010 through POPESTIMATE2015, you need to consider all six columns.)

e.g. If County Population in the 5 year period is 100, 120, 80, 105, 100, 130, then its largest change in the period would be |130-80| = 50.

*This function should return a single string value.*


```python
def answer_seven():
    return census_df.iloc[(census_df[census_df['SUMLEV']==50][['POPESTIMATE2010','POPESTIMATE2011','POPESTIMATE2012','POPESTIMATE2013','POPESTIMATE2014','POPESTIMATE2015']].max(axis=1)-census_df[census_df['SUMLEV']==50][['POPESTIMATE2010','POPESTIMATE2011','POPESTIMATE2012','POPESTIMATE2013','POPESTIMATE2014','POPESTIMATE2015']].min(axis=1)).idxmax()]['CTYNAME']
answer_seven()
```




    'Harris County'



### Question 8
In this datafile, the United States is broken up into four regions using the "REGION" column. 

Create a query that finds the counties that belong to regions 1 or 2, whose name starts with 'Washington', and whose POPESTIMATE2015 was greater than their POPESTIMATE 2014.

*This function should return a 5x2 DataFrame with the columns = ['STNAME', 'CTYNAME'] and the same index ID as the census_df (sorted ascending by index).*


```python
def answer_eight():
    return census_df[((census_df['REGION']==1) | (census_df['REGION']==2)) & (census_df['CTYNAME'].str.startswith('Washington')) & (census_df['POPESTIMATE2015'] > census_df['POPESTIMATE2014'])][['STNAME','CTYNAME']]
answer_eight()

```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>STNAME</th>
      <th>CTYNAME</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>896</th>
      <td>Iowa</td>
      <td>Washington County</td>
    </tr>
    <tr>
      <th>1419</th>
      <td>Minnesota</td>
      <td>Washington County</td>
    </tr>
    <tr>
      <th>2345</th>
      <td>Pennsylvania</td>
      <td>Washington County</td>
    </tr>
    <tr>
      <th>2355</th>
      <td>Rhode Island</td>
      <td>Washington County</td>
    </tr>
    <tr>
      <th>3163</th>
      <td>Wisconsin</td>
      <td>Washington County</td>
    </tr>
  </tbody>
</table>
</div>


