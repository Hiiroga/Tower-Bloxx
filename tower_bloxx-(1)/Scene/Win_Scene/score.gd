extends Label

func _process(_delta):
	# Code untuk menampilkan HUD Score
	text = "Score : " + str(Global.Score)
