//arg 1 is player
//arg 2 is enemy

if (argument0.selectedType == cardTypes.rock) {
	
	if (argument1.selectedType == cardTypes.rock) {
		//Nothing
	}
	if (argument1.selectedType == cardTypes.paper) {
		obj_manager.enemy_score++;
		audio_play_sound(lose, 1, false);
	}
	if (argument1.selectedType == cardTypes.scissors) {
		obj_manager.player_score++;
		audio_play_sound(win, 1, false);
	}
}
if (argument0.selectedType == cardTypes.paper) {
	
	if (argument1.selectedType == cardTypes.rock) {
		obj_manager.player_score++;
		audio_play_sound(win, 1, false);
	}
	if (argument1.selectedType == cardTypes.paper) {
	
	}
	if (argument1.selectedType == cardTypes.scissors) {
		obj_manager.enemy_score++;
		audio_play_sound(lose, 1, false);
	}
}
if (argument0.selectedType == cardTypes.scissors) {
	
	if (argument1.selectedType == cardTypes.rock) {
		obj_manager.enemy_score++;
		audio_play_sound(lose, 1, false);
	}
	if (argument1.selectedType == cardTypes.paper) {
		obj_manager.player_score++;
		audio_play_sound(win, 1, false);
	}
	if (argument1.selectedType == cardTypes.scissors) {
	
	}
} 

obj_manager.score_counted = true;