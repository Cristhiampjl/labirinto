extends Node
## Autoload (Singleton) responsável por centralizar os sinais globais do jogo.
## Assim, Player, Inimigo, Tiro e HUD conseguem se comunicar sem precisar
## se conhecer diretamente.

signal pontos_alterados(pontos: int)
signal vidas_alteradas(vidas: int)
signal jogador_morreu()

## Guarda a última pontuação, usada para exibir na tela de Game Over
var ultima_pontuacao := 0
