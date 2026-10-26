extends Node2D

var cena_inimigo

## Tempo mínimo (em segundos) que o timer pode atingir, mesmo com a
## dificuldade aumentando ao longo do jogo.
@export var tempo_minimo := 0.4

## O quanto o tempo de espera diminui a cada inimigo gerado.
@export var reducao_por_inimigo := 0.05

func _ready() -> void:
	cena_inimigo = preload("res://cenas/inimigo.tscn")

func _on_timer_timeout() -> void:
	var inimigo = cena_inimigo.instantiate()
	inimigo.position = Vector2(
		1200,
		randf_range(50, 600)
	)
	add_child(inimigo)

	# Exercício do tutorial: reduz o tempo de espera do timer ao longo do
	# jogo, sem deixar que ele fique menor que tempo_minimo.
	if $Timer.wait_time > tempo_minimo:
		$Timer.wait_time = max(tempo_minimo, $Timer.wait_time - reducao_por_inimigo)
