{ Game   : RainbowSix.exe
  Version: 1.0
  Date   : 10-23-16
  Author : Brian Coffey	

  Host Only

  Makes all players & hostage invincible. Also makes Blackbeard's shield invincible.
Note 1: enemymem might not be working properly due to patch 5.1. rest still works.
Note 2: Uncomment line 60 (enemymem,sub edx,#99) to make 
regular terrorists 1 hit kill and bombers take 99 more damage per bullet.

}

[ENABLE]

aobscanmodule(INJECT_GOD_MODE,RainbowSix.RBcCollisionObject::SetFilterId+16F4,89 91 08 01 00 00 33 D2)
alloc(newmem_GodMode,2048,RainbowSix.RBcCollisionObject::SetFilterId+16F4)
stealtheditex(stealth,INJECT_GOD_MODE,1)

label(originalcode_godMode)
label(returnhere_godmode)
label(sedit_health)
label(_PlayerGodMode)
registersymbol(sedit_health)
registersymbol(_PlayerGodMode)
globalalloc(PlayerBase,4)
label(enemymem)
registersymbol(enemymem)
label(hostagemem)
registersymbol(hostagemem)
label(shield)
registersymbol(shield)

//======================================================

newmem_GodMode:

	//cmp dword [rcx+00000110],3FE79863
    cmp byte [rcx+00000110],63
    //mov [PlayerBase],rcx
    je _PlayerGodMode

    cmp byte [rcx+00000110],73
    je enemymem
    cmp byte [rcx+00000110],#222
    je hostagemem
    cmp byte [rcx+00000110],0
    je shield
	mov [rcx+00000108],edx
    jmp returnhere_godmode

// Blackbeard's Shield
shield:
   mov [rcx+00000108],#150
   mov [rcx+0000012C],bf000000
   jmp returnhere_godmode

enemymem:
    //sub edx,#99 // 1 hit terrorists. alternatively, change to mov edx,0 to it so enemies can't spawn
    mov [rcx+00000108],edx
    jmp returnhere_godmode

_PlayerGodMode:

       mov [rcx+00000108],#120 // mov (decimal)120 to health
       // to be used in other scripts
       // gives players extra strong rook armour
       mov [rcx+0000012C],bf000000
       jmp returnhere_godmode

hostagemem:
   mov [rcx+00000108],#150

originalcode_godMode:

	jmp returnhere_godmode

//enable:
//db 0

//======================================================

stealth:
sedit_health:
	jmp newmem_GodMode
	nop

returnhere_godmode:

[DISABLE]

sedit_health:
	mov [rcx+00000108],edx

unregistersymbol(stealthedit)
dealloc(newmem_GodMode)
dealloc(PlayerBase)
