import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import Tree(Tree(Null,Node), buildTree)
import Game
import Room
import System.Process
import System.IO
import Data.Char
import Control.Monad

clear = system "clear"
file_barb_txts = "map_barb.txt"
file_barb_styles = "map_rooms_barb.txt"
file_arc = "map_arc.txt"
file_hunt = "map_hunt.txt"
play_again = "Deseja jogar novamente ? (1- SIM\n2-NAO\n)"
goodbye = "Ate a proxima, aventureiro !"

menu :: IO()
menu = do
  clear
  putStrLn "===================================================";
  putStrLn "Bem-Vindo Viajante, ao RPG - Haskell!\n Antes de começarmos a aventura, precisamos de uma informação importante:\n";
  putStrLn "Com qual classe deseja jogar ?\n 1 - Bárbaro";
  option <- getLine;
  case option of
    "1" -> main_barb
    -- "2" -> main_arc
    -- "3" -> main_hunt

main_barb = do
  clear
  styles <- fmap lines(readFile file_barb_styles)
  txts <- fmap lines (readFile file_barb_txts)
  let rpgMaps = buildTree (create_Rooms_list styles txts [])
  walk rpgMaps
  putStrLn play_again
  playAgain <- readLn
  if (playAgain == 1) then (menu) else putStrLn goodbye
