from __future__ import print_function, division

# Start scipy libaries
import numpy as np
import matplotlib.pyplot as pl

# enable LaTeX printing for sympy
from IPython.display import display
try:
   from sympy.interactive import printing
   printing.init_printing()
except ImportError:
   pass

# Set figsize on the fly
from IPython.core.pylabtools import figsize
figsize(10, 4)

# Use mpld3 to display interactive graphs
try:
   import mpld3
   mpld3.enable_notebook()
except ImportError:
   pass
