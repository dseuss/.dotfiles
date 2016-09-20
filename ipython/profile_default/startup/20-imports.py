import sys
sys.path.append('/Users/dsuess/Code/Pythonlibs')
del sys

# Start scipy libaries
import numpy as np
import numpy.random as rd
import matplotlib.pyplot as pl

pl.style.use('ggplot')

# Set figsize on the fly
from IPython.core.pylabtools import figsize
figsize(1.618 * 5, 5)
