extends CharacterBody2D

const SPEED = 300.0

var vidas = 5
var cena_tiro
var invencivel := false

func _ready() -> void:
	cena_tiro = preload("res://cenas/tiro.tscn")
	Sinais.vidas_alteradas.emit(vidas)

func _physics_process(delta: float) -> void:
	velocity.x = 0
	velocity.y = 0

	if Input.is_action_pressed("ui_left"):
		velocity.x = -1 * SPEED
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1 * SPEED
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1 * SPEED
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1 * SPEED

	move_and_slide()

	if Input.is_action_just_pressed("ui_accept"):
		atirar()

func atirar() -> void:
	var tiro = cena_tiro.instantiate()
	tiro.position.y = position.y
	tiro.position.x = position.x + 60
	get_parent().add_child(tiro)

func levar_dano() -> void:
	if invencivel:
		return

	vidas -= 1
	Sinais.vidas_alteradas.emit(vidas)

	if vidas <= 0:
		Sinais.jogador_morreu.emit()
	else:
		# breve período de invencibilidade para não perder várias vidas de uma vez
		invencivel = true
		$ImagemPlayer.modulate.a = 0.4
		await get_tree().create_timer(1.0).timeout
		$ImagemPlayer.modulate.a = 1.0
		invencivel = false
