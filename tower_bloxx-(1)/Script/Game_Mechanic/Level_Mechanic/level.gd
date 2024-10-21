extends Node3D

var prev_multiplier := 1						# Variabel untuk menyimpan multiplier untuk reset timer

@onready var FullHealth = $HUD/Health_Label/Health
@onready var HalfHealth = $HUD/Health_Label/Health2
@onready var CriticalHealth = $HUD/Health_Label/Health3
@onready var gameOver = $HUD/GameOver
@onready var win_screen = $HUD/Win_Screen						# Variable yang berisi Path Win Screen
@onready var pause_menu = $HUD/PauseMenu						# Variable yang berisi Path Pause Menu

func _ready():
	# Set score, multiplier, stack, count, spawn, miss, dan prev_multiplier
	Global.Score = 0
	Global.Multiplier = 1
	Global.Stack = 0
	Global.Count = 0
	Global.Spawn = 0
	Global.Miss_Count = 0
	Global.Miss = false
	Global.pause = false
	Engine.time_scale = 1
	
	prev_multiplier = Global.Multiplier
	

func _process(_delta):
	# Kondisi if jika Multiplier > 1 akan mengaktifkan timer
	if Global.Multiplier > 1 :
		# Kondisi if jika Multiplier bertambah akan mereset timer
		if Global.Multiplier > prev_multiplier or Global.Multiplier == 10:
			$Timer.stop() 
			$Timer.wait_time = 10  
			$Timer.start()  
			prev_multiplier = Global.Multiplier
	else :
		$Timer.stop()
		$Timer.wait_time = 10
		prev_multiplier = Global.Multiplier
	
	# Kondisi if untuk visualisasi UI Health
	if Global.Miss_Count == 0 :
		FullHealth.show()
		HalfHealth.hide()
		CriticalHealth.hide()
	elif Global.Miss_Count == 1 :
		FullHealth.hide()
		HalfHealth.show()
		CriticalHealth.hide()
	elif Global.Miss_Count == 2 :
		FullHealth.hide()
		HalfHealth.hide()
		CriticalHealth.show()
	else :
		GameOver()
		
	if Global.Stack == 100 :
		WinScreen()
	
	if Input.is_action_just_pressed("pause"):
		Global.pause = false
		PauseMenu()
	
func _physics_process(delta: float) -> void:
	# Fungsi untuk menggerakkan mobil sesuai pada rute
	var move_speed = 0													# Variabel berisi kecepatan gerak mobil
	if not Global.pause : 
		move_speed = 0.2
	else :
		move_speed = 0
		
	$Car_Spawners/Route_A/Car_Route.progress += move_speed + delta
	$Car_Spawners/Route_B/Car_Route.progress += move_speed + delta
	$Car_Spawners/Route_C/Car_Route.progress += move_speed + delta
		
func _on_timer_timeout():
	# Fungsi untuk mereset multiplier dan timer apabila waktu timer habis
	Global.Multiplier = 1
	$Timer.wait_time = 10
	prev_multiplier = Global.Multiplier

func GameOver():
	# Fungsi untuk memunculkan WinScreen
	gameOver.show()
	Engine.time_scale = 0.0001
	Global.pause = true
	if Global.pause :
		$HUD/Health_Label.hide()
		$HUD/Multiplier_Label.hide()
		$HUD/Bar.hide()
		$HUD/Stack_Label.hide()
		$HUD/Score_Label.hide()
		$"HUD/Multiplier_Label/Bar Multi".hide()
		$HUD/Multiplier_Label/MultiProgressBar.hide()
	else :
		$HUD/Health_Label.show()
		$HUD/Multiplier_Label.show()
		$HUD/Bar.show()
		$HUD/Stack_Label.show()
		$HUD/Score_Label.show()
		$"HUD/Multiplier_Label/Bar Multi".show()
		$HUD/Multiplier_Label/MultiProgressBar.show()

func WinScreen():
	# Fungsi untuk memunculkan WinScreen
	win_screen.show()
	Engine.time_scale = 0.0001
	Global.pause = true
	if Global.pause :
		$HUD/Health_Label.hide()
		$HUD/Multiplier_Label.hide()
		$HUD/Bar.hide()
		$HUD/Stack_Label.hide()
		$HUD/Score_Label.hide()
		$"HUD/Multiplier_Label/Bar Multi".hide()
		$HUD/Multiplier_Label/MultiProgressBar.hide()
	else :
		$HUD/Health_Label.show()
		$HUD/Multiplier_Label.show()
		$HUD/Bar.show()
		$HUD/Stack_Label.show()
		$HUD/Score_Label.show()
		$"HUD/Multiplier_Label/Bar Multi".show()
		$HUD/Multiplier_Label/MultiProgressBar.show()


func PauseMenu():
	# Fungsi untuk memunculkan menu pause
	if Global.pause:
		pause_menu.hide()
		Engine.time_scale = 1
		
	else:
		pause_menu.show()
		Engine.time_scale = 0.0001

	Global.pause = !Global.pause


func _on_button_pressed() -> void:
	PauseMenu()
