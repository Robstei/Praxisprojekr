response_matching = simple_matching;
active_buttons = 3;

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
		text{caption = "2";};
		text{caption = "3";};
		text{caption = "4";};
		text{caption = "6";};
		text{caption = "7";};
		text{caption = "9";};
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
		trial_duration = 1000;
		trial_type = first_response;
		
		stimulus_event{
		picture {} main_picture;
		duration = 250;
		}stim_event;
		
	} main_trial;

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
		trial_duration = 1000;
		picture {
			text { caption = ""; font_size = 24;} feedback_text; 
			x=0; y=0;
		} feedback_pic;
	} feedback_trial;
	
	trial {
		trial_duration = forever;
		trial_type = first_response;
		picture {
			text { caption = ""; font_size = 30;} instruction_text;
			x=0; y=0;
		} instruction_pic;
		target_button = 3;
	} instruction_trial;
	
begin_pcl;

	int CHAR = 1;
	int FORM = 2;
	int max_time= 1000;

	sub bool validade (array<int,2> list_to_test, int seperate_attention, int form_target_index, 
							int char_target_index, array<text,1> char_array)
	begin 
		loop int i = 1 until i == list_to_test.count() -1
		begin
			if list_to_test[i] == list_to_test[i+1]
			then 
				return false;
			end;
			i = i + 1;
		end;
		
		loop int i = 1 until i == 6
		begin
			if seperate_attention == 1 &&
				char_array[list_to_test[i][CHAR]].caption() == char_array[char_target_index].caption()
			then
				return false;
			elseif seperate_attention == 2 &&	
						list_to_test[i][FORM] == form_target_index
			then
				return false;
			elseif seperate_attention == 3 &&
				(char_array[list_to_test[i][CHAR]].caption() == char_array[char_target_index].caption()
				|| list_to_test[i][FORM] == form_target_index)
			then
				return false;
			end;
			i = i + 1;
		end;		
	
		loop int i = 6 until i == list_to_test.count() - 1 
		begin
			if seperate_attention == 1 &&
				char_array[list_to_test[i][CHAR]].caption() == char_array[char_target_index].caption() &&
				char_array[list_to_test[i+1][CHAR]].caption() == char_array[char_target_index].caption()
			then 
				return false;
			elseif seperate_attention == 2 &&
				list_to_test[i][FORM] == form_target_index &&
				list_to_test[i+1][FORM] == form_target_index 
			then
				return false;
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

	sub array<int,2> make_trial (int seperate_attention, int char_target_index, array<text,1> char_array ,int form_target_index, 
											int number_of_stimuli, int number_of_non_stimuli)
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
					tmp[CHAR] = random(1,char_target_index);
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
														  
		loop until (validade(list, seperate_attention ,form_target_index ,
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
								int form_target_index, array<int> trial_list[][], bool show_feedback)
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
									"Drücken Sie die Taste S wenn " + form_array[form_target_index].description() + " erscheint."
	end;
	instruction_string = instruction_string + "\nAntworten Sie so schnell sie können." +
															"\nDrücken Sie die Leertaste um fortzufahren.";
	instruction_text.set_caption(instruction_string, true);
	instruction_trial.present();
	
	#ISI
	trial_cross.set_duration(random(500,2300));
	trial_cross.present();
	
	loop int i = 1 until i > trial_list.count()
	begin
		int char_index = trial_list[i][CHAR];
		int form_index = trial_list[i][FORM];

		main_picture = form_array[form_index];
		main_picture.set_part(3,letters[char_index]);
		stim_event.set_stimulus(main_picture);
		stim_event.set_event_code("test");

		string caption = char_array[char_index].caption();
				
		if seperate_attention == 1 && char_array[char_target_index].caption() == caption
		then
			stim_event.set_target_button(1);
		elseif seperate_attention == 2 && form_target_index == form_index
		then
			stim_event.set_target_button(2);
		elseif seperate_attention == 3 && char_array[char_target_index].caption() == caption
		then
			stim_event.set_target_button(1);
		elseif
		seperate_attention == 3 && form_target_index == form_index
		then
			stim_event.set_target_button(2);
		else
			stim_event.set_response_active(true);
		end;
		
		main_trial.present();

		i=i+1;
			
		if (show_feedback) then
			string new_caption = "";
			stimulus_data last = stimulus_manager.last_stimulus_data();
			if (last.type() == last.HIT) then
				new_caption = "Korekt";
			elseif (last.type() == last.INCORRECT) then
				new_caption = "Falsche Taste";
			elseif (last.type() == last.MISS) then
				new_caption = "Sie hätten drücken müssen";
			elseif (last.type() == last.FALSE_ALARM) then
				new_caption = "Sie hätten nicht drücken müssen";
			end;
			
			feedback_text.set_caption(new_caption, true);
			feedback_trial.present();	
			end;
		end;
	end;

	array<int> test[][] = make_trial(1, 4, letters, 1, 2, 8);
	term.print_line(test);
	present_trials(1, 4, letters, 1, test, true);
	




