from pandocfilters import toJSONFilter, Emph, Para
import sys, codecs

sys.stderr = codecs.getwriter("utf-8")(sys.stderr.detach())

def errcho(*x):
    x = " ".join(map(str, x))
    sys.stderr.write(x + "\n")
    sys.stderr.flush()

#
#
#

def behead(key, value, format, meta):
    # sends function input to stderr
    # anything sent to stdout interferes with later processing
    #errcho("key:",key,"val:",value)
    # wraps the 'abstract' element in paragraph and emphasis markup
    # doesn't work, requires reader to read the abstract tag
    if key == 'abstract':
        return Para([Emph(value[2])])

if __name__ == "__main__":
    toJSONFilter(behead)
