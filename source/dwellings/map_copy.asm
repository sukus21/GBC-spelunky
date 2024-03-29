INCLUDE "hardware.inc"
INCLUDE "banks.inc"
INCLUDE "dwellings/tileid.inc"
INCLUDE "chunktypes.inc"
INCLUDE "camera.inc"

INCLUDE "tile macros/all.inc"

SECTION "DWELLINGS MAP COPY", ROMX, BANK[bank_dwellings_main]

; Updates buffer with raw tiles.
; Updates a row at the given coordinates.
;
; Input:
; - `b`: Worldspace X-position
; - `c`: Worldspace Y-position
;
; Destroys: all
dwellings_map_buffer_horizontal::
    
    ;Set up a level pointer
    ;Vertical (y*64)
    ld h, 0
    ld a, c
    and a, %00111111
    ld l, a
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl

    ;Vertical (+x)
    ld a, b
    and a, %00111111
    add a, l
    ld e, a

    ;Add level data offset ($D0)
    ld a, $D0
    adc a, h
    ld d, a

    ;Buffer pointer
    ld hl, w_screen_update_buffer

    ;Prepare that one area in HRAM
    ld a, $C3 ;jp $XXXX
    ldh [h_temp_tile], a

    ;Load 12 blocks = 48 tiles
    ld b, 12
    .tile_load

        ;Get tiletable
        ld a, [w_level_tiletable]               ;3
        ld [hl], a                              ;2

        ;Get tile ID
        ld a, [de]                              ;2

        ;Multiply this value by 3 (19-21)
        ld c, a                                 ;1
        add a, c                                ;1
        jr nc, :+                               ;2/3
            inc [hl]                            ;3
        :
        add a, c                                ;1
        jr nc, :+                               ;2/3
            inc [hl]                            ;3
        :

        ;Write destination
        ldh [h_temp_tile+1], a                  ;3
        ld a, [hl]                              ;2
        ldh [h_temp_tile+2], a                  ;3
        
        ;Call tilehandler
        call h_temp_tile                        ;6 - 4

        ;Now at the end of the loop
        ;increment pointers
        inc e
        inc l
        
        ;End of loop, test counter
        dec b
        jr nz, .tile_load
    ;

    ;Return
    ret 
;



; Updates buffer with raw tiles.
; Updates a column at given coordinates.
;
; Input:
; - `b`: Worldspace X-position
; - `c`: Worldspace Y-position
;
; Destroys: all
dwellings_map_buffer_vertical::
    
    ;Set up a level pointer
    ;Vertical (y*64)
    ld h, 0
    ld a, c
    and a, %00111111
    ld l, a
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl

    ;Vertical (+x)
    ld a, b
    and a, %00111111
    add a, l
    ld e, a

    ;Add level data offset ($D0)
    ld a, $D0
    adc a, h
    ld d, a

    ;Buffer pointer
    ld hl, w_screen_update_buffer

    ;Prepare that one area in HRAM
    ld a, $C3 ;jp $XXXX
    ldh [h_temp_tile], a

    ;Load 11 blocks = 44 tiles
    ld b, 11
    .tile_load

        ;Get tiletable
        ld a, [w_level_tiletable]               ;3
        ld [hl], a                              ;2

        ;Get tile ID
        ld a, [de]                              ;2

        ;Multiply this value by 3 (19-21)
        ld c, a                                 ;1
        add a, c                                ;1
        jr nc, :+                               ;2/3
            inc [hl]                            ;3
        :
        add a, c                                ;1
        jr nc, :+                               ;2/3
            inc [hl]                            ;3
        :

        ;Write destination
        ldh [h_temp_tile+1], a                  ;3
        ld a, [hl]                              ;2
        ldh [h_temp_tile+2], a                  ;3
        
        ;Call tilehandler
        call h_temp_tile                        ;6 - 4


        ;Move level pointer down
        ld a, e                                 ;1
        add a, 64                               ;2
        ld e, a                                 ;1
        jr nc, :+                               ;2
        inc d                                   ;1
        :

        ;Increment buffer pointer
        inc l
        
        ;End of loop, test counter
        dec b                                   ;1
        jr nz, .tile_load                       ;3
    ;

    ;Return
    ret 
