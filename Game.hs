module Game(walk) where

import Tree(Tree(Null,Node), buildTree)
import System.IO
import Room
import System.Process
import Control.Monad
import Data.String

clear = system "clear"

walk :: Tree.Tree -> IO()
walk (Node element Null Null) = do
  clear
  print element
  -- action element
  putStrLn "Fim da linha."

walk (Node element left right) = do
  clear
  putStrLn (desc element)
  putStrLn "O que deseja fazer ?"
  path <- readLn
  if ((path == 1) && (left /= Null)) then
    (walk(left))
    else if ((path == 2) && (right /= Null)) then
      (walk(right))
      else walk(Node element left right)

fight (Node element left right) = do
  putStrLn "Lute !"

play :: Tree.Tree -> IO()
play (Node element left right) = do
  if (style (element) == "Batalha") then
    fight (Node element left right)
    else walk(Node element left right)
-- action (Node element _ _) = do
  -- if(element == "T") then
    -- print "Texto"
  -- else print "Batalha"
