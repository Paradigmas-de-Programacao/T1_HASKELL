module Tree(Tree(Null,Node)) where

-- import Room

data Tree t = Null
        | Node [Char] (Tree t) (Tree t)
