response_matching = simple_matching;
default_font = "Apercu Mono";
active_buttons = 3;
event_code_delimiter = ";";
stimulus_properties = runid, string, blockid, string, form, string, character, string;
response_logging = log_active;

begin;

	array {
		text{caption = "D"; font_size= 50;};
		text{caption = "M"; font_size= 50;};
		text{caption = "X"; font_size= 50;};
		text{caption = "A"; font_size= 50;};
		text{caption = "T"; font_size= 50;};
		text{caption = "E"; font_size= 50;};
	}letters;

	array {
		text{caption = "2"; font_size= 50;};
		text{caption = "3"; font_size= 50;};
		text{caption = "4"; font_size= 50;};
		text{caption = "6"; font_size= 50;};
		text{caption = "7"; font_size= 50;};
		text{caption = "9"; font_size= 50;};
	}numbers;

	array {
		picture {
			description = "Viereck";
			box {width= 600; height= 600; color = 255,255,255;};
			x=0;y=0;
			box {width= 570; height=570; color = 0,0,0;};
			x=0;y=0;
			text{caption = ""; font_size= 50;};
			x=0;y=0;
			} main_picture_box;
		
		picture {
			description = "Kreis";
			ellipse_graphic {
				height = 600;
				width = 600;
				ellipse_height = 600;
				ellipse_width= 600;
				color = 255,255,255,255;
			};
			x=0;y=0;
				
			ellipse_graphic {
				height = 600;
				width = 600;
				ellipse_height = 570;
				ellipse_width= 570;
				color = 0,0,0,255;
			};
			x=0;y=0;
			
			text{caption = ""; font_size= 50;};
			x=0;y=0;
			} main_picture_circle;
		
		picture {
			description = "Dreieck";
			polygon_graphic {
				height = 750;
				width = 700;
				sides = 3;
				line_width = 15;
				line_color = 255,255,255,255;
				radius = 350;
			};
			x = 0; y = -50;
			
			polygon_graphic {
				height = 0;
				width = 0;
				sides = 3;
				fill_color = 0,0,0,255;
			};
			x = 0; y = 0;
			
			text{caption = ""; font_size= 50;};
			x=0;y=0;
		} main_picture_triangle;
	} form_array;

	trial {
		trial_duration = 1800;
		trial_type = first_response;
		
		stimulus_event{
		picture {} main_picture;
		duration = 250;
		}stim_event;
		
	} main_trial;

	trial {
		all_responses = false;
		picture {
			text {
				caption="+";
				font_size=50;
			};
			x=0; y=0;
		}cross;
	} trial_cross;

	trial {
		trial_duration = 2000;
		all_responses = false;
		picture {
			text { caption = ""; font_size = 24; max_text_width = 600;} feedback_text; 
			x=0; y=0;
		} feedback_pic;
	} feedback_trial;
	
	trial {
		trial_duration = forever;
		trial_type = first_response;
		all_responses = false;

		picture {
			text { caption = ""; font_size = 30; max_text_width = 1200;} introduction_text;
			x=0;y=0;
		} introduction_picture;
		stimulus_time_in = 3000;
		response_active= true;
	} introduction_trial;
	
	trial {
		trial_duration = forever;
		trial_type = first_response;
		all_responses = false;
		picture {
			text { caption = ""; font_size = 30;} instruction_text;
			x=0; y=0;
		} instruction_pic;
		stimulus_time_in = 2000;
		response_active= true;
		} instruction_trial;
	
	trial {
		trial_duration = 120000;
		
		picture {
			text {caption = "Pause \nIn 2 Minuten geht es weiter"; font_size = 30;};
			x=0; y=0;
		};
	} pause_trial;

