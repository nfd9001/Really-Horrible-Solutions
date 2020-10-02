import Data.Semigroup
import Data.Traversable
import Control.Monad.Compat.Repl (join)

-- make a predicate
p :: Bool -> p -> p -> p
p True x _ = x
p False _ y = y

-- fix issues with semigroup stuff
assist :: (Semigroup (f (Maybe a)), Applicative f) => Maybe a -> f (Maybe a) -> f (Maybe a)
assist = join . (<*>) ((.) . p . fixit) ((<>) . pure)

-- Fix maybe lists
fix :: (Foldable t, Applicative f, Monoid (f (Maybe a))) => t (Maybe a) -> f (Maybe a)
fix = foldr assist mempty

-- Helpers for the main helper
help' :: (Applicative f, Traversable t) => t (Maybe b) -> f b
help  = fixIt . fst . mapAccumR (flip (,)) Nothing
help' = (fixIt <$>) . pure . fst . mapAccumR (flip (,)) Nothing
help2 = (fixIt <$>) . fix . snd . mapAccumR (flip (,)) Nothing

-- Maybe predicate
fixit :: Maybe a -> Bool
fixit Nothing = False
fixit (Just _) = True

-- Fix maybes
fix_it :: Functor f => f a -> f (Maybe a)
fix_it = (Just <$>)

-- Fix maybe
fixIt :: Maybe a -> a
fixIt (Just x) = x

-- Main sorting logic. Through the magic of Haskell, this step of the sort is
-- O(n).
-- If you put the type annotation below, Haskell gives you some warnings.
-- helper :: (Monoid (f Integer), Applicative f) => f (Maybe Integer) -> f Integer
helper xs
    | xs == mempty = mempty
    | help2 xs == mempty = help' xs
    | otherwise = (mappend $ pure a) $ helper $ fix_it $ (pure b) <> rest where 
        x = help xs
        y = (help . fix_it . help2) xs
        a = min x y
        b = max x y
        rest = (help2 . fix_it . help2) xs

-- Do the actual sort by piping the array into pure helper.fix_it
doIt :: (Monad m, Monoid (f Integer), Applicative f) => m a -> m ([Integer] -> f Integer)
doIt = (>> pure (helper.fix_it))


-- Define my list
myList :: [Integer]
myList = [9,8,7,6,5,4,3,2,1,3,5,7,9] 

-- Define the sort.
-- Look how clean and minimal Haskell code is!
sort = foldl (.) id =<< doIt

-- And it sorts correctly!
main = print $ (sort myList)
-- [1,2,3,3,4,5,5,6,7,7,8,9,9]
