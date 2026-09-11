import os
import re

html_files = [f for f in os.listdir('.') if f.endswith('.html')]
issues = []

for file in html_files:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Find all hrefs
    hrefs = re.findall(r'href=[\"\'](.*?)[\"\']', content)
    for href in hrefs:
        if href.startswith('http') or href.startswith('mailto:') or href.startswith('tel:') or href.startswith('#'):
            continue
        # check if it exists
        path = href.split('?')[0].split('#')[0]
        if path and not os.path.exists(path):
            issues.append(f'{file}: Broken link -> {href}')
            
    # Find all srcs
    srcs = re.findall(r'src=[\"\'](.*?)[\"\']', content)
    for src in srcs:
        if src.startswith('http') or src.startswith('data:'):
            continue
        path = src.split('?')[0].split('#')[0]
        if path and not os.path.exists(path):
            issues.append(f'{file}: Missing asset -> {src}')

print(f'Found {len(issues)} issues.')
for issue in issues:
    print(issue)
