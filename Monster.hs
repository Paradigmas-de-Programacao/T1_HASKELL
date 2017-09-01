module Monster(Monster(Monster)) where

data Monster = Monster{ name :: String,
                        dmg :: Int,
                        hp :: Int,
                        armor :: Int
                      } deriving(Show, Eq, Ord)

create_monsters_list :: [String]->[Int]->[Int]->[Int]->[Monster]->[Monster]
create_monsters_list [] [] [] [] rs = reverse rs
create_monsters_list ns ds hs as rs = do
  let monster = Monster (head ns) (head ds) (head hs) (head as)
  let list = monster:rs -- ++ create_Rooms_list (tail xs) (tail ys)
  create_monsters_list (tail ns) (tail ds) (tail hs) (tail as) list
