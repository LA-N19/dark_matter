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

$m = 1 # [m]ode: -1: dbg, 0:movie, 1:album
disk="d"
$path = disk+":/LA-N19/dark_matter/dm/"
$file = $path+'txt_out/dm.txt'
wsl_file="/mnt/%s/LA-N19/dark_matter/dm/txt_out/dm.txt" % [disk]


print('for watching this movie:
watch -n 0,2 "tail -40 %s"
' % [wsl_file])

10.times { |iii| File.open($file, "w+") { |f| f.write(iii); sleep 1 } }

rec_stop=false
rec=0
live_loop :rec do
  #print cm="copy "+$file+" "+$path+"rec/"+rec.to_s+".txt"
  FileUtils.cp($file, $path+"txt_rec/"+rec.to_s+".txt")
  stop if rec_stop
  rec+=1
  sleep 1
end
'$s = -1; eval_file $path+"dm_titles.rb"
$s = -2; eval_file $path+"dm_titles.rb"
$s = 1; eval_file $path+"dm_titles.rb"
eval_file $path+"dm01_awakening_v02.rb"
$s = 2; eval_file $path+"dm_titles.rb"
eval_file $path+"dm02_engine_room_v01.rb"
$s = 3; eval_file $path+"dm_titles.rb"
eval_file $path+"dm03_harmony_swarm_v01.rb"
$s = 4; eval_file $path+"dm_titles.rb"
eval_file $path+"dm04_night_train.rb"
$s = 5; eval_file $path+"dm_titles.rb"
eval_file $path+"dm05_pentatiano_v07.rb"
$s = 6; eval_file $path+"dm_titles.rb"
eval_file $path+"dm06_cheater chord invasion v6.rb"
$s = 7; eval_file $path+"dm_titles.rb"
eval_file $path+"dm07_bug is raisin v3.rb"
$s = 8; eval_file $path+"/dm_titles.rb"
eval_file $path+"dm08_hal9k_v2.rb"
$s = 9; eval_file $path+"dm_titles.rb"
rec_stop=true
# rec=142
live_loop :rec do
  re=rand_i rec
  FileUtils.cp($path+"txt_rec/"+re.to_s+".txt", $file)
  sleep 1
end

eval_file $path+"dm09_dark_kick.rb"
$s = 10; eval_file $path+"dm_titles.rb"
eval_file $path+"dm10_I_own_U_v05.rb"
