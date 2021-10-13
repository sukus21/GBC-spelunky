INCLUDE "hardware.inc"

SECTION "COPYDATA", ROM0
; Copies data from one location to another using the CPU.
;
; Input:
; - `hl` = Destination
; - `bc` = Source
; - `de` = Byte count
;
; Output:
; - `hl` += Byte count
; - `bc` += Byte count
; - `de` = `$0000`
;
; Destroys: `a`
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



; Sets a number of bytes to a single value
;
; Input:
; - `hl` = Destination
; - `b` = Fill byte
; - `de` = Byte count
;
; Output:
; - `hl` += Byte count
; - `de` = `$0000`
;
; Destroys: `a`
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



; Copies a palette to background color memory
;
; Input:
; - `hl` = Palette address
; - `a` = Palette index * 8
;
; Output:
; - `hl` += `$0010`
; - `a` += `$08`
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



; Copies a palette to sprite color memory
;
; Input:
; - `hl` = Palette address
; - `a` = Palette index * 8
;
; Output:
; - `hl` += `$0010`
; - `a` += `$08`
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



; Copies ALL palettes.
; 
; Input:
; `hl`: Palette address
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



; Creates a copy of the currently loaded palettes.
;
; Input:
; - `hl`: Where to store the new palettes
; 
; Destroys: all(probably)
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