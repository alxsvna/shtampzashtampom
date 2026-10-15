extends Control

func _ready() -> void:
	$Buttons/StartButton.pressed.connect(_on_start)
	$Buttons/HowButton.pressed.connect(_on_how)
	$Buttons/AboutButton.pressed.connect(_on_about)

	$HowPanel/HowCloseButton.pressed.connect(_on_how_close)
	$AboutPanel/AboutCloseButton.pressed.connect(_on_about_close)

	$HowPanel.visible=false
	$AboutPanel.visible=false

func _on_start() -> void:
	SceneManager.go_to_intro()

func _on_how() -> void:
	$HowPanel.visible=true

func _on_how_close() -> void:
	$HowPanel.visible=false

func _on_about() -> void:
	$AboutPanel.visible=true

func _on_about_close() -> void:
	$AboutPanel.visible=false
