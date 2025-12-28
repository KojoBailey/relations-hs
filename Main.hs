type Set a = [a]

set :: Eq a => [a] -> Set a
set [] = []
set (x:xs) = if x `elem` xs then set xs else x : set xs

cartesianProduct :: Set a -> Set b -> [(a, b)]
cartesianProduct set1 set2 = [(x, y) | x <- set1, y <- set2]