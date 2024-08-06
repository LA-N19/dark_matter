"""
n19_drum_pats.rb - 200 beats 100 lines of code

20240802 - L.A.N19 - in D:\LA-N19\dark_matter / https://github.com/LA-N19
  reading n19_drum_pats.txt and play all the beats 
    https://github.com/montoyamoraga/drum-machine-patterns/readme-ov-file
"""
path = 'D:\LA-N19\dark_matter\\'
n19_drum_samples = { BD: :drum_bass_hard,
                     SD: :drum_snare_hard,
                     LT: :drum_tom_lo_hard,
                     MT: :drum_tom_mid_hard,
                     HT: :drum_tom_hi_hard,
                     CH: :drum_cymbal_closed,
                     OH: :drum_cymbal_open,
                     CY: :drum_cymbal_soft,
                     RS: :elec_tick, # usually rimshot..
                     CP: :elec_plip, # usually clap..
                     CB: :drum_cowbell,
                     AC: :elec_blip, # later on we'll use other samples or compression-fx for Accent...
                     }

"""
Rock 1 Measure A
4/4, quarter note 112-139
"""

def pad_2_array(pat, n19_drum_samples, column_sep="\t")
  pat_to_at = {}
  pat.split("\n").each_with_index { |p,pi|
    pa = p.split(column_sep)
    next if pa.length < 2
    s = pa.shift.to_sym
    if not n19_drum_samples.keys.include?(s) then
      print("pad_2_array: could'nt find", s)
      next
    end
    pat_to_at[s] = pa
  }
  return pat_to_at
end

def play_pat(pat, n19_drum_samples, debug=true, bpm=130)
  bpm = rrand_i(*pat[:bpm]) if bpm == true
  note_len, beats = pat[:note_length], pat[:beats]
  print("Playing %i beats of %s with 1/%i-notes at %s bpm" %
        [beats, pat[:name], note_len, bpm.to_s], pat) if debug
  p = pat[:pattern]
  use_bpm bpm if bpm
  p.each { |k,v|
    arr = v.each_with_index.select { |val,i| val == "X" }.map { |a| a[1]/note_len.to_f }
    print(k, v.map { |n| n == "" ? " " : n }.join) if debug
    at arr do sample n19_drum_samples[k] end
  }
  return beats
end

def import_pads(ls)
  start, tpats = false, {}
  pat_act = { pattern: {}, beats: 4, note_length: 4, bpm: [112, 139], }
  cat, prt, pats = nil
  ls.each { |l|
    start = true if l.strip == "## Patterns from the book *200 Drum machine patterns*"
    next if l.length < 6 or not start
    typ = nil
    typ, cat = "cat", l[4..-1].strip if l[0,4] == "### "
    typ, prt = "prt", l[5..-1].strip if l[0,5] == "#### "
    typ = "pat" if l[0] == "|" and l[0..4] != "|----" and l[0..4] != "|Drum"
    pat_act[:pattern] = {} if typ == "cat" or typ == "prt"
    next if not typ == "pat"
    pat_arr = l.split("|")[1..-2]
    pat_name = pat_arr.shift
    nam = cat + " - " + prt
    pat_act[:name] = nam
    pat_act[:pattern][pat_name.strip.to_sym] = pat_arr.map { |x| x.strip }
    tpats[nam] = pat_act.dup
  }
  return tpats
end
pates = import_pads(File.readlines(path+'n19_drum_pats.txt'))
File.write(path+'n19_drum_pats.json', JSON.dump(pates))
live_loop :drum do
  i = 0
  pates.each { |nam,pat|
    print("Beat ", i+=1, "/ 200")
    4.times { |t| sleep play_pat(pat, n19_drum_samples, debug=t==0) } # that a sleep in an at nested works!!!
  }
end
