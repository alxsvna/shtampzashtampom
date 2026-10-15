extends Control

@onready var dialogue_box: Control = $DialogueBox

func _ready() -> void:
	dialogue_box.dialogue_finished.connect(_on_dialogue_finished)

	dialogue_box.start([
		{"speaker": "Джон ЮЗ", "text": "Привет! Меня зовут Джон ЮЗ. Я провожу экспедиции по родному краю."},
		{"speaker": "Ева", "text": "Здравствуйте! Я Ева. Давно хотела узнать больше о республике, но не знала, с чего начать."},
		{"speaker": "Джон ЮЗ", "text": "Тогда отправляемся в путь. У нас пять точек на карте: природа, искусство, память, труд и история."},
		{"speaker": "Ева", "text": "А что нужно делать?"},
		{"speaker": "Джон ЮЗ", "text": "На каждой локации-небольшой рассказ и задание. За правильные ответы получишь 10 очков экспедиции и памятный значок."},
		{"speaker": "Ева", "text": "Я готова! С чего начнём?"},
		{"speaker": "Джон ЮЗ", "text": "С Донецкого ботанического сада-места, где собрано удивительное разнообразие растений."},
		{"speaker": "Ева", "text": "Тогда вперёд!"}
	])

func _on_dialogue_finished() -> void:
	SceneManager.go_to_location("botanical")
