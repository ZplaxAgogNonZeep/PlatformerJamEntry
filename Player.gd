extends KinematicBody2D

# So you might be wondering "What are all these variables for?"
# and the answer is nothing I'm just too lazy to clean up the code, ignore it
# Everything works fine by default rn
var vulnerable = true
var shielded := false
var activeShield = null
var OutOfDialogue = false
var CutSceneMode = false

onready var sprite = $Graphic
onready var game = get_tree().root.get_node("Game") # The Main game Node

var velocity = Vector2.ZERO # Veloctiy determines the direction and speed that the player is moving

func flip(isLeft : bool):
	# Flips the player to the given direction
	if sprite.flip_h != isLeft:
		if not is_on_floor():
			$StateMachine.momentum = 0
	
	sprite.flip_h = isLeft

func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact"):
		$Interaction.interact()
