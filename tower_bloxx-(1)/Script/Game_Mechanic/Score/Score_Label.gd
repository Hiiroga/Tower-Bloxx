extends Label

func _process(_delta):
	# Code untuk menampilkan HUD Score
	text = "" + str(Global.Score)
