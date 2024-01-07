sox dm.wav dm_001.wav trim 0 261
lame -V3 dm_001.wav dm_001.mp3
sox dm.wav dm_002.wav trim 261 167
lame -V3 dm_002.wav dm_002.mp3
sox dm.wav dm_003.wav trim 428 193
lame -V3 dm_003.wav dm_003.mp3
sox dm.wav dm_004.wav trim 622 424
lame -V3 dm_004.wav dm_004.mp3
sox dm.wav dm_005.wav trim 1046 287
lame -V3 dm_005.wav dm_005.mp3
sox dm.wav dm_006.wav trim 1333 204
lame -V3 dm_006.wav dm_006.mp3
sox dm.wav dm_007.wav trim 1537 144
lame -V3 dm_007.wav dm_007.mp3
sox dm.wav dm_008.wav trim 1682 232
lame -V3 dm_008.wav dm_008.mp3
sox dm.wav dm_009.wav trim 1914 62
lame -V3 dm_009.wav dm_009.mp3

sox dm.wav dm_010.wav trim 1976
lame -V3 dm_010.wav dm_010.mp3




id3v2 -a 'L.A.N19' -A 'dark matters' -t '_______________awakening v0.02' -g 'home brew sonic' -T 1 -y 2024 dm_001.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '_____________engine room v0.01' -g 'home brew sonic' -T 2 -y 2024 dm_002.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '_________________I own U v0.05' -g 'home brew sonic' -T 10 -y 2024 dm_010.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '___________harmony swarm v0.01' -g 'home brew sonic' -T 3 -y 2024 dm_003.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '___________________night train' -g 'home brew sonic' -T 4 -y 2024 dm_004.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '______________pentatiano v0.07' -g 'home brew sonic' -T 5 -y 2024 dm_005.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '_____cheater chord invasion v6' -g 'home brew sonic' -T 6 -y 2024 dm_006.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '____________bug is raisin v0.3' -g 'home brew sonic' -T 7 -y 2024 dm_007.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '____________________hal9k v0.2' -g 'home brew sonic' -T 8 -y 2024 dm_008.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '_________________I own U v0.05' -g 'home brew sonic' -T 10 -y 2024 dm_010.mp3
id3v2 -a 'L.A.N19' -A 'dark matters' -t '_____________________dark kick' -g 'home brew sonic' -T 9 -y 2024 dm_009.mp3

eyeD3 --add-image 'dm_cov.png:FRONT_COVER' dm_001.mp3
eyeD3 --add-image 'dm_cov.png:FRONT_COVER' dm_002.mp3
eyeD3 --add-image 'dm_cov.png:FRONT_COVER' dm_003.mp3
eyeD3 --add-image 'dm_cov.png:FRONT_COVER' dm_004.mp3
eyeD3 --add-image 'dm_cov.png:FRONT_COVER' dm_005.mp3
eyeD3 --add-image 'dm_cov.png:FRONT_COVER' dm_006.mp3
eyeD3 --add-image 'dm_cov.png:FRONT_COVER' dm_007.mp3
eyeD3 --add-image 'dm_cov.png:FRONT_COVER' dm_008.mp3
eyeD3 --add-image 'dm_cov.png:FRONT_COVER' dm_009.mp3
eyeD3 --add-image 'dm_cov.png:FRONT_COVER' dm_010.mp3
