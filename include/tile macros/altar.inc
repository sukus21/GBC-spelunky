INCLUDE "hardware.inc"

; Macro for tiles that should be flipped on even numbered blocks.
; Useful for Kali Altars.
; 
; Input:
; - 1: Tile 1 ID
; - 2: Palette
MACRO tm_altar
    
    ;Regular tile (copy-pasted from simple.inc)
    bit 0, e
    jr z, :+
        
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

        ;Get away
        jr :++
    :

    ;Flipped tile (copy-pasted from flip.inc)
        ;Load tiles
        ld a, \1+1
        ld [hl+], a
        dec a
        ld [hl-], a
        add a, 3
        set 5, l
        ld [hl+], a
        dec a
        ld [hl-], a

        ;Load palettes
        set 6, l
        ld a, \2 | OAMB_XFLIP
        ld [hl+], a
        ld [hl-], a
        res 5, l
        ld [hl+], a
        ld [hl], a
        res 6, l
    :
ENDM

; Macro for tiles that should be flipped on even tiles.
; Useful for Kali Altars.
; 
; Input:
; - 1: Tile 1 ID
; - 2: Palette
MACRO tile_macro_altar
    
    ;Regular tile
    bit 0, c
    jr z, :+

        ;Load tile 1
        ld e, \1
        ld [hl], e

        ;Load palette 1
        set 6, l
        ld a, \2
        ld [hl+], a

        ;Increment tile ID
        inc e

        ;Load palette 2
        ld [hl], a

        ;Load tile 2
        res 6, l
        ld [hl], e

        ;Return
        ret
    :

    ;Flipped tile
        ;Load tile 1
        ld e, \1+1
        ld [hl], e

        ;Load palette 1
        set 6, l
        ld a, \2 + OAMF_XFLIP
        ld [hl+], a

        ;Increment tile ID
        dec e

        ;Load palette 2
        ld [hl], a

        ;Load tile 2
        res 6, l
        ld [hl], e

        ;Return
        ret
ENDM