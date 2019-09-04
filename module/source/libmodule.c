#include <switch.h>
#include <stdio.h>

typedef struct
{
    u32(*DummyFunction)();
} ModuleSampleStruct;

u32 sample_dummy()
{
    return 69;
}

// Main program will send us a pointer to this struct, and we set one of our functions, which later the main program will call.
// If dkA64's newlib supported dynamic linking properly, we could use libnx API here, then via symbol loading access the main program's libnx symbols like official NSOs do.

void libmodule_setConfig(ModuleSampleStruct *cfg)
{
    cfg->DummyFunction = &sample_dummy;
}