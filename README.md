# Paradigmas de Programação - Trabalho 1 Haskell

## Integrantes

|Aluno| Matrícula|
|  -- |    --    |
|Iago Vasconcelos de Carvalho| 15/0011849|
|Caio Felipe Dias Nunes      | 14/0133305|

## Descrição do projeto

### O que é o Haskell RPG?

- A ideia para o desenvolvimento desse projeto era ser capaz de desenvolver uma
aplicação na linguagem haskell utilizando os fundamentos dos paradigmas
funcionais, permitindo o ganho de conhecimento quanto aos conceitos de modularização
de código em haskell, implementação de árvores binárias e recursividade.
- O Haskell RPG foi idealizado como um game que pudesse permitir ao jogador
se aventurar em um mapa ao estilo de um text-based rpg, com combates em turnos.
Com o desenvolvimento do projeto e a maneira que diversos aspectos do
gerenciamento do mapa estava sendo realizada, notamos que seria possível adaptar
o código para que qualquer pessoa pudesse utilizar um arquivo .txt para editar
e criar mapas e monstros, criando assim a sua própria aventura.

### Como foi feito o Haskell RPG?

- O jogo foi desenvolvido a partir da abstração do funcionamento de um mapa onde
o jogador pode seguir por diferentes caminhos  após uma batalha ou sala percorrida, mapeando esses caminhos para uma árvore binária.
- O mapa do jogo é gerado a partir de dois arquivos .txt onde a linha central do arquivo mapa determina a sala inicial do jogo e se uma sala é do tipo batalha, enquanto o outro arquivo passa as descrições, caminhos e monstros
presentes nesse mapa. As salas descritas abaixo ou acima da sala principal correspondem as salas direita e esquerda respectivamente. Cada Sala é passada para um tipo de dado Room, tratada e passada novamente para uma árvore binária.
- A batalha é realizada através de turnos e utiliza um sistema de precedência de ataques para determinar um vencedor.

## Instruções de instalação

- Para a utilização da aplicação é necessário
primeiramente que você possua as dependências do ghci instaladas,
para isso utilize o comando: <br><br>
  $ sudo apt-get install haskell-platform

- Após isso é necessário que vocẽ clone o repositório, entre no diretório T1_Haskell e execute o seguinte comando: <br><br>
  $ ghci Main.hs

- Utilize o comando abaixo para iniciar o jogo:<br><br>
  $ menu
