
"""
"""

$path = "D:/LA-N19/dark_matter/LArt_N19_culms"
$i = 0
def create(nam, svg)
  s = "LArt_N19_culms"; $i += 1
  fi = $path+"/"+s+"_"+$i.to_s.rjust(2, "0")+"_"+nam
  File.open(fi+".svg", 'w') { |f|
    f.write('''<svg width="297mm" height="420mm" version="1.1" xmlns="http://www.w3.org/2000/svg">
  <rect x="10" y="10" width="287" height="400" stroke="black" fill="transparent" stroke-width="0.1"/>
  <rect x="40" y="150" width="227" height="32" stroke="black" fill="transparent" stroke-width="0.2"/>
  '''+svg+'''
  <text x="267" y="188" text-anchor="end" font-family="Courier New, monospace" font-size="3">
    '''+nam+''' | L.Art N19 - calm culms | (c) 2024 - L.A.N19
  </text>
</svg>
   ''')
  }
end

"""
gem 'prawn'
gem 'prawn-svg'
require 'prawn'
require 'prawn-svg'

Prawn::Document.generate('output.pdf') do
  svg_data = File.read('/path/to/your/man.svg')
  svg(svg_data)
end
"""


one = '''<path d="M 150,180 Q 150,150 160,160" stroke="black" fill="none" stroke-width="0.1" stroke-linecap="round"/>'''
create("one", one)

two = '''<path d="M 160,180 Q 175,150 160,162" stroke="black" fill="none" stroke-width="0.1" stroke-linecap="round"/>'''
create("two", one+two)

devote = '''<path d="M 160,180 Q 165,160 155 172" stroke="black" fill="none" stroke-width="0.1" stroke-linecap="round"/>'''
create("domination", one+devote)


one1 = '''<path d="M 155,180 Q 150,150 170,170" stroke="black" fill="none" stroke-width="0.1" stroke-linecap="round"/>'''
devote = '''<path d="M 160,180 Q 165,160 155 172" stroke="black" fill="none" stroke-width="0.1" stroke-linecap="round"/>'''
create("protect", one1+devote)