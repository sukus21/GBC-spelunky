; Macro for a 4x4 tile background.
; 
; Input:
; - 1: Base tile ID
; - 2: Palette
MACRO tm_bg4x4
    
    ;Add horizontal offset
    ld a, \1
    bit 0, e
    jr z, :+
        add a, 2
    :

    ;Add vertical offset
    bit 6, e
    jr z, :+
        add a, 8
    :


    ;Place tiles
    ;Top-left
    ld [hl+], a

    ;Top-right
    inc a
    ld [hl], a

    ;Bottom-right
    add a, 4
    set 5, l
    ld [hl-], a

    ;Bottom-left
    dec a
    ld [hl], a



    ;Switch to palettes
    set 6, l

    ;Apply palettes
    ld a, \2

    ;Bottom-left
    ld [hl+], a
    ld [hl-], a
    res 5, l
    ld [hl+], a
    ld [hl], a
    
    ;Reset VRAM bank
    res 6, l
ENDM




; Macro for a 4x4 tile background.
; Only fills in a half.
; L.5 will not be set/reset, must be done manually.
; 
; Input:
; - 1: Base tile ID
; - 2: Palette
MACRO tm_bg4x4_h
    
    ;Get vertical offset (bit 2-3)
    ld a, l
    and a, %01100000
    swap a
    rlca 
    ld c, a

    ;Add horizontal offset (bit 0-1)
    ld a, l
    and a, %00000011
    add a, c

    ;Add base tile offset
    add a, \1



    ;Place tiles
    ld [hl+], a
    inc a
    ld [hl-], a

    ;Switch to palettes
    set 6, l

    ;Place palettes
    ld a, \2
    ld [hl+], a
    ld [hl], a

    ;Switch back to tiles
    res 6, l
ENDM