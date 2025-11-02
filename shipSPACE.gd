extends Sprite2D

var velocity=Vector2()
@onready var cooldown = $cooldown
@export var bullet:PackedScene
@export var max_speed=100
@export var speed_incr=10
@export var drag=0.1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func heading_vector():
	return Vector2.from_angle(deg_to_rad(rotation_degrees))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("forward"):
		if velocity.length()<max_speed:
			velocity+=heading_vector()*speed_incr*delta
	else:
		velocity*=1-drag*delta
	position+=velocity*delta
	rotation=(get_global_mouse_position()-position).angle()		
	if Input.is_action_pressed("shoot"):
		if cooldown.is_stopped():
			var sulkin_spellkin:Bullet = bullet.instantiate()
			sulkin_spellkin.rotation=rotation
			sulkin_spellkin.position = position
			get_tree().root.add_child(sulkin_spellkin)
			cooldown.start()
