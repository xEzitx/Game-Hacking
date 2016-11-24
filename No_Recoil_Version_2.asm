{ Game   : RainbowSix.exe
  Version: 1.0
  Date   : 11-22-16
  Author : Brian Coffey

  New Injection Point = "RainbowSix.exe"+EA1E13

  Script for No Recoil.

  Status: Working 11/22

}

[ENABLE]

aobscanmodule(INJECT_No_Recoil,"RainbowSix.exe"+EA1E13,F3 0F 10 4B 70 44)
alloc(newmem_no_recoil,2048,"RainbowSix.exe"+EA1E13)
stealtheditex(stealth,INJECT_No_Recoil,1)

label(originalcode_No_Recoil)
label(returnhere)
label(No_Recoil)

registersymbol(No_Recoil)
alloc(_recoilValue,8)
registersymbol(_recoilValue)

//======================================================

newmem_no_recoil:

   movss xmm0, [_recoilValue]
   movss xmm2,xmm0
   movss xmm1,xmm0
   movss [rbx+48],xmm0
   movss [rbx+70],xmm0
   movss [rbx+40],xmm0
   movss [rbx+4C],xmm0
   movss [rbx+44],xmm0
   movss [rbx+5C],xmm0 // make our Recoil Value = 0
   movss [rbx+54],xmm0 // make rbx+54 = 0
   movss [rbx+58],xmm0
   movss [rbx+50],xmm0




originalcode_No_Recoil:

	jmp returnhere

_recoilValue:

dd (float)0.0

//enable:
//db 0

//======================================================

stealth:
No_Recoil:
	jmp newmem_no_recoil

returnhere:

[DISABLE]

No_Recoil:
	movss xmm1,[rbx+70]

unregistersymbol(No_Recoil)
dealloc(newmem_no_recoil)


