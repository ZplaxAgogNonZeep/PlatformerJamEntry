extends Node2D

export var active := false

func _ready():
	setActive(active)

func activate():
	print("Switch Activated")
	
	var connection = null
	if $Outlet.get_overlapping_areas().size() > 0:
			connection = $Outlet.get_overlapping_areas()[0]
	
	setActive(!active)
	
	if connection != null:
		connection.get_parent().power("Outlet", active)

func setActive(status):
	active = status
	
	if active:
		$AnimatedSprite.set_animation("Active")
	else:
		$AnimatedSprite.set_animation("Inactive")


# INTERACTABLES ======================================
#func activate():
#	pass
