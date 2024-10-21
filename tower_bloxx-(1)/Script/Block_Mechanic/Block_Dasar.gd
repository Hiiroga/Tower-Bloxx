extends RigidBody3D

var collided := false					# Variable untuk mengetahui apabila block telah bertabrakan dengan block lain

func _on_down_area_body_entered(body):
	# Fungsi untuk memberikan skor saat block bertabrakan
	var Block_Score = 0.0 				# Variable yang berisi skor block	
	
	# Kondisi if apabila objek yang ditabrak adalah floor maka akan menambah Stack
	if body.name == "Floor":
		# Code untuk menambahkan Score dan Stack
		Global.Score += Block_Score * Global.Multiplier
		Global.Stack += 1
		collided = true
