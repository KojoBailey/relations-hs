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