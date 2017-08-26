module Game(loop) where

import Tree(Tree(Null,Node))
import System.IO
import Control.Monad

loop :: Tree t -> IO()
loop Null  = putStrLn "Sala Vazia"
loop (Node x esq dir) = do {
      putStrLn x;

      opcao <- getLine;
      case opcao of "1" -> loop(esq);
			"2" -> loop(dir);
}
