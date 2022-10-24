INCLUDE "hardware.inc"
INCLUDE "banks.inc"
INCLUDE "physics.inc"
INCLUDE "player.inc"
INCLUDE "blockproperties.inc"

SECTION "PLAYER COMMON", ROMX, BANK[bank_player]

; Player gravity function.
; 
; Input:
; - `hl`: `w_player_direction`
player_common_gravity::
    
    ;Moving up or down?
    bit player_going_up, [hl]
    jr z, .godown

        ;Player is moving up, subtract speed
        inc l
        inc l ;hl = *vspp
        ld a, [hl]
        sub a, physics_gravity
        ld [hl], a
        ret nc

            ;Player is now moving down
            xor a
            ld [hl], a
            dec l
            dec l
            res player_going_up, [hl]
            inc l
            inc l
            ret
    
    .godown
        
        ;Player is moving down, add speed
        inc l
        inc l
        ld a, [hl]
        add a, physics_gravity
        cp a, physics_maxspeed
        jr c, :+
            ld a, physics_maxspeed
        :
        ld [hl], a
        ret 
    ;
;



; Normal horizontal player movement function.
;
; Input:
; - `hl`: `w_player_hspp`
player_common_hmove::
    
    ;Is player not moving?
    ldh a, [h_input]
    ld b, a
    ld a, [hl-] ;a = hspp, hl = *direction
    cp a, 0
    jr nz, .moving

        ;Player is not moving, set direction according to input
        bit PADB_LEFT, b
        jr z, :+

            ;Player is moving left
            set player_going_left, [hl]
            set player_facing_left, [hl]
            jr .inchspp
        :
        bit PADB_RIGHT, b
        jr z, .return
            
            ;Player is moving right
            res player_going_left, [hl]
            res player_facing_left, [hl]
            jr .inchspp
        
        jr .return
    ;

    ;Player is moving, what now?
    .moving
        
        ;Friction
        sub a, player_friction
        jr nc, :+
            xor a
        :

        ;Is player moving or right left?
        bit player_going_left, [hl]
        jr z, :+
            
            ;Player is moving left
            set player_facing_left, [hl]
            bit PADB_LEFT, b
            jr nz, .inchspp
            bit PADB_RIGHT, b
            jr nz, .dechspp
            jr .return
        :
            
            ;Player is moving right
            res player_facing_left, [hl]
            bit PADB_LEFT, b
            jr nz, .dechspp
            bit PADB_RIGHT, b
            jr z, .return
            ;falls into `.inchspp`
        :

        ;Move faster
        .inchspp
            add a, player_accel
            cp a, player_maxspeed+1
            jr c, :+
                ld a, player_maxspeed
            :
            jr .return
        
        ;Slow down
        .dechspp
            sub a, player_accel
            jr nc, :+
                xor a
            :
        ;Falls into label `.storehspp`.
    ;

    ;Store hspp and return
    .return
    inc l
    ld [hl-], a
    ret 
;



; Jumping functionality for the player.
; Also handles dropping through platforms.
;
; Input:
; - `hl`: `w_player_vspp`
player_common_jump::

    ;Has player not left the ground yet?
    ld de, w_player_grounded
    ld a, [de]
    cp a, player_jumptimer
    jr nz, .midair

        ;Initialize jump
        ld c, a
        ldh a, [h_input_pressed]
        bit PADB_A, a
        ld a, c
        jr z, .nojump
        bit PADB_DOWN, b
        jr nz, .crawl
        ld [hl], player_jump_force
        jr .dojump

        ;Crawl, drop through platform
        .crawl

            push hl
            push de

            ;Create pointer to stage data BELOW the player
            ld l, 0
            ld a, [w_player_y]
            inc a
            rra
            rr l
            rra 
            rr l
            add a, high(level_foreground)
            ld h, a
            ld a, [w_player_x]
            add a, l
            ld l, a

            ;Is this a platform?
            ld d, high(w_blockdata)
            ld e, [hl]
            ld a, [de]
            bit bpb_solid, a
            jr nz, .dropthrough_end

            ;This is a platform, check for tile overlap
            ld a, [w_player_x+1]
            add a, player_width
            jr nc, .dropthrough_go
            inc l
            ld e, [hl]
            ld a, [de]
            bit bpb_solid, a
            jr nz, .dropthrough_end

            ;Platform secured
            .dropthrough_go
            ld hl, w_player_y+1
            inc [hl]

            ;Return from this nonsense
            .dropthrough_end
            pop de
            pop hl
            ret
        ;
    ;

    .midair
    bit PADB_A, b
    jr z, .nojump

        ;The jump button was pressed
        .dojump
        dec a
        jr z, .nojump

            ;Player is grounded
            ;Set vspp to jump speed
            ld [de], a
            ld a, [hl]
            add a, player_gravity
            ld [hl], a
            dec l
            dec l
            set player_going_up, [hl]
            ret
        ;
    ;

    ;Set grounded variable
    .nojump
    ld a, 1
    ld [de], a
    ret 