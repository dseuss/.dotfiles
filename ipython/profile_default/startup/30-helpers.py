import sys


# FIXME Make this python3 compatible
def print_status(msg):
   """Prints msg to screen by updating the current line

   :msg: Message to print

   """
   print "\r" + str(msg),
   sys.stdout.flush()


# FIXME Make this much more readable
def print_statusbar(current, total, length=50):
   """Prints a statusbar on the screen, where status=current/total

   :current: Iterations already done
   :total: Total number of iterations
   :length(10): length of the statusbar

   """
   carrets = ((current + 1) * length) // total if current+1 < total else length
   nr_digits = lambda i: len(str(i))
   statusmsg = ('{0:' + str(nr_digits(total)) + '}/{1}').format(current + 1, total)
   msg = ''.join(('<', carrets * '=', (length - carrets) * ' ', '>  ', statusmsg))
   print_status(msg)
