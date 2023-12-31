extends AcceptDialog


# Called when the node enters the scene tree for the first time.
func _ready():
	print("TForm: GNU")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# TODO: delta elapsed time since the previous frame.
	pass

func _enter_tree():
	var _dialog_autowrap = Object.new()
	var _get_layout_direction = Object.new()
	var _set_layout_direction = Object.new()
	# type logic reference count access files
	if _dialog_autowrap && _get_layout_direction && _set_layout_direction:
		print("TForm: Tree")
			
		 
		
