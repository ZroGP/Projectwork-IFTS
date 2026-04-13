extends MarginContainer

# -------------------------------------------------------
# MALE ASSETS
# "z" controls draw order — higher = drawn on top
# Tune these values if something still overlaps wrongly
# -------------------------------------------------------
const ASSETS_MALE = [
	# --- Pets ---
	{
		"id": "cat_void", "name": "Void", "cost": 3, "category": "Pets",
		"icon": "res://assets/pets/cat_void.png",
		"scene": "res://scenes/room/pets/cat_void.tscn",
		"position": Vector2(415, -145), "z": 5
	},
	# --- Beds ---
	{
		"id": "bed_black_2", "name": "Bed Black", "cost": 300, "category": "Beds",
		"icon": "res://assets/room/bed/sprite_bed_black2.png",
		"scene": "res://scenes/room/bed/bed_black_2.tscn",
		"position": Vector2(409, -147), "z": 3
	},
	{
		"id": "bed_cyan_2", "name": "Bed Cyan", "cost": 300, "category": "Beds",
		"icon": "res://assets/room/bed/sprite_bed_cyan2.png",
		"scene": "res://scenes/room/bed/bed_cyan_2.tscn",
		"position": Vector2(409, -147), "z": 3
	},
	{
		"id": "bed_olive_2", "name": "Bed Olive", "cost": 300, "category": "Beds",
		"icon": "res://assets/room/bed/sprite_bed_olive2.png",
		"scene": "res://scenes/room/bed/bed_olive_2.tscn",
		"position": Vector2(409, -147), "z": 3
	},
	{
		"id": "bed_violet_2", "name": "Bed Violet", "cost": 300, "category": "Beds",
		"icon": "res://assets/room/bed/sprite_bed_violet2.png",
		"scene": "res://scenes/room/bed/bed_violet_2.tscn",
		"position": Vector2(409, -147), "z": 3
	},
	# --- Carpets ---
	{
		"id": "carpet_blu_1", "name": "Carpet Blu", "cost": 150, "category": "Carpets",
		"icon": "res://assets/room/carpet/carpet_blu1.png",
		"scene": "res://scenes/room/carpet/carpet_blu_1.tscn",
		"position": Vector2(479, -130), "z": 1
	},
	{
		"id": "carpet_green_1", "name": "Carpet Green", "cost": 150, "category": "Carpets",
		"icon": "res://assets/room/carpet/carpet_green1.png",
		"scene": "res://scenes/room/carpet/carpet_green_1.tscn",
		"position": Vector2(479, -130), "z": 1
	},
	{
		"id": "carpet_ivery_1", "name": "Carpet Ivory", "cost": 150, "category": "Carpets",
		"icon": "res://assets/room/carpet/carpet_ivory1.png",
		"scene": "res://scenes/room/carpet/carpet_ivory_1.tscn",
		"position": Vector2(479, -130), "z": 1
	},
	{
		"id": "carpet_red_1", "name": "Carpet Red", "cost": 150, "category": "Carpets",
		"icon": "res://assets/room/carpet/carpet_red1.png",
		"scene": "res://scenes/room/carpet/carpet_red_1.tscn",
		"position": Vector2(479, -130), "z": 1
	},
	# --- Chairs ---
	{
		"id": "chair_black_1", "name": "Chair Black", "cost": 75, "category": "Chairs",
		"icon": "res://assets/room/chair/chair_black1.png",
		"scene": "res://scenes/room/chair/chair_black_1.tscn",
		"position": Vector2(464, -163), "z": 4
	},
	{
		"id": "chair_cream_1", "name": "Chair Cream", "cost": 75, "category": "Chairs",
		"icon": "res://assets/room/chair/chair_cream1.png",
		"scene": "res://scenes/room/chair/chair_cream_1.tscn",
		"position": Vector2(464, -163), "z": 4
	},
	{
		"id": "chair_lilla_1", "name": "Chair Lilla", "cost": 75, "category": "Chairs",
		"icon": "res://assets/room/chair/chair_lilla1.png",
		"scene": "res://scenes/room/chair/chair_lilla_1.tscn",
		"position": Vector2(464, -163), "z": 4
	},
	# --- Consoles ---
	{
		"id": "console_gray_2", "name": "Console Gray", "cost": 150, "category": "Consoles",
		"icon": "res://assets/room/console/console_grey2.png",
		"scene": "res://scenes/room/console/console_grey_2.tscn",
		"position": Vector2(435, -119), "z": 6
	},
	{
		"id": "console_white_2", "name": "Console White", "cost": 150, "category": "Consoles",
		"icon": "res://assets/room/console/console_white2.png",
		"scene": "res://scenes/room/console/console_white_2.tscn",
		"position": Vector2(435, -119), "z": 6
	},
	# --- Desks ---
	{
		"id": "desk_2", "name": "Desk", "cost": 225, "category": "Desks",
		"icon": "res://assets/room/desk/desk2.png",
		"scene": "res://scenes/room/desk/desk_2.tscn",
		"position": Vector2(455, -169), "z": 3
	},
	# --- Lamps ---
	{
		"id": "lamp_green_2", "name": "Lamp Green", "cost": 100, "category": "Lamps",
		"icon": "res://assets/room/lamps/lamp_green2.png",
		"scene": "res://scenes/room/lamp/lamp_green_2.tscn",
		"position": Vector2(467, -185), "z": 2
	},
	{
		"id": "lamp_orange_2", "name": "Lamp Orange", "cost": 100, "category": "Lamps",
		"icon": "res://assets/room/lamps/lamp_orange2.png",
		"scene": "res://scenes/room/lamp/lamp_orange_2.tscn",
		"position": Vector2(467, -185), "z": 2
	},
	{
		"id": "lamp_white_2", "name": "Lamp White", "cost": 100, "category": "Lamps",
		"icon": "res://assets/room/lamps/lamp_white2.png",
		"scene": "res://scenes/room/lamp/lamp_white_2.tscn",
		"position": Vector2(467, -185), "z": 2
	},
	# --- Decorations ---
	{
		"id": "cactus_2", "name": "Cactus", "cost": 15, "category": "Decorations",
		"icon": "res://assets/room/plants/cactus2.png",
		"scene": "res://scenes/room/plants/cactus_2.tscn",
		"position": Vector2(488, -185), "z": 2
	},
	{
		"id": "exotic_1", "name": "Exotic", "cost": 20, "category": "Decorations",
		"icon": "res://assets/room/plants/exotic1.png",
		"scene": "res://scenes/room/plants/exotic_1.tscn",
		"position": Vector2(445, -177), "z": 2
	},
	{
		"id": "books_2", "name": "Books", "cost": 30, "category": "Decorations",
		"icon": "res://assets/room/books/books2.png",
		"scene": "res://scenes/room/books/books_2.tscn",
		"position": Vector2(495, -184), "z": 7
	},
	# --- Paintings ---
	{
		"id": "paint_2", "name": "Paint", "cost": 75, "category": "Paintings",
		"icon": "res://assets/room/paintings/paint2.png",
		"scene": "res://scenes/room/paintings/paint_2.tscn",
		"position": Vector2(397, -164), "z": 0
	},
	# --- PCs ---
	{
		"id": "pc_grey_2", "name": "PC Grey", "cost": 500, "category": "PCs",
		"icon": "res://assets/room/pc/pc_grey2.png",
		"scene": "res://scenes/room/pc/pc_grey_2.tscn",
		"position": Vector2(457, -180), "z": 5
	},
	{
		"id": "pc_white_2", "name": "PC White", "cost": 500, "category": "PCs",
		"icon": "res://assets/room/pc/pc_white2.png",
		"scene": "res://scenes/room/pc/pc_white_2.tscn",
		"position": Vector2(457, -180), "z": 5
	},
	# --- Shelves ---
	{
		"id": "shelf_2", "name": "Shelf", "cost": 50, "category": "Shelves",
		"icon": "res://assets/room/shelfs/shelf2.png",
		"scene": "res://scenes/room/shelfs/shelf_2.tscn",
		"position": Vector2(492, -179), "z": 2
	},
	# --- Windows ---
	{
		"id": "widow_1", "name": "Window", "cost": 150, "category": "Windows",
		"icon": "res://assets/room/windows/window1.png",
		"scene": "res://scenes/room/windows/window1.tscn",
		"position": Vector2(480, -204), "z": 0
	},
	{
		"id": "widow_2", "name": "Window", "cost": 200, "category": "Windows",
		"icon": "res://assets/room/windows/window2.png",
		"scene": "res://scenes/room/windows/window2.tscn",
		"position": Vector2(520, -189), "z": 0
	},
	{
		"id": "widow_3", "name": "Window", "cost": 200, "category": "Windows",
		"icon": "res://assets/room/windows/window3.png",
		"scene": "res://scenes/room/windows/window3.tscn",
		"position": Vector2(520, -189), "z": 0
	},
	# --- Specials ---
	{
		"id": "punchin_bag_red", "name": "Punching Bag Red", "cost": 110, "category": "Specials",
		"icon": "res://assets/room/specials/punching_bag_red.png",
		"scene": "res://scenes/room/specials/punching_bag_red.tscn",
		"position": Vector2(532, -150), "z": 3
	},
	{
		"id": "punchin_bag_black", "name": "Punching Bag Black", "cost": 110, "category": "Specials",
		"icon": "res://assets/room/specials/punching_bag_black.png",
		"scene": "res://scenes/room/specials/punching_bag_black.tscn",
		"position": Vector2(532, -150), "z": 3
	},
	# Add more male assets here...
]

