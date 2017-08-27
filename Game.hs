module Game(walk) where

import Tree(Tree(Null,Node),
            Marker(LeftMarker,RightMarker),
            goLeft,
            goRight,
            )
import System.IO
import Control.Monad

walk :: Tree t-> Marker a -> IO()
walk Null  = putStrLn "Sala Vazia!"
walk (Node x left right, [a]) = do {

  putStrLn x;

	option <- getLine;
	case option of
	"1" -> walk(goLeft(left, [LeftMarker t]));
	"2" -> walk(goRight( right, [RightMarker t]));
}
