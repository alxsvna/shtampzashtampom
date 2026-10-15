extends Control

@onready var counter: Label = $CounterLabel
@onready var points_label: Label = $PointsLabel
@onready var back_button: Button = $BackButton

var stamp_nodes: Dictionary = {}

func _ready() -> void:
	stamp_nodes = {
		"botanical": $Stamp1,
		"museum": $Stamp2,
		"memory": $Stamp3,
		"monument": $Stamp4,
		"history": $Stamp5,
	}

	back_button.pressed.connect(func(): SceneManager.go_to_map())

	_update()

func _update() -> void:
	counter.text = "Собрано штампов: %d / 5" % GameState.collected_count()
	points_label.text = "Баллы: %d" % GameState.points

	for id in stamp_nodes.keys():
		var stamp: TextureRect = stamp_nodes[id]
		stamp.modulate.a = 1.0 if GameState.stamps[id] else 0.0
