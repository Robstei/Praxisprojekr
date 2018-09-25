response_matching = simple_matching;
scenario = "Messung von Wechselkosten zwischen geteilter und selektiver Aufmerksamkeit";
default_font = "Apercu Mono";
active_buttons = 3;
event_code_delimiter = ";";
stimulus_properties = configuration, number, runid, string, blockid, string, form, string, character, string, seperateAttention, number, target, number;
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
		text{caption = "5"; font_size= 50;};
		text{caption = "7"; font_size= 50;};
		text{caption = "9"; font_size= 50;};
	}numbers;

	array {
		picture {
			description = "Raute";
			line_graphic {
				coordinates = 0, 300, 200, 0, 0, -300, -200, 0, 0, 300, 200, 0;
				line_width = 15;
			};
			x = 0; y = 0;
			
			polygon_graphic {
					height = 0;
					width = 0;
					sides = 3;
					fill_color = 0,0,0,255;
				};
			x = 0; y = 0;
				
			text{caption = ""; font_size= 50;};
			x = 0;y = 0;
		} main_picture_diamand;
		
		picture {
			description = "Quadrat";
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
		
		picture {
			description = "Stern";
			line_graphic {
				coordinates = 0, 300, 67, 93, 285, 93, 109, -35, 176, -243, 
									0, -115, -176, -243, -109, -35, -285, 93, -67, 93, 
									0, 300, 67, 93;
				line_width = 15;
			};
			x = 0; y = 0;
			
			polygon_graphic {
				height = 0;
				width = 0;
				sides = 3;
				fill_color = 0,0,0,255;
			};
			x = 0; y = 0;
			
			text{caption = ""; font_size= 50;};
			x=0;y=0;
		} main_picture_star;
		
		picture {
			description = "Achteck";
			
			polygon_graphic {
				sides = 8;
				radius = 300;
				line_width = 15;
				join_type = join_flat;
				height = 650;
				width = 650;
			};
			x = 0; y = 0;
			
			polygon_graphic {
					height = 0;
					width = 0;
					sides = 3;
					fill_color = 0,0,0,255;
				};
			x = 0; y = 0;
				
			text{caption = ""; font_size= 50;};
			x = 0;y = 0;
		} main_picture_octagon;
	} form_array;

	trial {
		trial_duration = EXPARAM("Time Response Active" : 1800);
		trial_type = first_response;
		
		stimulus_event{
		picture {} main_picture;
		duration = EXPARAM("Time Stimulus" : 250);
		}stim_event;
	} trial_main;

	trial {
		picture {
			text {
				caption="+";
				font_size=50;
			};
			x=0; y=0;
		}cross;
	} trial_cross;

	trial {
		trial_duration = EXPARAM("Time Feedback" : 2000);
		picture {
			text { caption = ""; font_size = 24; max_text_width = 600;} text_feedback; 
			x=0; y=0;
		} feedback_pic;
	} trial_feedback;
	
	trial {
		trial_duration = forever;
		trial_type = first_response;
		all_responses = false;

		picture {
			text { caption = ""; font_size = 25; max_text_width = 1200;} text_introduction;
			x=0;y=0;
		} picture_information;
		stimulus_time_in = 1000;
		response_active= true;
	} trial_information;
	
	trial {
		trial_duration = forever;
		trial_type = first_response;
		all_responses = false;
		
		picture {
			text { caption = ""; font_size = 30;} text_instruction;
			x=0; y=0;
		} instruction_pic;
		stimulus_time_in = 1500;
		response_active= true;
		} trial_instruction;
	
	trial {
		trial_duration = 120000;
		
		picture {
			text {caption = "Pause. \nIn 2 Minuten geht es weiter."; font_size = 25;} pause_text;
			x=0; y=0;
		};
	} trial_pause;

################################PCL##############################################	
begin_pcl;

	int CHAR = 1;
	int FORM = 2;
	array <int> ISI_values [] = {500, 700, 900, 1100, 1300, 1500, 1700, 1900, 2100, 2300};
	int configuration = parameter_manager.get_int("Configuration Parameter");
	int non_targets = parameter_manager.get_int("Non Targets at Start of each Block");
	
	sub pause_seconds (int time_in_seconds)
	begin
		trial_pause.set_duration(time_in_seconds *1000);
		pause_text.set_caption("Pause \nIn " + string(time_in_seconds) + " Sekunden geht es weiter", true);
		trial_pause.present();
	end;
	
	sub pause_minutes (int time_in_minutes)
	begin
		trial_pause.set_duration(time_in_minutes *60000);
		pause_text.set_caption("Pause \nIn " + string(time_in_minutes) + " Minuten geht es weiter", true);
		trial_pause.present();
	end;
	
	sub present_information (string information, int font_size)
	begin
		text_introduction.set_font_size(font_size);
		text_introduction.set_caption(information, true);
		trial_information.present();
	end;
	
	string information_start = 
		"Im Folgenden werden Ihnen auf dem Bildschirm unterschiedliche Zahlen und Formen " +
		"präsentiert. Vor jedem Durchlauf erhalten Sie eine kurze Instruktion, auf welche Zahlen " + 
		"und/oder Formen Sie reagieren sollen. Die Reaktion erfolgt mit den Tasten " +
		"\"L\" und \"S\". Reagieren Sie so schnell und so richtig wie möglich. \n\n Zunächst " +
		"folgt ein Testdurchlauf. \n\n Drücken Sie die Leertaste, um fortzufahren.";
	string information_test = 
		"Dies ist ein Testdurchlauf. \n\n Weiter mit Leertaste.";
	string information_first_run = 
		"Der Testdurchlauf ist vorbei.\n\n" +
		"Im Folgenden wird Ihnen kein Feedback mehr präsentiert.\n\n" +
		"Der erste Durchgang beginnt.\n" + 
		"Weiter mit Leertaste.";
	string information_second_run =
		"Der zweite Durchgang beginnt.\n" + 
		"Weiter mit Leertaste.";
	string information_third_run =
		"Der dritte Durchgang beginnt.\n" + 
		"Weiter mit Leertaste.";
	string information_end =
		"Bitte wenden Sie sich an den Versuchsleiter.";
		
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
	
	# returns true if
	# 1. successive stimuli are never identical
	# 2. first "Non Targets at Start of each Block" (parameter) are non targets
	# 3. successive stimuli are never targets
	
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
		
		loop int i = 1 until i > non_targets
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
	
		loop int i = (non_targets + 1) until i == list_to_test.count()
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

	# returns  a 2D array representation of a valid block with given paramters
	# for each pair the first value represents the index of the used char in char_array and the second value
	# represents the index of the used form in form_array
	# see make_and_present_block for parameter explanation
	
	sub array<int,2> make_block (int seperate_attention, int char_target_index, array<text,1> char_array,
											int form_target_index, int number_of_targets, int number_of_non_targets)
	begin
		array<int> list[0][2];
		array<int> tmp_possible_targets[0][2];
		array<int> tmp_possible_char_targets[0][2];
		array<int> tmp_possible_form_targets[0][2];
		array<int> tmp_possible_non_targets[0][2];
		
		if seperate_attention == 1
		then
			loop int i = 1 until i > form_array.count()
			begin
				array<int> tmp[2];
				tmp[CHAR] = char_target_index;
				tmp[FORM] = i;
				tmp_possible_targets.add(tmp);
				i = i + 1;
			end;
			tmp_possible_targets.shuffle();
			
			loop int i = 1 until i > number_of_targets
			begin
				int index = i % tmp_possible_targets.count();
				if index == 0
				then
					list.add(tmp_possible_targets[tmp_possible_targets.count()]);
				else
					list.add(tmp_possible_targets[index]);
				end;
				i = i + 1;
			end;
			
			loop int char_count = 1 until char_count > char_array.count()
			begin
				loop int form_count = 1 until form_count > form_array.count()
				begin
					if char_count != char_target_index
					then
						array<int> tmp[2];
						tmp[CHAR] = char_count;
						tmp[FORM] = form_count;
						tmp_possible_non_targets.add(tmp);
					end;
					form_count = form_count + 1;
				end;
				char_count = char_count + 1;
			end;
			tmp_possible_non_targets.shuffle();		
			
			
			loop int i = 1 until list.count() == number_of_targets + number_of_non_targets
			begin
				int index = i % tmp_possible_non_targets.count();
				if index == 0
				then
					list.add(tmp_possible_non_targets[tmp_possible_non_targets.count()]);
				else
					list.add(tmp_possible_non_targets[index]);
				end;
				i = i + 1;
			end;
			
		elseif seperate_attention == 2
		then
			loop int i = 1 until i > char_array.count()
			begin
				array<int> tmp[2];
				tmp[CHAR] = i;
				tmp[FORM] = form_target_index;
				tmp_possible_targets.add(tmp);
				i = i + 1;
			end;
			tmp_possible_targets.shuffle();
			
			loop int i = 1 until i > number_of_targets
			begin
				int index = i % tmp_possible_targets.count();
				if index == 0
				then
					list.add(tmp_possible_targets[tmp_possible_targets.count()]);
				else
					list.add(tmp_possible_targets[index]);
				end;
				i = i + 1;
			end;
			
			loop int char_count = 1 until char_count > char_array.count()
			begin
				loop int form_count = 1 until form_count > form_array.count()
				begin
					if form_count != form_target_index
					then
						array<int> tmp[2];
						tmp[CHAR] = char_count;
						tmp[FORM] = form_count;
						tmp_possible_non_targets.add(tmp);
					end;
					form_count = form_count + 1;
				end;
				char_count = char_count + 1;
			end;
			tmp_possible_non_targets.shuffle();		
			
			
			loop int i = 1 until list.count() == number_of_targets + number_of_non_targets
			begin
				int index = i % tmp_possible_non_targets.count();
				if index == 0
				then
					list.add(tmp_possible_non_targets[tmp_possible_non_targets.count()]);
				else
					list.add(tmp_possible_non_targets[index]);
				end;
				i = i + 1;
			end;
		elseif seperate_attention == 3
		then
			loop int i = 1 until i > form_array.count()
			begin
				if i != form_target_index
				then
					array<int> tmp[2];
					tmp[CHAR] = char_target_index;
					tmp[FORM] = i;
					tmp_possible_char_targets.add(tmp);
				end;
				i = i + 1;
			end;
			tmp_possible_char_targets.shuffle();
			
			loop int i = 1 until i > char_array.count()
			begin
				if i != char_target_index
				then
					array<int> tmp[2];
					tmp[CHAR] = i;
					tmp[FORM] = form_target_index;
					tmp_possible_form_targets.add(tmp);
				end;
				i = i + 1;
			end;
			tmp_possible_form_targets.shuffle();
			
			loop int i = 1 until i > number_of_targets/2
			begin
				int char_index = i % tmp_possible_char_targets.count();
				if char_index == 0
				then
					list.add(tmp_possible_char_targets[tmp_possible_char_targets.count()]);
				else
					list.add(tmp_possible_char_targets[char_index]);
				end;
				
				int form_index = i % tmp_possible_form_targets.count();
				if form_index == 0
				then
					list.add(tmp_possible_form_targets[tmp_possible_form_targets.count()]);
				else
					list.add(tmp_possible_form_targets[form_index]);
				end;
				i = i + 1;
			end;
			
			loop int char_count = 1 until char_count > char_array.count()
			begin
				loop int form_count = 1 until form_count > form_array.count()
				begin
					if char_count != char_target_index && form_count!= form_target_index
					then
						array<int> tmp[2];
						tmp[CHAR] = char_count;
						tmp[FORM] = form_count;
						tmp_possible_non_targets.add(tmp);
					end;
					form_count = form_count + 1;
				end;
				char_count = char_count + 1;
			end;
			tmp_possible_non_targets.shuffle();		
			
			loop int i = 1 until list.count() == number_of_targets + number_of_non_targets
			begin
				int index = i % tmp_possible_non_targets.count();
				if index == 0
				then
					list.add(tmp_possible_non_targets[tmp_possible_non_targets.count()]);
				else
					list.add(tmp_possible_non_targets[index]);
				end;
				i = i + 1;
			end;
		end;
		
		loop until (validade(list, seperate_attention ,form_target_index,
						char_target_index, char_array))
		begin
			list.shuffle();
		end;
		return list;
	end;

	# presents a block with given paramters.
	# that means showing instroction, fixation cross and possibly feedback.
	# The block is normally created by make_block() but could be created manually aswell
	# see make_and_present_block for parameter explanation
	
	sub present_block( int seperate_attention, int char_target_index, array<text,1> char_array, 
								int form_target_index, array<int> block[][], bool show_feedback, string run_id, string block_id)
	begin
		string instruction_string = "";
		if seperate_attention == 1
		then
			instruction_string = ("Drücken Sie die Taste \"L\", wenn das Zeichen \"" + char_array[char_target_index].caption() + "\" erscheint.");
		elseif seperate_attention == 2
		then
			instruction_string = ("Drücken Sie die Taste \"S\", wenn die Form \"" + form_array[form_target_index].description() + "\" erscheint.");
		elseif seperate_attention == 3
		then
			instruction_string = "Drücken Sie die Taste \"L\", wenn das Zeichen \"" + char_array[char_target_index].caption() + "\" erscheint." +
										"\nDrücken Sie die Taste \"S\", wenn die Form \"" + form_array[form_target_index].description() + "\" erscheint."
		end;
		instruction_string = instruction_string + "\n\nAntworten Sie so schnell und richtig wie möglich." +
																"\nDrücken Sie die Leertaste, um fortzufahren.";
		text_instruction.set_caption(instruction_string, true);
		trial_instruction.present();
		
		loop int i = 1 until i > block.count()
		begin
			int char_index = block[i][CHAR];
			int form_index = block[i][FORM];

			main_picture = form_array[form_index];
			main_picture.set_part(3,char_array[char_index]);
			stim_event.set_stimulus(main_picture);
			string tmp_event_code = string(configuration) + ";" + run_id + ";" + block_id + ";" + main_picture.description() + 
												";" + char_array[char_index].caption() + ";" + string(seperate_attention);

			string caption = char_array[char_index].caption();
			stim_event.set_target_button(0);
			stim_event.set_response_active(true);
			
			if seperate_attention == 1
			then
				if char_array[char_target_index].caption() == caption
				then
					stim_event.set_target_button(1);
					stim_event.set_event_code(tmp_event_code + ";" + "1");
				else
					stim_event.set_event_code(tmp_event_code + ";" + "0");
				end;
			elseif seperate_attention == 2
			then
				if form_target_index == form_index
				then 
					stim_event.set_target_button(2);
					stim_event.set_event_code(tmp_event_code + ";" + "2");
				else
					stim_event.set_event_code(tmp_event_code + ";" + "0");
				end;
			elseif seperate_attention == 3 
			then
				if char_array[char_target_index].caption() == caption
				then
					stim_event.set_target_button(1);
					stim_event.set_event_code(tmp_event_code + ";" + "1");
				elseif form_target_index == form_index
				then
					stim_event.set_target_button(2);
					stim_event.set_event_code(tmp_event_code + ";" + "2");
				else
					stim_event.set_event_code(tmp_event_code + ";" + "0");
				end;
			else
				
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
			trial_main.present();
			set_response_mode(1);
			i=i+1;
		
			if show_feedback
			then
				string feedback = "";
				stimulus_data last = stimulus_manager.last_stimulus_data();
				if (last.type() == last.HIT) then
					feedback = parameter_manager.get_string("Feedback HIT", "Richtig");
				elseif (last.type() == last.INCORRECT) then
					feedback = parameter_manager.get_string("Feedback INCORRECT", "Falsche Taste");
				elseif (last.type() == last.MISS) then
					feedback = parameter_manager.get_string("Feedback MISS", "Falsch.\nSie hätten drücken müssen.");
				elseif (last.type() == last.FALSE_ALARM) then
					feedback = parameter_manager.get_string("Feedback FALSE ALARM", "Falsch.\nSie hätten nicht drücken müssen.");
				end;
				
				if feedback != ""
				then
				text_feedback.set_caption(feedback, true);
				trial_feedback.present();	
				end;
			end;
		end;
	end;
	
	sub make_and_present_block (int seperate_attention, int char_target_index, array<text,1> char_array,
											int form_target_index, int number_of_targets, int number_of_non_targets,  
											bool show_feedback, string run_id, string block_id)
	begin
		array<int> block_presentet[][] = make_block(seperate_attention,char_target_index, char_array,
											form_target_index, number_of_targets, number_of_non_targets);
		present_block(seperate_attention, char_target_index, char_array,
											 form_target_index, block_presentet, show_feedback, run_id, block_id)
	end;
	
#	Parameters for make_and_present_block
#	1. Value: selective_attention: 1 = only a char is a target
#											 2 = only a form is a target
#											 3 = a char and a form is a target
#	2. Value: index of char target. Use -1 if no char targets will be presentet
#	3. Value: char array to be used
#	4. Value: index of form target in form_array. Use -1 if no form targets will be presentet
#	5. Value: number of targets in returned trial
#	6. Value: number of non targets in returned trial
#	7. Value: bool to determin if feedback will be given. true = feedback
#	8. Value: run_id for event_code
#	9. Value: block_id for event_code

##########################Test Run########################################
	
	set_response_mode(1);
	present_information(information_start, 25);
   present_information(information_test, 30);

	make_and_present_block(1, 1, numbers, -1, 4, 6, true, "test", "block_1");
	make_and_present_block(3, 2, numbers, 1, 4, 6, true, "test", "block_2");
	
	if configuration == 1
	then
		##########################Run 1########################################

			pause_seconds(30);
			present_information(information_first_run, 30);
			make_and_present_block(2, -1, numbers, 2, 6, 20, false, "selective", "block_1");
			make_and_present_block(1, 3, numbers, -1, 6, 20, false, "selective", "block_2");
			make_and_present_block(1, 4, numbers, -1, 6, 20, false, "selective", "block_3");
			make_and_present_block(2, -1, numbers, 3, 6, 20, false, "selective", "block_4");
			
		##########################Run 2########################################

			pause_minutes(2);
			present_information(information_second_run, 30);
			make_and_present_block(3, 5, numbers, 4, 6, 20, false, "divided", "block_1");
			make_and_present_block(3, 6, numbers, 5, 6, 20, false, "divided", "block_2");
			make_and_present_block(3, 1, numbers, 6, 6, 20, false, "divided", "block_3");
			make_and_present_block(3, 2, numbers, 1, 6, 20, false, "divided", "block_4");
			
		##########################Run 3########################################

			pause_minutes(2);
			present_information(information_third_run, 30);
			make_and_present_block(2, -1, numbers, 2, 6, 20, false, "combination", "block_1");
			make_and_present_block(3, 3, numbers, 3, 6, 20, false, "combination", "block_2");
			make_and_present_block(1, 4, numbers, -1, 6, 20, false, "combination", "block_3");
			make_and_present_block(3, 5, numbers, 4, 6, 20, false, "combination", "block_4");
			
			make_and_present_block(2, -1, numbers, 5, 6, 20, false, "combination", "block_5");
			make_and_present_block(3, 6, numbers, 6, 6, 20, false, "combination", "block_6");
			make_and_present_block(1, 1, numbers, -1, 6, 20, false, "combination", "block_7");
			make_and_present_block(3, 2, numbers, 1, 6, 20, false, "combination", "block_8");
			present_information(information_end, 30);
			
	elseif configuration == 2
	then
		##########################Run 1########################################

			pause_seconds(30);
			present_information(information_first_run, 30);
			make_and_present_block(3, 3, numbers, 2, 6, 20, false, "divided", "block_1");
			make_and_present_block(3, 4, numbers, 3, 6, 20, false, "divided", "block_2");
			make_and_present_block(3, 5, numbers, 4, 6, 20, false, "divided", "block_3");
			make_and_present_block(3, 6, numbers, 5, 6, 20, false, "divided", "block_4");
			
		##########################Run 2########################################

			pause_minutes(2);
			present_information(information_second_run, 30);
			make_and_present_block(2, -1, numbers, 6, 6, 20, false, "selective", "block_1");
			make_and_present_block(1, 1, numbers, -1, 6, 20, false, "selective", "block_2");
			make_and_present_block(1, 2, numbers, -1, 6, 20, false, "selective", "block_3");
			make_and_present_block(2, -1, numbers, 1, 6, 20, false, "selective", "block_4");
			
		##########################Run 3########################################

			pause_minutes(2);
			present_information(information_third_run, 30);
			make_and_present_block(2, -1, numbers, 2, 6, 20, false, "combination", "block_1");
			make_and_present_block(3, 3, numbers, 3, 6, 20, false, "combination", "block_2");
			make_and_present_block(1, 4, numbers, -1, 6, 20, false, "combination", "block_3");
			make_and_present_block(3, 5, numbers, 4, 6, 20, false, "combination", "block_4");
			
			make_and_present_block(2, -1, numbers, 5, 6, 20, false, "combination", "block_5");
			make_and_present_block(3, 6, numbers, 6, 6, 20, false, "combination", "block_6");
			make_and_present_block(1, 1, numbers, -1, 6, 20, false, "combination", "block_7");
			make_and_present_block(3, 2, numbers, 1, 6, 20, false, "combination", "block_8");
			present_information(information_end, 30);
			
	elseif configuration == 3
	then
		##########################Run 1########################################

			pause_seconds(30);
			present_information(information_first_run, 30);
			make_and_present_block(2, -1, numbers, 2, 6, 20, false, "combination", "block_1");
			make_and_present_block(3, 3, numbers, 3, 6, 20, false, "combination", "block_2");
			make_and_present_block(1, 4, numbers, -1, 6, 20, false, "combination", "block_3");
			make_and_present_block(3, 5, numbers, 4, 6, 20, false, "combination", "block_4");
			
			make_and_present_block(2, -1, numbers, 5, 6, 20, false, "combination", "block_5");
			make_and_present_block(3, 6, numbers, 6, 6, 20, false, "combination", "block_6");
			make_and_present_block(1, 1, numbers, -1, 6, 20, false, "combination", "block_7");
			make_and_present_block(3, 2, numbers, 1, 6, 20, false, "combination", "block_8");
			
		##########################Run 2########################################

			pause_minutes(2);
			present_information(information_second_run, 30);
			make_and_present_block(2, -1, numbers, 2, 6, 20, false, "divided", "block_1");
			make_and_present_block(1, 3, numbers, -1, 6, 20, false, "divided", "block_2");
			make_and_present_block(1, 4, numbers, -1, 6, 20, false, "divided", "block_3");
			make_and_present_block(2, -1, numbers, 3, 6, 20, false, "divided", "block_4");
			
		##########################Run 3########################################

			pause_minutes(2);
			present_information(information_third_run, 30);
			make_and_present_block(3, 5, numbers, 4, 6, 20, false, "selective", "block_1");
			make_and_present_block(3, 6, numbers, 5, 6, 20, false, "selective", "block_2");
			make_and_present_block(3, 1, numbers, 6, 6, 20, false, "selective", "block_3");
			make_and_present_block(3, 2, numbers, 1, 6, 20, false, "selective", "block_4");
			present_information(information_end, 30);
			
	elseif configuration == 4
	then
		##########################Run 1########################################

			pause_seconds(30);
			present_information(information_first_run, 30);
			make_and_present_block(2, -1, numbers, 2, 6, 20, false, "combination", "block_1");
			make_and_present_block(3, 3, numbers, 3, 6, 20, false, "combination", "block_2");
			make_and_present_block(1, 4, numbers, -1, 6, 20, false, "combination", "block_3");
			make_and_present_block(3, 5, numbers, 4, 6, 20, false, "combination", "block_4");
			
			make_and_present_block(2, -1, numbers, 5, 6, 20, false, "combination", "block_5");
			make_and_present_block(3, 6, numbers, 6, 6, 20, false, "combination", "block_6");
			make_and_present_block(1, 1, numbers, -1, 6, 20, false, "combination", "block_7");
			make_and_present_block(3, 2, numbers, 1, 6, 20, false, "combination", "block_8");
			
		##########################Run 2########################################

			pause_minutes(2);
			present_information(information_second_run, 30);
			make_and_present_block(3, 3, numbers, 2, 6, 20, false, "selective", "block_1");
			make_and_present_block(3, 4, numbers, 3, 6, 20, false, "selective", "block_2");
			make_and_present_block(3, 5, numbers, 4, 6, 20, false, "selective", "block_3");
			make_and_present_block(3, 6, numbers, 5, 6, 20, false, "selective", "block_4");
			
		##########################Run 3########################################

			pause_minutes(2);
			present_information(information_third_run, 30);
			make_and_present_block(2, -1, numbers, 6, 6, 20, false, "divided", "block_1");
			make_and_present_block(1, 1, numbers, -1, 6, 20, false, "divided", "block_2");
			make_and_present_block(1, 2, numbers, -1, 6, 20, false, "divided", "block_3");
			make_and_present_block(2, -1, numbers, 1, 6, 20, false, "divided", "block_4");
			present_information(information_end, 30);
			
	elseif configuration == 5
	then
		##########################Run 1########################################

			pause_seconds(30);
			present_information(information_first_run, 30);
			make_and_present_block(2, -1, numbers, 2, 6, 20, false, "divided", "block_1");
			make_and_present_block(1, 3, numbers, -1, 6, 20, false, "divided", "block_2");
			make_and_present_block(1, 4, numbers, -1, 6, 20, false, "divided", "block_3");
			make_and_present_block(2, -1, numbers, 3, 6, 20, false, "divided", "block_4");
			
		##########################Run 2########################################

			pause_minutes(2);
			present_information(information_second_run, 30);
			make_and_present_block(2, -1, numbers, 4, 6, 20, false, "combination", "block_1");
			make_and_present_block(3, 5, numbers, 5, 6, 20, false, "combination", "block_2");
			make_and_present_block(1, 6, numbers, -1, 6, 20, false, "combination", "block_3");
			make_and_present_block(3, 1, numbers, 6, 6, 20, false, "combination", "block_4");
			
			make_and_present_block(2, -1, numbers, 1, 6, 20, false, "combination", "block_5");
			make_and_present_block(3, 2, numbers, 2, 6, 20, false, "combination", "block_6");
			make_and_present_block(1, 3, numbers, -1, 6, 20, false, "combination", "block_7");
			make_and_present_block(3, 4, numbers, 3, 6, 20, false, "combination", "block_8");
			
		##########################Run 3########################################

			pause_minutes(2);
			present_information(information_third_run, 30);
			make_and_present_block(3, 5, numbers, 4, 6, 20, false, "selective", "block_1");
			make_and_present_block(3, 6, numbers, 5, 6, 20, false, "selective", "block_2");
			make_and_present_block(3, 1, numbers, 6, 6, 20, false, "selective", "block_3");
			make_and_present_block(3, 2, numbers, 1, 6, 20, false, "selective", "block_4");
			present_information(information_end, 30);
			
	elseif configuration == 6
	then
		##########################Run 1########################################

			pause_seconds(30);
			present_information(information_first_run, 30);
			make_and_present_block(3, 3, numbers, 2, 6, 20, false, "selective", "block_1");
			make_and_present_block(3, 4, numbers, 3, 6, 20, false, "selective", "block_2");
			make_and_present_block(3, 5, numbers, 4, 6, 20, false, "selective", "block_3");
			make_and_present_block(3, 6, numbers, 5, 6, 20, false, "selective", "block_4");
			
		##########################Run 2########################################

			pause_minutes(2);
			present_information(information_second_run, 30);
			make_and_present_block(2, -1, numbers, 6, 6, 20, false, "combination", "block_1");
			make_and_present_block(3, 1, numbers, 1, 6, 20, false, "combination", "block_2");
			make_and_present_block(1, 2, numbers, -1, 6, 20, false, "combination", "block_3");
			make_and_present_block(3, 3, numbers, 2, 6, 20, false, "combination", "block_4");
			
			make_and_present_block(2, -1, numbers, 3, 6, 20, false, "combination", "block_5");
			make_and_present_block(3, 4, numbers, 4, 6, 20, false, "combination", "block_6");
			make_and_present_block(1, 5, numbers, -1, 6, 20, false, "combination", "block_7");
			make_and_present_block(3, 6, numbers, 5, 6, 20, false, "combination", "block_8");
			
		##########################Run 3########################################

			pause_minutes(2);
			present_information(information_third_run, 30);
			make_and_present_block(2, -1, numbers, 6, 6, 20, false, "divided", "block_1");
			make_and_present_block(1, 1, numbers, -1, 6, 20, false, "divided", "block_2");
			make_and_present_block(1, 2, numbers, -1, 6, 20, false, "divided", "block_3");
			make_and_present_block(2, -1, numbers, 1, 6, 20, false, "divided", "block_4");
			present_information(information_end, 30);
	end;
