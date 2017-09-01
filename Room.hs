module Room(Room(Room), create_Rooms_list, style, desc) where

import Monster
import System.Process
import System.IO
import Data.Char
import Control.Monad

data Room = Room{ style :: String,
                  desc :: String,
                  monster :: Monster
                } deriving(Show, Eq, Ord)

create_Rooms_list :: [String]->[String]->[Monster]->[Room]->[Room]
create_Rooms_list [] [] [] rs = reverse rs
create_Rooms_list xs ys ms rs = do
  let sala = Room (head xs) (head ys) (head ms)
  let list = sala:rs -- ++ create_Rooms_list (tail xs) (tail ys)
  create_Rooms_list (tail xs) (tail ys) (tail ms) list
