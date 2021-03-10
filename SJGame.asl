//Credits Mysterion_06_

state("SJGAME-Win64-Shipping") 
{
    int gameTimer: 0x03A2C610, 0x8, 0x710;
    float milliTimer: 0x03a26F50, 0x80, 0x7B4;
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
    current.milliTimer = Math.Floor(current.milliTimer * 100) / 100;
    // Death case: Keep old game time when dying instead of resetting to checkpoint's recorded time.
    if (current.gameTimer < old.gameTimer) {
        vars.totalTime += old.gameTimer - current.gameTimer + old.milliTimer - current.milliTimer;
    }
    if (current.gameTimer >= 0 && old.gameTimer == 0) {
        vars.totalTime = vars.totalTime - current.gameTimer && vars.totalTime- current.milliTimer;
    }
    return TimeSpan.FromSeconds(vars.totalTime + current.gameTimer + current.milliTimer);
}
