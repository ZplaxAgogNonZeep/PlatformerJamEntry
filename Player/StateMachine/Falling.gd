extends Node


onready var sm = get_parent()
onready var kino = get_parent().get_parent()


func startState():
	#sm.setAnimation("Falling")
	pass

func endState():
	sm.momentum = 0

func physics_process(_delta):
	if kino.is_on_floor():
		#kino.velocity.x = 0
		sm.changeState("Walk")
	
	get_input()
	kino.velocity.y += sm.gravity * _delta
	kino.velocity = kino.move_and_slide(kino.velocity, Vector2.UP)
	
	

func get_input():
	sm.dir = 0
	
	if Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
		sm.dir += 1
		kino.flip(false)
		if sm.momentum < sm.MAX_MOMENTUM:
			sm.momentum += 15

	if Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		sm.dir -= 1
		kino.flip(true)
		if sm.momentum < sm.MAX_MOMENTUM:
			sm.momentum += 15
		
	if sm.dir != 0:
		kino.velocity.x = lerp(kino.velocity.x, sm.dir * sm.speed, sm.acceleration)
	else:
		# Change State to end of run?
		if sm.sprite.flip_h:
			sm.dir = -1
		else:
			sm.dir = 1
		kino.velocity.x = lerp(kino.velocity.x, sm.momentum * sm.dir, sm.friction)
