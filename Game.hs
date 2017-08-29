module Game(walk) where

import Tree(Tree(Null,Node), buildTree)
import System.IO
import System.Process
import Control.Monad
import Data.String

clear = system "clear"

walk :: (Eq element, Show element) => Tree element -> IO()
walk (Node element Null Null) = do
  clear
  print element
  putStrLn "Não há passagens adiante. Fim da linha."

walk (Node element left right) = do
  clear
  print element
  putStrLn "O que deseja fazer ?"
  path <- readLn
  if ((path == 1) && (left /= Null)) then
    (walk(left))
    else if ((path == 2) && (right /= Null)) then
      (walk(right))
      else walk(Node element left right)
