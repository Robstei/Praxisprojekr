response_matching = simple_matching;
active_buttons = 2;

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
	
		box {width= 600; height= 600; color = 255,255,255;};
		x=0;y=0;
	
		box {width= 570; height=570; color = 0,0,0;};
		x=0;y=0;
		
		text{caption = ""; font_size= 50;};
		x=0;y=0;
	} main_picture_box;
	
	picture {
	
		ellipse_graphic {
			height = 600;
			width = 600;
			ellipse_height = 600;
			ellipse_width= 600;
			color = 255,255,255,255;};
			x=0;y=0;
			
			ellipse_graphic {
			height = 600;
			width = 600;
			ellipse_height = 570;
			ellipse_width= 570;
			color = 0,0,0,255;};
			x=0;y=0;
		
		text{caption = ""; font_size= 50;};
		x=0;y=0;
	} main_picture_circle;
	
	picture {
	
		polygon_graphic {
			height = 750;
			width = 700;
			sides = 3;
			line_width = 15;
			line_color = 255,255,255,255;
			radius = 350;};
		x = 0; y = -50;
		
		polygon_graphic {
			height = 0;
			width = 0;
			sides = 3;
			fill_color = 0,0,0,255;};
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

begin_pcl;

int CHAR = 1;
int FORM = 2;
int max_time= 1000;

sub bool validade (array<int,2> list_to_test, bool seperate_attention, int form_target_index, int char_target_index, array<text,1> char_array)begin 
	
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
		if (char_array[list_to_test[i][CHAR]].caption() == char_array[char_target_index].caption()) || (seperate_attention && list_to_test[i][FORM] == form_target_index)
		then
			return false;
		end;
		i = i + 1;
	end;
	loop int i = 6 until i == list_to_test.count() - 1 
	begin
		if char_array[list_to_test[i][CHAR]].caption() == char_array[char_target_index].caption() &&
			char_array[list_to_test[i+1][CHAR]].caption() == char_array[char_target_index].caption()
		then 
			return false;
		end;
		
		if char_array[list_to_test[i][CHAR]].caption() == char_array[char_target_index].caption() || (seperate_attention && list_to_test[i][FORM] == form_target_index)
		then
			if 
				char_array[list_to_test[i+1][CHAR]].caption() == char_array[char_target_index].caption()|| (seperate_attention && list_to_test[i+1][FORM] == form_target_index)
			then
				return false;
			end;
		end;
		i = i +1;
	end;
	return true;
end;

sub array<int,2> make_trial (int number_of_stimuli, int number_of_non_stimuli, bool seperate_attention, int char_target_index, int form_target_index, array<text,1> char_array)
begin
	array<int> list[0][2];
		
		if seperate_attention
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
		else 
			loop int i = 1 until i > number_of_stimuli
			begin
					array<int> tmp[2];
					tmp[CHAR] = char_target_index;
					tmp[FORM] = random(1, form_array.count());
					list.add(tmp);
					i = i + 1;
			end;
			
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
	                                      

	loop until (validade(list, seperate_attention ,form_target_index ,char_target_index,char_array))
	begin
	list.shuffle();
	end;
	return list;
end;

# form_target:
# 1 = Recktangle
# 2 = Circle
# 3 = Triangle
sub present_trials( array<int> trial_list[][], bool show_feedback, bool seperate_attention, int form_target, string target)
begin

	loop int i = 1 until i > trial_list.count()
	begin
		int char_index = trial_list[i][CHAR];
		int form_index = trial_list[i][FORM];

		main_picture = form_array[form_index];
		main_picture.set_part(3,letters[char_index]);
		stim_event.set_stimulus(main_picture);
		stim_event.set_event_code("test");

		string caption = letters[char_index].caption();
			
		if target == caption
		then
		stim_event.set_target_button(1);
		elseif seperate_attention && form_target == form_index
		then
		stim_event.set_target_button(2);
		else
		stim_event.set_target_button(0);
		end;
	
		main_trial.present();

		i=i+1;
		
		if (show_feedback) then
			string new_caption = "test";
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
		
			if( last.reaction_time() > max_time) then
				new_caption = new_caption + "\nPlease respond faster";
			end;
			feedback_text.set_caption(new_caption, true);
			feedback_trial.present();	
		end;
		
		trial_cross.set_duration(random(500,2300));
		trial_cross.present();
	end;
end;

array<int> test[][] = make_trial(2, 8, true, 4, 1, letters);

term.print_line(test);
present_trials(test, true, false, 1, "A");



