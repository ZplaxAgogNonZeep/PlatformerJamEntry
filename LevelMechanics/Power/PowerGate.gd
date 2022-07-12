extends Node2D

# Spawns a set of platforms equal to the amount of space between it and the position.
# when given power, will move all those platforms to a line, as if it were a gate.

export var speed := .5
export var active := false
var posnMod := 1
var distance := 0
var isHorizontal : bool
var endPosn := 0


const UNIT := 32

func _ready():
	setActive(active)
	
	if $Position2D.position.x == 0 and $Position2D.position.y != 0:
		#Y Axis
		endPosn = $Position2D.position.y
		isHorizontal = false
	elif $Position2D.position.y == 0 and $Position2D.position.x != 0:
		#X Axis
		endPosn = $Position2D.position.x
		isHorizontal = true
	if endPosn < 0:
		posnMod = -1
	
	distance = (endPosn * posnMod) / UNIT
	spawnPlatforms(endPosn)

func power(outlet, liveStatus):
	# Recieves signal from other Electric Objects then
	# Decides if it will open platform
	setActive(liveStatus)
	
	if active:
		open()
	else:
		close()
	


func open():
	# okay, so. my naming convention was bad and I don't want to fix it. 
	# Open closes the gate
	print("open")
	var platformList = $PlatformManager.get_children()
	var count = 0
	
	for i in range($PlatformManager.get_child_count()):
		var finalPosn
		
		var pos = UNIT * i * posnMod
		
		if isHorizontal:
			finalPosn = Vector2(pos, 0)
		else:
			finalPosn = Vector2(0, pos)
		
		platformList[i].get_node("Tween").interpolate_property(platformList[i], "position", platformList[i].position, finalPosn, speed)
		platformList[i].get_node("Tween").start()

func close():
	# Close Opens the Gate
	print("Close")
	
	var storePoint : Vector2
	
	if endPosn < 0:
		storePoint = Vector2(0,0)
	else:
		storePoint = $PositiveStorePoint.position
	
	var platformList = $PlatformManager.get_children()

	for i in range($PlatformManager.get_child_count()):
		platformList[i].get_node("Tween").interpolate_property(platformList[i], "position", platformList[i].position, storePoint, speed)
		platformList[i].get_node("Tween").start()

func spawnPlatforms(endPosn):
	# Spawns enough platforms to fill the space between the gate and the Position2D
	var platform = preload("res://LevelMechanics/Power/Platform.tscn")
	
	for i in range(distance):
		var platInstance = platform.instance()
		
		if isHorizontal:
			#X Axis
			platInstance.rotation_degrees = 90 * posnMod
			
			platInstance.position.x += UNIT * i * posnMod
		else:
			#Y Axis
			platInstance.rotation_degrees = 180 * posnMod
			if platInstance.rotation_degrees < 0:
				platInstance.rotation_degrees = 0
			
			platInstance.position.y += UNIT * i * posnMod
		$PlatformManager.add_child(platInstance)
	
	if active:
		open()
	else:
		close()

func setActive(liveStatus):
	active = liveStatus
	
	if active:
		$PivotPoint.set_animation("Active")
	else:
		$PivotPoint.set_animation(("Inactive"))
