extends RigidBody2D

var size : int = 2
var score : int = 5
var red : PackedScene = preload("res://yellow.tscn")
var collision_handled : bool = false

func get_sizee():
	return size

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if collision_handled:
		return

	for i in range(state.get_contact_count()):
		var collided_body = state.get_contact_collider_object(i)

		if is_instance_valid(collided_body) and collided_body is RigidBody2D:
			var contact_point = state.get_contact_local_position(i)
			print("Collision point: ", contact_point)
			print("Collided with: ", collided_body)

			if collided_body.has_method("get_sizee") and not collided_body.collision_handled:
				if collided_body.get_sizee() == 2:
					print("RigidBody2D Blue collided with other Blue")
					if self.get_instance_id() < collided_body.get_instance_id():
						call_deferred("handle_collision", contact_point, collided_body)
					break

func handle_collision(contact_point: Vector2, collided_body: RigidBody2D):
	collision_handled = true
	collided_body.collision_handled = true
	
	var red_instance = red.instantiate()
	red_instance.position = contact_point
	get_parent().add_child(red_instance)

	Global.update_score(score)

	collided_body.queue_free()
	self.queue_free()
