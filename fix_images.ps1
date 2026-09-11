$files = Get-ChildItem -Path 'c:\Users\user\Desktop\drop2' -Filter *.html
$files += Get-ChildItem -Path 'c:\Users\user\Desktop\DROP' -Filter *.html

foreach ($f in $files) {
    if (-Not $f) { continue }
    $content = Get-Content -Path $f.FullName -Raw

    # Find and replace all Unsplash images with picsum placeholders
    # Because PowerShell regular expressions might be tricky, let's use a simpler match
    # We replace 'https://images.unsplash.com/photo-[^"]+'
    $pattern = 'https://images\.unsplash\.com/photo-[^"]+'
    
    $matches = [regex]::Matches($content, $pattern)
    if ($matches.Count -gt 0) {
        foreach ($m in $matches) {
            $rand = Get-Random -Minimum 1000 -Maximum 9999
            $replacement = "https://picsum.photos/800/600?random=$rand"
            $content = $content.Replace($m.Value, $replacement)
        }
    }

    Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}
