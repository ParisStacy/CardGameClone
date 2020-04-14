dealer_timer++;

if (last_index < 0) last_index = 23;

switch(current_state) {
	case gameStates.dealing:
			if (dealer_timer > 15) {
				
				dealer_timer = 0;
				
				if (cards_dealt == 6) {
					for (var i = 0; i < 3; i++) {
						var flip_card = ds_list_find_value(global.hand, i);
						flip_card.revealed = true;
						flip_card.interactable = true;
						current_state = gameStates.playing;
					}
				}
				
				var top_card = global.deck[| last_index];
				last_index--;
				
				if (cards_dealt < 3) {
					cards_dealt++;
					top_card.targetX = 125 + (50 * cards_dealt);
					top_card.targetY = 50;
					top_card.enemy = true;
					ds_list_add(global.enemyHand, top_card);
					ds_list_delete(global.deck,top_card);
					audio_play_sound(card, 1, false);
				} else if (cards_dealt < 6) {
					cards_dealt++
					top_card.targetX = 125 + (50 * (cards_dealt - 3));
					top_card.targetY = 300;
					ds_list_add(global.hand, top_card);
					ds_list_delete(global.deck,top_card);
					audio_play_sound(card, 1, false);
				}
			}
	break;
	case gameStates.playing:
		
		if (!enter_state_init) {
			var random_selection = random_range(0,3);
			enemy_selection = ds_list_find_value(global.enemyHand, random_selection);
			enemy_selection.selected = true;
			enter_state_init = true;
			both_cards_selected = false;
		}
		
		if (both_cards_selected) {
			enter_state_init = false;
			current_state = gameStates.matching;
			dealer_timer = 0;
			for (var i = 0; i < 3; i++) {
				var flip_card = ds_list_find_value(global.hand, i);
				flip_card.interactable = false;
			}
		}
	break;
	case gameStates.matching:
		dealer_timer++;
		if (dealer_timer > 60) {
			enemy_selection.revealed = true;
				
			if (!score_counted) who_won(player_selection,enemy_selection);
			show_debug_message(player_score);
			show_debug_message(enemy_score);
			
			if (dealer_timer > 180) {
				discard = true;
				cards_discarded = 0;
			}
		}
		if (discard && dealer_timer > 30) {
			dealer_timer = 0;
			if (cards_discarded < 3) {
				var discard_card = ds_list_find_value(global.enemyHand, cards_discarded);
				ds_list_add(global.discard, discard_card);
				discard_card.targetY = 177 - ds_list_size(global.discard) * 2;
				discard_card.targetX = 438;
				discard_card.revealed = true;
				discard_card.selected = false;
				discard_card.depth = -ds_list_size(global.discard);
				audio_play_sound(card, 1, false);
			} else {
				var discard_card = ds_list_find_value(global.hand, cards_discarded - 3);
				ds_list_add(global.discard, discard_card);
				discard_card.targetY = 177 - ds_list_size(global.discard) * 2;
				discard_card.targetX = 438;
				discard_card.revealed = true;
				discard_card.selected = false;
				discard_card.depth = -ds_list_size(global.discard);
				audio_play_sound(card, 1, false);
			}
			cards_discarded++;
			
			if (cards_discarded == 6) {
				ds_list_clear(global.enemyHand);
				ds_list_clear(global.hand);
				current_state = (last_index == 22) ? gameStates.resetting : gameStates.dealing;
				if (last_index == 22) ds_list_clear(global.deck);
				cards_dealt = 0;
				cards_discarded = 0;
				discard = false;
				last_index++;
				score_counted = false;
			}
		}
	break;
	case gameStates.resetting:
		dealer_timer++
		if (dealer_timer > 5 && discard_index >= 0) {
		//take from shuffle pile
		var reshuffle_card = ds_list_find_value(global.discard, discard_index);
			reshuffle_card.targetX = 30;
			reshuffle_card.targetY = 125 + discard_index * 2;
			reshuffle_card.enemy = false;
			reshuffle_card.revealed = false;
			reshuffle_card.depth = discard_index;
			ds_list_add(global.deck, reshuffle_card);
			ds_list_delete(global.discard,reshuffle_card);
			audio_play_sound(card, 1, false);
			discard_index--;
			if (discard_index < 0){
				ds_list_shuffle(global.deck);
				}
			dealer_timer = 0;
		} else if (dealer_timer > 10 && discard_index < 0 && correction_index >= 0) {
			var card_correction = ds_list_find_value(global.deck, correction_index);
				card_correction.depth = -correction_index;
				card_correction.x += random_range(-10,10);
				card_correction.targetY = 175;
				card_correction.targetY -= correction_index * 2;
				audio_play_sound(card, 1, false);
				correction_index--;
		}
		if (correction_index < 0) {
			current_state = gameStates.dealing;
			reset_variables();
			ds_list_clear(global.discard);
		}
		
	break;
}
