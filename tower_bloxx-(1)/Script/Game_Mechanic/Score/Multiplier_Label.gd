extends Label

var progress_speed = 1.0  
var current_value = 0.0
var previous_multiplier = 0 
var visibility_timer = 1.0  
var remaining_time = 0.0  

func _process(delta):
	if Global.Multiplier < 2:
		remaining_time -= delta  
		if remaining_time <= 0:
			text = ""
			visible = false
	else:
		text = "x" + str(Global.Multiplier)
		visible = true
		
		if Global.Multiplier > previous_multiplier:
			$MultiProgressBar.value = 0  
			current_value = 0  
			remaining_time = visibility_timer  
			#print("Multiplier bertambah, reset progress bar")

	update_progress_bar(delta)

	previous_multiplier = Global.Multiplier

func update_progress_bar(delta):
	current_value += progress_speed * delta
	
	if current_value >= 1:
		$MultiProgressBar.value += 1
		#print("Progress bar bertambah, nilai saat ini:", $MultiProgressBar.value)
		current_value = 0  
