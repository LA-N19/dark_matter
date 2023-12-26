sox dm.wav dm_001.wav trim 0 261
lame V3 dm_001.wav dm_001.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '_____________engine room v0.01' -g 'home brew sonic' -T 2 -y 2024 dm_001.mp3
sox dm.wav dm_002.wav trim 261 167
lame -V3 dm_002.wav dm_002.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '___________harmony swarm v0.01' -g 'home brew sonic' -T 3 -y 2024 dm_002.mp3