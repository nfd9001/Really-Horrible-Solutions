import Data.Semigroup
import Data.Traversable
import Control.Monad.Compat.Repl (join)

p True x _ = x
p False _ y = y

isOk Nothing = False
isOk (Just _) = True

assist = join . (<*>) ((.) . p . isOk) ((<>) . pure)

help = fix . fst . mapAccumR (flip (,)) Nothing
help' = (fix <$>) . pure . fst . mapAccumR (flip (,)) Nothing
help2 = (fix <$>) . (foldr assist mempty) . snd . mapAccumR (flip (,)) Nothing

aid = (Just <$>)

fix (Just x) = x

support xs
    | xs == mempty = mempty
    | help2 xs == mempty = help' xs
    | otherwise = mappend ((mappend $ pure a) . support . aid . pure $ b) rest where 
        x = help xs
        y = (help . aid . help2) xs
        a = min x y
        b = max x y
        rest = (help2 . aid . help2) xs

helper = (>> pure (support . aid))

sort = foldl (.) id =<< helper

main = print $ ((sort [9,8,7,6,5,4,3,2,1,3,5,7,9]) :: [Integer])
