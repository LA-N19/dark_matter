

######### dm011_I own U v0.05 #########
sox dm.wav 'dm011_I own U v0.05.wav' trim 0 360
lame -V3 'dm011_I own U v0.05.wav' 'dm011_I own U v0.05.mp3'
id3v2 -a 'L.A.N19' -A 'dark matters' -t 'dm011_I own U v0.05' -g 'L.A.N19 - sonic home brew studios' -T 11 -y 2024 'dm011_I own U v0.05.mp3'
eyeD3 --add-image 'dm_cov_front.png:FRONT_COVER' 'dm011_I own U v0.05.mp3'
eyeD3 --add-image 'dm_cov_back.png:BACK_COVER' 'dm011_I own U v0.05.mp3'