extends CanvasLayer

var fade_rect: ColorRect

func _ready() -> void:
	layer = 100  

	fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0) 
	fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(fade_rect)

func fade_out(duration: float = 0.4) -> void:
	var tween := create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, duration)
	await tween.finished

func fade_in(duration: float = 0.4) -> void:
	var tween := create_tween()
	tween.tween_property(fade_rect, "color:a", 0.0, duration)
	await tween.finished

func change_scene(path: String, duration: float = 0.4) -> void:
	await fade_out(duration)
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	await fade_in(duration)
