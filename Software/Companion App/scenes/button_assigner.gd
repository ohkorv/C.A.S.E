extends Control

# Samma arrays som tidigare
@export var middle_buttons: Array[Button]
@export var right_buttons: Array[Button]

var selected_middle_button: Button = null

func _ready():
	# Konfigurera alla mittenknappar automatiskt för centrerade ikoner
	for button in middle_buttons:
		if button != null:
			# 1. Koppla signalen som vanligt
			button.pressed.connect(_on_middle_button_pressed.bind(button))
			
			# 2. TVINGA FRAM RÄTT LAYOUT:
			# Detta ser till att ikonen hamnar i mitten och skalas rätt
			# utan att ändra knappens storlek.
			button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
			button.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER
			button.expand_icon = true # GÖR ATT IKONEN SKALAS ATT PASSA KNAPPEN
			
			# Tips: Se till att knappen har en bestämd 'Minimum Size' 
			# i Inspektorn för bästa resultat.
			
	# Koppla signalen för högerknappar
	for button in right_buttons:
		if button != null:
			button.pressed.connect(_on_right_button_pressed.bind(button))

# --- Resten av koden är samma som tidigare ---

func _on_middle_button_pressed(clicked_button: Button):
	selected_middle_button = clicked_button
	# print("Vald knapp i mitten: ", clicked_button.name)
	
	for btn in middle_buttons:
		if btn != null:
			btn.modulate = Color(1, 1, 1)
	clicked_button.modulate = Color(0.6, 0.8, 1.0) 

func _on_right_button_pressed(clicked_button: Button):
	if selected_middle_button != null:
		# Kopiera ikonen. Tack vare expand_icon=true i _ready()
		# så skalas nu ikonen inuti den befintliga knappen.
		selected_middle_button.icon = clicked_button.icon
		# print("Kopierade ikon")
		
		selected_middle_button.modulate = Color(1, 1, 1)
		selected_middle_button = null
