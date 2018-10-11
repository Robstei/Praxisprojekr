begin;
	$inheight = 800;
	$inwidth = 1280;
	
	array{  
			bitmap {filename = "instructions/original/instruction1.jpg";description = "instruction1";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/play1.jpg";description = "play1";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/play2.jpg";description = "play2";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/play3.jpg";description = "play3";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/play4.jpg";description = "play4";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/practice1.jpg";description = "practice1";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/practice2.jpg";description = "practice2";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/practice3.jpg";description = "practice3";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/practice4.jpg";description = "practice4";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/practice5.jpg";description = "practice5";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/practice6.jpg";description = "practice6";height=$inheight;width=$inwidth;};
		}instructions;
		
		array{  
			bitmap {filename = "instructions/original/block_A_1.jpg";description = "block_A_1";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/block_A_2.jpg";description = "block_A_2";height=$inheight;width=$inwidth;};
		}blockA;
		
		array{  
			bitmap {filename = "instructions/original/block_B_1.jpg";description = "block_B_1";height=$inheight;width=$inwidth;};
			bitmap {filename = "instructions/original/block_B_2.jpg";description = "block_B_2";height=$inheight;width=$inwidth;};
		}blockB;
		
		
		sound { wavefile { filename = "sounds/original/Kugelschreiber.wav"; };attenuation = 0.05;}sound1;
		sound { wavefile { filename = "sounds/original/Locher.wav"; };attenuation = 0.05;}sound2;
		sound { wavefile { filename = "sounds/original/Schere_zweimal.wav"; };attenuation = 0.05;}sound3;
		sound { wavefile { filename = "sounds/original/Tacker.wav"; };attenuation = 0.05;}sound4;
		
		trial {
		} main_trial;
		
begin_pcl;



