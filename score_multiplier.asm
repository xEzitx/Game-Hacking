{ Game   : RainbowSix.exe
  Version: 1.0
  Date   : 10-29-16
  Author : Brian Coffey

Increase score earned during game.

Change the value @ line 29 (add edx,75) to increase / decrease score earned.
works for all players in lobby if host.

}

[ENABLE]

aobscanmodule(INJECT_Score_Multiplier,RainbowSixGame.exe+755239,01 91 B8 00 00 00 48)
alloc(Score_Multiplier,2048,RainbowSix.RainbowSixGame.exe+755239)
stealtheditex(stealth,INJECT_Score_Multiplier,1)

label(originalcode_scoreMultiplier)
label(returnhere_ScoreMultiplier)
label(score)

registersymbol(score)

//======================================================

Score_Multiplier:

	add edx,75
	add [rcx+000000B8],edx
originalcode_scoreMultiplier:

	jmp returnhere_ScoreMultiplier

//enable:
//db 0

//======================================================

stealth:
score:
	jmp Score_Multiplier
	nop

returnhere_ScoreMultiplier:

[DISABLE]

score:
	add [rcx+000000B8],edx

unregistersymbol(score)
dealloc(Score_Multiplier)

