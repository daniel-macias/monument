extends Sprite2D

var speed = 250  # Adjust movement speed
var deceleration = 5  # Adjust deceleration rate
var current_velocity = Vector2.ZERO

var wind_influence = 0.5  # Adjust wind's effect on speed
var wind_vector = Vector2(1, 0)  # Initial wind direction (rightward)


func _ready():
	pass

func _process(delta):
	var motion = Vector2.ZERO

	var desired_motion = Vector2.ZERO
	var desired_speed = speed

	# Check for horizontal input
	if Input.is_action_pressed("right"):
		desired_motion.x += 1
		desired_speed += speed * wind_influence * wind_vector.x  # Apply wind boost
	if Input.is_action_pressed("left"):
		desired_motion.x -= 1
		desired_speed -= speed * wind_influence * wind_vector.x  # Apply wind boost

	# Check for vertical input 
	if Input.is_action_pressed("down"):
		desired_motion.y += 1
		desired_speed += speed * wind_influence * wind_vector.y  # Apply wind boost
	if Input.is_action_pressed("up"):
		desired_motion.y -= 1
		desired_speed -= speed * wind_influence * wind_vector.y  # Apply wind boost
		


	# Smoothly adjust velocity towards desired motion
	current_velocity = lerp(current_velocity.normalized() * current_velocity.length(), desired_speed * desired_motion.normalized(), deceleration * delta)
	print(current_velocity)
	
	# Apply velocity
	position += current_velocity * delta

	# Gradually slow down when no input is pressed
	if current_velocity.length() > 0.1:
		current_velocity -= current_velocity.normalized() * deceleration * delta