;



; Updates the screen with tiles from buffer.
; Updates a row at the given coordinates.
; Assumes VRAM access.
;
; Input:
; - `b`: Worldspace X-position
; - `c`: Worldspace Y-position
;
; Destroys: all
dwellings_map_update_horizontal::
    
    ;Set up a map pointer
    ;Vertically (*32)
    ld h, 0
    ld a, c
    add a, a
    and a, %00011111
    ld l, a
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl

    ;Horizontally (+)
    ld a, b
    add a, a
    and a, %00011111
    add a, l
    ld l, a

    ;Add VRAM tilemap offset
    ld a, high(_SCRN0)
    adc a, h
    ld h, a

    ld de, w_screen_update_buffer

    ;Copy upper tiles
    ld c, l ;Save for later
    REPT 12
        ld a, [de]
        inc e
        ld [hl+], a
        ld a, [de]
        inc e
        ld [hl+], a
        res 5, l
    ENDR

    ;Copy lower tiles in reverse
    set 5, l
    dec l
    set 5, l
    ld b, l ;Save for later
    set 5, e
    REPT 12
        dec e
        ld a, [de]
        ld [hl-], a
        dec e
        ld a, [de]
        ld [hl-], a
        set 5, l
    ENDR

    ;Copy upper palettes
    ld a, 1
    ldh [rVBK], a
    ld e, low(w_screen_update_buffer_pal)
    ld l, c ;Restored from earlier
    REPT 12
        ld a, [de]
        inc e
        ld [hl+], a
        ld a, [de]
        inc e
        ld [hl+], a
        res 5, l
    ENDR

    ;Copy lower palettes in reverse
    ld l, b
    set 5, e
    REPT 12
        dec e
        ld a, [de]
        ld [hl-], a
        dec e
        ld a, [de]
        ld [hl-], a
        set 5, l
    ENDR

    ;Reset VRAM bank
    xor a
    ldh [rVBK], a

    ;Return
    ret 
;



; Updates the screen with tiles from buffer.
; Updates a column at given coordinates.
; Assumes VRAM access.
;
; Input:
; - `b`: Worldspace X-position
; - `c`: Worldspace Y-position
;
; Destroys: all
dwellings_map_update_vertical::
    
    ;Set up a map pointer
    ;Vertically (*32)
    ld h, 0
    ld a, c
    add a, a
    and a, %00011111
    ld l, a
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl

    ;Horizontally (+)
    ld a, b
    add a, a
    and a, %00011111
    add a, l
    ld l, a

    ;Add VRAM tilemap offset
    ld a, high(_SCRN0)
    adc a, h
    ld h, a

    ld de, w_screen_update_buffer

    ;Copy tiles (upper and lower)
    ld b, 32 ;Small optimization
    push hl
    REPT 11
        
        ;Upper
        ld a, [de]
        ld [hl+], a
        inc e
        ld a, [de]
        ld [hl-], a
        dec e

        ;Lower
        set 5, l
        set 5, e
        ld a, [de]
        ld [hl+], a
        inc e
        ld a, [de]
        ld [hl-], a
        inc e

        ;Prepare for next row
        res 5, e
        ld a, l
        add a, b
        ld l, a
        jr nc, :+
            inc h
        :

        ;Wrap around vertically
        res 2, h
    ENDR

    ;Switch to palettes
    pop hl
    ld e, low(w_screen_update_buffer_pal)
    ld a, 1
    ldh [rVBK], a

    ;Copy palettes (upper and lower)
    REPT 11
        
        ;Upper
        ld a, [de]
        ld [hl+], a
        inc e
        ld a, [de]
        ld [hl-], a
        dec e

        ;Lower
        set 5, l
        set 5, e
        ld a, [de]
        ld [hl+], a
        inc e
        ld a, [de]
        ld [hl-], a
        inc e

        ;Prepare for next row
        res 5, e
        ld a, l
        add a, b
        ld l, a
        jr nc, :+
            inc h
        :

        ;Wrap around vertically
        res 2, h
    ENDR

    ;Switch back to tiles
    xor a
    ldh [rVBK], a

    ;Do that again but with palettes this time
    ;Return
    ret 
