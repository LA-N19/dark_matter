#!/bin/bash
cd /mnt/d/LA-N19/dark_matter/wav_out
ll *.wav
for file in *.wav; do
mp3=$(basename "$file" .wav).mp3;
echo "lame V3 "$file" "$mp3";"
lame V3 "$file" "$mp3";
done