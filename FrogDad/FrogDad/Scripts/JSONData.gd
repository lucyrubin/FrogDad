#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

extends Node

var item_data: Dictionary
# parses the JSON file and saves it as a dictionary within the script
func _ready():
	# item_data holds the dictionary from the JSON file
	item_data = LoadData("res://Data/ItemData.json")
	
func LoadData(file_path):
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	return json_data.result
