module Tree(Tree(Null,Node)) where

data Tree t = Null | Node [Char] (Tree t) (Tree t) deriving (Show)

-- data Direction = L | R deriving (Show)
-- type Directions = [Direction]

data Crumb t = LeftCrumb t (Tree t) | RightCrumb t (Tree t) deriving (Show)

type Breadcrumbs t = [Crumb t]

goLeft :: (Tree t, Breadcrumbs t) -> (Tree t, Breadcrumbs t)
goLeft (Node x l r, bs) = (l, LeftCrumb x r:bs)

goRight :: (Tree t, Breadcrumbs t) -> (Tree t, Breadcrumbs t)
goRight (Node x l r, bs) = (r, RightCrumb x l:bs)

goUp :: (Tree t, Breadcrumbs t) -> (Tree t, Breadcrumbs t)
goUp (t, LeftCrumb x r:bs) = (Node x t r, bs)
goUp (t, RightCrumb x l:bs) = (Node x t l, bs)
