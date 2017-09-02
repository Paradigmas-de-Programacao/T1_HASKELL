module Player(Player(Player), health, damage, equipment) where

import Monster
import System.Process
import System.IO
import Data.Char
import Control.Monad

data Player = Player{ health :: Integer,
                      damage :: Integer,
                      equipment :: Integer
                    } deriving(Show, Eq, Ord)
