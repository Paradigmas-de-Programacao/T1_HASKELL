module Game(walk) where

import Tree(Tree(Null,Node), buildTree)
import System.IO
import System.Random(randomRIO)
import System.Process
import Control.Monad
import Data.String
import Room

clear = system "clear"

decision_room :: Tree.Tree -> IO()
decision_room (Node element Null Null) = do
  clear
  putStrLn (desc element)
  putStrLn "Fim da linha."

decision_room (Node element left right) = do
  clear
  putStrLn (desc element)
  putStrLn "O que deseja fazer ?"
  path <- readLn
  if ((path == 1) && (left /= Null)) then
    (walk(left))
    else if ((path == 2) && (right /= Null)) then
      (walk(right))
      else walk(Node element left right)

-- All battle rooms must have two fix possibilities:
-- Victory are left Room and Loses are right Room
fight_room (Node element left right) = do
  putStrLn "Lute !"
  path <- readLn
  if(path == 1) then
    (walk (left))
    else (walk(right))

walk :: Tree.Tree -> IO()
walk (Node element left right) = do
  if (style (element) == "Batalha") then
    fight_room (Node element left right)
    else decision_room(Node element left right)

--Generates de ATK type where 1 = Power atack, 2 = Technical ATK and 3 = Speed ATK
randomATK :: Int -> IO(Int)
randomATK 0 = return 0
randomATK n  = do
  r <- randomRIO (1,3)
--rs <- randomATK(n-1)
  return (r)
