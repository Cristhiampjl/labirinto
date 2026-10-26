extends Control

func _ready() -> void:
	$Pontuacao.text = "Pontuação final: %d" % Sinais.ultima_pontuacao

func _on_jogar_novamente_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/jogo.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu.tscn")
