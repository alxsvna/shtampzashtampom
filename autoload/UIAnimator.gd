extends Node

const GREEN := Color("#4A8F3C")
const GREEN_HOVER := Color("#6BB35A")
const GREEN_PRESS := Color("#A87943")
const CREAM := Color("#DAC6B2")
const GOLD := Color("#D7A661")

func _ready() -> void:
	get_tree().node_added.connect(_on_node_added)
	call_deferred("_scan", get_tree().root)

func _scan(node: Node) -> void:
	_try_attach(node)
	for child in node.get_children():
		_scan(child)

func _on_node_added(node: Node) -> void:
	call_deferred("_try_attach", node)

func _try_attach(node: Node) -> void:
	if not is_instance_valid(node):
		return
	if node is BaseButton:
		_make_button(node as BaseButton)

func _make_button(btn: BaseButton) -> void:
	if btn.get_meta("_ui_fx", false):
		return
	btn.set_meta("_ui_fx", true)

	if btn is Button and not (btn as Button).has_theme_stylebox_override("normal"):
		_apply_default_style(btn as Button)

	if btn.size.x > 1.0:
		_center_pivot(btn)
	else:
		btn.resized.connect(_center_pivot.bind(btn), CONNECT_ONE_SHOT)

	btn.mouse_entered.connect(_on_hover.bind(btn, true))
	btn.mouse_exited.connect(_on_hover.bind(btn, false))
	btn.button_down.connect(_on_down.bind(btn))
	btn.button_up.connect(_on_up.bind(btn))

func _apply_default_style(btn: Button) -> void:
	btn.add_theme_stylebox_override("normal", _box(GREEN, 10, 2, GOLD))
	btn.add_theme_stylebox_override("hover", _box(GREEN_HOVER, 10, 2, CREAM))
	btn.add_theme_stylebox_override("pressed", _box(GREEN_PRESS, 10, 2, CREAM))
	btn.add_theme_stylebox_override("disabled", _box(Color("#7A6A58"), 10, 2, Color("#B8A48E")))
	btn.add_theme_color_override("font_color", CREAM)
	btn.add_theme_color_override("font_hover_color", Color(1, 1, 1))
	btn.add_theme_color_override("font_pressed_color", CREAM)
	btn.add_theme_color_override("font_disabled_color", Color("#E8D9C8"))

func _box(bg: Color, radius: int, border: int, border_color: Color) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = bg
	s.corner_radius_top_left = radius
	s.corner_radius_top_right = radius
	s.corner_radius_bottom_left = radius
	s.corner_radius_bottom_right = radius
	s.border_width_left = border
	s.border_width_top = border
	s.border_width_right = border
	s.border_width_bottom = border
	s.border_color = border_color
	s.content_margin_left = 12
	s.content_margin_right = 12
	s.content_margin_top = 8
	s.content_margin_bottom = 8
	s.shadow_color = Color(0, 0, 0, 0.28)
	s.shadow_size = 6
	s.shadow_offset = Vector2(0, 3)
	return s

func _center_pivot(btn: Control) -> void:
	if not is_instance_valid(btn):
		return
	btn.pivot_offset = btn.size * 0.5

func _tween_of(btn: Node) -> Tween:
	if btn.has_meta("_hover_tween"):
		var old: Tween = btn.get_meta("_hover_tween")
		if old:
			old.kill()
	var tween := btn.create_tween()
	btn.set_meta("_hover_tween", tween)
	return tween

func _on_hover(btn: BaseButton, entered: bool) -> void:
	if not is_instance_valid(btn) or btn.disabled:
		return
	_center_pivot(btn)
	var tween := _tween_of(btn)
	var target := Vector2(1.07, 1.07) if entered else Vector2.ONE
	tween.tween_property(btn, "scale", target, 0.14).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_down(btn: BaseButton) -> void:
	if not is_instance_valid(btn) or btn.disabled:
		return
	_center_pivot(btn)
	var tween := _tween_of(btn)
	tween.tween_property(btn, "scale", Vector2(0.93, 0.93), 0.06).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_up(btn: BaseButton) -> void:
	if not is_instance_valid(btn):
		return
	_center_pivot(btn)
	var tween := _tween_of(btn)
	var hovered := btn.is_hovered() and not btn.disabled
	var target := Vector2(1.07, 1.07) if hovered else Vector2.ONE
	tween.tween_property(btn, "scale", target, 0.12).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func bob(node: CanvasItem, amplitude: float = 8.0, duration: float = 2.2, delay: float = 0.0) -> void:
	if not is_instance_valid(node):
		return
	if node is Control:
		var control := node as Control
		control.pivot_offset = control.size * 0.5
	var start = node.position
	var tween = node.create_tween().set_loops()
	tween.tween_interval(delay)
	tween.tween_property(node, "position:y", start.y - amplitude, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(node, "position:y", start.y + amplitude * 0.35, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func sway(node: CanvasItem, degrees: float = 2.4, duration: float = 2.6, delay: float = 0.0) -> void:
	if not is_instance_valid(node):
		return
	if node is Control:
		var control := node as Control
		control.pivot_offset = control.size * 0.5
	var rad := deg_to_rad(degrees)
	var tween := node.create_tween().set_loops()
	tween.tween_interval(delay)
	tween.tween_property(node, "rotation", rad, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(node, "rotation", -rad, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func pulse(node: CanvasItem, scale_to: float = 1.08, duration: float = 0.7) -> void:
	if not is_instance_valid(node):
		return
	if node is Control:
		(node as Control).pivot_offset = (node as Control).size * 0.5
	var tween := node.create_tween().set_loops()
	tween.tween_property(node, "scale", Vector2(scale_to, scale_to), duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(node, "scale", Vector2.ONE, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func pop_in(node: CanvasItem, duration: float = 0.35, delay: float = 0.0) -> void:
	if not is_instance_valid(node):
		return
	if node is Control:
		(node as Control).pivot_offset = (node as Control).size * 0.5
	node.scale = Vector2(0.82, 0.82)
	node.modulate.a = 0.0
	var tween := node.create_tween()
	tween.tween_interval(delay)
	tween.set_parallel()
	tween.tween_property(node, "modulate:a", 1.0, duration * 0.7)
	tween.tween_property(node, "scale", Vector2.ONE, duration).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
