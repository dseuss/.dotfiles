#--- nbextensions configuration ---
import os
import sys
sys.path.append(os.path.join(r'/Users/dsuess/Library/Jupyter', 'extensions'))
c = get_config()
c.Exporter.template_path = [ '.', os.path.join(r'/Users/dsuess/Library/Jupyter', 'templates') ]
#--- nbextensions configuration ---
