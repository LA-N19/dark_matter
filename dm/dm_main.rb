# D:\LA-N19\dm\dm_main.rb / 23.11.2021
#
# watch -n 0,2 "tail -40 /mnt/d/LA-N19/dark_matter/dm/txt_out/dm.txt"

$m = 0 # [m]ode: -1: dbg, 0:movie, 1:album, 2: booklet, 3: txt2wav
disk="d"
$path = disk+":/LA-N19/dark_matter/dm/"
$wsl_path = "/mnt/%s/LA-N19/dark_matter/dm/" % [disk]
$file = $path+'../txt_out/dm.txt'
$file_wav_cut_bash_out=$path+'../wav_out/dm_wav_cut.sh'
wsl_file="/mnt/%s/LA-N19/dark_matter/dm/../txt_out/dm.txt" % [disk]


if $m == 2 or $m == 3  then
  eval_file $path+"dm_titles.rb";
  stop
end

print('for watching this movie enter this code in your wsl:')
print('watch -n 0,2 "tail -40 %s"' % [wsl_file])

if $m == 0 then
  9.times { |iii|
    File.open($file, 'w+') { |file|
      file.write(("|"+(10-iii).to_s*180+"|\n")*40)
    }
    sleep 1
} end


# screen recording by copying the output file $file to txt_rec/[i].txt

rec_mode, rec = $m, 0 # rec_mode={0: recording, else: pause}
live_loop :rec do if rec_mode == 0 then
    FileUtils.cp($file, $path+"../txt_rec/rec_"+rec.to_s.rjust(6, "0")+".txt")
    rec+=1;
  end
  sleep 1
end

#10.times { |iii| File.open($file, "w+") { |f| f.write(iii); print(iii); sleep 1 } }
$vt=vt

$s = -1; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
$s = -2; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
$s = 1; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
eval_file $path+"dm01_awakening_v02.rb"
$s = 2; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;

eval_file $path+"dm02_engine_room_v01.rb"
$s = 3; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
eval_file $path+"dm03_harmony_swarm_v01.rb" # TODO: Movie

$s = 4; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
eval_file $path+"dm04_night_train.rb"

$s = 5; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
eval_file $path+"dm05_pentatiano_v07.rb"

$s = 6; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
eval_file $path+"dm06_cheater chord invasion v6.rb"

$s = 7; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
eval_file $path+"dm07_de4d_mouse.rb" # TODO: Movie

$s = 8; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
eval_file $path+"dm08_bug is raisin v3.rb"

$s = 9; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
eval_file $path+"dm09_hal9k_v2.rb"

# dm10_dark_kick.rb:
$s = 10; rec_mode = 1; eval_file $path+"dm_titles.rb"; rec_mode = $m;
rec_mode = 1;
live_loop :rec do
  re=rand_i rec
  FileUtils.cp($path+"../txt_rec/rec_"+re.to_s.rjust(6, "0")+".txt", $file)
  sleep 0.2
end
eval_file $path+"dm10_dark_kick.rb"


$s = 11; eval_file $path+"dm_titles.rb"
eval_file $path+"dm11_I_own_U_v05.rb" # TODO: Movie

# even in album mode: we need to call "dm_titles.rb" once again due dm_wav_cut.sh is always written afterwards
$s = 12; eval_file $path+"dm_titles.rb"
if $m == 0 then # movie mode: "credits and making of"...
  eval_file $path+"dm12_making_of.rb"
end
