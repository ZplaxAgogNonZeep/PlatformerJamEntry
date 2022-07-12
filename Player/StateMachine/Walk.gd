extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()

var maxSlowdown := .2

func startState():
	#sm.setAnimation("Walk")
	$Timer.start(maxSlowdown)


func physics_process(_delta):
	if not kino.is_on_floor():
		sm.changeState("Falling")
	
	#if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
	get_input()
	kino.velocity.y += sm.gravity * _delta
	kino.velocity = kino.move_and_slide_with_snap(kino.velocity, Vector2(0, 10), Vector2.UP)
		
	
	if Input.is_action_just_pressed("Jump"):
		sm.changeState("Jump")
	
	
	if kino.velocity.x > 0 or kino.velocity.x == 0:
		if sm.dir == 0 and kino.velocity.x < 1:
			sm.changeState("Idle")
	elif kino.velocity.x < 0 or kino.velocity.x == 0:
		if sm.dir == 0 and kino.velocity.x >= -1:
			sm.changeState("Idle")



func get_input():
	sm.dir = 0
	
	if Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
		$Timer.stop()
		sm.dir += 1
		kino.flip(false)

	if Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		$Timer.stop()
		sm.dir -= 1
		kino.flip(true)
	
	if (Input.is_action_just_released("Right") or Input.is_action_just_released("Left")) and not (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
		
		$Timer.start(maxSlowdown)
	
	if sm.dir != 0:
		#Speeds up
		kino.velocity.x = lerp(kino.velocity.x, sm.dir * sm.speed, sm.acceleration)
	else:
		#Slows Down
		kino.velocity.x = lerp(kino.velocity.x, 0, sm.friction)

func _on_Timer_timeout():
	if kino.velocity.x != 0 and sm.stateName == "Walk":
		kino.velocity.x = 0
		sm.changeState("Idle")