;



; Updates the screen with tiles.
; Updates tiles anywhere.
; Assumes VRAM access.
;
;
; Destroys: all
dwellings_map_update_list::
    
    ;Load block count and list pointer
    ld hl, w_screen_update_list_head
    ld b, [hl]
    dec b

    ;Prepare that one area in HRAM
    ld a, $C3 ;jp $XXXX
    ldh [h_temp_tile], a

    ;Loop
    .tile_load
    
        ;Grab pointer to tile
        ld c, b
        ld b, high(w_screen_update_list)
        ld a, [bc]
        ld e, a
        dec c
        ld a, [bc]
        ld d, a
        dec c
        
        ;Decrement list element count
        ld c, low(w_screen_update_list_head)
        ld a, [bc]
        dec a
        dec a
        ld [bc], a
        ld b, a
        jr z, .done
        dec b

        ;Pointer to buffer
        ld hl, w_screen_update_buffer

        ;Multiply this value by 3
        ld a, [w_level_tiletable]               ;4
        ld [hl], a                              ;2

        ;Tile ID -> A+C
        ld a, [de]                              ;2
        ld c, a                                 ;1
        add a, c                                ;1
        jr nc, :+                               ;2/3
            inc [hl]                                ;3
        :
        add a, c                                ;1
        jr nc, :+                               ;2/3
            inc [hl]                                ;3
        :
        ldh [h_temp_tile+1], a                  ;3
        ld a, [hl]                              ;2
        ldh [h_temp_tile+2], a                  ;3
        
        ;Call tilehandler
        call h_temp_tile                        ;6 - 4

        ;Turn DE this into VRAM pointer in HL
        ld a, d
        and a, %00000011
        rra 
        ld h, a
        ld a, e
        rra 
        and a, %11100000
        ld l, a
        add hl, hl
        ld a, e
        and a, $0F
        rla 
        add a, l
        ld l, a
        ld a, h
        adc a, high(_SCRN0)
        ld h, a

        ;Copy tile from buffer to VRAM
        ld de, w_screen_update_buffer
        ld a, [de]
        ld [hl+], a
        inc e
        ld a, [de]
        ld [hl-], a
        dec e
        set 5, e
        set 5, l
        ld a, [de]
        ld [hl+], a
        inc e
        ld a, [de]
        ld [hl-], a
        dec e

        ;Switch to palettes
        ld a, 1
        ldh [rVBK], a

        ;Load palettes
        set 6, e
        ld a, [de]
        ld [hl+], a
        inc e
        ld a, [de]
        ld [hl-], a
        dec e
        res 5, e
        res 5, l
        ld a, [de]
        ld [hl+], a
        inc e
        ld a, [de]
        ld [hl-], a
        dec e

        ;Switch to tiles
        xor a
        ldh [rVBK], a
        
        ;Now at the end of loop, check rLY
        ldh a, [rLY]
        cp a, high(_SCRN0)
        jr c, .tile_load
    ;

    ;Return
    ret 

    .done
        ld hl, w_screen_update_enable
        res camb_update_list, [hl]
        ld hl, w_screen_update_list_count
        xor a
        ld [hl+], a
        ld [hl], 2
        ret 
;



