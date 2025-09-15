extends Control




func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0,value)


func _on_check_box_toggled(toggled_on):
	pass # Replace with function body.


func _on_test_item_selected(index):
	match index:
		0: 
			print("You picked option 0")
