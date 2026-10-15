extends Node

signal points_added(amount: int)
signal stamp_added(location_id: String)
signal all_stamps_collected

const POINTS_PER_ANSWER := 2

var points: int = 0
var player_name: String ="Путешественник"

var stamps: Dictionary = {
	"botanical": false,
	"museum": false,
	"memory": false,
	"monument": false,
	"history": false,
}

var location_names: Dictionary = {
	"botanical": "Ботанический сад",
	"museum": "Художественный музей",
	"memory": "Музей памяти",
	"monument": "Памятник шахтёру",
	"history": "Исторический парк",
}

func add_points(amount: int) -> void:
	points += amount
	points_added.emit(amount)

func add_stamp(location_id: String) -> void:
	if stamps.has(location_id) and not stamps[location_id]:
		stamps[location_id]=true
		stamp_added.emit(location_id)
		if all_collected():
			all_stamps_collected.emit()

func all_collected() -> bool:
	for value in stamps.values():
		if not value:
			return false
	return true

func collected_count() -> int:
	var count := 0
	for value in stamps.values():
		if value:
			count += 1
	return count

func reset() -> void:
	points =0
	for key in stamps.keys():
		stamps[key] = false
