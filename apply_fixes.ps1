$files = Get-ChildItem -Path '.' -Filter *.html
foreach ($f in $files) {
    $content = Get-Content -Path $f.FullName -Raw
    
    # 1. Add nav-link to nav items
    $content = [regex]::Replace($content, '<a href="([^"]+)" class="([^"]*?hover:text-white[^"]*?)">', '<a href="$1" class="$2 nav-link">')
    $content = [regex]::Replace($content, '<a href="home\.html" class="text-white">', '<a href="home.html" class="text-white nav-link">')
    $content = [regex]::Replace($content, '<a href="communities\.html" class="text-blue-500 hover:text-blue-400 font-bold transition-colors">', '<a href="communities.html" class="text-blue-500 hover:text-blue-400 font-bold transition-colors nav-link">')
    $content = [regex]::Replace($content, '<a href="blog\.html" class="text-blue-500 font-bold">', '<a href="blog.html" class="text-blue-500 font-bold nav-link">')

    # 5. Fix all href='#'
    $content = [regex]::Replace($content, '<a href="#"([^>]+)>([^<]*)Get the App', '<a href="#download"$1>$2Get the App')
    $content = $content.Replace('href="#" class="btn-primary"', 'href="#download" class="btn-primary"')

    if ($f.Name -eq 'home.html') {
        $content = $content.Replace('grid grid-cols-2 gap-4 h-[400px] relative z-20 lg:-mb-24', 'grid grid-cols-2 gap-4 h-[400px] relative z-20 lg:-mb-24 lg:-mt-16')
        
        $content = $content.Replace('<button class="service-pill" style="color: #2563eb; background: #eff6ff; border-color: #dbeafe;">', '<button class="service-pill" style="color: #2563eb; background: #eff6ff; border-color: #dbeafe;" onclick="window.location.href=''services.html#instant-rides''">')
        $content = $content.Replace('<button class="service-pill">' + "`r`n" + '                <i data-lucide="package"', '<button class="service-pill" onclick="window.location.href=''services.html#courier-service''">' + "`r`n" + '                <i data-lucide="package"')
        $content = $content.Replace('<button class="service-pill">' + "`r`n" + '                <i data-lucide="user"', '<button class="service-pill" onclick="window.location.href=''services.html#hire-a-driver''">' + "`r`n" + '                <i data-lucide="user"')
        $content = $content.Replace('<button class="service-pill">' + "`r`n" + '                <i data-lucide="key"', '<button class="service-pill" onclick="window.location.href=''services.html#rent-a-car''">' + "`r`n" + '                <i data-lucide="key"')
        $content = $content.Replace('<button class="service-pill">' + "`r`n" + '                <i data-lucide="truck"', '<button class="service-pill" onclick="window.location.href=''services.html#book-freight''">' + "`r`n" + '                <i data-lucide="truck"')
        $content = $content.Replace('<button class="service-pill">' + "`r`n" + '                <i data-lucide="hammer"', '<button class="service-pill" onclick="window.location.href=''services.html#hire-artisan''">' + "`r`n" + '                <i data-lucide="hammer"')
        
        $content = [regex]::Replace($content, '(?s)<a href="#" class="inline-flex items-center justify-center bg-blue-600 hover:bg-blue-700([^>]+)>\s+Explore Our Communities', '<a href="communities.html" class="inline-flex items-center justify-center bg-blue-600 hover:bg-blue-700$1>' + "`r`n" + '                Explore Our Communities')
    }

    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}

# Now fix DROP\blog.html
$blogPath = 'c:\Users\user\Desktop\DROP\blog.html'
if (Test-Path $blogPath) {
    $content = Get-Content -Path $blogPath -Raw
    $content = [regex]::Replace($content, '<a href="([^"]+)" class="([^"]*?hover:text-white[^"]*?)">', '<a href="$1" class="$2 nav-link">')
    $content = [regex]::Replace($content, '<a href="blog\.html" class="text-blue-500 font-bold">', '<a href="blog.html" class="text-blue-500 font-bold nav-link">')
    $content = [regex]::Replace($content, '<a href="index\.html" class="text-white hover:text-white">', '<a href="index.html" class="text-white hover:text-white nav-link">')
    Set-Content -Path $blogPath -Value $content -Encoding UTF8
}
