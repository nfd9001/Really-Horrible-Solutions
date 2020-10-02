import Data.List

-- get minimum element
minElem::[Int]->Int
minElem [] = 0
minElem [x] = x
minElem (x:y:xs) 
 |x > y = minElem (y:xs)
 |x < y = minElem (x:xs)
 |x == y = minElem (x:xs)

-- get minimum and add it to the beginning
-- delete minimum from original list
-- repeat first two steps
sorter :: [Int] -> [Int]
sorter [] = []
sorter [x] = [x]
sorter list = (minElem list):(sorter (delete (minElem list) list))

myList :: [Int]
myList = [8,5,7,1,9,2,9,3,1,4]

main = print $ (sorter myList)
