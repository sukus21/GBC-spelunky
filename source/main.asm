INCLUDE "hardware.inc"
INCLUDE "header.inc"
INCLUDE "camera.inc"
INCLUDE "banks.inc"

SECTION "ERROR HANDLER", ROM0[$0038]

    ;Error handling
    v_error::
    ld a, bank(errorhandler)
    ld [$2000], a
    jp errorhandler
;

SECTION "VBLANK INTERRUPT", ROM0[$0040]
    
    ;No
    v_vblank::
    ld hl, error_vblank
    rst v_error 
;

SECTION "STAT INTERRUPT", ROM0[$0048]
    
    ;Disable interupts and push everything
    v_stat::
    di 
    push af
    push bc
    push de
    push hl

    ;Move the window out of the way
    xor a
    ldh [rIF], a
    dec a
    ldh [rWX], a
    ld a, IEF_VBLANK
    ldh [rIE], a
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00 | LCDCF_OBJON | LCDCF_OBJ16
    ldh [rLCDC], a

    ;Do music
    call _hUGE_dosound

    ;Pop everything and return
    pop hl
    pop de
    pop bc
    pop af
    ret
;



SECTION "ENTRY POINT", ROM0[$0100]
    
    ;Disable interupts and jump
    v_entry::
    di
    jp setup_complete
;



SECTION "MAIN", ROM0[$0150]

;Entrypoint of the program, jumped to after setup is complete
start::

;Endless loop, replace with game code
main:
    
    ;Wait for STAT interupt
    ld a, [rIE]
    and a, IEF_LCDC
    jr z, :+
    halt
    :
    
    ;Wait for Vblank
    halt

    ;Window shenanigans
    ld a, 7
    ldh [rWX], a
    xor a
    ldh [rWY], a
    ldh [rIF], a
    ld a, IEF_LCDC
    ldh [rIE], a
    ld hl, rLCDC
    res 1, [hl]
    ei
    
    ;Fetch update enable
    ld a, [w_screen_update_enable]
    bit camb_update, a
    jr z, :+

        ;Should it be updates horizontally or vertically?
        bit camb_vertical, a

        ;Fetch camera update coordinates
        ld hl, w_cam_update_x
        ld a, [hl+]
        ld c, [hl]
        ld b, a

        ;Switch banks around
        ld a, [w_world_bank]
        ld [$2000], a
        ld a, [w_layer_bank]
        ldh [rSVBK], a

        ;Call update functions
        push af
        call z, dwellings_map_update_vertical
        pop af
        call nz, dwellings_map_update_horizontal
        jr .dma
    :

    ;Update blocks from the updatelist instead
    bit camb_update_list, a
    jr z, :+

        ;There are items to be updated in the list
        ld a, [w_world_bank]
        ld [$2000], a
        ld a, [w_layer_bank]
        ldh [rSVBK], a
        call dwellings_map_update_list
        jr .dma
    :

    ;Update colors?
    ldh a, [h_input_pressed]
    bit PADB_SELECT, a
    jr z, :+

        ld hl, dwellings_palettes
        ld a, [w_palette_used]
        cpl 
        ld [w_palette_used], a
        inc a
        jr z, @+5
            ld hl, w_palette_buffer
        ld a, [w_world_bank]
        ldh [h_bank_number], a
        ld [$2000], a
        call palette_copy_all
        jr .dma
    :

    ;I have spare VRAM-time, update HUD
    ldh a, [rLY]
    cp a, $90
    call nc, hud_update

    ;Run sprite DMA
    .dma
    call h_dma_routine

    ;Load shadow scroll registers
    ldh a, [h_scx]
    ldh [rSCX], a
    ldh a, [h_scy]
    ldh [rSCY], a
    
    ;Get input
    call input

    ;Reset the entire thing maybe
    ;bit PADB_START, c
    ;jp nz, setup_newlevel

    ;Player code
    call_bank_m0 player

    ;Entity code
    ld a, bank_entities
    ldh [rSVBK], a

    ;Make sure entities are within the screen
    call entsys_oobcheck

    ;Execute entity code
    call w_entsys_execute

    ;Increment timer
    call hud_update_timer

    ;Go back to the start
    jp main
;



; Call this to end the game.
gameover::

    ;Wait for Vblank
    di 
    xor a
    ldh [rIF], a
    ld a, IEF_VBLANK
    ldh [rIE], a
    halt 

    ;Window shenanigans
    ld a, 7
    ldh [rWX], a
    xor a
    ldh [rWY], a

    ;Disable sprites
    ld hl, rLCDC
    res 1, [hl]

    ;Update hud once
    ld hl, w_level_timer
    ld a, 1
    ld [hl+], a
    ld [hl+], a
    ld [hl], 0
    call hud_update

    ;Set all sound registers to 0 to hopefully mute sound?
    ;maybe??? I hope??
    ld hl, $FF10
    ld b, $00
    ld de, $0030
    call memfill

    ;Wait for vblank again
    .wait
    xor a
    ldh [rIF], a
    ld a, IEF_VBLANK
    ldh [rIE], a
    halt 

    ;Vblank active
    call input
    bit PADB_START, c
    jr z, .wait

    jp setup_partial
;