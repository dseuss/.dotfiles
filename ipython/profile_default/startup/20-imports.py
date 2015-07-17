import sys
sys.path.append('/home/dsuess/Documents/python')
del sys
# Start scipy libaries
import numpy as np
import matplotlib.pyplot as pl
pl.style.use('ggplot')

# Set figsize on the fly
from IPython.core.pylabtools import figsize
figsize(1.618 * 5, 5)
