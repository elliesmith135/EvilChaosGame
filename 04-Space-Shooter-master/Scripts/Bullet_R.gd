extends RigidBody2D

export var speed = 500
onready var Explosion = load("res://Scenes/Explosion.tscn")
onready var SpeedUp = load("res://Scenes/SpeedUp.tscn")
onready var ShieldPower = load("res://Scenes/ShieldPower.tscn")
onready var Player = get_node("/root/Game/Player")

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	var colliding = get_colliding_bodies()
	for c in colliding:
		var explosion = Explosion.instance()
		explosion.position = position
		explosion.get_node("Sprite").playing = true
		var speed_up = SpeedUp.instance()
		speed_up.position = position
		var shield_power = ShieldPower.instance()
		shield_power.position = position
		get_node("/root/Game/Explosions").add_child(explosion)
		if c.get_parent().name == "Enemies":
			Player.change_score(c.score)
			c.die()
			var rand = randi()%6+1
			if rand == 1:
				get_node("/root/Game/Power Ups").add_child(speed_up)
			if rand == 2:
				get_node("/root/Game/Power Ups").add_child(shield_power)
		queue_free()

	if position.y < -10:
		queue_free()

func _integrate_forces(state):
	state.set_linear_velocity(Vector2(0,-speed))
	state.set_angular_velocity(0)
