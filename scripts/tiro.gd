extends Area2D

var velocidade = 700

func _process(delta: float) -> void:
	position.x += velocidade * delta
	if position.x > 1200:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("inimigo"):
		area.explodir()     # chama a função explodir
		queue_free()         # remove o tiro, ele não atravessa
