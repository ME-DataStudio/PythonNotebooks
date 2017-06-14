from __future__ import absolute_import, division, print_function

import os
from six import moves
import ssl
import tflearn
from tflearn.data_utils import *

path = "US_Cities.txt"

if not os.path.isfile(path):
    context = ssl._create_unverified_context()
    moves.urllib.request.urlretrieve("https://raw.githubusercontent.com/tflearn/tflearn.github.io/master/resources/US_Cities.txt", path, context=context)

maxlen = 20

