response_matching = simple_matching;

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
	} form_array;

	

trial {
		trial_duration = 2000;
		
		stimulus_event{
		picture {
			} main_picture;
		}stim_event;
		
	} main_trial;



begin_pcl;


loop int i = 1 until i > numbers.count()
begin
	loop int j = 1 until j > form_array.count()
	begin

	main_picture = form_array[j];
	main_picture.set_part(3,numbers[i]);
	stim_event.set_stimulus(main_picture);
	main_trial.present();
	display_device.screenshot(form_array[j].description() + numbers[i].caption() +".bmp");
	j = j +1;
	end;
	
	i = i + 1;
end;

loop int i = 1 until i > letters.count()
begin
	loop int j = 1 until j > form_array.count()
	begin

	main_picture = form_array[j];
	main_picture.set_part(3,letters[i]);
	stim_event.set_stimulus(main_picture);
	main_trial.present();
	display_device.screenshot(form_array[j].description() + letters[i].caption() +".bmp");
	j = j +1;
	end;
	
	i = i + 1;
end;