################################PCL##############################################	
begin_pcl;

	int CHAR = 1;
	int FORM = 2;
	int max_time= 1000;
	array <int> ISI_values [] = {500, 700, 900, 1100, 1300, 1500, 1700, 1900, 2100, 2300};

	sub set_response_mode (int mode)
	begin
		if mode == 1
		then
			response_manager.set_button_active(1, false);
			response_manager.set_button_active(2, false);
			response_manager.set_button_active(3, true);
		elseif mode == 2
		then
			response_manager.set_button_active(1, true);
			response_manager.set_button_active(2, true);
			response_manager.set_button_active(3, false);
		end;
	end;
	sub bool validade (array<int,2> list_to_test, int seperate_attention, int form_target_index, 
							int char_target_index, array<text,1> char_array)
	begin 
		loop int i = 1 until i == list_to_test.count()
		begin
			if list_to_test[i] == list_to_test[i+1]
			then 
				return false;
			end;
			i = i + 1;
		end;
		
		loop int i = 1 until i == 2
		begin
			if seperate_attention == 1 
			then
				if char_array[list_to_test[i][CHAR]].caption() == char_array[char_target_index].caption()
				then
					return false;
				end;
			elseif seperate_attention == 2			
			then
				if list_to_test[i][FORM] == form_target_index
				then
					return false;
				end;
			elseif seperate_attention == 3 &&
				(char_array[list_to_test[i][CHAR]].caption() == char_array[char_target_index].caption()
				|| list_to_test[i][FORM] == form_target_index)
			then
				return false;
			end;
			i = i + 1;
		end;		
	
		loop int i = 2 until i == list_to_test.count()
		begin
			if seperate_attention == 1
			then
				if char_array[list_to_test[i][CHAR]].caption() == char_array[char_target_index].caption() &&
					char_array[list_to_test[i+1][CHAR]].caption() == char_array[char_target_index].caption()
				then 
					return false;
				end;
			elseif seperate_attention == 2
			then
				if list_to_test[i][FORM] == form_target_index &&
					list_to_test[i+1][FORM] == form_target_index 
				then
					return false;
				end;
			elseif seperate_attention == 3 &&
						(char_array[list_to_test[i][CHAR]].caption() == char_array[char_target_index].caption() 
								|| list_to_test[i][FORM] == form_target_index)
			then
				if 
					char_array[list_to_test[i+1][CHAR]].caption() == char_array[char_target_index].caption()
								|| list_to_test[i+1][FORM] == form_target_index
				then
					return false;
				end;
			end;
			i = i +1;
		end;
		return true;
	end;

	sub array<int,2> make_trial (int seperate_attention, int char_target_index, array<text,1> char_array,
											int form_target_index, int number_of_stimuli, int number_of_non_stimuli)
	begin
		array<int> list[0][2];
		
		if seperate_attention == 1
		then
			loop int i = 1 until i > number_of_stimuli
			begin
				array<int> tmp[2];
				tmp[CHAR] = char_target_index;
				tmp[FORM] = random(1, form_array.count());
				list.add(tmp);
				i = i + 1;
			end;
			
			loop until list.count() == number_of_stimuli + number_of_non_stimuli
			begin
				array<int> tmp[2];
				int rmd = random(1,char_array.count());
				if rmd != char_target_index
				then
					tmp[CHAR] = rmd;
					tmp[FORM] = random(1, form_array.count());
					list.add(tmp);
				end;
			end;
		elseif seperate_attention == 2
		then
			loop int i = 1 until i > number_of_stimuli
			begin
				array<int> tmp[2];
				tmp[CHAR] = random(1, char_array.count());
				tmp[FORM] = form_target_index;
				list.add(tmp);
				i = i + 1;
			end;
			
			loop until list.count() == number_of_stimuli + number_of_non_stimuli
			begin
				array<int> tmp[2];
				int rmd = random(1,form_array.count());
				if rmd != form_target_index
				then
					tmp[CHAR] = random(1,char_array.count());
					tmp[FORM] = rmd;
					list.add(tmp);
				end;
			end;
		elseif seperate_attention == 3
		then
			loop int i = 1 until i > number_of_stimuli/2
			begin
				array<int> tmp[2];
				tmp[CHAR] = char_target_index;
				tmp[FORM] = random(1, form_array.count());
				if tmp[FORM] != form_target_index
				then
				list.add(tmp);
				i = i + 1;
				end
			end;
			
			loop until list.count() == number_of_stimuli
			begin
				array<int> tmp[2];
				tmp[CHAR] = random(1,char_array.count());
				tmp[FORM] = form_target_index;
				if tmp[CHAR] != char_target_index
				then
					list.add(tmp);
				end;
			end;
				
			loop until list.count() == number_of_stimuli + number_of_non_stimuli
			begin
				array<int> tmp[2];
				int rmd_char = random(1,char_array.count());
				int rmd_form = random(1,form_array.count());
				if rmd_char != char_target_index && rmd_form != form_target_index
				then
					tmp[CHAR] = rmd_char;
					tmp[FORM] = rmd_form;
					list.add(tmp);
				end;
			end;
		end;
														  
		loop until (validade(list, seperate_attention ,form_target_index,
						char_target_index,char_array))
		begin
			list.shuffle();
		end;
		return list;
	end;

	# form_target:
	# 1 = Recktangle
	# 2 = Circle
	# 3 = Triangle
	sub present_trials( int seperate_attention, int char_target_index, array<text,1> char_array, 
								int form_target_index, array<int> trial_list[][], bool show_feedback, string run_id, string block_id)
	begin
	string instruction_string = "";
	if seperate_attention == 1
	then
		instruction_string = ("Drücken Sie die Taste L wenn " + char_array[char_target_index].caption() + " erscheint.");
	elseif seperate_attention == 2
	then
		instruction_string = ("Drücken Sie die Taste S wenn " + form_array[form_target_index].description() + " erscheint.");
	elseif seperate_attention == 3
	then
		instruction_string = "Drücken Sie die Taste L wenn " + char_array[char_target_index].caption() + " erscheint." +
									"\nDrücken Sie die Taste S wenn " + form_array[form_target_index].description() + " erscheint."
	end;
	instruction_string = instruction_string + "\nAntworten Sie so schnell sie können." +
															"\nDrücken Sie die Leertaste um fortzufahren.";
	instruction_text.set_caption(instruction_string, true);
	set_response_mode(1);
	instruction_trial.present();
	
	loop int i = 1 until i > trial_list.count()
	begin
		int char_index = trial_list[i][CHAR];
		int form_index = trial_list[i][FORM];

		main_picture = form_array[form_index];
		main_picture.set_part(3,char_array[char_index]);
		stim_event.set_stimulus(main_picture);
		stim_event.set_event_code(run_id + ";" + block_id + ";" + main_picture.description() + ";" + char_array[char_index].caption());

		string caption = char_array[char_index].caption();
		stim_event.set_target_button(0);
		stim_event.set_response_active(true);
		if seperate_attention == 1
		then
			if char_array[char_target_index].caption() == caption
			then
				stim_event.set_target_button(1);
			end;
		elseif seperate_attention == 2
		then
			if form_target_index == form_index
			then 
				stim_event.set_target_button(2);
			end;
		elseif seperate_attention == 3 
		then
			if char_array[char_target_index].caption() == caption
			then
				stim_event.set_target_button(1);
			end;
			if form_target_index == form_index
			then
				stim_event.set_target_button(2);
			end;
			
		end;
		
		#ISI
		if i == 1
		then 
			trial_cross.set_duration(1000);
		else
			trial_cross.set_duration(ISI_values[random(1,ISI_values.count())]);
		end;
		trial_cross.present();
		set_response_mode(2);
		main_trial.present();

		i=i+1;
			
		if show_feedback
		then
			string new_caption = "";
			stimulus_data last = stimulus_manager.last_stimulus_data();
			if (last.type() == last.HIT) then
				new_caption = "Richtig";
			elseif (last.type() == last.INCORRECT) then
				new_caption = "Falsche Taste";
			elseif (last.type() == last.MISS) then
				new_caption = "Falsch\nSie hätten drücken müssen";
			elseif (last.type() == last.FALSE_ALARM) then
				new_caption = "Falsch\nSie hätten nicht drücken müssen";
			end;
			
			feedback_text.set_caption(new_caption, true);
			feedback_trial.present();	
			end;
		end;
	end;
	
