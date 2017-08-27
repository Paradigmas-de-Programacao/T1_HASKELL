module Game(walk) where

import Tree(Tree(Null,Node))
import System.IO
import Control.Monad

walk :: Tree t -> IO()
walk Null  = putStrLn "Sala Vazia!"
walk (Node x left right) = do {

	putStrLn x;

	option <- getLine;
	case option of
	"Back" ->
	"Left" -> walk(left);
	"Right" -> walk(right);
}
