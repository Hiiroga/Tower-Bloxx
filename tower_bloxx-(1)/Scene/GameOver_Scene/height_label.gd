extends Label

func _process(_delta):
	# Code untuk menampilkan HUD Score
	text = "Tower Height : " + str(Global.Stack)