# -------------------------------------------------------
# FEMALE ASSETS
# -------------------------------------------------------
const ASSETS_FEMALE = [
	# --- Pets ---
	{
		"id": "f_cat_void", "name": "Void", "cost": 3, "category": "Pets",
		"icon": "res://assets/pets/cat_void.png",
		"scene": "res://scenes/room/pets/cat_void.tscn",
		"position": Vector2(461, -174), "z": 5
	},
	# --- Beds ---
	{
		"id": "f_bed_black_1", "name": "Bed Black", "cost": 300, "category": "Beds",
		"icon": "res://assets/room/bed/sprite_bed_black1.png",
		"scene": "res://scenes/room/bed/bed_black_1.tscn",
		"position": Vector2(460, -175), "z": 3
	},
	{
		"id": "f_bed_cyan_1", "name": "Bed Cyan", "cost": 300, "category": "Beds",
		"icon": "res://assets/room/bed/sprite_bed_cyan1.png",
		"scene": "res://scenes/room/bed/bed_cyan_1.tscn",
		"position": Vector2(460, -175), "z": 3
	},
	{
		"id": "f_bed_olive_1", "name": "Bed Olive", "cost": 300, "category": "Beds",
		"icon": "res://assets/room/bed/sprite_bed_olive1.png",
		"scene": "res://scenes/room/bed/bed_olive_1.tscn",
		"position": Vector2(460, -175), "z": 3
	},
	{
		"id": "f_bed_violet_1", "name": "Bed Violet", "cost": 300, "category": "Beds",
		"icon": "res://assets/room/bed/sprite_bed_violet1.png",
		"scene": "res://scenes/room/bed/bed_violet_1.tscn",
		"position": Vector2(460, -175), "z": 3
	},
	# --- Carpets ---
	{
		"id": "f_carpet_blu_2", "name": "Carpet Blu", "cost": 150, "category": "Carpets",
		"icon": "res://assets/room/carpet/carpet_blu2.png",
		"scene": "res://scenes/room/carpet/carpet_blu_2.tscn",
		"position": Vector2(457, -124), "z": 1
	},
	{
		"id": "f_carpet_green_2", "name": "Carpet Green", "cost": 150, "category": "Carpets",
		"icon": "res://assets/room/carpet/carpet_green2.png",
		"scene": "res://scenes/room/carpet/carpet_green_2.tscn",
		"position": Vector2(457, -124), "z": 1
	},
	{
		"id": "f_carpet_ivery_2", "name": "Carpet Ivory", "cost": 150, "category": "Carpets",
		"icon": "res://assets/room/carpet/carpet_ivory2.png",
		"scene": "res://scenes/room/carpet/carpet_ivory_2.tscn",
		"position": Vector2(457, -124), "z": 1
	},
	{
		"id": "f_carpet_red_2", "name": "Carpet Red", "cost": 150, "category": "Carpets",
		"icon": "res://assets/room/carpet/carpet_red2.png",
		"scene": "res://scenes/room/carpet/carpet_red_2.tscn",
		"position": Vector2(457, -124), "z": 1
	},
	# --- Chairs ---
	{
		"id": "f_chair_black_2", "name": "Chair Black", "cost": 75, "category": "Chairs",
		"icon": "res://assets/room/chair/chair_black2.png",
		"scene": "res://scenes/room/chair/chair_black_2.tscn",
		"position": Vector2(507, -145), "z": 4
	},
	{
		"id": "f_chair_cream_2", "name": "Chair Cream", "cost": 75, "category": "Chairs",
		"icon": "res://assets/room/chair/chair_cream2.png",
		"scene": "res://scenes/room/chair/chair_cream_2.tscn",
		"position": Vector2(507, -145), "z": 4
	},
	{
		"id": "f_chair_lilla_2", "name": "Chair Lilla", "cost": 75, "category": "Chairs",
		"icon": "res://assets/room/chair/chair_lilla2.png",
		"scene": "res://scenes/room/chair/chair_lilla_2.tscn",
		"position": Vector2(507, -145), "z": 4
	},
	# --- Consoles ---
	{
		"id": "f_console_gray_1", "name": "Console Gray", "cost": 150, "category": "Consoles",
		"icon": "res://assets/room/console/console_grey1.png",
		"scene": "res://scenes/room/console/console_grey_1.tscn",
		"position": Vector2(490, -154), "z": 6
	},
	{
		"id": "f_console_white_1", "name": "Console White", "cost": 150, "category": "Consoles",
		"icon": "res://assets/room/console/console_white1.png",
		"scene": "res://scenes/room/console/console_white_1.tscn",
		"position": Vector2(490, -154), "z": 6
	},
	# --- Desks ---
	{
		"id": "f_desk_1", "name": "Desk", "cost": 225, "category": "Desks",
		"icon": "res://assets/room/desk/desk1.png",
		"scene": "res://scenes/room/desk/desk_1.tscn",
		"position": Vector2(512, -154), "z": 3
	},
	# --- Lamps ---
	{
		"id": "f_lamp_green_1", "name": "Lamp Green", "cost": 100, "category": "Lamps",
		"icon": "res://assets/room/lamps/lamp_green1.png",
		"scene": "res://scenes/room/lamp/lamp_green_1.tscn",
		"position": Vector2(538, -150), "z": 2
	},
	{
		"id": "f_lamp_orange_1", "name": "Lamp Orange", "cost": 100, "category": "Lamps",
		"icon": "res://assets/room/lamps/lamp_orange1.png",
		"scene": "res://scenes/room/lamp/lamp_orange_1.tscn",
		"position": Vector2(538, -150), "z": 2
	},
	{
		"id": "f_lamp_white_1", "name": "Lamp White", "cost": 100, "category": "Lamps",
		"icon": "res://assets/room/lamps/lamp_white1.png",
		"scene": "res://scenes/room/lamp/lamp_white_1.tscn",
		"position": Vector2(538, -150), "z": 2
	},
	# --- Decorations ---
	{
		"id": "f_cactus_1", "name": "Cactus", "cost": 15, "category": "Decorations",
		"icon": "res://assets/room/plants/cactus1.png",
		"scene": "res://scenes/room/plants/cactus_1.tscn",
		"position": Vector2(500, -165), "z": 2
	},
	{
		"id": "f_exotic_2", "name": "Exotic", "cost": 20, "category": "Decorations",
		"icon": "res://assets/room/plants/exotic2.png",
		"scene": "res://scenes/room/plants/exotic_2.tscn",
		"position": Vector2(455, -207), "z": 2
	},
	{
		"id": "f_books_1", "name": "Books", "cost": 30, "category": "Decorations",
		"icon": "res://assets/room/books/books1.png",
		"scene": "res://scenes/room/books/books_1.tscn",
		"position": Vector2(449, -205), "z": 7
	},
	# --- Paintings ---
	{
		"id": "f_paint_2", "name": "Paint", "cost": 75, "category": "Paintings",
		"icon": "res://assets/room/paintings/paint2.png",
		"scene": "res://scenes/room/paintings/paint_2.tscn",
		"position": Vector2(398, -173), "z": 0
	},
	# --- PCs ---
	{
		"id": "f_pc_grey_1", "name": "PC Grey", "cost": 500, "category": "PCs",
		"icon": "res://assets/room/pc/pc_grey1.png",
		"scene": "res://scenes/room/pc/pc_grey_1.tscn",
		"position": Vector2(514, -164), "z": 5
	},
	{
		"id": "f_pc_white_1", "name": "PC White", "cost": 500, "category": "PCs",
		"icon": "res://assets/room/pc/pc_white1.png",
		"scene": "res://scenes/room/pc/pc_white_1.tscn",
		"position": Vector2(514, -164), "z": 5
	},
	# --- Shelves ---
	{
		"id": "f_shelf_1", "name": "Shelf", "cost": 50, "category": "Shelves",
		"icon": "res://assets/room/shelfs/shelf1.png",
		"scene": "res://scenes/room/shelfs/shelf_1.tscn",
		"position": Vector2(451, -200), "z": 2
	},
	# --- Windows ---
	{
		"id": "f_widow_1", "name": "Window", "cost": 150, "category": "Windows",
		"icon": "res://assets/room/windows/window1.png",
		"scene": "res://scenes/room/windows/window1.tscn",
		"position": Vector2(480, -204), "z": 0
	},
	{
		"id": "f_widow_2", "name": "Window", "cost": 200, "category": "Windows",
		"icon": "res://assets/room/windows/window2.png",
		"scene": "res://scenes/room/windows/window2.tscn",
		"position": Vector2(520, -189), "z": 0
	},
	{
		"id": "f_widow_3", "name": "Window", "cost": 200, "category": "Windows",
		"icon": "res://assets/room/windows/window3.png",
		"scene": "res://scenes/room/windows/window3.tscn",
		"position": Vector2(520, -189), "z": 0
	},
	# --- Specials ---
	{
		"id": "f_pouf_pink", "name": "Pouf Pink", "cost": 110, "category": "Specials",
		"icon": "res://assets/room/specials/pouf_pink.png",
		"scene": "res://scenes/room/specials/pouf_pink.tscn",
		"position": Vector2(402, -143), "z": 3
	},
	{
		"id": "f_pouf_cyan", "name": "Pouf Cyan", "cost": 110, "category": "Specials",
		"icon": "res://assets/room/specials/pouf_cyan.png",
		"scene": "res://scenes/room/specials/pouf_cyan.tscn",
		"position": Vector2(402, -143), "z": 3
	},
	# Add more female assets here...
]

