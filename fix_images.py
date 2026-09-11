import os
import re
import random
import glob

# Collect all HTML files
files = glob.glob('c:/Users/user/Desktop/drop2/*.html') + glob.glob('c:/Users/user/Desktop/DROP/*.html')

for f in files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # 1. Replace broken Unsplash links
    # Match https://images.unsplash.com/... up to the next double quote
    def replace_unsplash(match):
        rnd = random.randint(1000, 9999)
        return f'https://picsum.photos/800/600?random={rnd}'
    
    content = re.sub(r'https://images\.unsplash\.com/photo-[^"]+', replace_unsplash, content)

    # Write back
    with open(f, 'w', encoding='utf-8') as file:
        file.write(content)
