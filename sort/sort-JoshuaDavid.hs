import Data.Semigroup
import Data.Traversable
import Control.Monad.Compat.Repl (join)

p True x _ = x
p False _ y = y

assist = join . (<*>) ((.) . p . fixBool) ((<>) . pure)

fix = foldr assist mempty

help = service . fst . mapAccumR (flip (,)) Nothing
help' = (service <$>) . pure . fst . mapAccumR (flip (,)) Nothing
help2 = (service <$>) . fix . snd . mapAccumR (flip (,)) Nothing

fixBool Nothing = False
fixBool (Just _) = True

fix_it = (Just <$>)

service (Just x) = x

helper xs
    | xs == mempty = mempty
    | help2 xs == mempty = help' xs
    | otherwise = (mappend $ pure a) $ helper $ fix_it $ (pure b) <> rest where 
        x = help xs
        y = (help . fix_it . help2) xs
        a = min x y
        b = max x y
        rest = (help2 . fix_it . help2) xs

fixIt = (>> pure (helper.fix_it))
sort = foldl (.) id =<< fixIt

main = print $ ((sort [9,8,7,6,5,4,3,2,1,3,5,7,9]) :: [Integer])
