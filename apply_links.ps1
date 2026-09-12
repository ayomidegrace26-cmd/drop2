$files = Get-ChildItem -Path 'c:\Users\user\Desktop\drop2' -Filter *.html
$files += Get-Item -Path 'c:\Users\user\Desktop\DROP\blog.html' -ErrorAction SilentlyContinue

foreach ($f in $files) {
    if (-Not $f) { continue }
    $content = Get-Content -Path $f.FullName -Raw
    
    # 1. Change "Get the App" / "Download the App" to Play Store
    # The previous script changed '#' to '#download'.
    $content = [regex]::Replace($content, 'href="#download"', 'href="https://play.google.com/store/apps/details?id=com.hdprointernational.ridedrop" target="_blank" rel="noopener noreferrer"')
    # Catch any remaining '#' that say 'Download the App' or 'Get the App'
    $content = [regex]::Replace($content, '<a href="#"([^>]+)>([^<]*)Get the App', '<a href="https://play.google.com/store/apps/details?id=com.hdprointernational.ridedrop" target="_blank" rel="noopener noreferrer"$1>$2Get the App')
    $content = [regex]::Replace($content, '<a href="#"([^>]+)>([^<]*)Download the App', '<a href="https://play.google.com/store/apps/details?id=com.hdprointernational.ridedrop" target="_blank" rel="noopener noreferrer"$1>$2Download the App')

    # 2. Login button to redirect to home page
    $content = [regex]::Replace($content, 'href="#login"', 'href="home.html"')
    
    # 3. Fix nav-link missing on active pages (like text-white without hover:text-white)
    # We'll just look for nav links. They are usually inside <nav>. 
    # Let's replace any class="text-white" that is an <a> tag inside nav.
    # A generic approach: 
    $content = [regex]::Replace($content, '<a href="([^"]+)" class="text-white">', '<a href="$1" class="text-white nav-link">')
    $content = [regex]::Replace($content, '<a href="([^"]+)" class="text-white font-medium text-lg">', '<a href="$1" class="text-white font-medium text-lg nav-link">')
    # If they already have nav-link, regex will replace class="text-white nav-link" ? No, because it matches exact 'class="text-white"'.
    
    # For active links that have font-bold, text-blue-500, etc.
    $content = [regex]::Replace($content, '<a href="([^"]+)" class="text-blue-500 font-bold">', '<a href="$1" class="text-blue-500 font-bold nav-link">')
    $content = [regex]::Replace($content, '<a href="([^"]+)" class="text-blue-600 font-bold">', '<a href="$1" class="text-blue-600 font-bold nav-link">')
    
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}
