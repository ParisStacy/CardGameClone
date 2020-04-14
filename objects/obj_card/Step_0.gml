//Decide display
if (!revealed) {
	image_index = 0;
} else {
	switch (selectedType) {
		case cardTypes.rock:
			image_index = 1;
			break;
		case cardTypes.paper:
			image_index = 2;
			break;
		case cardTypes.scissors:
			image_index = 3;
			break;
		case cardTypes.noType:
			image_index = 4;
			break;
	}
}

//Lerp
x = lerp (x,targetX, .3);
y = lerp (y,targetY + targetYOffset, .3);


if (interactable) {
	targetYOffset = (instance_position(mouse_x,mouse_y,self)) ? -20 : 0;
	if (instance_position(mouse_x,mouse_y,self) && mouse_check_button_pressed(mb_left)) {
		selected = true;
		interactable = false;
		obj_manager.both_cards_selected = true;
	}
} else {
	targetYOffset = 0;
}

if (selected){
	targetX = 225
	targetY = (enemy) ? 135 : 215;
	if (!enemy) obj_manager.player_selection = self;
}
