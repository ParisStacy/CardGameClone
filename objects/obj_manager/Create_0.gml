//Game States
enum gameStates {
dealing,
playing,
matching,
resetting,
}

randomize();

player_score = 0;
enemy_score = 0;

current_state = gameStates.dealing;

rock_cards    = 0
paper_cards   = 0

deck_total = 24;

dealer_timer = 0;
cards_dealt = 0;
last_index = 0;
discard_index = 0;
correction_index = 0;
reset_variables();

enter_state_init = false;

both_cards_selected = false;

enemy_selection = noone;
player_selection = noone;
score_counted = false;

discard = false;

//Lists
global.deck = ds_list_create();
global.hand = ds_list_create();
global.enemyHand = ds_list_create();
global.discard = ds_list_create();

//Create Cards (8 of each type)
for (var i = 0; i < deck_total; i++) {
	new_card = instance_create_layer(x,y,"Instances",obj_card);
	if (rock_cards < 9) {
		new_card.selectedType = cardTypes.rock;
		rock_cards++;
	} else if (paper_cards < 9) {
		new_card.selectedType = cardTypes.paper;
		paper_cards++;
	} else {
		new_card.selectedType = cardTypes.scissors;
	}
	ds_list_add(global.deck, new_card);
}

//Shuffle
ds_list_shuffle(global.deck);

//Offset Position
for (var i = 0; i < deck_total; i++) {
	var stack_card = ds_list_find_value(global.deck, i);
	stack_card.targetY -= (i * 2);
	stack_card.depth = -i;
}