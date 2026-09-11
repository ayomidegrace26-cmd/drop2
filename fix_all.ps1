$files = Get-ChildItem -Path 'c:\Users\user\Desktop\drop2' -Filter *.html
$files += Get-ChildItem -Path 'c:\Users\user\Desktop\DROP' -Filter *.html

foreach ($f in $files) {
    if (-Not $f) { continue }
    $content = Get-Content -Path $f.FullName -Raw

    # 1. Fix JS syntax error
    $content = $content.Replace("progressCircle.setAttribute('stroke-dasharray', `, 100`);", "progressCircle.setAttribute('stroke-dasharray', scrollPercent + ', 100');")
    
    # 2. Fix Unsplash image links that are broken
    # E.g. https://images.unsplash.com/photo-1593941707882-a5bba14938c7?w=1200&h=600&fit=crop
    $content = [regex]::Replace($content, 'https://images\.unsplash\.com/photo-[a-zA-Z0-9-]+[^\s"]*', { param($m) 'https://picsum.photos/800/600?random=' + (Get-Random) })

    # 3. Apply fixes specifically to DROP files to bring them in line with drop2
    if ($f.FullName -like "*DROP\*") {
        $content = [regex]::Replace($content, '<a href="([^"]+)" class="([^"]*?hover:text-white[^"]*?)">', '<a href="$1" class="$2 nav-link">')
        $content = [regex]::Replace($content, '<a href="index\.html" class="text-white">', '<a href="index.html" class="text-white nav-link">')
        
        $content = [regex]::Replace($content, 'href="#download"', 'href="https://play.google.com/store/apps" target="_blank"')
        $content = [regex]::Replace($content, '<a href="#"([^>]+)>([^<]*)Get the App', '<a href="https://play.google.com/store/apps" target="_blank"$1>$2Get the App')
        $content = [regex]::Replace($content, '<a href="#"([^>]+)>([^<]*)Download the App', '<a href="https://play.google.com/store/apps" target="_blank"$1>$2Download the App')
        
        $content = $content.Replace('href="#" class="btn-primary"', 'href="https://play.google.com/store/apps" class="btn-primary"')
        $content = $content.Replace('href="#login"', 'href="index.html"')
    }

    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}

# Also ensure DROP\blog.html has the nav-link CSS!
# Since I replaced it before but maybe not the others. I'll just check if animations.css is included.
$dropFiles = Get-ChildItem -Path 'c:\Users\user\Desktop\DROP' -Filter *.html
foreach ($f in $dropFiles) {
    if (-Not $f) { continue }
    $content = Get-Content -Path $f.FullName -Raw
    
    # Check if animations.css is included, if not, we can inject a link to it, but the path would be ../drop2/assets/animations.css. 
    # Let's just do that to make sure it works!
    if (-not $content.Contains('animations.css')) {
        $content = $content.Replace('</head>', "    <link rel=`"stylesheet`" href=`"../drop2/assets/animations.css`">`r`n</head>")
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
    }
}
