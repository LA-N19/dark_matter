# D:\LA-N19\dm\dm_main.rb / 23.11.2021
# 
# watch -n 0,2 "tail -40 /mnt/d/LA-N19/dark_matter/dm/txt_out/dm.txt"

# todo 1: Alle Texte �berarbeiten
# todo 2: dm01-oeffnen des sarks: zeicvhen weg und noch Fenster mit sternen
# todo 3: dm05: Andere Tanzmodi: moonwalk und breakdance
# todo 4: dm06: corona-virus programmieren
# todo 5: dm07: hal9k / tueren, saerge, stop/go
# toto 6: geschichte weiterschreiben
# todo 7: text2ogg
# todo 8: title seite abspann

$path='d:/LA-N19/dark_matter/dm/txt_out'
$file=$path+'dm.txt'
'
10.times { |iii|
  File.open($file, "w+") { |f| f.write(iii) }
  sleep 1
}

rec_stop=false
rec=0
live_loop :rec do
  #print cm="copy "+$file+" "+$path+"rec/"+rec.to_s+".txt"
  FileUtils.cp($file, $path+"rec/"+rec.to_s+".txt")
  stop if rec_stop
  rec+=1
  sleep 1
end
$s = 0; eval_file "d:/LA-N19/dm/dm_titles.rb"
$s = 1; eval_file "d:/LA-N19/dm/dm_titles.rb"
$s = 1+1; eval_file "d:/LA-N19/dm/dm_titles.rb"
eval_file "d:/LA-N19/dm/dm01_awakening_v02.rb"
$s = 2+1; eval_file "d:/LA-N19/dm/dm_titles.rb"
eval_file "d:/LA-N19/dm/dm02_engine_room_v01.rb"
$s = 3+1; eval_file "d:/LA-N19/dm/dm_titles.rb"
eval_file "d:/LA-N19/dm/dm03_harmony_swarm_v01.rb"
$s = 4+1; eval_file "d:/LA-N19/dm/dm_titles.rb"
eval_file "d:/LA-N19/dm/dm04_pentatiano_v07.rb"
$s = 5+1; eval_file "d:/LA-N19/dm/dm_titles.rb"
'
eval_file "d:/LA-N19/dm/dm05_cheater chord invasion v6.rb"
$s = 6+1; eval_file "d:/LA-N19/dm/dm_titles.rb"
eval_file "d:/LA-N19/dm/dm06_bug is raisin v3.rb"
$s = 7+1; eval_file "d:/LA-N19/dm/dm_titles.rb"
eval_file "d:/LA-N19/dm/dm07_hal9k_v2.rb"
$s = 8+1; eval_file "d:/LA-N19/dm/dm_titles.rb"

rec_stop=true
live_loop :rec do
  re=rand_i rec
  FileUtils.cp($path+"rec/"+re.to_s+".txt", $file)
  sleep 1
end

eval_file "d:/LA-N19/dm/dm08_dark_kick.rb"