const FONT_PATH = "res://assets/fonts/PIXELADE.TTF"
const FONT_SIZE = 14
const TOP_OFFSET = 500

var _spawned:  Dictionary = {}
var _placed:   Dictionary = {}
var _font:     FontFile
var _open:     Dictionary = {}
var _panels:   Dictionary = {}

var ASSETS: Array = []

func _ready() -> void:
	_font = load(FONT_PATH)
	if globals.player_character.contains("female"):
		ASSETS = ASSETS_FEMALE
	else:
		ASSETS = ASSETS_MALE
	_build_ui()
	_load_state()

func _build_ui() -> void:
	var scroll = ScrollContainer.new()
	scroll.size_flags_horizontal  = Control.SIZE_EXPAND_FILL
	scroll.size_flags_vertical    = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.vertical_scroll_mode   = ScrollContainer.SCROLL_MODE_SHOW_NEVER
	scroll.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	scroll.offset_top = TOP_OFFSET
	add_child(scroll)

	var main_list = VBoxContainer.new()
	main_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	main_list.add_theme_constant_override("separation", 2)
	scroll.add_child(main_list)

	for cat in _get_categories():
		_open[cat] = false

		var header = Button.new()
		header.text = cat
		header.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		header.alignment = HORIZONTAL_ALIGNMENT_LEFT
		if _font:
			header.add_theme_font_override("font", _font)
		header.add_theme_font_size_override("font_size", FONT_SIZE)
		header.add_theme_color_override("font_color", Color.BLACK)
		header.add_theme_color_override("font_hover_color", Color.BLACK)
		header.add_theme_color_override("font_pressed_color", Color.BLACK)
		header.add_theme_color_override("font_focus_color", Color.BLACK)
		for state in ["normal", "hover", "pressed", "focus"]:
			var sb = StyleBoxFlat.new()
			sb.bg_color = Color(0, 0, 0, 0)
			sb.set_content_margin(SIDE_LEFT,   10)
			sb.set_content_margin(SIDE_RIGHT,  10)
			sb.set_content_margin(SIDE_TOP,     4)
			sb.set_content_margin(SIDE_BOTTOM,  4)
			header.add_theme_stylebox_override(state, sb)
		header.pressed.connect(_toggle_category.bind(cat))
		main_list.add_child(header)

		var panel = VBoxContainer.new()
		panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		panel.add_theme_constant_override("separation", 4)
		panel.visible = false
		main_list.add_child(panel)

		_panels[cat] = panel
		_fill_panel(cat)

