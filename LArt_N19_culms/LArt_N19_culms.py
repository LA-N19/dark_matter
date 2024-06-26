TITLE = "LArt_N19_culms"
DESC="""
Just culms or a Representation of relationships and society in most minimalist way.

This pgm creates svgs (which dont work really; see svg comment) and pdfs with culms.
That's it ;)
But if you might look at the culms in their infinite simplicity, you might see:
Those culms are just strokes in their representation and each stroke has feelings. Or?
Or strength? Or weakness? Or "purpose"? Or looks like it thinking: what the fuck i am doin here!
Or: Whatever? Each stroke is just a stroke. But each stroke might relate to another.
And another might relate to another and there might be many relations?
And there

"""
from svglib.svglib import svg2rlg
from reportlab.graphics import renderPDF
import reportlab 
from reportlab.pdfgen import canvas
from random import randrange, seed
from pypdf import PdfMerger

do_single_pdf = True
see = 1
ver = "0.1"
seed(see)
s = f"LArt_N19_culms_v{ver}_seed{see}"; 
path = "D:/LA-N19/dark_matter/LArt_N19_culms/out"
i = 0
files = {}
grp = "unkown"

def create(nam, svg):
  global i, pics
  name = f'{nam} | {grp} | seed {see} | L.Art N19 - culms v{ver} | (c) 2024 - L.A.N19'
  fname=f"{s}_{str(i).zfill(4)}_{nam}"
  fi = f"{path}/{fname}"
  files[name] = fname
  i += + 1
  if i < 200:
    return
  print("creating", fi, name)
  with open(fi+".svg", 'w') as f:
    f.write(f'''<svg width="297mm" height="420mm" version="1.1" xmlns="http://www.w3.org/2000/svg">
   <rect x="10mm" y="10mm" width="277mm" height="400mm" stroke="black" fill="transparent" stroke-width="0.1"/>
   <rect x="30mm" y="150mm" width="237mm" height="32mm" stroke="black" fill="transparent" stroke-width="0.2"/>
   <!--<rect x="30mm" y="182mm" width="237mm" height="0mm" stroke="black" fill="transparent" stroke-width="0.2"/-->
            <!-- fuehrende raketenwissenschafter haben unter leitung von professoren der teilschenbeschleunigung
                 definiert das kein mm-Angaben in den Paths funktionieren, sondern schwurbelige einheitsfreie 
                 Angaben, die in SVG und PDF-Export in anderen dimensionen definiert sind.
                 Ja, ok, es gibt bestimmt eine "Ne, ist doch klar"-Erklaerung: Bitte melden!!!
                 -->
  {svg}
  <text x="267mm" y="188mm" text-anchor="end" font-family="Courier New, monospace" font-size="6">
    {name}
    </text>
</svg>
    ''')
  if do_single_pdf:
    drawing = svg2rlg(fi+".svg")
    renderPDF.drawToFile(drawing, fi+".pdf")
  """
  # Create a PDF canvas with A3 size
  pdf_canvas = canvas.Canvas(fi+"2.pdf", pagesize=reportlab.lib.pagesizes.A4)
  renderPDF.draw(drawing, pdf_canvas, x=0, y=0)
  pdf_canvas.showPage()
  pdf_canvas.save()
  """



#if do_single_pdf:
pdfs = files.values()

"""
#with PdfMerger() as merger:
merger = PdfMerger()
for pdf in pdfs:
  print(f" adding {path}/{pdf}.pdf")
  merger.append(f"{path}/{pdf}.pdf")
print(f" write {path}/{s}.pdf")
merger.write(f"{path}/{s}.pdf")
merger.close()
"""
import fitz
result = fitz.open()
for pdf in files.values():
    with fitz.open(f"{path}/{pdf}.pdf") as mfile:
        result.insert_pdf(mfile)
result.save(f"{path}/{s}.pdf")


