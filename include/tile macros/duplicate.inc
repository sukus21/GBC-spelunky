; Macro for a basic tile.
; Places the given tile 4 times
; 
; Input:
; - 1: Tile 1 ID
; - 2: Palette
MACRO tm_duplicate
    
    ;Place tiles
    ld a, \1
    ld [hl+], a
    ld [hl-], a
    set 5, l
    ld [hl+], a
    ld [hl-], a

    ;Switch to palettes
    set 6, l

    ;Place palettes
    ld a, \2
    ld [hl+], a
    ld [hl-], a
    res 5, l
    ld [hl+], a
    ld [hl], a

    ;Switch to tiles
    res 6, l
ENDM


; Macro for a basic tile.
; Places the given tile 2 times
; 
; Input:
; - 1: Tile 1 ID
; - 2: Palette
MACRO tm_duplicate_h
    
    ;Place tiles
    ld a, \1
    ld [hl+], a
    ld [hl-], a

    ;Switch to palettes
    set 6, l

    ;Place palettes
    ld a, \2
    ld [hl+], a
    ld [hl], a

    ;Switch to tiles
    res 6, l
ENDM