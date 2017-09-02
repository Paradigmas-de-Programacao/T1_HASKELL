module Battle(randomATK, compareAttack, player_damaged, monster_damaged, fight, detWinner) where

import System.IO
import System.Random
import System.Process
import Control.Monad
import Data.String
import Room
import Player
import Monster

--Generates de ATK type where 1 = Power atack, 2 = Technical ATK and 3 = Speed ATK
randomATK :: IO Integer
randomATK = do
  r <- randomRIO (1,3)
--rs <- randomATK(n-1)
  return (r)

-- 1 wins 2 ,2 wins 3, 3 wins 1
-- Attack Option, Monster Attack Option, HP Player, Player, HP Monster, Monster, returns Winner
compareAttack :: Integer -> Integer -> Integer -> Player -> Integer -> Monster -> IO()
compareAttack op_player op_monster hp_player player hp_monster monster = do
  if (op_player < op_monster) then
    detWinner (player_damaged monster player hp_player) player hp_monster monster
    -- putStrLn "Monstro acertou!"
    else if(op_player > op_monster) then
      detWinner hp_player player (monster_damaged monster player hp_monster) monster
      -- putStrLn "Player acertou!"
      else fight hp_player player hp_monster monster
      -- else putStrLn "Empate"

-- HP Player, Player, HP Monster, Monster
fight :: Integer -> Player -> Integer -> Monster -> IO()
fight hp_player player hp_monster monster = do
  putStrLn "Player HP: \t\t\tMonster HP: "
  print hp_player
  putStrLn "Escolha seu ataque !\n"
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
