extends TileMapLayer

signal square_clicked(square: Vector2i)

func _input(event):
    if event is InputEventMouseButton and event.pressed:
        if event.button_index == MOUSE_BUTTON_LEFT:
            var local_mouse_pos: Vector2 = to_local(get_global_mouse_position())
            
            # 2. Convert that posiion to tile grid coordinates
            var tile_pos: Vector2i = local_to_map(local_mouse_pos)
            
            # 3. Check if there is actually a tile there
            var tile_data: TileData = get_cell_tile_data(tile_pos)
            
            if tile_data:
                print("Clicked tile at: ", tile_pos)
                square_clicked.emit(tile_pos)
                # You can now trigger logic here!
            else:
                print("Clicked an empty space.")


func get_tile_position(tile: Vector2i) -> Vector2:
    var tilePosition: Vector2 = to_global(map_to_local(tile))

    return tilePosition