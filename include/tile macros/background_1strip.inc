; Macro for a background that tiles vertically.
; Places the given tile ID and the one after.
; 
; Input:
; - 1: Base tile ID
; - 2: Palette
; - 3: Block ID
MACRO tm_bg1strip
    
    ;Initialize tile ID
    ld c, \1
    push de

    ;Check block above
    ld a, e
    sub a, $40
    ld e, a
    jr nc, :+
    dec d
    :

    ;If tile above is NOT the same
    ld a, [de]
    cp a, \3
    ld a, c
    jr z, :+
        
        ;Switch to top tile
        inc a
    :

    ;Write tile 1 + 2
    ld [hl+], a
    ld [hl-], a
    set 5, l

    
    ;Check block below
    ld a, e
    add a, $80
    ld e, a
    jr nc, :+
    inc d
    :

    ;If tile below is NOT the same
    ld a, [de]
    cp a, \3
    ld a, c
    jr z, :+
        
        ;Switch to bottom tile
        inc a
        inc a
    :

    ;Write tile 3 + 4
    ld [hl+], a
    ld [hl-], a
    

    ;Write palettes
    set 6, l
    ld a, \2
    ld [hl+], a
    ld [hl-], a
    res 5, l
    ld [hl+], a
    ld [hl], a
    res 6, l
    pop de

ENDM