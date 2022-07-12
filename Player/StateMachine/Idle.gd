extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()


func startState():
	#sm.setAnimation("Idle")
	pass


func physics_process(_delta):
	
	# .5 seems to be the bare minimum speed the player can move at before they aren't really moving anymore.
	# Test moving platform moves at ~.80 per frame so make sure you keep track of what speed the player is at
	
	if kino.velocity.x < .5 and kino.velocity.x > -.5:
		kino.velocity.x = 0
	
	kino.velocity.y += sm.gravity * _delta
	kino.velocity = kino.move_and_slide(kino.velocity, Vector2.UP, true)
	
	if not kino.is_on_floor():
		sm.changeState("Falling")
	
	if Input.is_action_pressed("Left") and Input.is_action_pressed("Right"):
		pass
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		sm.changeState("Walk")
	
	if Input.is_action_just_pressed("Jump"):
		sm.changeState("Jump")
