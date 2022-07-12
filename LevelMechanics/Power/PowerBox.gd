extends Node2D

# Provides power to other objects connected. can be set to be off or on by default

export var active = false

func _ready():
	setActive(active)
	if active:
		$Timer.start(1.0)

func _on_Timer_timeout():
	# For whatever reason, collisions won't work on load so I have to start all power things
	# like one second after. Consider this a part of ready
	print("Power Box")
	var connections = $Outlet.get_overlapping_areas()
	if connections.size() > 0:
		var posn = 0
		while posn < connections.size():
			connections[posn].get_parent().power(connections[posn].name, active)
			posn += 1

func power(outlet : String, liveStatus : bool):
	#The primary signal that is called when passing power to an electric object
	setActive(liveStatus)
	
	print("Power Box power called")
	
	var connections = $Outlet.get_overlapping_areas()
	print(connections)
	if connections.size() > 0:
		var posn = 0
		while posn < connections.size():
			if connections[posn].get_parent().active != active:
				connections[posn].get_parent().power(connections[posn].name, liveStatus)
			posn += 1

func setActive(status : bool):
	# Changes active status to given bool
	active = status
	
	if active:
		$Graphic.set_animation("Active")
	else:
		$Graphic.set_animation("Inactive")

# ELECTRICITY INHERENT FUNCTIONS ================================================
#func power(outlet : String, liveStatus : bool):
## The primary signal that is called when passing power to an electric object
#	pass
