extends Control

signal dialogue_finished

@onready var portrait: TextureRect = $Panel/Portrait
@onready var speaker_name: Label = $Panel/SpeakerName
@onready var text_label: RichTextLabel = $Panel/Text
@onready var next_button: Button = $Panel/NextButton

var lines: Array = []
var current: int = 0

var portraits := {
	"Ева": preload("res://assets/characters/eva.png"),
	"Джон ЮЗ": preload("res://assets/characters/john_uz.png"),
}


const COLOR_EVA := Color("#C76D5D") 
const COLOR_JOHN :=Color("#4A8F3C")     

func _ready() -> void:
	visible = false
	next_button.pressed.connect(_on_next)

func start(new_lines: Array) -> void:
	lines = new_lines
	current = 0
	visible = true
	_show_line()

func _show_line() -> void:
	if current >= lines.size():
		visible = false
		dialogue_finished.emit()
		return

	var line: Dictionary = lines[current]
	var speaker: String = line["speaker"]

	speaker_name.text = speaker
	text_label.text = line["text"]
	portrait.texture = portraits.get(speaker, null)

	
	if speaker == "Ева":
		speaker_name.add_theme_color_override("font_color", COLOR_EVA)
	elif speaker == "Джон ЮЗ":
		speaker_name.add_theme_color_override("font_color", COLOR_JOHN)

func _on_next() -> void:
	current += 1
	_show_line()
