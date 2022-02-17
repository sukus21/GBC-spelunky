INCLUDE "hardware.inc"

SECTION "SPRITES", ROM0
; DMA routune to be copied to HRAM.
; Lives in ROM0.
;
; DO NOT CALL!!!
dma_routine:
    
    ;Initialize OAM DMA
    ld a, HIGH(w_oam_mirror)
    ldh [rDMA], a
    ld a, 40

    ;Wait until transfer is complete
    .wait
    dec a
    jr nz, .wait

    ;Return
    ret
;



; Copy the DMA routine to HRAM.
; Lives in ROM0.
;
; Destroys: all
sprite_setup::
    
    ;Copy DMA routine to HRAM
    ld hl, h_dma_routine
    ld bc, dma_routine
    ld de, 10
    call memcopy

    ;Clear WRAM at shadow OAM
    ld hl, w_oam_mirror
    ld b, 0
    ld de, $9F
    call memfill

    ;Return
    ret
;



; Get one or multiple sprites.
; Lives in ROM0.
; 
; Input:
; - `b`: Sprite count * 4
;
; Output:
; - `a`: lower sprite address byte
sprite_get::

    ldh a, [h_sprite_slot]
    add a, b
    ldh [h_sprite_slot], a
    sub a, b
    ret 
;



; Clear remaining sprite slots.
; Sets sprite counter to 0.
; Lives in ROM0.
;
; Destroys: `hl`
sprite_finish::

    ldh a, [h_sprite_slot]
    ld l, a
    ld h, high(w_oam_mirror)
    ld a, $A0

    ;Fill loop
    :
        ld [hl], 0
        inc l
        cp a, l
        jr nz, :-
    
    ;Return
    xor a
    ldh [h_sprite_slot], a
    ret 
;