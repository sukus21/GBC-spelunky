INCLUDE "hardware.inc"

SECTION "SNIPPETS", ROM0

; Copies data from one location to another using the CPU.
; Lives in ROM0.
;
; Input:
; - `hl`: Destination
; - `bc`: Source
; - `de`: Byte count
;
; Output:
; - `hl`: Destination + Byte count
; - `bc`: Source + Byte count
; - `de`: `$0000`
;
; Destroys: `af`
memcopy::

    ;Copy the data
    ld a, [bc]
    ld [hl+], a
    inc bc
    dec de

    ;Check byte count
    ld a, d
    or e
    jr nz, memcopy

    ;Return
    ret 
;



; Sets a number of bytes at a location to a single value.
; Lives in ROM0.
;
; Input:
; - `hl`: Destination
; - `b`: Fill byte
; - `de`: Byte count
;
; Output:
; - `hl`: Destination + Byte count
; - `de`: `$0000`
;
; Destroys: `af`
memfill::

    ;Fill data
    ld a, b
    ld [hl+], a
    dec de

    ;Check byte count
    ld a, d
    or e
    jr nz, memfill

    ;Return
    ret
;



; Same as memcopy, but only stops once 0 is seen.
; Made specifically to copy text.
; Lives in ROM0.
;
; Input:
; - `hl`: Destination
; - `bc`: Source
strcopy::
    ld a, [bc]
    inc bc
    or a, a
    ret z

    ld [hl+], a
    jr strcopy
;



; Compares two strings.
; Lives in ROM0.
; 
; Input: 
; - `hl`: String 1
; - `de`: String 2
;
; Output:
; `fz`: Strings are equal (z=1, strings are equal)
strcomp::

    ;Compare values
    ld a, [de]
    cp a, [hl]
    ret nz

    ;Is [hl] == 0?
    inc de
    ld a, [hl+]
    cp a, 0
    ret z
    jr strcomp
;



; Copies a cgb palette to background color memory.
; Lives in ROM0.
;
; Input:
; - `hl`: Palette address
; - `a`: Palette index * 8
;
; Output:
; - `hl`: `$0010`
; - `a`: `$08`
;
; Destroys: `bc`
palette_copy_bg::

    ;Write palette index
    ld b, a
    set 7, a
    ldh [rBCPS], a
    ld c, low(rBCPD)

    ;Copy the palette
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a

    ;Increase palette index
    ld a, b
    add a, $08

    ;Return
    ret
;



; Copies a cgb palette to sprite color memory.
; Lives in ROM0.
;
; Input:
; - `hl`: Palette address
; - `a`: Palette index * 8
;
; Output:
; - `hl`: Palette address + `$10`
; - `a`: Palette index + `$08`
;
; Destroys: `bc`
palette_copy_spr::

    ;Write palette index
    ld b, a
    set 7, a
    ldh [rOCPS], a
    ld c, low(rOCPD)

    ;Copy the palette
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a
    ld a, [hl+]
    ldh [c], a

    ;Increase palette index
    ld a, b
    add a, $08

    ;Return
    ret
;



; Copies ALL CGB palettes.
; Lives in ROM0.
; 
; Input:
; - `hl`: Palette address
palette_copy_all::

    ld a, $80
    ldh [rBCPS], a
    ld c, low(rBCPD)
    ld b, 8

    .bgcopy

        ;Copy one palette
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a

        ;Counter
        dec b
        jr nz, .bgcopy
    ;

    ld a, $80
    ldh [rOCPS], a
    ld c, low(rOCPD)
    ld b, 8

    .sprcopy

        ;Copy one palette
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a
        ld a, [hl+]
        ldh [c], a

        ;Counter
        dec b
        jr nz, .sprcopy
    ;

    ;Return
    ret 
;



