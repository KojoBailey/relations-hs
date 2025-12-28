type Set a = [a]

type Relation a b = ((a, b) -> Bool)

set :: Eq a => [a] -> Set a
set [] = []
set (x:xs) = if x `elem` xs then set xs else x : set xs

cartesianProduct :: Set a -> Set b -> [(a, b)]
cartesianProduct set1 set2 = [(x, y) | x <- set1, y <- set2]

relationOnPairs :: Relation a b -> [(a, b)] -> [(a, b)]
relationOnPairs relation pairs = [x | x <- pairs, relation x]