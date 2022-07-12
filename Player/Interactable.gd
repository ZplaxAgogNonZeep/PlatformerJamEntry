extends Area2D

var activeArea = null

func interact():
	# Called from player script when interact button is pressed, will check if there is something in 
	# range of the area, then will see if it can be activated and calls that obejects activate 
	# function if possible
	if activeArea != null:
		if activeArea.has_method("activate"):
			activeArea.activate()
		else:
			activeArea.get_parent().activate()
	else:
		pass

func _on_Interaction_area_entered(area):
	# Adds an interacable object to the activeArea variable
	if area.is_in_group("Interactable"):
		activeArea = area
	

func _on_Interaction_area_exited(area):
	# Removes an interactable Object to the activeArea variable
	print("Object exited")
	if area.is_in_group("Interactable"):
		activeArea = null

