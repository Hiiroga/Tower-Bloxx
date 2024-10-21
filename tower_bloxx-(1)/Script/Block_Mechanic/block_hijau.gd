extends RigidBody3D

var collided := false					# Variable untuk mengetahui apabila block telah bertabrakan dengan block lain
var perfectly_collided := false			# Variable untuk mengetahui apabila block telah bertabrakan secara sempurna dengan block lain

func _on_down_area_body_entered(body):
	collide_checker(body)

func collide_checker(body) :
	# Fungsi untuk memeriksa object yang bertabrakan
	var body1 = "Block" + str(Global.Count)				    # Variabel berisi nama Block yang bertabrakan 
	var body2 = "Block" + str(Global.Count - 1)				# Variabel berisi nama Block yang bertabrakan
	var body3 = "Block" + str(Global.Count - 2)				# Variabel berisi nama Block yang bertabrakan
	var body4 = "Block" + str(Global.Count - 3)				# Variabel berisi nama Block yang bertabrakan
	var body5 = "Block" + str(Global.Count - 4)				# Variabel berisi nama Block yang bertabrakan
	var Block_Score = 0.0									# Variabel berisi score block
	
	Global.Miss = false
	
	'''
	print("-------------------------")
	print("			debug			")
	print("-------------------------")
	print("hit = ", body.name)
	print("should hit = ", body1)
	print("should hit = ", body2)
	print("should hit = ", body3)
	print("should hit = ", body4)
	print("should hit = ", body5)
	print("Block Spawned = ", Global.Spawn)
	print("Block Count = ", Global.Count)
	'''
	
	if (body.name == body1 or body.name == body2 or body.name == body3 or body.name == body4 or body.name == body5) :
		if not collided :
			Block_Score = set_Block_Score()
			perfect_checker(body)
			add_score(Block_Score)
			Global.Count += 1
			collided = true
		
func _on_miss_area_body_entered(_body: Node3D) -> void:
	var Counted = Global.Spawn - Global.Count
	if Global.Miss_Count == 0 :
		print("MISS!")
		Global.Count += Counted
		Global.Miss_Count += 1
	elif Global.Miss_Count == 1 :
		print("MISS!")
		Global.Count += Counted - 1
		Global.Miss_Count += 1
	elif Global.Miss_Count == 2 :
		print("MISS!")
		Global.Count += Counted - 2
		Global.Miss_Count += 1
		
	Global.Multiplier = 1
		
	print("The Count = ", Global.Count )
	print("The Spawn = ", Global.Spawn)
	collided = true
	Global.Miss = true
	queue_free()

func set_Block_Score():
	# Fungsi untuk set variabel block score
	var Block_Score = 0.0								# Variabel berisi score block
	
	if Global.Stack >= 50 and Global.Stack <= 60:
		Block_Score = 50
	elif Global.Stack > 60 and Global.Stack <= 70:
		Block_Score = 60
	elif Global.Stack > 70 and Global.Stack <= 75:
		Block_Score = 70
		
	return Block_Score

func perfect_checker(body) :
	# Fungsi untuk mengecek kondisi perfect pada block yang bertabrakan
	
	var collider_distance = body.position.x					# Variabel berisi posisi body block saat bertabrakan
	
	# Kondisi if apabila objek bertabrakan secara sempurna akan menambah multiplier
	# Apabila objek tidak bertabrakan secara sempurna akan mereset multiplier ke 1
	if abs(collider_distance - self.position.x) < 0.5:
		perfectly_collide()
	else:
		perfectly_collided = false
		if Global.Multiplier > 1 :
			Global.Multiplier -= 1

func perfectly_collide():
	perfectly_collided = true
	if Global.Multiplier < 10:
		Global.Multiplier += 1

func add_score(Value):
	Global.Score += Value * Global.Multiplier
	Global.Stack += 1
