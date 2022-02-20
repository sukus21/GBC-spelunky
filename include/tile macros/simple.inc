; Macro for a basic tile.
; Places 4 tiles.
; 
; Input:
; - 1: Tile 1 ID
; - 2: Palette
MACRO tm_simple
    
    ;Load tiles
    ld a, \1
    ld [hl+], a
    inc a
    ld [hl-], a
    inc a
    set 5, l
    ld [hl+], a
    inc a
    ld [hl-], a

    ;Load palettes
    set 6, l
    ld a, \2
    ld [hl+], a
    ld [hl-], a
    res 5, l
    ld [hl+], a
    ld [hl], a
    res 6, l
ENDM



; Macro for a basic tile.
; Places 2 tiles.
; 
; Input:
; - 1: Tile 1 ID
; - 2: Palette
MACRO tm_simple_h
    
    ;Load tile 1
    ld c, \1
    ld [hl], c
    
    ;Load palette 1
    set 6, l
    ld a, \2
    ld [hl+], a

    ;Increment tile ID
    inc c

    ;Load palette 2
    ld [hl], a

    ;Load tile 2
    res 6, l
    ld [hl], c
ENDM