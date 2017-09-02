module Game(walk) where

import Tree(Tree(Null,Node), buildTree)
import System.IO
import System.Random
import System.Process
import Control.Monad
import Data.String
import Room
import Player
import Monster
import Battle

clear = system "clear"

decision_room :: Tree.Tree -> Integer -> IO()
decision_room (Node element Null Null) classe = do
  clear
  putStrLn (desc element)
  putStrLn "Fim da linha."

decision_room (Node element left right) classe = do
  clear
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
  if(classe == 1) then
    fight 150 (Player 500 150 50) (hp(monster element)) (monster element)
    else if(classe == 2) then
      fight 400 (Player 400 200 30) (hp(monster element)) (monster element)
      else fight 400 (Player 400 200 40) (hp(monster element)) (monster element)

walk :: Tree.Tree -> Integer -> IO()
walk (Node element left right) classe = do
  if (style (element) == "Batalha") then
    fight_room (Node element left right) classe
    else decision_room(Node element left right) classe
