extends CanvasLayer

var pontos := 0

func _ready() -> void:
	Sinais.pontos_alterados.connect(_on_pontos_alterados)
	Sinais.vidas_alteradas.connect(_on_vidas_alteradas)
	Sinais.jogador_morreu.connect(_on_jogador_morreu)
	_atualizar_pontos()

func _on_pontos_alterados(valor: int) -> void:
	pontos += valor
	_atualizar_pontos()

func _atualizar_pontos() -> void:
	$Pontuacao.text = "Pontos: %d" % pontos

func _on_vidas_alteradas(vidas: int) -> void:
	$Vidas.text = "Vidas: %d" % vidas

func _on_jogador_morreu() -> void:
	Sinais.ultima_pontuacao = pontos
	get_tree().change_scene_to_file("res://cenas/game_over.tscn")
