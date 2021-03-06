module Tree(Tree(Null,Node),buildTree, returnRoom) where

import Room
import Monster
import System.Process

data Tree = Null
      | Node Room (Tree) (Tree)
      deriving (Show, Eq, Ord)

buildTree :: [Room]-> Tree.Tree
buildTree [] = Null

buildTree list = (Node (list !! half)
                 (buildTree $ take half list)
                 (buildTree $ drop (half+1) list))
                  where half = length list `quot` 2

returnRoom :: Tree.Tree -> Room
returnRoom (Node element left right) = element
