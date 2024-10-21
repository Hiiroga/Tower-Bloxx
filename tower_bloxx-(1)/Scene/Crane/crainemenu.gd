extends Node3D

var block_scene = preload("res://Scene/Blocks/block_biru.tscn") 	# Variabel untuk path block yang akan muncul
var Crane_y = 0.0  													# Variabel Mengatur posisi crane setelah drop block
var Camera_y = 0.0 													# Variabel Mengatur posisi Camera setelah drop block

var attached := true  												# Variabel Mengatur Block dengan Crane Nyangkut atau tidak
var new_block = null   												# Variabel untuk memunculkan block baru
var joint = null  													# Variabel memunculkan Joint Baru
var block_dasar = true												# Variabel apakah blok dasar dijatuhkan atau belum
var no_block = false												# Variabel untuk mengecek apabila ada blok atau tidak

var shake := 1.0  													# Variabel Mengatur Goyangan Crane
var circle_radius := 4.0											# Variabel besaran area x goyangan crane
var vertical_radius := 1.0											# Variabel besaran area y goyangan crane
var angle := 0.0													# Variabel untuk menghitung goyangan crane

var pause := false													# Variable boolean pause

func _process(delta):

	angle += delta * shake
	var new_x = circle_radius * cos(angle)
	var new_y = Crane_y + vertical_radius * sin(angle)
	$Crane_Body.transform.origin = Vector3(new_x, new_y,0)
	
	#Implementasi Block dan Joint agar mengikuti Goyangan Crane
	if block_dasar == true :
		$Joint/Generic6DOFJoint3D.transform.origin = Vector3(new_x, new_y - 1.5 ,0)
		$Blocks/Block_Dasar.transform.origin = $Joint/Generic6DOFJoint3D.transform.origin
	
	if attached and new_block and joint:
		joint.transform.origin = Vector3(new_x, new_y - 1.5 ,0)
		new_block.transform.origin = joint.transform.origin
	
	# Jika menekan spasi block akan jatuh
	if Input.is_action_just_pressed("drop") and attached:
		drop_block()
	
	
func drop_block():
	# Fungsi untuk menjatuhkan block
	attached = false
	no_block = true
	
	if not Global.Miss :
		if Global.Stack < 75 :
			Crane_y += 2
			Camera_y += 2
		else :
			Camera_y += 2.1
			Crane_y += 2.1
	
	if block_dasar:
		block_dasar = false
		$Blocks/Block_Dasar.linear_velocity = Vector3.ZERO
		$Blocks/Block_Dasar.angular_velocity = Vector3.ZERO
		$Blocks/Block_Dasar.gravity_scale = 1.0
		$Joint.get_node("Generic6DOFJoint3D").queue_free()
	else :
		new_block.linear_velocity = Vector3.ZERO
		new_block.angular_velocity = Vector3.ZERO
		new_block.gravity_scale = 1.0
	
	if joint:
		joint.queue_free()
		joint = null 
	
	$Crane_Body.transform.origin.y = Crane_y
	$Camera3D.transform.origin.y = Camera_y  
	
	$Timer.start()
	
func _on_timer_timeout():
	if no_block :
		add_block()

func add_block():
	# Fungsi untuk memunculkan block
	if Global.Stack >= 25 and Global.Stack < 50 :
		block_scene = preload("res://Scene/Blocks/block_merah.tscn")
	elif Global.Stack >= 50 and Global.Stack < 75 :
		block_scene = preload("res://Scene/Blocks/block_hijau.tscn")
	elif Global.Stack >= 75 and Global.Stack < 99 :
		block_scene = preload("res://Scene/Blocks/block_kuning.tscn")
	elif Global.Stack == 99 :
		block_scene = preload("res://Scene/Blocks/block_puncak.tscn")
	
	if Global.Stack < 100 :
		no_block = false
		new_block = block_scene.instantiate()
		var blocks_node = get_node("Blocks")
	
		new_block.transform.origin = blocks_node.transform.origin + Vector3(0, Crane_y, 0)
		new_block.gravity_scale = 0.0

		blocks_node.add_child(new_block)
		new_block.name = "Block"
		Global.Spawn += 1
		attach_block()

func attach_block():
	# Fungsi untuk menempelkan block pada crane
	var joint_node = get_node("Joint") 
	
	joint = Generic6DOFJoint3D.new()
	$Joint.add_child(joint)
	joint.node_a = $Crane_Body.get_path()
	joint.node_b = new_block.get_path()
	joint.transform.origin = joint_node.transform.origin + Vector3(0, Crane_y, 0)
	
	attached = true
		# Implementasi goyangan crane
	if Global.Stack == 25 :
		shake -= 1.0
	if Global.Stack == 50 :
		shake -= 1.0
	if Global.Stack == 75 :
		shake -= 1.0
	if Global.Stack == 100 :
		shake -= 1.0
		
	shake += 0.1