#	Parameter for make_trial and present_trial
#	1. Value: selective_attention: 1 = only a char is a target
#											 2 = only a form is a target
#											 3 = a char and a form is a target
#	2. Value: index of char target. Use -1 if no char targets will be presentet
#	3. Value: char array to be used
#	4. Value: index of form target in form_array. Use -1 if no form targets will be presentet

# make_trial:
#	5. Value: number of targets in returned trial
#	6. Value: number of non targets in returned trial

# present_trial
#	5. Value: trial to be presentet as array<int,2>
#	6. Value: bool to determin if feedback will be given. true = feedback

##########################Test Run########################################


	introduction_text.set_caption("Allgemeiner Text über das gesamte Experiment. Weiter mit Leertaste(nach 3 sekunden möglich)",true);
	set_response_mode(1);
	introduction_trial.present();
	
	array<int> test[][] = make_trial(1, 4, letters, -1, 2, 8);
	present_trials(1, 4, letters, -1, test, true, "test", "block1");
	array<int> test2[][] = make_trial(2, -1, numbers, 1, 2, 8);
	present_trials(2, -1, numbers, 1, test2, true, "test", "block2");
	array<int> test3[][] = make_trial(1, 4, numbers, -1, 2, 8);
	present_trials(1, 4, numbers, -1, test3, true, "test", "block3");
	array<int> test4[][] = make_trial(2, -1, letters, 1, 2, 8);
	present_trials(2, -1, letters, 1, test4, true, "test", "block4");
	
	array<int> test5[][] = make_trial(3, 4, letters, 1, 2, 8);
	present_trials(3, 4, letters, 1, test5, true, "test", "block5");
	array<int> test6[][] = make_trial(3, 1, numbers, 1, 2, 8);
	present_trials(3, 1, numbers, 1, test6, true, "test", "block6");
	array<int> test7[][] = make_trial(3, 4, numbers, 2, 2, 8);
	present_trials(1, 4, numbers, 1, test7, true, "test", "block7");
	array<int> test8[][] = make_trial(3, 6, letters, 3, 2, 8);
	present_trials(3, 6, letters, 3, test8, true, "test", "block8");
	
	array<int> test9[][] = make_trial(3, 4, letters, 1, 2, 8);
	present_trials(1, 4, letters, 1, test9, true, "test", "block9");
	array<int> test10[][] = make_trial(2, -1, numbers, 1, 2, 8);
	present_trials(2, 4, numbers, 1, test10, true, "test", "block10");
	array<int> test11[][] = make_trial(1, 4, numbers, -1, 2, 8);
	present_trials(1, 4, numbers, 1, test11, true, "test", "block11");
	array<int> test12[][] = make_trial(3, 6, letters, 3, 2, 8);
	present_trials(2, 4, letters, 1, test12, true, "test", "block12");
	
