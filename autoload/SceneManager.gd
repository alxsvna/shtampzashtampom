extends Node

var current_location: String = ""

func go_to_map() -> void:
	Transition.change_scene("res://scenes/Map.tscn")

func go_to_menu() -> void:
	Transition.change_scene("res://scenes/MainMenu.tscn")

func go_to_intro() -> void:
	Transition.change_scene("res://scenes/Intro.tscn")

func go_to_location(location_id: String) -> void:
	current_location = location_id
	var path := "res://scenes/locations/Location_%s.tscn" % location_id
	Transition.change_scene(path)

func go_to_passport() -> void:
	Transition.change_scene("res://scenes/Passport.tscn")

func go_to_certificate() -> void:
	Transition.change_scene("res://scenes/Certificate.tscn")

func go_to_name_input() -> void:
	Transition.change_scene("res://scenes/NameInput.tscn")
