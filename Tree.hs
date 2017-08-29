module Tree(Tree(Null,Node),buildTree) where

import System.Process

data Tree t = Null
      | Node t (Tree t) (Tree t)
      deriving (Show, Eq, Ord)

buildTree :: [element] -> Tree.Tree element
buildTree [] = Null

buildTree list = (Node (list !! half)
                  (buildTree $ take half list)
                  (buildTree $ drop (half+1) list))
                  where half = length list `quot` 2
