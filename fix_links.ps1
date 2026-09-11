$content = Get-Content -Path home.html -Raw

# Nav links
$content = $content -replace "href='/about'", "href='about.html'"
$content = $content -replace "href='/services'", "href='services.html'"
$content = $content -replace "href='/communities'", "href='communities.html'"
$content = $content -replace "href='/investors'", "href='investors.html'"
$content = $content -replace "href='/careers'", "href='careers.html'"
$content = $content -replace "href='/blog'", "href='blog.html'"
$content = $content -replace "href='/home'", "href='home.html'"
$content = $content -replace "href='/services#", "href='services.html#"

# Become a Driver / Partner
$content = $content -replace 'href="#" class="inline-flex items-center justify-center border-2 border-white/80 hover:border-white hover:bg-white/5 text-white font-bold py-3.5 px-8 rounded-full transition-all"', 'href="careers.html" class="inline-flex items-center justify-center border-2 border-white/80 hover:border-white hover:bg-white/5 text-white font-bold py-3.5 px-8 rounded-full transition-all"'

# Download app buttons
$content = $content -replace '<a href="#" class="bg-black hover:bg-gray-900', '<a href="https://play.google.com/store/apps" target="_blank" class="bg-black hover:bg-gray-900'

# Press
$content = $content -replace '<li><a href="#" class="text-slate-400 hover:text-white text-\[14px\] transition-colors nav-link">Press</a></li>', '<li><a href="blog.html" class="text-slate-400 hover:text-white text-[14px] transition-colors nav-link">Press</a></li>'

# Privacy / Terms
$content = $content -replace 'href="#" class="hover:text-white transition-colors nav-link"', 'href="home.html" class="hover:text-white transition-colors nav-link"'

Set-Content -Path home.html -Value $content -Encoding UTF8