def s_culm_rand(sx, sy=510,  qx=-10, qy=-50, px=10, py=-60, w=0.1, r=10, rx=None):
  if rx is None:
    rx=r
  sx += randrange(rx)
  qx += randrange(r)
  qy += randrange(r)
  px += randrange(r)
  py += randrange(r)
  return f'<path d="M {sx},{sy} q {qx},{qy} {px},{py}" stroke="black" fill="none" stroke-width="{w}" stroke-linecap="round"/>'

grp = "one"
one = s_culm_rand(16*20+110, 510, 10,-50, -10,-60)    
create("one", one)

grp = "two"
two = s_culm_rand(15*20+110, 510, -10,-80, 10,-50) 
create("two", one+two)

dominate = s_culm_rand(14.5*20+110, 510, -10,-80, 10,-50)    
devote = '''<path d="M 420,510 q 20,-60 -10,-30" stroke="black" fill="none" stroke-width="0.1" stroke-linecap="round"/>'''
create("domination", dominate+devote)

protecter = s_culm_rand(14.5*20+110, 510, -25,-80, 15,-45, r=5)    
protected = '''<path d="M 410,510 q -20,-60 10,-30" stroke="black" fill="none" stroke-width="0.1" stroke-linecap="round"/>'''
create("protect", protecter+protected)

grp = "one group"
#create("homogen", "\n".join([s_culm_rand(ii*5+100) for ii in range(128)]))
for lvl in range(10):
  st=""
  #l = int(lvl/10.0) + 2
  for ii in range(128):
    # f=randrange(-lvl*0.1, 1)
    f=randrange(-lvl, lvl+1)
    st += s_culm_rand(ii*5+100, 510, f,-50, -f,-60, w=(0.2 if randrange(lvl+1)==0 else 0.1), r=lvl*3+3, rx=lvl+2) 
  i = 100+lvl
  create(f"hetrogen_level_{lvl}", st)
  i = 119-lvl
  create(f"homogen_level_{str(9-lvl)}", st)


i, grp  = 200, "two groups"
grp = "one group/one special"
st = ""
for ii in range(32):
  #st+= f'<path d="M {str(ii*20+110)},510 q -20,-60 10,-30" stroke="black" fill="none" stroke-width="0.1" stroke-linecap="round"/>'''
  #q = "10,-50 +10,-60" if ii==20 else "-10,-50 10,-60"
  #st+= f'<path d="M {str(ii*20+110)},510 q {q}" stroke="black" fill="none" stroke-width="0.1" stroke-linecap="round"/>'''
  f = 1 if ii==20 else -1
  st += s_culm_rand(ii*20+110, 510, 10*f,-50, -10*f,-60)
create("align", st)


st = ' '.join([s_culm_rand(ii*20+110, 510, -10,-50, 10,-60, w=(0.2 if ii==20 else 0.1)) for ii in range(32)])
create("differ", st)

st = ' '.join([s_culm_rand(ii*20+110, 510, -10,-50-(20 if ii==20 else 0), 10,-60-(20 if ii==20 else 0)) for ii in range(32)])
create("outstanding", st)

st = ""
for ii in range(32):
  f = 1 if ii==20 else -1
  st += s_culm_rand(ii*20+110, 510, 10*f,-50, -10*f,-60)
create("align", st)

st = ""
for ii in range(32):
  st += s_culm_rand(ii*30-ii**2/2+110, 510, -10,-50, ii+(20 if ii==31 else 0),-60,  w=(0.2 if ii==31 else 0.1))
create("lead", st)


i, grp = 300, "two groups"
create("separation TODO", "")
create("love TODO", "")
create("father_n_son TODO", "")

create("family 1 TODO", "")
create("family 2 TODO", "")

"""
# write into the html file
with open(f"{path}/{s}.html", 'w') as f:
  for fname in pics:
    f.write(f'<img src = "{fname}.svg" />')
"""