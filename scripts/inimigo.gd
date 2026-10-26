extends Area2D

var velocidade = Vector2(0, 0)
var pontos_por_abate = 10
var _tempo := 0.0
var _y_base := 0.0

func _ready() -> void:
	# velocidade horizontal e vertical sorteadas aleatoriamente
	velocidade.x = randf_range(-400, -120)
	velocidade.y = randf_range(-60, 60)
	_y_base = position.y

func _process(delta: float) -> void:
	_tempo += delta
	position.x += velocidade.x * delta
	# movimento em zig-zag: soma um seno ao deslocamento vertical
	position.y += velocidade.y * delta + sin(_tempo * 5.0) * 1.2

	# remove o inimigo se ele sair muito da tela
	if position.x < -100:
		queue_free()

func explodir() -> void:
	set_process(false)
	velocidade = Vector2.ZERO
	$CorpoInimigo.set_deferred("disabled", true)  # desabilite a colisão
	$ImagemInimigo.play("explodir")                # dê play na explosão
	Sinais.pontos_alterados.emit(pontos_por_abate)
	await $ImagemInimigo.animation_finished          # espere a explosão acabar
	queue_free()                                      # tire o nó de cena

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":       # se colidiu no jogador
		body.levar_dano()           # reduza suas vidas
		explodir()