; Creates a copy of the currently loaded CGB palettes.
; Lives in ROM0.
;
; Input:
; - `hl`: Where to store the new palettes
; 
; Destroys: all (probably)
palette_make_lighter::

    ld d, h
    ld e, l
    push hl
    
    ;First, copy all palettes to the destination
    ld hl, rBCPS
    ld [hl], 0
    ld c, low(rBCPD)
    ld b, $40

    .copybg
        
        ldh a, [c]
        ld [de], a
        inc de
        inc [hl]
        dec b
        jr nz, .copybg
    ;

    ;Now copy sprite palettes
    ld hl, rOCPS
    ld [hl], 0
    ld c, low(rOCPD)
    ld b, $40

    .copyobj
        
        ldh a, [c]
        ld [de], a
        inc de
        inc [hl]
        dec b
        jr nz, .copyobj
    ;

    
    
    ;Initialize modifying
    pop hl
    ld b, $40
    push bc
    
    .modify
        ld a, [hl+]
        ld e, a
        ld a, [hl-]
        ld d, a

        ;Red
        ld a, d
        and a, %01111100
        add a, %00001100
        bit 7, a
        jr z, :+
            ld a, %01111100
        :
        ld b, a

        ;Green
        ld a, d
        and a, %00000011
        ld c, a
        ld a, e
        and a, %11100000
        or a, c
        swap a
        add a, %00000110
        bit 6, a
        jr z, :+
            ld a, %00111110
        :
        swap a
        ld c, a
        and a, %00000011
        or a, b
        ld b, a

        ;Blue
        ld a, e
        and a, %00011111
        add a, %00000011
        bit 5, a
        jr z, :+
        ld a, %00011111
        :
        or a, c
        ld c, a

        ;Store this value
        ld a, c
        ld [hl+], a
        ld a, b
        ld [hl+], a

        pop bc
        dec b
        push bc
        jr nz, .modify

    ;Return
    pop af
    ret 
;



; Switches bank and calls a given address.
; Does NOT switch banks back after returning.
; Usefull when bankjumping from a non-bankable area.
; Lives in ROM0.
;
; Input:
; - `b`: ROM bank number
; - `hl`: Address to jump to
;
; Destroys: `a`, unknown
bank_call_0::

    ;Switch banks
    ld a, b
    ldh [h_bank_number], a
    ld [rROMB0], a

    ;Jump
    jp hl
;



; Switches bank and calls a given address.
; Switches banks back after returning.
; Lives in ROM0.
;
; Input:
; - `b`: ROM bank number
; - `hl`: Address to jump to
;
; Destroys: `a`, unknown
bank_call_x::

    ;Set up things for returning
    ldh a, [h_bank_number]
    push af

    ;Switch banks
    ld a, b
    ldh [h_bank_number], a
    ld [rROMB0], a

    ;Jump
    call _hl_

    ;Returning after jump, reset bank number
    pop af
    ldh [h_bank_number], a
    ld [rROMB0], a

    ;Return
    ret
;



; Switches bank and calls a given address.
; Switches banks back after returning.
; Also saves and restores WRAMX bank on GBC.
; Lives in ROM0.
;
; Input:
; - `d`: ROM bank number
; - `hl`: Address to jump to
;
; Destroys: `a`, unknown
bank_call_xd::

    ;Store current bank number
    ldh a, [h_bank_number]
    push af

    ;Switch banks
    ld a, d
    ldh [h_bank_number], a
    ld [rROMB0], a

    ;Jump
    call _hl_

    ;Returning after jump, reset banks
    pop af
    ldh [h_bank_number], a
    ld [rROMB0], a
    
    ;Return
    ret 
;



; Literally just jumps to the address of HL.
; Lives in ROM0.
; 
; Input:
; - `hl`: Address to jump to
; 
; Destroys: unknown
_hl_::
    jp hl
;



; Set CPU speed.
; Lives in ROM0.
;
; Input:
; - `b.7`: Desired speed
;
; Destroys: `a`, `hl`
cpu_speedtogle::
    
    ;Ignore ENTIRELY if not on a color machine
    ldh a, [h_is_color]
    cp a, 0
    ret z
    
    ;Ignore function call if CPU speed is already as desired
    ld hl, rKEY1
    ld a, [hl]
    and a, %10000000
    cp a, b
    ret z

        ;Double CPU speed
        ldh a, [rIE]
        ld d, a
        xor a
        ldh [rIE], a
        ld a, b
        ldh [rKEY1], a
        ld a, $30
        ldh [rP1], a
        stop 
        ld a, d
        ldh [rIE], a
        
        ;Return
        ret 
;



; Stalls until it reaches the desired scanline.
; Returns in HBLANK the scanline before.
; Does not use interrupts.
; Lives in ROM0.
;
; Input:
; - `c`: Desired scanline
;
; Destroys: `af`, `hl`, `b`
wait_scanline::
    
    ;Wait for scanline
    dec c
    ld hl, rLY
    ld a, c
    :
    cp a, [hl]
    jr nz, :-

    ;Scanline has been hit, wait for mode 0
    ld l, low(rSTAT)
    ld b, %00000011
    :
    ld a, [hl]
    and a, b
    jr nz, :-

    ;Return
    ret 
;