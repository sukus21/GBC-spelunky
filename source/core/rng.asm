SECTION "RNG ROUTINE", ROM0

; RNG routine. More or less copied from SMW lol.
; Lives in ROM0.
; 
; Output:
; - `a`: Random value
;
; Destroys: `f`
rng_run_single::
    push hl
    
    ;Initialize RNG pointer
    ld hl, h_rng_seed

    ;Call RNG routine
    call rng_tick

    ;Return
    pop hl
    ret 
;



; RNG routine. More or less copied from SMW lol.
; Lives in ROM0.
; 
; Output:
; - `de`: Random values
; - `a`: Mirror of `d`
;
; Destroys: `f`
rng_run::
    push hl

    ;Initialize RNG pointer
    ld hl, h_rng_seed

    ;Tick the first byte and store in E
    call rng_tick
    ld e, a

    ;Tick the second byte and store in D
    call rng_tick
    ld d, a

    ;Store these
    inc l
    inc l
    ld [hl+], a
    ld [hl], e

    ;Return
    pop hl
    ret
;



; REQUIRES HL TO BE SET TO h_rng_seed!!!
; Lives in ROM0.
;
; Output:
; - `a`: Random value
;
; Destroys: `f`
rng_tick:
    ld a, [hl]
    sla a
    sla a
    scf 
    adc a, [hl]
    ld [hl+], a
    sla [hl]
    ld a, $20
    and a, [hl]
    jr nc, :+
    jr z, :+++
    jr nz, :++
    :
    jr nz, :++
    :
    inc [hl]
    :
    ld a, [hl-]
    xor a, [hl]
    ret
;