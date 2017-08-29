import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import Tree(Tree(Null,Node), buildTree)
import Game
import System.Process
import System.IO
import Data.Char

clear = system "clear"

main = do
  clear
  history <- fmap Text.lines (Text.readFile "Map.txt")
  let rpgMaps = buildTree history
  walk rpgMaps
  putStrLn "Deseja jogar novamente ? (1- SIM\n2-NAO\n)"
  playAgain <- readLn
  if (playAgain == 1) then (main) else putStrLn ("Ate a proxima, aventureiro !")
