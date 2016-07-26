from sys import argv
from os import path
from wordcloud import WordCloud, ImageColorGenerator
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
import random
# from PIL import image

def grey_color_func(word, font_size, position, orientation, random_state=None, **kwargs):
    return "hsl(0, 0%, 80%)"

d = path.dirname(__file__)

freqFile = open(argv[1], 'r')
freq = dict()
for (line_number,line) in enumerate(freqFile):
	line = line.replace('\n','')
	# print(line + '\n')
	label, num = line.split('\t')
	num = float(num)
	freq[label] = num

mask = np.array(Image.open(path.join(d, "black.jpg")))
# wc = WordCloud(mask= mask, max_font_size=100, relative_scaling=1).
wc = WordCloud(mask=mask, relative_scaling=0.3,
               random_state=1).generate_from_frequencies(freq.items())

# image_colors = ImageColorGenerator(mask)


plt.imshow(wc.recolor(color_func=grey_color_func))
plt.axis("off")
# plt.figure()
# plt.imshow(mask, cmap=plt.cm.gray)
# plt.axis("off")
plt.show()
