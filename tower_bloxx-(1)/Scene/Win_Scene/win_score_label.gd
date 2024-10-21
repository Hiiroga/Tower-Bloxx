extends Label


func _process(delta):
	# Code untuk menampilkan HUD Score
	text = "Score : " + str(Global.Score)
