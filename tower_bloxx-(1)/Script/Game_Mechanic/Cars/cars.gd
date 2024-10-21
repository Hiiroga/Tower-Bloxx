extends RigidBody3D

func _on_hit_area_body_entered(body: Node3D) -> void:
	# Fungsi untuk menghilangkan mobil apabila sudah berada di titik tertentu
	if body.name == "EndPoints" :
		#print("HIT")
		queue_free()
