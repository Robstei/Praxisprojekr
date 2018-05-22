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
			
} form_array;

trial {
	trial_duration = 1000;
	
	stimulus_event{
	picture {} main_picture;
	}stim_event;

} main_trial;

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
int max_time= 3000;

sub array<int,2> make_trial (int repeat)
begin
	array<int> list[0][2];
	loop int i = 1 until i > form_array.count()
	begin
		loop int j = 1 until j > letters.count()
		begin
			array<int> tmp[2];
			tmp[FORM] = (i);
			tmp[CHAR] = (j);
			loop int r = 1 until r > repeat
			begin
			list.add(tmp);
			r = r +1;
			end;
			j = j + 1;
		end;
		i = i + 1;
	end;
	list.shuffle();
	return list;
end;

sub present_trials( array<int> trial_list[][], bool show_feedback, string target)
begin

	loop int i = 1 until i > trial_list.count()
	begin
		int char_index = trial_list[i][CHAR];
		int form_index = trial_list[i][FORM];

		picture stim = form_array[form_index];
		stim.set_part(3,letters[char_index]);
		stim_event.set_stimulus(stim);
		stim_event.set_event_code("test");

		string caption = letters[char_index].caption();
		
		
		term.print_line(target);
		term.print_line(caption);
		term.print_line("-------");
		if target == caption
		then
		stim_event.set_target_button(1);
		else
		stim_event.set_target_button(0);
		end;
		main_trial.present();
		i=i+1;
		
		if (show_feedback) then
			string new_caption;
			stimulus_data last = stimulus_manager.last_stimulus_data();
			
		if (last.type() == last.HIT) then
				new_caption = "correct";
			else
				new_caption = "incorrect";
			end;
		
			if( last.reaction_time() > max_time) then
				new_caption = new_caption + "\nPlease respond faster";
			end;
			feedback_text.set_caption(new_caption, true);
			feedback_trial.present();	
		end;
	end;
end;

array<int> test[][] = make_trial(1);
present_trials(test, true, "A");



