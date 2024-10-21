extends Node3D

var rng = RandomNumberGenerator.new()										# Variable berisi RNG (Random Number Generator)

@onready var car_red = preload("res://Scene/Cars/car_red.tscn")				# Variable berisi path scene mobil merah
@onready var car_blue = preload("res://Scene/Cars/car_blue.tscn")			# Variable berisi path scene mobil biru
@onready var car_green = preload("res://Scene/Cars/car_green.tscn")			# Variable berisi path scene mobil hijau
@onready var car_yellow = preload("res://Scene/Cars/car_yellow.tscn")		# Variable berisi path scene mobil kuning

func _on_timer_timeout() -> void:
	rng.randomize()
	var random_number = rng.randi_range(1,4)								# Variable berisi angka acak dari RNG
	var car_type = car_red													# Variable berisi tipe mobil
	
	# Kondisi untuk menentukan tipe mobil yang muncul sesuai angka dari RNG
	if random_number == 1 :
		car_type = car_red
	elif random_number == 2 :
		car_type = car_blue
	elif random_number == 3 :
		car_type = car_green
	elif random_number == 4 :
		car_type = car_yellow
		
	var Cars = car_type.instantiate()										# Variable berisi tipe mobil yang akan muncul
	Cars.position = $Mesh.position
	get_parent().get_node("Car_Route").add_child(Cars)
	
	
