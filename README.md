# Relations - Haskell
Having had an introduction to mathematical **relations** in my Computer Science course, I figured it'd be good to implement as many of the concepts that I've learned as I can.

This is programmed in the **Haskell** language partly due to it also being in my course, but also because I find it to be fitting for mathemtical things such as this.

## Documentation
### `Set`
```hs
type Set a = [a]
```

An alias for a list of any type.

Although intended to only allow 1 of each value (since sets in maths ignore duplicates), I don't know how to express this in Haskell at the moment. For now, it exists to make intention clear in function parameters.

### `Relation`
```hs
type Relation a b = ((a, b) -> Bool)
```

From what I've learned, a mathematical relation is essentially a function compares a pair of values, adding them to a resultant set if the relational condition is met.

```hs
((\(x, y) -> x > y) :: Relation Int Int) (1, 2)
-- False
```

### `toSet`
```hs
toSet :: Eq a => [a] -> Set a
```

Converts a normal list into a mathematical set by removing duplicates.

```hs
toSet [1,1,1]
-- [1]
toSet [1,2,3,2,1]
-- [3,2,1]
toSet [5]
-- [5]
toSet []
-- []
```

The order of the output values may appear different than expected, but since the order of elements in a set is unimportant, this function prioritises performance over preserving order.

```hs
toSet [1,9,2,8,9,1,7,3,4,1,9,5,6,2,4]
-- [8,7,3,1,9,5,6,2,4]
```

This is equivalent to the mathematical expression:

$$ \set{1,9,2,8,9,1,7,3,4,1,9,5,6,2,4} = \set{8,7,3,1,9,5,6,2,4} $$

### `cartesianProduct`
```hs
cartesianProduct :: Set a -> Set b -> Set (a, b)
```

Calculates the cartesian product of 2 sets, $A \times B$.

```hs
cartesianProduct (toSet [1,2,1,3]) (toSet "abba")
[(2,'b'),(2,'a'),(1,'b'),(1,'a'),(3,'b'),(3,'a')]
```