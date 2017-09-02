module Battle(randomATK, compareAttack, player_damaged, monster_damaged, fight, detWinner) where

import System.IO
import System.Random
import System.Process
import Control.Monad
import Data.String
import Room
import Player
import Monster

clear = system "clear"

--Generates de ATK type where 1 = Power atack, 2 = Technical ATK and 3 = Speed ATK
randomATK :: IO Integer
randomATK = do
  r <- randomRIO (1,3)
  return (r)

--Shows the monster ATK DMG
defineSucessAttackMonster :: Integer -> Player -> Integer -> Monster -> IO()
defineSucessAttackMonster hp_player player hp_monster monster = do
  putStr "O Monstro acertou ! Você levou "
  print (dmg monster -  equipment player)
  putStrLn "de dano"
  detWinner (player_damaged monster player hp_player) player hp_monster monster

--Shows the player ATK DMG
defineSucessAttackPlayer :: Integer -> Player -> Integer -> Monster -> IO()
defineSucessAttackPlayer hp_player player hp_monster monster = do
  putStr "Você acertou ! O monstro levou "
  print (damage player -  armor monster)
  putStrLn "de dano"
  detWinner hp_player player (monster_damaged monster player hp_monster) monster

defineDrawAttack :: Integer -> Player -> Integer -> Monster -> IO()
defineDrawAttack hp_player player hp_monster monster = do
  putStr "Ambos utilizaram o mesmo tipo de ataque! você levou "
  print (dmg monster -  equipment player)
  putStrLn "de dano"
  putStrLn "e o monstro levou "
  print (damage player -  armor monster)
  putStrLn "de dano"
  detWinner hp_player player (monster_damaged monster player hp_monster) monster

-- 1 wins 2 ,2 wins 3, 3 wins 1
-- Attack Option, Monster Attack Option, HP Player, Player, HP Monster, Monster, returns Winner
compareAttack :: Integer -> Integer -> Integer -> Player -> Integer -> Monster -> IO()
compareAttack op_player op_monster hp_player player hp_monster monster = do
  if (op_player < op_monster) then
    -- detWinner (player_damaged monster player hp_player) player hp_monster monster
    defineSucessAttackMonster hp_player player hp_monster monster
    else if(op_player > op_monster) then
      -- detWinner hp_player player (monster_damaged monster player hp_monster) monster
      defineSucessAttackPlayer hp_player player hp_monster monster
      else if (op_player == op_monster) then
        defineDrawAttack hp_player player hp_monster monster
        -- detWinner hp_player player (monster_damaged monster player hp_monster) monster
      else fight hp_player player hp_monster monster

--Shows The type of the monster ATK
detTypeAttackMonster :: Integer -> Integer -> Integer -> Player -> Integer -> Monster -> IO()
detTypeAttackMonster op_player op_monster hp_player player hp_monster monster = do
  if (op_monster == 1) then
    putStrLn "O monstro te deu um power attack !"
    else if (op_monster == 2) then
      putStrLn "O monstro te deu um technical attack !"
        else putStrLn "O monstro te deu um speed attack"
  compareAttack op_player op_monster hp_player player hp_monster monster

-- HP Player, Player, HP Monster, Monster
fight :: Integer -> Player -> Integer -> Monster -> IO()
fight hp_player player hp_monster monster = do
  putStrLn "============================="
  putStr "Player HP: "
  print hp_player
  putStr "Monster HP: "
  print hp_monster
  putStrLn "Escolha seu ataque !\n1 - Power Attack(Axe)\n2 - Technical Attack(Sword)\n3 - Speed Attack(Rapier)"
  putStrLn "============================="
  xs<-randomATK
  attack <- readLn
  compareAttack attack xs hp_player player hp_monster monster
--
--Monster, Player, HP_Player
player_damaged :: Monster -> Player -> Integer -> Integer
player_damaged m p hp_player = (hp_player + (equipment p) - (dmg m))
--
--Monster, Player, HP_Monster
monster_damaged :: Monster -> Player -> Integer -> Integer
monster_damaged m p hp = (hp + (armor m) - (damage p))

--HP_Player, Player, HP_Monster, Monster
detWinner :: Integer -> Player -> Integer -> Monster -> IO()
detWinner hp_player player hp_monster monster = do
  if(hp_player <= 0) then
    putStrLn "Player are death ! You Lose !"
    else if(hp_monster <= 0) then
      putStrLn "You Kill the Enemy ! Success !"
      else fight hp_player player hp_monster monster
