extends Node2D

# Extends Power along a line. Works like a recusive function.

export var delay := .05
var active := false
export var isCorner := false

func _ready():
	if isCorner:
		$Connection.set_animation("Corner")
		$OutletB.position.x = $Position2D.position.x
		$OutletB.position.y = $Position2D.position.y
		print("POWER LINE CORD: " + str($OutletB.position))

func power(outlet : String, liveStatus : bool):
	# The primary signal that is called when passing power to an electric object
	print("PowerLine Called")
	
	setActive(liveStatus)
	$Timer.start(delay)
	yield($Timer, "timeout")
	var connection = null
	if outlet == "OutletA":
		if $OutletB.get_overlapping_areas().size() > 0:
			connection = $OutletB.get_overlapping_areas()[0]
	elif outlet == "OutletB":
		if $OutletA.get_overlapping_areas().size() > 0:
			connection = $OutletA.get_overlapping_areas()[0]
	
	if connection != null and connection.get_parent().active != active:
		connection.get_parent().power(connection.name, liveStatus)

func setActive(status : bool):
	# Changes active status to given bool
	active = status
	if active:
		$Center.set_animation("Active")
	else:
		$Center.set_animation("Inactive")


# ELECTRICITY INHERENT FUNCTIONS ================================================
## The primary signal that is called when passing power to an electric object
#func power(outlet : String, liveStatus : bool):
#	pass
