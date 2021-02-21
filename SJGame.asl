//Credits Mysterion_06_

state("SJGAME-Win64-Shipping") 
{
    int gameTimer: 0x39E8428, 0x830, 0x330, 0x7B0;
    float milliTimer: 0x039DA9B0, 0x80, 0x7B4;
}

init 
{
    vars.totalTime = 0;
}

start
{
    if(current.gameTimer > 0){
        vars.totalTime = 0;
        return true;
    }
}

isLoading 
{
    return true;
}

gameTime {
    if (current.gameTimer < old.gameTimer) {
        vars.totalTime += old.gameTimer - current.gameTimer;
    }
    if (current.gameTimer >= 0 && old.gameTimer == 0) {
        vars.totalTime = vars.totalTime - current.gameTimer;
    }
    return TimeSpan.FromSeconds(vars.totalTime + current.gameTimer + current.milliTimer);
}
