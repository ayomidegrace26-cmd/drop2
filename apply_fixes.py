import os, re
import glob

# Fixes in drop2 workspace
files = glob.glob('*.html')
for f in files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # 1. Add nav-link to nav items
    content = re.sub(r'<a href="([^"]+)" class="([^"]*?hover:text-white[^"]*?)">', r'<a href="\1" class="\2 nav-link">', content)
    # Special case for Home or active link
    content = re.sub(r'<a href="home\.html" class="text-white">', r'<a href="home.html" class="text-white nav-link">', content)
    content = re.sub(r'<a href="communities\.html" class="text-blue-500 hover:text-blue-400 font-bold transition-colors">', r'<a href="communities.html" class="text-blue-500 hover:text-blue-400 font-bold transition-colors nav-link">', content)
    content = re.sub(r'<a href="blog\.html" class="text-blue-500 font-bold">', r'<a href="blog.html" class="text-blue-500 font-bold nav-link">', content)

    # 5. Fix all href='#' to actually lead somewhere if possible
    content = re.sub(r'<a href="#"([^>]+)>([^<]*)Get the App', r'<a href="#download"\1>\2Get the App', content)
    content = content.replace('href="#" class="btn-primary"', 'href="#download" class="btn-primary"')

    # Service buttons link fix
    if f == 'home.html':
        content = content.replace('grid grid-cols-2 gap-4 h-[400px] relative z-20 lg:-mb-24', 'grid grid-cols-2 gap-4 h-[400px] relative z-20 lg:-mb-24 lg:-mt-16')
        content = content.replace('<button class="service-pill" style="color: #2563eb; background: #eff6ff; border-color: #dbeafe;">', '<button class="service-pill" style="color: #2563eb; background: #eff6ff; border-color: #dbeafe;" onclick="window.location.href=\'services.html#instant-rides\'">')
        content = content.replace('<button class="service-pill">\n                <i data-lucide="package"', '<button class="service-pill" onclick="window.location.href=\'services.html#courier-service\'">\n                <i data-lucide="package"')
        content = content.replace('<button class="service-pill">\n                <i data-lucide="user"', '<button class="service-pill" onclick="window.location.href=\'services.html#hire-a-driver\'">\n                <i data-lucide="user"')
        content = content.replace('<button class="service-pill">\n                <i data-lucide="key"', '<button class="service-pill" onclick="window.location.href=\'services.html#rent-a-car\'">\n                <i data-lucide="key"')
        content = content.replace('<button class="service-pill">\n                <i data-lucide="truck"', '<button class="service-pill" onclick="window.location.href=\'services.html#book-freight\'">\n                <i data-lucide="truck"')
        content = content.replace('<button class="service-pill">\n                <i data-lucide="hammer"', '<button class="service-pill" onclick="window.location.href=\'services.html#hire-artisan\'">\n                <i data-lucide="hammer"')
        
        # Communities Explore button
        content = re.sub(r'<a href="#" class="inline-flex items-center justify-center bg-blue-600 hover:bg-blue-700([^>]+)>\n\s+Explore Our Communities', r'<a href="communities.html" class="inline-flex items-center justify-center bg-blue-600 hover:bg-blue-700\1>\n                Explore Our Communities', content)

    with open(f, 'w', encoding='utf-8') as file:
        file.write(content)

# Now fix DROP\blog.html
blog_path = r'c:\Users\user\Desktop\DROP\blog.html'
if os.path.exists(blog_path):
    with open(blog_path, 'r', encoding='utf-8') as file:
        content = file.read()
    
    content = re.sub(r'<a href="([^"]+)" class="([^"]*?hover:text-white[^"]*?)">', r'<a href="\1" class="\2 nav-link">', content)
    content = re.sub(r'<a href="blog\.html" class="text-blue-500 font-bold">', r'<a href="blog.html" class="text-blue-500 font-bold nav-link">', content)
    content = re.sub(r'<a href="index\.html" class="text-white hover:text-white">', r'<a href="index.html" class="text-white hover:text-white nav-link">', content)
    
    with open(blog_path, 'w', encoding='utf-8') as file:
        file.write(content)

print("Fixes applied.")
