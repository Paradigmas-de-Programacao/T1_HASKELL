import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import Tree(Tree(Null,Node), buildTree)
import Game
import System.Process
import System.IO
import Data.Char

clear = system "clear"
file_barb = "Map.txt"
file_arc = "Map2.txt"
file_hunt = "Map3.txt"
play_again = "Deseja jogar novamente ? (1- SIM\n2-NAO\n)"
goodbye = "Ate a proxima, aventureiro !"

menu :: IO()
menu = do
  putStrLn "===================================================";
  putStrLn "Bem-Vindo Viajante, ao Diablo 3 - Haskell Version !\n Antes de começarmos a aventura, precisamos de uma informação importante:\n";
  putStrLn "Com qual classe deseja jogar ?\n 1 - Bárbaro\n 2 - Arcanista\n 3 - Caçador de Demônios ";
  option <- getLine;
  case option of
    "1" -> main_barb
    "2" -> main_arc
    "3" -> main_hunt

main_barb = do
  clear
  history <- fmap Text.lines (Text.readFile file_barb)

  let rpgMaps = buildTree history
  walk rpgMaps
  putStrLn play_again
  playAgain <- readLn
  if (playAgain == 1) then (menu) else putStrLn goodbye

main_arc = do
  clear
  history <- fmap Text.lines (Text.readFile file_arc)

  let rpgMaps = buildTree history
  walk rpgMaps
  putStrLn play_again
  playAgain <- readLn
  if (playAgain == 1) then (menu) else putStrLn goodbye

main_hunt = do
  clear
  history <- fmap Text.lines (Text.readFile file_hunt)

  let rpgMaps = buildTree history
  walk rpgMaps
  putStrLn play_again
  playAgain <- readLn
  if (playAgain == 1) then (menu) else putStrLn goodbye
