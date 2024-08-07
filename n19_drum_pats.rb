"""
n19_drum_pats.rb - read and play 200 beats in 100 lines of code (sonic pi)

reading the beats from [infile_md] and play all of those 200 beats 4 times

History:
20240802 - L.A.N19 - Creation in D:\LA-N19\dark_matter / https://github.com/LA-N19
20240806 - L.A.N19 - version 0.1

Usage: 
   1) open this file in sonic pi 
   2) copy https://github.com/montoyamoraga/drum-machine-patterns/README.md 
        and the set infile_md to this file
   3) and 'play'!

Next:
  a) Midi-support to choose beat and sample set on the run
  b) implement Accent to substitue the blib
  c) add fx (compression, reverb etc.pp.)
  d) add beat generator (random lane; crossing? bit like night train)
  e) remember Funk 15: this fat! R&B 3 is good. 4 also? whatever; disco 2 ride the horse!
  f) read beat and bpm and so on from md file
  g) load & save and so on
  h) new video only with pattern and needle ()
"""
infile_md, outfile_json  = 'D:\LA-N19\dark_matter\n19_drum_pats.md', nil
n19_drum_samples = { BD: :drum_bass_hard,
                     SD: :drum_snare_hard,
                     LT: :drum_tom_lo_hard,
                     MT: :drum_tom_mid_hard,
                     HT: :drum_tom_hi_hard,
                     CH: :drum_cymbal_closed,
                     OH: :drum_cymbal_open,
                     CY: :drum_cymbal_soft,
                     RS: :elec_tick, # usually rimshot..
                     CP: :perc_snap, # snap: best i could find in the common sonic pi samples...
                     CB: :drum_cowbell,
                     AC: :elec_blip, # later on we'll use other samples or compression-fx for Accent...
                     }

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
  "
    reads the pattern from the .md file as give by https://github.com/montoyamoraga/drum-machine-patterns/README.md 

    parameter:
      the md-file as array of strings

    return (return with one example entry):
       { 'rock 1 - Measure A': 
           { name: 'rock 1 - Measure A', category: 'rock 1', part: 'Measure A',
             beats: 4, note_length: 4, bpm: [112, 139], # just default in the moment...
             pattern: {
               ch: ['X','','X','X','X','','X','X','X','','X','X','X','','X','X']
             }
           } 
      }
    oh man! just see n19_drum_pats.json!
  "
  start, tpats = false, {}
  # TODO: basic beat informations are not grabbed yet...
  pat_act = { pattern: {}, beats: 4, note_length: 4, bpm: [112, 139], }
  cat, prt, pats = nil
  ls.each { |l|
    start = true if l.strip == "## Patterns from the book *200 Drum machine patterns*"
    next if l.length < 6 or not start
    typ = nil
    typ, cat = "cat", l[4..-1].strip if l[0,4] == "### " # category
    typ, prt = "prt", l[5..-1].strip if l[0,5] == "#### "  # part
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

pates = import_pads(File.readlines(infile_md))
File.write(outfile_json, JSON.dump(pates)) if outfile_json

live_loop :drum do
  i = 0
  pates.each { |nam,pat|
    print("Beat ", i+=1, "/ 200")
    4.times { |t| sleep play_pat(pat, n19_drum_samples, debug=t==0) } # that a sleep in an at nested works!!!
  }
end
"""
  somes lines left..., so i could have documented more
  somes lines left..., so i could have coded not that compressed ;)
  somes lines left..., so i could have coded to read beat and bpm and so on
  somes lines left...
  somes lines left...
  somes lines left...
  somes lines left...
  somes lines left...
"""