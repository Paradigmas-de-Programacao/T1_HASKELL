module Game(loop) where

import Tree(Tree(Null,Node))
import System.IO
import Control.Monad

loop :: Tree t -> IO()
loop Null  = putStrLn "Sala Vazia"
loop (Node x esq dir) = do {
      putStrLn x;
      loop (esq);
}
