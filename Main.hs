type Set a = [a]

type Relation a b = ((a, b) -> Bool)

toSet :: Eq a => [a] -> Set a
toSet [] = []
toSet (x:xs) = if x `elem` xs then toSet xs else x : toSet xs

cartesianProduct :: Set a -> Set b -> Set (a, b)
cartesianProduct set1 set2 = [(x, y) | x <- set1, y <- set2]

relationOnPairs :: Relation a b -> Set (a, b) -> Set (a, b)
relationOnPairs relation pairs = [x | x <- pairs, relation x]

relationOnSet :: Relation a a -> Set a -> Set (a, a)
relationOnSet relation set = relationOnPairs relation (cartesianProduct set set)

extrapolateSetFromPairs :: Eq a => Set (a, a) -> Set a
extrapolateSetFromPairs pairs = toSet $ foldr (\(x, y) acc -> x : y : acc) [] pairs

isReflexive :: Eq a => Set (a, a) -> Bool
isReflexive pairs = all (\x -> (x, x) `elem` pairs) set
  where set = extrapolateSetFromPairs pairs

isSymmetric :: Eq a => Set (a, a) -> Bool
isSymmetric pairs = all (\(x, y) -> (y, x) `elem` pairs) pairs

isAntiSymmetric :: Eq a => Set (a, a) -> Bool
isAntiSymmetric pairs = all (\(x, y) -> x == y || (y, x) `notElem` pairs) pairs

isTransitive :: Eq a => Set (a, a) -> Bool
isTransitive pairs = all (\(x1, y1) -> all (\(x2, y2) -> y1 /= x2 || (x1, y2) `elem` pairs) pairs) pairs