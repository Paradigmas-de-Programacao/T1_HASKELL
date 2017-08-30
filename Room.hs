module Room(Room(Room), create_Rooms_list, style, desc) where

import System.Process
import System.IO
import Data.Char
import Control.Monad

data Room = Room{ style :: String,
                  desc :: String
                } deriving(Show, Eq, Ord)

create_Rooms_list :: [String]->[String]->[Room]->[Room]
create_Rooms_list [] [] rs = reverse rs
create_Rooms_list xs ys rs= do
  let sala = Room (head xs) (head ys)
  let list = sala:rs -- ++ create_Rooms_list (tail xs) (tail ys)
  create_Rooms_list (tail xs) (tail ys) list
