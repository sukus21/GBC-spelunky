; Color macro, useful for defining palettes.
; Expands to a single `dw` command.
; 
; Input:
; - 1: Red (0-31)
; - 2: Green (0-31)
; - 3: Blue (0-31)
MACRO color_t
    dw ((\3) << 10) + ((\2) << 5) + (\1)
ENDM

;The color that closest matches DMG black.
MACRO color_dmg_blk
    color_t 0, 0, 0
ENDM

;The color that closest matches DMG dark gray.
MACRO color_dmg_dkg
    color_t 7, 7, 7
ENDM

;The color that closest matches DMG light gray.
MACRO color_dmg_ltg
    color_t 13, 13, 13
ENDM

;The color that closest matches DMG white.
MACRO color_dmg_wht
    color_t 31, 31, 31
ENDM