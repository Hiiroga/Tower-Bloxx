extends Label

func _process(_delta):
	# Code untuk menampilkan HUD Stack
	text = "" + str(Global.Stack)
	update_progress_bar()

func update_progress_bar():
	var progress := Global.Stack
	$BlockProgressBar.value = progress
