import sys
sys.path.append('/home/dsuess/Documents/python')
del sys
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

try:
    import seaborn as sns
    sns.set_style('darkgrid')
except ImportError:
    pass

# Set figsize on the fly
from IPython.core.pylabtools import figsize
figsize(15, 5)
