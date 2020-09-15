state("SJGAME-Win64-Shipping") 
{
    int gameTimer: 0x39E8428, 0x830, 0x330, 0x7B0;
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
    return TimeSpan.FromSeconds(vars.totalTime + current.gameTimer);
}