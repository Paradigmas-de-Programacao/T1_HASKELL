module Game(walk) where

import Tree
import System.IO
import System.Random
import System.Process
import Control.Monad
import Data.String
import Room
import Player
import Monster
-- import Battle

clear = system "clear"

decision_room :: Tree.Tree -> Integer -> IO()
decision_room (Node element Null Null) classe = do
  clear
  putStrLn (desc element)
  putStrLn "Fim da linha."

decision_room (Node element left right) classe = do
  clear
  if(desc (returnRoom left) == "Null") then
    decision_room (Node element Null Null) classe
    else do
      putStrLn (desc element)
      putStrLn "O que deseja fazer ?"
      path <- readLn
      if ((path == 1) && (left /= Null)) then
        (walk left classe)
        else if ((path == 2) && (right /= Null)) then
          (walk right classe)
          else walk(Node element left right) classe

-- All battle rooms must have two fix possibilities:
-- Victory are left Room and Loses are right Room
fight_room (Node element left right) classe = do
  clear
  putStrLn (desc element)
  if(classe == 1) then
    fight (Node element left right) 500 (Player 500 150 50) (hp(monster element)) (monster element)
    else if(classe == 2) then
      fight (Node element left right) 400 (Player 400 200 30) (hp(monster element)) (monster element)
      else fight (Node element left right) 400 (Player 400 200 40) (hp(monster element)) (monster element)
--
walk :: Tree.Tree -> Integer -> IO()
walk (Node element left right) classe = do
  if (style (element) == "Batalha") then
    fight_room (Node element left right) classe
    else decision_room(Node element left right) classe

--Monsters Art
file_bat_monster = "Mobs_imgs/bat.txt"
file_diablo_monster = "Mobs_imgs/diablo.txt"
file_minotaur_monster = "Mobs_imgs/minotaur.txt"
file_orc_monster = "Mobs_imgs/orc.txt"

renderMonster :: String -> IO()
renderMonster m = do
  handle <- openFile m ReadMode
  contents <- hGetContents handle
  putStr contents
  hClose handle

--Generates de ATK type where 1 = Power atack, 2 = Technical ATK and 3 = Speed ATK
randomATK :: IO Integer
randomATK = do
  r <- randomRIO (1,3)
  return (r)

--Shows the monster ATK DMG
defineSucessAttackMonster :: Tree.Tree -> Integer -> Player -> Integer -> Monster -> IO()
defineSucessAttackMonster (Node element left right) hp_player player hp_monster monster = do
  putStr "O Monstro acertou ! Você levou "
  print (dmg monster -  equipment player)
  putStrLn "de dano"
  detWinner (Node element left right) (player_damaged monster player hp_player) player hp_monster monster

--Shows the player ATK DMG
defineSucessAttackPlayer :: Tree.Tree -> Integer -> Player -> Integer -> Monster -> IO()
defineSucessAttackPlayer (Node element left right) hp_player player hp_monster monster = do
  putStr "Você acertou ! O monstro levou "
  print (damage player -  armor monster)
  putStrLn "de dano"
  detWinner (Node element left right) hp_player player (monster_damaged monster player hp_monster) monster

defineDrawAttack :: Tree.Tree -> Integer -> Player -> Integer -> Monster -> IO()
defineDrawAttack (Node element left right) hp_player player hp_monster monster = do
  putStr "Ambos utilizaram o mesmo tipo de ataque! você levou "
  print (dmg monster -  equipment player)
  putStrLn "de dano"
  putStrLn "e o monstro levou "
  print (damage player -  armor monster)
  putStrLn "de dano"
  detWinner (Node element left right) hp_player player (monster_damaged monster player hp_monster) monster

-- 1 wins 2 ,2 wins 3, 3 wins 1
-- Attack Option, Monster Attack Option, HP Player, Player, HP Monster, Monster, returns Winner
compareAttack :: Tree.Tree -> Integer -> Integer -> Integer -> Player -> Integer -> Monster -> IO()
compareAttack (Node element left right) op_player op_monster hp_player player hp_monster monster = do
  if (op_player < op_monster) then
    -- detWinner (player_damaged monster player hp_player) player hp_monster monster
    defineSucessAttackMonster (Node element left right) hp_player player hp_monster monster
    else if(op_player > op_monster) then
      -- detWinner hp_player player (monster_damaged monster player hp_monster) monster
      defineSucessAttackPlayer (Node element left right) hp_player player hp_monster monster
      else if (op_player == op_monster) then
        defineDrawAttack (Node element left right) hp_player player hp_monster monster
        -- detWinner hp_player player (monster_damaged monster player hp_monster) monster
      else fight (Node element left right) hp_player player hp_monster monster

--Shows The type of the monster ATK
detTypeAttackMonster :: Tree.Tree -> Integer -> Integer -> Integer -> Player -> Integer -> Monster -> IO()
detTypeAttackMonster (Node element left right) op_player op_monster hp_player player hp_monster monster = do
  if (op_monster == 1) then
    putStrLn "O monstro te deu um power attack !"
    else if (op_monster == 2) then
      putStrLn "O monstro te deu um technical attack !"
        else putStrLn "O monstro te deu um speed attack"
  compareAttack (Node element left right) op_player op_monster hp_player player hp_monster monster

-- HP Player, Player, HP Monster, Monster
fight :: Tree.Tree -> Integer -> Player -> Integer -> Monster -> IO()
fight (Node element left right) hp_player player hp_monster monster = do

  if (name monster == "Morcego") then
    renderMonster file_bat_monster
    else if(name monster == "Diablo") then
      renderMonster file_diablo_monster
      else if(name monster == "Minotaur") then
        renderMonster file_minotaur_monster
        else if(name monster == "Orc") then
          renderMonster file_orc_monster
          else putStrLn "SEM IMAGEM"

  putStrLn "============================="
  putStr "Monster's Name: "
  print (name monster)
  putStr "Monster's HP: "
  print hp_monster
  putStrLn "============================="
  putStrLn "            -                "
  putStrLn "============================="
  putStr "Player's HP: "
  print hp_player
  putStr "Player's Equipment: "
  print (equipment player)
  putStrLn "============================="
  putStrLn "Escolha seu ataque !\n1 - Power Attack(Axe)\n2 - Technical Attack(Sword)\n3 - Speed Attack(Rapier)"
  putStrLn "============================="
  xs<-randomATK
  attack <- readLn
  compareAttack (Node element left right) attack xs hp_player player hp_monster monster

--Monster, Player, HP_Player
player_damaged :: Monster -> Player -> Integer -> Integer
player_damaged m p hp_player = (hp_player + (equipment p) - (dmg m))
--
--Monster, Player, HP_Monster
monster_damaged :: Monster -> Player -> Integer -> Integer
monster_damaged m p hp = (hp + (armor m) - (damage p))

--HP_Player, Player, HP_Monster, Monster
detWinner :: Tree.Tree -> Integer -> Player -> Integer -> Monster -> IO()
detWinner (Node element left right) hp_player player hp_monster monster = do
  if(hp_player <= 0) then
    walk right 1
    else if(hp_monster <= 0) then
      walk left 2
      else fight (Node element left right) hp_player player hp_monster monster