{ Recoil Notes / Scratch Buffer

rbx+28 = "RainbowSix.exe"+02E2AF48 + 18 + D0 + 488 + 98 + 158

//RECOIL_BASE = rbx = "RainbowSix.exe"+02E2AF48 + 18 + D0 + 488 + 98 + 130

//Known Recoil VALUE address = rbx+28 -- moved into xmm0

//{current recoil amount? = rbx+74 -- moved into xmm1

xmm0 -

movss xmm0,[rbx+58] // --- Injection Here --- \\
subss xmm0,[rbx+50]
mulss xmm0,xmm2 -- find out where xmm2 is calculated.
adds xmm0,[rbx+50]

movss [rbx+10],xmm0 -- moves current value of xmm0 into rbx+10
// possible current recoil amount = [rbx+10]
// possible_current_recoil =  "RainbowSix.exe"+02E2AF48 + 18 + D0 + 488 + 98 + 140


// Recoil 1 (same as above, just copied for reference)
RainbowSix.RDcGroupCondition::IsActive+4CBC2 - movss xmm0,[rbx+58]
RainbowSix.RDcGroupCondition::IsActive+4CBC7 - subss xmm0,[rbx+50]
RainbowSix.RDcGroupCondition::IsActive+4CBCC - mulss xmm0,xmm2
RainbowSix.RDcGroupCondition::IsActive+4CBD0 - addss xmm0,[rbx+50]
RainbowSix.RDcGroupCondition::IsActive+4CBD5 - movss [rbx+10],xmm0

// Recoil 2
RainbowSix.RDcGroupCondition::IsActive+4CBA7 - movss xmm0,[rbx+4C]
RainbowSix.RDcGroupCondition::IsActive+4CBAC - subss xmm0,[rbx+44]
RainbowSix.RDcGroupCondition::IsActive+4CBB1 - mulss xmm0,xmm2
RainbowSix.RDcGroupCondition::IsActive+4CBB5 - addss xmm0,[rbx+44]
RainbowSix.RDcGroupCondition::IsActive+4CBBA - movss [rbx+00000098],xmm0

// rbx+18 also gets effected by xmm0->
// Recoil 3
RainbowSix.RDcGroupCondition::IsActive+4CBDA - movss xmm0,[rbx+5C]
RainbowSix.RDcGroupCondition::IsActive+4CBDF - subss xmm0,[rbx+54]
RainbowSix.RDcGroupCondition::IsActive+4CBE4 - mulss xmm0,xmm2
RainbowSix.RDcGroupCondition::IsActive+4CBE8 - addss xmm0,[rbx+54]
RainbowSix.RDcGroupCondition::IsActive+4CBED - movss [rbx+18],xmm0


// current possible effective injection:

alloc(_recoilValue,8)
registersymbol(_recoilValue)

newmem:
movss xmm0, [_recoilValue]
movss [rbx+48],xmm0
movss [rbx+70],xmm0
movss [rbx+40],xmm0
movss [rbx+4C],xmm0
movss [rbx+44],xmm0
movss xmm2,xmm0
movss [rbx+5C],xmm0 // make our Recoil Value = 0
movss [rbx+54],xmm0 // make rbx+54 = 0
movss xmm2,xmm0 // make xmm2 = 0 // repeated, for good measure.
movss [rbx+58],xmm0
movss [rbx+50],xmm0



originalcode:

_recoilValue
dd (float)0.0

{
// ORIGINAL CODE - INJECTION POINT: "RainbowSix.exe"+EA1E13

RainbowSix.RDcGroupCondition::IsActive+4CB5A: F3 0F10 43 3C  - movss xmm0,[rbx+3C]
RainbowSix.RDcGroupCondition::IsActive+4CB5F: F3 0F5E C3  - divss xmm0,xmm3
RainbowSix.RDcGroupCondition::IsActive+4CB63: 41 0F2F C1  - comiss xmm0,xmm9
RainbowSix.RDcGroupCondition::IsActive+4CB67: 76 11 - jna 7FF76052EC1A
RainbowSix.RDcGroupCondition::IsActive+4CB69: F3 0F10 15 D7B35701  - movss xmm2,[7FF761AA9FE8]
RainbowSix.RDcGroupCondition::IsActive+4CB71: 44 0F28 C8  - movaps xmm9,xmm0
RainbowSix.RDcGroupCondition::IsActive+4CB75: 0F2F C2  - comiss xmm0,xmm2
RainbowSix.RDcGroupCondition::IsActive+4CB78: 73 04 - jae 7FF76052EC1E
RainbowSix.RDcGroupCondition::IsActive+4CB7A: 41 0F28 D1  - movaps xmm2,xmm9
RainbowSix.RDcGroupCondition::IsActive+4CB7E: F3 0F10 43 48  - movss xmm0,[rbx+48]
// ---------- INJECTING HERE ----------
"RainbowSix.exe"+EA1E13: F3 0F10 4B 70  - movss xmm1,[rbx+70]
// ---------- DONE INJECTING  ----------
RainbowSix.RDcGroupCondition::IsActive+4CB88: 44 0F28 4C 24 40  - movaps xmm9,[rsp+40]
RainbowSix.RDcGroupCondition::IsActive+4CB8E: 0F2F F9  - comiss xmm7,xmm1
RainbowSix.RDcGroupCondition::IsActive+4CB91: F3 0F5C 43 40  - subss xmm0,[rbx+40]
RainbowSix.RDcGroupCondition::IsActive+4CB96: F3 0F59 C2  - mulss xmm0,xmm2
RainbowSix.RDcGroupCondition::IsActive+4CB9A: F3 0F58 43 40  - addss xmm0,[rbx+40]
RainbowSix.RDcGroupCondition::IsActive+4CB9F: F3 0F11 83 94000000  - movss [rbx+00000094],xmm0
RainbowSix.RDcGroupCondition::IsActive+4CBA7: F3 0F10 43 4C  - movss xmm0,[rbx+4C]
RainbowSix.RDcGroupCondition::IsActive+4CBAC: F3 0F5C 43 44  - subss xmm0,[rbx+44]
RainbowSix.RDcGroupCondition::IsActive+4CBB1: F3 0F59 C2  - mulss xmm0,xmm2
RainbowSix.RDcGroupCondition::IsActive+4CBB5: F3 0F58 43 44  - addss xmm0,[rbx+44]
}