##########################Run 1########################################

	pause_trial.present();
	
	introduction_text.set_caption("Run1 text. Weiter mit Leertaste(nach 3 sekunden möglich)",true);
	set_response_mode(1);
	introduction_trial.present();
	
	array<int> run1_block1[][] = make_trial(2, 4, letters, 1, 6, 20);
	present_trials(2, 4, letters, 1, run1_block1, false, "run_1", "block_1");
	array<int> run1_block2[][] = make_trial(1, 1, letters, 1, 6, 20);
	present_trials(1, 1, letters, 1, run1_block2, false, "run_1", "block_2");
	array<int> run1_block3[][] = make_trial(1, 4, numbers, 1, 6, 20);
	present_trials(1, 4, numbers, 1, run1_block3, false, "run_1", "block_3");
	array<int> run1_block4[][] = make_trial(3, 4, letters, 1, 6, 20);
	present_trials(3, 4, letters, 1, run1_block4, false, "run_1", "block_4");
	array<int> run1_block5[][] = make_trial(3, 5, numbers, 2, 6, 20);
	present_trials(3, 5, numbers, 1, run1_block5, false, "run_1", "block_5");
	array<int> run1_block6[][] = make_trial(3, 1, letters, 3, 6, 20);
	present_trials(3, 1, letters, 1, run1_block6, false, "run_1", "block_6");
	
##########################Run 2########################################

	pause_trial.present();
	
	introduction_text.set_caption("Run2 text. Weiter mit Leertaste(nach 3 sekunden möglich)",true);
	set_response_mode(1);
	introduction_trial.present();
	
	array<int> run2_block1[][] = make_trial(1, 2, letters, 1, 6, 20);
	present_trials(1, 2, letters, 1, run2_block1, false, "run_2", "block_1");
	array<int> run2_block2[][] = make_trial(1, 1, numbers, 1, 6, 20);
	present_trials(2, 1, letters, 1, run2_block2, false, "run_2", "block_2");
	array<int> run2_block3[][] = make_trial(3, 4, letters, 1, 6, 20);
	present_trials(3, 4, numbers, 1, run2_block3, false, "run_2", "block_3");
	array<int> run2_block4[][] = make_trial(3, 4, numbers, 1, 6, 20);
	present_trials(3, 4, letters, 1, run1_block4, false, "run_2", "block_4");
	array<int> run2_block5[][] = make_trial(2, 5, numbers, 2, 6, 20);
	present_trials(2, 5, numbers, 1, run2_block5, false, "run_2", "block_5");
	array<int> run2_block6[][] = make_trial(3, 1, letters, 3, 6, 20);
	present_trials(3, 1, letters, 1, run2_block6, false, "run_2", "block_6");
	
##########################Run 3########################################

	pause_trial.present();

	introduction_text.set_caption("Run3 text. Weiter mit Leertaste(nach 3 sekunden möglich)",true);
	set_response_mode(1);
	introduction_trial.present();
	
	array<int> run3_block1[][] = make_trial(3, 4, letters, 1, 6, 20);
	present_trials(3, 4, letters, 1, run3_block1, false, "run_3", "block_1");
	array<int> run3_block2[][] = make_trial(1, 1, numbers, 1, 6, 20);
	present_trials(1, 1, letters, 1, run3_block2, false, "run_3", "block_2");
	array<int> run3_block3[][] = make_trial(3, 4, letters, 1, 6, 20);
	present_trials(3, 4, letters, 1, run3_block3, false, "run_3", "block_3");
	array<int> run3_block4[][] = make_trial(2, 4, numbers, 1, 6, 20);
	present_trials(2, 4, numbers, 1, run3_block4, false, "run_3", "block_4");
	array<int> run3_block5[][] = make_trial(3, 5, numbers, 2, 6, 20);
	present_trials(3, 5, numbers, 1, run3_block5, false, "run_3", "block_5");
	array<int> run3_block6[][] = make_trial(1, 1, letters, 3, 6, 20);
	present_trials(1, 1, letters, 1, run3_block6, false, "run_3", "block_6");
	
	introduction_text.set_caption("Bitte wenden Sie sich an den Versuchsleiter",true);
	set_response_mode(1);
	introduction_trial.present();
