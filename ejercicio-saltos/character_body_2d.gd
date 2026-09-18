extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const TELEPORT_DISTANCE = 200.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():  #si cuando comienza el juego la figura no está tocando el suelo, va a ir cayendo 
		velocity += get_gravity() * delta  #de esta forma la velocidad va aumentando en cada frame

	if Input.is_action_just_pressed("arriba") and is_on_floor(): #si acabo de pulsar la flecha de arriba y estoy en el suelo salto
		velocity.y = JUMP_VELOCITY #ajusto la cantidad del salto en el vector y 
		
	if Input.is_action_just_pressed("espacio") and Input.is_action_pressed("derecha"):
		position.x += TELEPORT_DISTANCE
	
	if Input.is_action_just_pressed("espacio") and Input.is_action_pressed("izquierda"):
		position.x -= TELEPORT_DISTANCE
	

	var direction := Input.get_axis("ui_left", "ui_right") #devuelve direction (-1 izq o 1 derecha) 
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) #si no pulso nada, la velocidad se reduce progresivamente hasta que el objeto se pare 

	move_and_slide() #para que mueva el cuerpo utilizando su velocidad y teniendo en cuenta sus colisiones
