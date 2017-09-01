import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import Tree(Tree(Null,Node), buildTree)
import Game
import Room
import System.Process
import System.IO
import Data.Char
import Control.Monad
import Monster

clear = system "clear"
--Monsters data
file_mobs_name = "Mobs_Data/file_mobs_name.txt"
file_mobs_dmg = "Mobs_Data/file_mobs_dmg.txt"
file_mobs_hp = "Mobs_Data/file_mobs_hp.txt"
file_mobs_armor = "Mobs_Data/file_mobs_armor.txt"
--Player Classes
file_barb_txts = "Maps/map_barb.txt"
file_barb_styles = "Maps/map_rooms_barb.txt"

file_arc_txts = "Maps/map_arc.txt"
file_arc_styles = "Maps/map_rooms_arc.txt"

file_hunt_txts = "Maps/map_hunt.txt"
file_hunt_styles = "Maps/map_rooms_hunt.txt"
--Menu
play_again = "Deseja jogar novamente ? (1- SIM\n2-NAO\n)"
goodbye = "Ate a proxima, aventureiro !"

menu :: IO()
menu = do
  clear
  putStrLn "===================================================\n";
  putStrLn "Bem-Vindo Viajante, ao RPG - Haskell!\nAntes de começarmos a aventura, precisamos de uma informação importante:\n";
  putStrLn "===================================================\n";
  putStrLn "Com qual classe deseja jogar ?\n1- Bárbaro\n2- Arcano\n3- Demon hunter\n";
  option <- getLine;
  case option of
    "1" -> main_barb
    "2" -> main_arc
    "3" -> main_hunt

main_barb = do
  clear

  mobs_name <- fmap lines(readFile file_mobs_name)
  mobs_dmg <- fmap lines(readFile file_mobs_dmg)
  mobs_hp <- fmap lines(readFile file_mobs_hp)
  mobs_armor <- fmap lines(readFile file_mobs_armor)

  styles <- fmap lines(readFile file_barb_styles)
  txts <- fmap lines (readFile file_barb_txts)

  let monsters = create_monsters_list mobs_name mobs_dmg mobs_hp mobs_armor []
  let rpgMaps = buildTree (create_Rooms_list styles txts monsters [])
  walk rpgMaps
  putStrLn play_again
  playAgain <- readLn
  if (playAgain == 1) then (menu) else putStrLn goodbye

main_arc = do
  clear

  mobs_name <- fmap lines(readFile file_mobs_name)
  mobs_dmg <- fmap lines(readFile file_mobs_dmg)
  mobs_hp <- fmap lines(readFile file_mobs_hp)
  mobs_armor <- fmap lines(readFile file_mobs_armor)

  styles <- fmap lines(readFile file_arc_styles)
  txts <- fmap lines (readFile file_arc_txts)
  let monsters = create_monsters_list mobs_name mobs_dmg mobs_hp mobs_armor []
  let rpgMaps = buildTree (create_Rooms_list styles txts monsters [])
  walk rpgMaps
  putStrLn play_again
  playAgain <- readLn
  if (playAgain == 1) then (menu) else putStrLn goodbye

main_hunt = do
  clear

  mobs_name <- fmap lines(readFile file_mobs_name)
  mobs_dmg <- fmap lines(readFile file_mobs_dmg)
  mobs_hp <- fmap lines(readFile file_mobs_hp)
  mobs_armor <- fmap lines(readFile file_mobs_armor)

  styles <- fmap lines(readFile file_hunt_styles)
  txts <- fmap lines (readFile file_hunt_txts)
  let monsters = create_monsters_list mobs_name mobs_dmg mobs_hp mobs_armor []
  let rpgMaps = buildTree (create_Rooms_list styles txts monsters [])
  walk rpgMaps
  putStrLn play_again
  playAgain <- readLn
  if (playAgain == 1) then (menu) else putStrLn goodbye
