//Stubbs The Zombie Fullgame autosplitter
//by Burnt
//for both new and old ports


//Features:
//start timer
//split between levels
//split on ending
//automatic resets
//DOES NOT split on hippo heads (yet)


state("CoDSP") 
{
	uint levelname: 0x3FC083B7;
	uint tickcounter1: 0x3FC084BC; //used for start 105
	uint menutick: 0x3FC08BE0; //used for start
	uint inputflag: 0x23FD48; //used for ending
	uint lastroomflag: 0x3FECDCA0; //used for ending
	
}

state("StubbsTheZombieSub")
{
	//uint levelname: 0x64AD84;
	uint levelname: 0x638B78;
	uint tickcounter1: 0x640AB4; //used for start
	uint menutick: 0x6BE2A8; //used for start
	uint inputflag: 0x63FA90; //used for ending
	uint lastroomflag: 0x0064B688, 0x21C; //becomes 1 when in boss battle (NOT when in cs beforehand)
	
	
}

startup 
{
	//var init
	vars.indexoffset = 0;
	vars.crashflag = false;
	vars.crashwait = timer.CurrentTime.RealTime; //should be zero but doesn't matter
}

init
{
	//moved indexoffset out of init in case of game crash
}

exit
{
	vars.crashflag = true;
}



start 	//starts timer
{
	
	if(current.levelname == 1596993889 
		&& current.tickcounter1 < 20 
		&& current.menutick > 1)
	{
		vars.crashwait = timer.CurrentTime.RealTime;
		vars.indexoffset = 0;
		return true;
	}
	
	//starts timer on start of first level intro cutscene
}


reset
{
	
	if (current.levelname == 1596993889 
		&& current.tickcounter1 < 20 
		&& current.menutick < old.menutick 
		&& timer.CurrentTime.RealTime > TimeSpan.FromSeconds(1) //safety check to prevent double resets
		&& timer.CurrentTime.RealTime > vars.crashwait + TimeSpan.FromSeconds(1) //safety check to prevent reset after crash
	)
	{
		if (vars.crashflag) //anti crash-reset stuff
		{
			vars.crashflag = false;
			vars.crashwait = timer.CurrentTime.RealTime;
		}
		else
		{
			return true;
		}
		
		
	}
}




split
{
	
	int checkindex = timer.CurrentSplitIndex + vars.indexoffset;
	switch (checkindex)
	{
		case 0: //split on a10 end
		return (current.levelname == 1596994401); //a30
		break;
		
		case 1: //split on a30 end
		return (current.levelname == 1596994657); //a40
		break;
		
		case 2: //split on a40 end
		return (current.levelname == 1597322337); //a45
		break;
		
		case 3: //split on a45 end
		return (current.levelname == 1596994913); //a50
		break;
		
		case 4: //split on a50 end
		return (current.levelname == 1596995169); //a60
		break;
		
		case 5: //split on a60 end
		return (current.levelname == 1596993890); //b10
		break;
		
		case 6: //split on b10 end
		return (current.levelname == 1596994402); //b30
		break;
		
		case 7: //split on b30 end
		return (current.levelname == 1596993891); //c10
		break;
		
		case 8: //split on c10 end
		return (current.levelname == 1596994403); //c30
		break;
		
		case 9: //split on c30 end
		return (current.levelname == 1596994659); //c40
		break;
		
		case 10: //split on c40 end
		return (current.levelname == 1596994915); //c50
		break;
		
		case 11: //split on c50 end
		return (current.levelname == 1596994915 && current.lastroomflag == 1 && current.inputflag == 1);
		break;
		
		
		
		
		default:	//split on c50 end
		return (current.levelname == 1596994915 && current.lastroomflag == 1 && current.inputflag == 1);
		break;
	}
}

