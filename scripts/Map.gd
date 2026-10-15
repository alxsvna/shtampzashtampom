extends Control

@onready var points_label: Label = $PointsLabel
@onready var stamps_label: Label = $StampsLabel

var buttons: Dictionary = {}
var green_style: StyleBoxFlat
var gray_style: StyleBoxFlat

func _ready() -> void:
	buttons = {
		"botanical": $BtnBotanical,
		"museum": $BtnMuseum,
		"memory": $BtnMemory,
		"monument": $BtnMonument,
		"history": $BtnHistory,
	}

	green_style = StyleBoxFlat.new()
	green_style.bg_color = Color("#4A8F3C")
	green_style.corner_radius_top_left = 30
	green_style.corner_radius_top_right = 30
	green_style.corner_radius_bottom_left = 30
	green_style.corner_radius_bottom_right = 30
	green_style.border_width_left = 3
	green_style.border_width_top = 3
	green_style.border_width_right = 3
	green_style.border_width_bottom = 3
	green_style.border_color = Color("#DAC6B2")

	gray_style = StyleBoxFlat.new()
	gray_style.bg_color = Color("#A87943")
	gray_style.corner_radius_top_left =30
	gray_style.corner_radius_top_right =30
	gray_style.corner_radius_bottom_left =30
	gray_style.corner_radius_bottom_right =30
	gray_style.border_width_left =3
	gray_style.border_width_top =3
	gray_style.border_width_right =3
	gray_style.border_width_bottom =3
	gray_style.border_color = Color("#DAC6B2")

	for btn in buttons.values():
		btn.add_theme_stylebox_override("normal", green_style)
		btn.add_theme_stylebox_override("hover", green_style)
		btn.add_theme_stylebox_override("pressed", green_style)
		btn.add_theme_color_override("font_color", Color("#DAC6B2"))
		btn.add_theme_color_override("font_hover_color", Color("#DAC6B2"))
		btn.add_theme_color_override("font_pressed_color", Color("#DAC6B2"))

	$BtnBotanical.pressed.connect(func(): SceneManager.go_to_location("botanical"))
	$BtnMuseum.pressed.connect(func(): SceneManager.go_to_location("museum"))
	$BtnMemory.pressed.connect(func(): SceneManager.go_to_location("memory"))
	$BtnMonument.pressed.connect(func(): SceneManager.go_to_location("monument"))
	$BtnHistory.pressed.connect(func(): SceneManager.go_to_location("history"))

	if has_node("PassportButton"):
		$PassportButton.pressed.connect(func(): SceneManager.go_to_passport())
	if has_node("MenuButton"):
		$MenuButton.pressed.connect(func(): SceneManager.go_to_menu())
	if has_node("CertificateButton"):
		$CertificateButton.pressed.connect(func(): SceneManager.go_to_certificate())

	GameState.points_added.connect(_on_update)
	GameState.stamp_added.connect(_on_update)

	_update()

func _update() -> void:
	points_label.text = "Баллы: %d" % GameState.points
	stamps_label.text = "Штампы: %d / 5" % GameState.collected_count()

	for id in buttons.keys():
		var btn: Button = buttons[id]
		if GameState.stamps[id]:
			btn.disabled = true
			btn.add_theme_stylebox_override("disabled", gray_style)
			btn.add_theme_color_override("font_disabled_color", Color("#DAC6B2"))
			btn.text = "✓"
		else:
			btn.disabled=false

	if has_node("CertificateButton"):
		$CertificateButton.visible = GameState.all_collected()

func _on_update(_arg = null) -> void:
	_update()
