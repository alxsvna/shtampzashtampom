extends Control

@onready var eva: TextureRect = $Eva
@onready var eva_desc: Label = $EvaDesc
@onready var john: TextureRect = $JohnUz
@onready var john_desc: Label = $JohnUzDesc
@onready var dialogue_box: Control = $DialogueBox

func _ready() -> void:
	eva.modulate.a = 0.0
	eva_desc.modulate.a = 0.0
	john.modulate.a = 0.0
	john_desc.modulate.a = 0.0

	dialogue_box.dialogue_finished.connect(_on_dialogue_finished)

	await _fade_in(eva)
	await _fade_in(eva_desc)
	await _fade_in(john)
	await _fade_in(john_desc)

	dialogue_box.start([
		{"speaker": "Джон ЮЗ", "text": "Привет, Ева! Добро пожаловать в «Экспедицию по республике»! Я помогу тебе познакомиться с пятью интересными достопримечательностями ДНР."},
		{"speaker": "Ева", "text": "Здорово! Я давно хотела узнать больше о родном крае, но не знала, с чего начать."},
		{"speaker": "Джон ЮЗ", "text": "Тогда отправляемся в путь. На каждой локации тебя ждёт небольшой рассказ и игровое задание. За правильные ответы ты будешь получать очки экспедиции и памятные значки."},
		{"speaker": "Ева", "text": "Я готова! Какая локация будет первой?"},
		{"speaker": "Джон ЮЗ", "text": "Начнём с места, где можно увидеть удивительное разнообразие растений, — с Донецкого ботанического сада!"}
	])

func _fade_in(node: CanvasItem) -> void:
	var tween := create_tween()
	tween.tween_property(node, "modulate:a", 1.0, 0.8)
	await tween.finished

func _on_dialogue_finished() -> void:
	SceneManager.go_to_map()
