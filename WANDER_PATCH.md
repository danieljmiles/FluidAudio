# Wander dependency patch

Based on FluidInference/FluidAudio revision 5c19d5e12320e22bbfb7a1877b089d2665a69add.
AppLogger is a no-op: upstream English G2P warning paths include words from the
input, including in Release builds. Wander does not permit narration content
in logs. The English frontend also throws a generic error if G2P returns no pronunciation
for a word, instead of silently omitting it. Focused regression tests cover nil,
empty and unresolved hyphenated words. No model, download or compute-routing changes.

Wander pins the resulting commit. Do not open an upstream PR or otherwise
send messages on Daniel’s behalf without his authorization.
