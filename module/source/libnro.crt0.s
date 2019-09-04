.section ".crt0","ax"
.global _start

// Custom CRT0, basically a stripped switch_crt0.s
// Executing it calls "libnoexec" what is stubbed to return 0xDEAD
// Also, instead of writing "HOMEBREW" in the unused 8 bytes of the nro start, we write "DYNROLIB"

_start:
    b libnoexec
    .word __nx_mod0 - _start
    .ascii "DYNROLIB"

.org _start+0x80
libnoexec:
    mov w0, #0xDEAD
    ret

.global __nx_mod0
__nx_mod0:
    .ascii "MOD0"
    .word  _DYNAMIC             - __nx_mod0
    .word  __bss_start__        - __nx_mod0
    .word  __bss_end__          - __nx_mod0
    .word  __eh_frame_hdr_start - __nx_mod0
    .word  __eh_frame_hdr_end   - __nx_mod0
    .word  0 // "Runtime-generated module object", used by rtld on official titles, thus useless for us.
