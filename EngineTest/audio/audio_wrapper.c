
// audio_wrapper.c
#include "stdlib.h"
#include "raylib.h"

// 1. Load the sound and return a raw memory pointer
__declspec(dllexport) void* LoadSoundPtr(const char* fileName) {
    Sound* snd = (Sound*)malloc(sizeof(Sound));
    *snd = LoadSound(fileName);
    return snd;
}

// 2. Take the memory pointer and play the sound
__declspec(dllexport) void PlaySoundPtr(void* snd) {
    PlaySound(*(Sound*)snd);
}
