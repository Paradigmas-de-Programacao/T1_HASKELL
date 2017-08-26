import Tree(Tree(Null,Node))

descRoom :: Tree t -> [Char]
descRoom Null = "Sala Vazia"
descRoom (Node x esq dir) = x
