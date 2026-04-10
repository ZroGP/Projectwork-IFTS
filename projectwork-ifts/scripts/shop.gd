extends MarginContainer

# -------------------------------------------------------
# ASSET CATALOGUE
# -------------------------------------------------------
const ASSETS = [
	{
		"id":       "bed_black_1",
		"name":     "Bed Black",
		"cost":     100,
		"icon":     "res://assets/room/bed/sprite_bed_black1.png",
		"scene":    "res://scenes/room/bed/bed_black_1.tscn",
		"position": Vector2(520, -145)
	},
	{
		"id":       "bed_cyan_1",
		"name":     "Bed Cyan",
		"cost":     100,
		"icon":     "res://assets/room/bed/sprite_bed_cyan1.png",
		"scene":    "res://scenes/room/bed/bed_cyan_1.tscn",
		"position": Vector2(520, -145)
	},
	{
		"id":       "bed_olive_1",
		"name":     "Bed Olive",
		"cost":     100,
		"icon":     "res://assets/room/bed/sprite_bed_olive1.png",
		"scene":    "res://scenes/room/bed/bed_olive_1.tscn",
		"position": Vector2(520, -145)
	},
	{
		"id":       "carpet_blu_1",
		"name":     "Carpet Blu",
		"cost":     120,
		"icon":     "res://assets/room/carpet/carpet_blu1.png",
		"scene":    "res://scenes/room/carpet/carpet_blu_1.tscn",
		"position": Vector2(460, -130)
	},
	{
		"id":       "carpet_green_1",
		"name":     "Carpet Green",
		"cost":     120,
		"icon":     "res://assets/room/carpet/carpet_green1.png",
		"scene":    "res://scenes/room/carpet/carpet_green_1.tscn",
		"position": Vector2(460, -130)
	},
	{
		"id":       "carpet_ivery_1",
		"name":     "Carpet Ivory",
		"cost":     120,
		"icon":     "res://assets/room/carpet/carpet_ivory1.png",
		"scene":    "res://scenes/room/carpet/carpet_ivory_1.tscn",
		"position": Vector2(460, -130)
	}
	# Add more assets here...
]

const FONT_PATH = "res://assets/fonts/PIXELADE.TTF"
const FONT_SIZE = 14

# How many pixels to push the list down from the top
# Increase this value if items still overlap your buttons
const TOP_OFFSET = 500

var _spawned: Dictionary = {}
var _placed:  Dictionary = {}
var _scroll:  ScrollContainer
var _list:    VBoxContainer
var _font:    FontFile

func _ready() -> void:
	_font = load(FONT_PATH)
	_build_scroll_container()
	_load_state()
	_build_shop_ui()

# -------------------------------------------------------
# ScrollContainer with hidden scrollbars + top offset
# -------------------------------------------------------
func _build_scroll_container() -> void:
	_scroll = ScrollContainer.new()
	_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_scroll.size_flags_vertical   = Control.SIZE_EXPAND_FILL

	# Hide both scrollbars
	_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	_scroll.vertical_scroll_mode   = ScrollContainer.SCROLL_MODE_SHOW_NEVER

	# Push content down so it doesn't overlap the top buttons
	_scroll.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_scroll.offset_top = TOP_OFFSET

	add_child(_scroll)

	_list = VBoxContainer.new()
	_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_list.add_theme_constant_override("separation", 6)
	_scroll.add_child(_list)

# -------------------------------------------------------
# Build item rows
# -------------------------------------------------------
func _build_shop_ui() -> void:
	for child in _list.get_children():
		child.queue_free()

	for asset in ASSETS:
		var slot      = _slot_key(asset["position"])
		var is_placed = _placed.get(slot, "") == asset["id"]

		# Row
		var row = HBoxContainer.new()
		row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.add_theme_constant_override("separation", 8)

		# ---- Icon as TextureButton (24x24) ----
		var icon_btn = TextureButton.new()
		icon_btn.custom_minimum_size = Vector2(24, 24)
		icon_btn.ignore_texture_size = true
		icon_btn.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED

		var tex = load(asset["icon"]) if asset["icon"] != "" else null
		if tex:
			icon_btn.texture_normal = tex

		if is_placed:
			icon_btn.modulate = Color(1, 1, 1, 0.4)
			icon_btn.disabled = true
		else:
			icon_btn.pressed.connect(_on_icon_pressed.bind(asset))

		row.add_child(icon_btn)

		# ---- Name + price ----
		var info = VBoxContainer.new()
		info.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var name_label = Label.new()
		name_label.text = asset["name"]
		_apply_font(name_label, is_placed)
		info.add_child(name_label)

		var price_label = Label.new()
		price_label.text = "%d coins" % asset["cost"]
		_apply_font(price_label, is_placed)
		info.add_child(price_label)

		row.add_child(info)

		_list.add_child(row)
		_list.add_child(HSeparator.new())

# -------------------------------------------------------
# Apply font — black text, dimmed if placed
# -------------------------------------------------------
func _apply_font(label: Label, is_placed: bool) -> void:
	if _font:
		label.add_theme_font_override("font", _font)
	label.add_theme_font_size_override("font_size", FONT_SIZE)
	if is_placed:
		label.add_theme_color_override("font_color", Color(0, 0, 0, 0.4))
	else:
		label.add_theme_color_override("font_color", Color.BLACK)

# -------------------------------------------------------
# Icon pressed — buy and place
# -------------------------------------------------------
func _on_icon_pressed(asset: Dictionary) -> void:
	if globals.coins < asset["cost"]:
		print("Not enough coins for: ", asset["name"])
		# TODO: flash a "not enough coins" message
		return

	var slot = _slot_key(asset["position"])

	# Refund previous asset in this slot
	if _placed.has(slot):
		for a in ASSETS:
			if a["id"] == _placed[slot]:
				globals.coins += a["cost"]
				break

	globals.coins -= asset["cost"]
	globals.save_game()

	_place_asset(asset)
	_save_state()
	_build_shop_ui()

	print("Placed: ", asset["name"], " | Coins left: ", globals.coins)

# -------------------------------------------------------
# Spawn asset — replaces whatever is in the same slot
# -------------------------------------------------------
func _place_asset(asset: Dictionary) -> void:
	var assets_node = get_tree().root.get_node("room/assets")
	var slot = _slot_key(asset["position"])

	if _spawned.has(slot) and is_instance_valid(_spawned[slot]):
		_spawned[slot].queue_free()
		_spawned.erase(slot)

	var scene = load(asset["scene"])
	if scene == null:
		print("ERROR: could not load scene: ", asset["scene"])
		return

	var instance = scene.instantiate()
	assets_node.add_child(instance)
	instance.position = asset["position"]

	_spawned[slot] = instance
	_placed[slot]  = asset["id"]

# -------------------------------------------------------
# Re-place all bought assets on game load
# -------------------------------------------------------
func _restore_placed_assets() -> void:
	for slot in _placed.keys():
		var asset_id = _placed[slot]
		for asset in ASSETS:
			if asset["id"] == asset_id:
				_place_asset(asset)
				break

func _slot_key(pos: Vector2) -> String:
	return "%d_%d" % [int(pos.x), int(pos.y)]

func _save_state() -> void:
	var config = ConfigFile.new()
	config.load(globals.SAVE_PATH)
	config.set_value("shop", "placed", _placed)
	config.save(globals.SAVE_PATH)

func _load_state() -> void:
	var config = ConfigFile.new()
	if config.load(globals.SAVE_PATH) == OK:
		_placed = config.get_value("shop", "placed", {})
	_restore_placed_assets()
