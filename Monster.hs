module Monster(Monster(Monster), create_monsters_list) where

data Monster = Monster{ name :: String,
                        dmg :: Integer,
                        hp :: Integer,
                        armor :: Integer
                      } deriving(Show, Eq, Ord)

create_monsters_list :: [String]->[String]->[String]->[String]->[Monster]->[Monster]
create_monsters_list [] [] [] [] rs = reverse rs
create_monsters_list ns ds hs as rs = do
  let monster = Monster (head ns) (read (head ds) :: Integer) (read (head hs) :: Integer) (read (head as) :: Integer)
  let list = monster:rs -- ++ create_Rooms_list (tail xs) (tail ys)
  create_monsters_list (tail ns) (tail ds) (tail hs) (tail as) list
