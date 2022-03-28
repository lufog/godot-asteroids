class_name AsteroidType extends Resource

@export
var texture: Texture2D

@export
var shape: Shape2D

@export_range(0, 10)
var debris_count: int

@export
var debris_types: Array[Resource]
