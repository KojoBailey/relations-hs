# Relations - Haskell
Having had an introduction to mathematical **relations** in my Computer Science course, I figured it'd be good to implement as many of the concepts that I've learned as I can.

This is programmed in the **Haskell** language partly due to it also being in my course, but also because I find it to be fitting for mathemtical things such as this.

My code is neither optimal in performance nor readability, but it does seem to function as intended.

> [NOTE]
> Since **unary** relations exist, it's worth noting that this project specifically focuses on **binary relations**. Maybe if I can figure out applicatives and whatnot, I can extend this to support all tiers of relations.

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

### `BinaryMatrix`
```hs
type BinaryMatrix = [[Int]]
```

A 2-dimensional array of 1s and 0s.

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
-- [(2,'b'),(2,'a'),(1,'b'),(1,'a'),(3,'b'),(3,'a')]
```

This is equivalent to the mathematical expression:

$$ \set{2,1,3} \times \set{\text{b},\text{a}} = \set{(2,\text{b}),(2,\text{a}),(1,\text{b}),(1,\text{a}),(3,\text{b}),(3,\text{a})} $$

### `relationOnPairs`
```hs
relationOnPairs :: Relation a b -> Set (a, b) -> Set (a, b)
```

Applies a relation to cartesian product - a set of pairs.

```hs
relationOnPairs (\(x, y) -> x > y) [(1, 3), (3, 1), (4, 2), (6, 7), (8, 5)]
-- [(3,1),(4,2),(8,5)]
```

This is equivalent to the mathematical expression:

$$ R = \set{(x, y) | x > y} $$
$$ R \subseteq \set{(1, 3), (3, 1), (4, 2), (6, 7), (8, 5)} = \set{(3,1),(4,2),(8,5)} $$

### `relationOnSet`
```hs
relationOnSet :: Relation a a -> Set a -> Set (a, a)
```

Applies a relation from a set to itself.

```hs
relationOnSet (\(x, y) -> x > y) [1..3]
-- [(2,1),(3,1),(3,2)]
```

This is equivalent to the mathematical expression:

$$ R = \set{(x, y) | x > y} $$
$$ A = \set{1, 2, 3} $$
$$ R \subseteq A \times A = \set{(2,1),(3,1),(3,2)} $$

### `extrapolateSetFromPairs`
```hs
extrapolateSetFromPairs :: Eq a => Set (a, a) -> Set a
```

Takes a set of pairs and extracts their unique elements.

```hs
extrapolateSetFromPairs [(1,2), (2,1), (3,4), (3,2)]
-- [1,4,3,2]
```
### `isReflexive`
```hs
isReflexive :: Eq a => Set (a, a) -> Bool
```

Checks if a set is reflexive.

```hs
isReflexive [(1,1), (2,3)]
-- False
isReflexive [(1,1), (2,3), (2,2), (3,3)]
-- True
isReflexive $ relationOnSet (\(x, y) -> x == y) [1..5]
-- True
```

### `isSymmetric`
```hs
isSymmetric :: Eq a => Set (a, a) -> Bool
```

Checks if a set is symmetric.

```hs
isSymmetric [(1,1), (2,3), (1,4)]
-- False
isSymmetric [(1,1), (2,3), (1,4), (3,2), (4,1)]
-- True
isSymmetric $ relationOnSet (\(x, y) -> x /= y) [1..5]
-- True
```

### `isAntiSymmetric`
```hs
isAntiSymmetric :: Eq a => Set (a, a) -> Bool
```

Checks if a set is anti-symmetric (not to be mistaken as the opposite of symmetric!).

```hs
isAntiSymmetric [(1,1), (2,3), (1,4)]
-- True
isAntiSymmetric [(1,1), (2,3), (1,4), (3,2)]
-- False
isAntiSymmetric $ relationOnSet (\(x, y) -> x /= y) [1..5]
-- False
```

### `isTransitive`
```hs
isTransitive :: Eq a => Set (a, a) -> Bool
```

Checks if a set is transitive.

```hs
isTransitive [(1,2), (2,3)]
-- False
isTransitive [(1,2), (2,3), (1,3)]
-- True
isTransitive $ relationOnSet (\(x, y) -> x > y) [1..5]
-- True
```

### `isEquivalenceRelation`
```hs
isEquivalenceRelation :: Eq a => Set (a, a) -> Bool
```

Checks if a set is reflexive, symmetric, and transitive.

```hs
isEquivalenceRelation $ [(1,1), (1,2), (2,1), (2,2), (1,3), (3,1), (3,3), (2,3), (3,2)]
-- True
isEquivalenceRelation $ relationOnSet (\(x, y) -> x == y) [1..5]
-- True
```

### `isPartialOrder`
```hs
isPartialOrder :: Eq a => Set (a, a) -> Bool
```

Checks if a set is reflexive, anti-symmetric, and transitive.

```hs
isPartialOrder $ [(1,1), (1,2), (2,2), (1,3), (3,3), (2,3)]
-- True
isPartialOrder $ relationOnSet (\(x, y) -> x >= y) [1..5]
-- True
```

### `transitiveClosure`
```hs
transitiveClosure :: Eq a => Set (a, a) -> Set (a, a)
```

Produces the transitive closure of a set, making a non-transitive set transitive.

```hs
let set = [(1,1), (1,2), (2,1), (1,3), (3,1)]
isTransitive set
-- False
let newSet = transitiveClosure $ [(1,1), (1,2), (2,1), (1,3), (3,1)]
print newSet
-- [(1,1),(1,2),(2,1),(1,3),(3,1),(2,2),(2,3),(3,2),(3,3)]
isTransitive newSet
-- True
```

### `binaryMatrixRelation`
```hs
binaryMatrixRelation :: (Eq a, Eq b) => Relation a b -> Set a -> Set b -> BinaryMatrix
```

Turns the relation between two sets into its binary matrix representation.

```hs
let r = (\(x, y) -> x > y)
let setA = [2,3,4]
let setB = [1,2,3]

relationOnPairs r (cartesianProduct setA setB)
-- [(2,1),(3,1),(3,2),(4,1),(4,2),(4,3)]
binaryMatrixRelation r setA setB
-- [[1,1,1],[0,1,1],[0,0,1]]
```

If this were to be represented in mathematically with a 2D matrix:

$$ R = \set{(x, y) | x > y} $$
$$ A = \set{2,3,4} $$
$$ B = \set{1,2,3} $$
$$ R \subseteq A \times B = \begin{bmatrix}
1 & 1 & 1 \\
0 & 1 & 1 \\
0 & 0 & 1
\end{bmatrix} $$
$$ = \set{(2,1),(3,1),(4,1),(3,2),(4,2),(4,3)} $$

It may also help to see it as a table:

| $\times$ | **2** | **3** | **4** |
| -------- | ----- | ----- | ----- |
| **1**    | 1     | 1     | 1     |
| **2**    | 0     | 1     | 1     |
| **3**    | 0     | 0     | 1     |