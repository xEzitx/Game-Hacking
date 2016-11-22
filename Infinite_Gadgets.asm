{ Game   : RainbowSix.exe
  Version: 1.0
  Date   : 10-25-16
  Author : Brian Coffey

Works when HOST ONLY, Unfortunately, the host calculates amount of gadgets
used by a player, so even if the clients game says he has 99 gadgets left, he can't
use more than normal amount of gadgets.

Gives all players Primary and Secondary infinite gadgets / deployables


Normally i'd add some compares to target the player or players only, but
terrorists get 999 gadgets so unless i decide to mess w/ their gadgets im not
going to bother.

}


[ENABLE]

aobscanmodule(INJECT_Gadgets,RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41461,89 91 08 02 00 00 8B)
alloc(Infinite_Gadgets,2048,RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41461)
stealtheditex(stealth,INJECT_Gadgets,1)

label(originalcode_Gadgets)
label(returnhere)
label(sedit_infiniteGadgets)

registersymbol(sedit_infiniteGadgets)

//======================================================

Infinite_Gadgets:

	mov edx,3

	mov [rcx+00000208],edx
originalcode_Gadgets:

	jmp returnhere

//enable:
//db 0

//======================================================

stealth:
sedit_infiniteGadgets:
	jmp Infinite_Gadgets
	nop

returnhere:

[DISABLE]

sedit_infiniteGadgets:
	mov [rcx+00000208],edx

dealloc(Infinite_Gadgets)
unregistersymbol(sedit_infiniteGadgets)


{
// ORIGINAL CODE - INJECTION POINT: RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41461

RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+4143C: CC - int 3 
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+4143D: CC - int 3 
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+4143E: CC - int 3 
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+4143F: CC - int 3 
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41440: 80 B9 12020000 00 - cmp byte ptr [rcx+00000212],00
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41447: 74 08 - je 7FF74369E821
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41449: 3B 91 08020000  - cmp edx,[rcx+00000208]
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+4144F: 7C 75 - jl 7FF74369E896
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41451: 65 48 8B 04 25 58000000  - mov rax,gs:[00000058]
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+4145A: 4C 8B 81 F0000000  - mov r8,[rcx+000000F0]
// ---------- INJECTING HERE ----------
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41461: 89 91 08020000  - mov [rcx+00000208],edx
// ---------- DONE INJECTING  ----------
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41467: 8B 15 2B632C05  - mov edx,[7FF748964B68]
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+4146D: 41 B9 34000000 - mov r9d,00000034
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41473: 48 8B 04 D0   - mov rax,[rax+rdx*8]
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41477: 41 83 3C 01  02 - cmp dword ptr [r9+rax],02
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+4147C: 75 05 - jne 7FF74369E853
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+4147E: 49 8B 10  - mov rdx,[r8]
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41481: EB 17 - jmp 7FF74369E86A
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41483: 41 8B 40 0C  - mov eax,[r8+0C]
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+41487: 25 00000080 - and eax,80000000
RainbowSix.RBcFragmentedObject::GetCollisionMaterialOverride+4148C: 3D 00000080 - cmp eax,80000000
}
