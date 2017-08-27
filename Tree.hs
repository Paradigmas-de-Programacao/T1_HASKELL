module Tree(Tree(Null,Node), Marker(LeftMarker,RightMarker), goLeft, goRight) where

data Tree t = Null | Node t (Tree t) (Tree t) deriving (Show)
data Marker t = LeftMarker t (Tree t) | RightMarker t (Tree t) deriving (Show)

type DirectionMarker t = [Marker t]

goLeft :: (Tree t, DirectionMarker t) -> (Tree t, DirectionMarker t)
goLeft (Node x l r, bs) = (l, LeftMarker x r:bs)

goRight :: (Tree t, DirectionMarker t) -> (Tree t, DirectionMarker t)
goRight (Node x l r, bs) = (r, RightMarker x l:bs)

goBack :: (Tree t, DirectionMarker t) -> (Tree t, DirectionMarker t)
goBack (t, LeftMarker x r:bs) = (Node x t r, bs)
goBack (t, RightMarker x l:bs) = (Node x t l, bs)