func _toggle_category(cat: String) -> void:
	_open[cat] = not _open[cat]
	_panels[cat].visible = _open[cat]

func _fill_panel(cat: String) -> void:
	var panel: VBoxContainer = _panels[cat]
	for child in panel.get_children():
		child.queue_free()

	for asset in ASSETS:
		if asset["category"] != cat:
			continue

		var slot      = _slot_key(asset["position"])
		var is_placed = _placed.get(slot, "") == asset["id"]

		var row = HBoxContainer.new()
		row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.add_theme_constant_override("separation", 10)
		row.add_theme_constant_override("margin_left",  10)
		row.add_theme_constant_override("margin_right", 10)

		var icon_btn = TextureButton.new()
		icon_btn.custom_minimum_size = Vector2(32, 32)
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

		var info = VBoxContainer.new()
		info.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var name_lbl = Label.new()
		name_lbl.text = asset["name"]
		_apply_font(name_lbl, is_placed)
		info.add_child(name_lbl)

		var price_lbl = Label.new()
		price_lbl.text = "%d coins" % asset["cost"]
		_apply_font(price_lbl, is_placed)
		info.add_child(price_lbl)

		row.add_child(info)
		panel.add_child(row)
		panel.add_child(HSeparator.new())

func _apply_font(label: Label, is_placed: bool) -> void:
	if _font:
		label.add_theme_font_override("font", _font)
	label.add_theme_font_size_override("font_size", FONT_SIZE)
	label.add_theme_color_override("font_color",
		Color(0, 0, 0, 0.4) if is_placed else Color.BLACK)

func _on_icon_pressed(asset: Dictionary) -> void:
	if globals.coins < asset["cost"]:
		print("Not enough coins for: ", asset["name"])
		return

	var slot = _slot_key(asset["position"])

	if _placed.has(slot):
		for a in ASSETS:
			if a["id"] == _placed[slot]:
				globals.coins += a["cost"]
				break

	globals.coins -= asset["cost"]
	globals.save_game()

	_place_asset(asset)
	_save_state()
	_fill_panel(asset["category"])

	print("Placed: ", asset["name"], " | Coins left: ", globals.coins)

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
	# Apply manual z_index — tune the "z" value per asset in the catalogue above
	instance.z_index = asset.get("z", 0)

	_spawned[slot] = instance
	_placed[slot]  = asset["id"]

func _restore_placed_assets() -> void:
	for slot in _placed.keys():
		var asset_id = _placed[slot]
		for asset in ASSETS:
			if asset["id"] == asset_id:
				_place_asset(asset)
				break

func _get_categories() -> Array:
	var seen: Array = []
	for asset in ASSETS:
		if not asset["category"] in seen:
			seen.append(asset["category"])
	return seen

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