; Takes the finished path structure + info and creates a map from them.
;
; Input:
; - `w_chunk_type`: Path structure in WRAM
; - `w_chunk_info`: Path structure info
;
; Destroys: all
dwellings_map_generate::

    ;Switch to foreground map bank
    ld a, bank(level_foreground)
    ldh [rSVBK], a

    ;Clear it entirely
    ld hl, level_foreground
    ld de, $1000
    ld b, b_border
    call memfill

    ;Initialize loop
    ld de, w_chunk_type
    push de

    ;Reset variables
    ld a, $05
    ld [w_chunk_x], a
    ld a, $FF
    ld [w_chunk_y], a
    
    .loop

        ;Chunk X/Y positions
        ld a, [w_chunk_x]
        inc a
        ld [w_chunk_x], a
        cp a, 6
        jr c, :+
            
            ;Reset X counter
            xor a
            ld [w_chunk_x], a

            ;Increment Y counter
            ld a, [w_chunk_y]
            inc a
            ld [w_chunk_y], a

            ;If Y counter is at maximum
            cp a, 6
            jr nz, :+
                
                ;Break from function
                pop de
                jp z, .oversee
        :
    
        ;Get chunk type
        pop de
        ld a, [de]
        ld [w_chunk_id], a
        inc de
        push de

        ;If this chunk is a border/invalud chunk, do nothing
        cp a, ct_invalid
        jr z, .loop
        
        ;Test if entrance
        bit ctb_entrance, a
        jr z, :+
            ld hl, dwellings_chunk_struct_lookup+2
            jr .getchunk
        :

        ;Test if exit
        bit ctb_exit, a
        jr z, :+
            ld hl, dwellings_chunk_struct_lookup+4
            jr .getchunk
        :

        ;Default
        ld hl, dwellings_chunk_struct_lookup

        ;Get chunk pointer
        .getchunk
        and a, $0F
        ld c, a
        ld a, [hl+]
        ld h, [hl]
        ld l, a

        ;Get chunk type
        ld a, c
        add a, a
        add a, a
        add a, c
        add a, c

        ;Here we are
        add a, l
        ld l, a
        jr nc, :+
        inc h
        :

        ;Data things
        ld a, [hl+] ;Read chunk count
        ld d, a
        ld a, [hl+] ;Read chunk size (Mostly redundant)
        ld c, a

        ;Get start of chunk data
        inc hl
        inc hl
        ld a, [hl+]
        ld h, [hl]
        ld l, a

        ;Call randomizer
        call rng_run_single

        ;Number must be between 0 and d-1
        :
        add a, d
        jr nc, :-
        
        ;Multiplication loop
        push hl
        ld hl, $0000
        ld d, l
        ld e, c
        ld c, a
        inc c
        :
            dec c
            jr z, :+
            add hl, de
            jr :-
        :

        ;Get final pointer
        ld d, h
        ld e, l
        pop hl
        add hl, de
        
        ;Copy chunk to chunk buffer
        ld b, h
        ld c, l
        ld hl, w_chunk_buffer
        ld de, 80
        call memcopy

        ;Find any macro-blocks
        ld hl, w_chunk_buffer
        ld b, 80

        ;Look for macroblocks
        .mloop
        ld a, [hl+]
        bit 7, a
        jr z, .mloop_end
            
            ;Push everything
            push af
            push de
            push bc
            push hl
            
            ;Figure out where to call to and call
            res 7, a
            add a, a
            ld b, h
            ld c, l
            ld h, high(dwellings_macroblock_lookup)
            ld l, a

            ;Read address at location
            ld a, [hl+]
            ld h, [hl]
            ld l, a
            call _hl_

            ;Pop everything
            pop hl
            pop bc
            pop de
            pop af

        ;End of macroblock loop
        .mloop_end
        dec b
        jp nz, .mloop

        ;Get chunk X and Y coordinates
        ld a, [w_chunk_x]
        ld b, a
        ld a, [w_chunk_y]
        ld c, a

        ;Get chunk info byte
        pop de
        ld hl, 36
        add hl, de
        ld a, [hl]
        push de
        ld hl, w_chunk_buffer

        ;Copy chunk to level data
        call level_chunk_place

        ;Return to the start of loop
        jp .loop
    
    .oversee
    ;Go over every single block in the level and maybe run some code?
    ld hl, level_foreground+$1000
    .loop2

        ;End loop if we reach WRAM0
        dec hl
        ld a, l
        cp a, $FF
        jr nz, :+

            ld a, h
            cp a, $CF
            ret z
        :

        call dwellings_polish
        jr .loop2

;