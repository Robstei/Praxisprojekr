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
	picture {} main_picture;
} main_trial;


begin_pcl;


int LETTER = 1;
int FORM = 2;

sub array<int,2> make_trial (int repeat)
begin
	array<int> list[0][2];
	loop int i = 1 until i > form_array.count()
	begin
		loop int j = 1 until j > letters.count()
		begin
			array<int> tmp[2];
			tmp[FORM] = (i);
			tmp[LETTER] = (j);
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

sub present_trials( array<int> trial_list[][])
begin

	loop int i = 1 until i > trial_list.count()
	begin
		int Letter_index = trial_list[i][LETTER];
		int Form_index = trial_list[i][FORM];
		main_trial.clear_stimulus_events();
		picture stim = form_array[Form_index];
		stim.set_part(3,letters[Letter_index]);
		main_trial.add_stimulus_event(stim);
		
		i =i+1;

		main_trial.present();
	
	end;
end;

array<int> test[][] = make_trial(2);
present_trials(test);
term.print_line(test);
#main_trial.add_stimulus_event(form_array[1],1);
#main_trial.present();
#main_trial.clear_stimulus_events();
#main_trial.add_stimulus_event(main_picture_circle,1);
#main_trial.present();



