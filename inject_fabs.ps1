$snippet = @"
    <!-- Global Floating Action Buttons -->
    <div class="fixed bottom-6 left-6 z-[100] flex flex-col items-center gap-4">
        <!-- Progress Circular Button -->
        <button id="back-to-top" style="pointer-events: none;" class="relative w-12 h-12 flex items-center justify-center rounded-full bg-white text-blue-600 shadow-xl opacity-0 translate-y-4 transition-all duration-300 hover:scale-110 active:scale-95 group">
            <!-- SVG Progress Circle -->
            <svg class="absolute inset-0 w-full h-full transform -rotate-90" viewBox="0 0 36 36">
                <path class="text-gray-200" stroke-width="3" stroke="currentColor" fill="none" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" />
                <path id="progress-circle" class="text-blue-600 transition-all duration-150" stroke-width="3" stroke-dasharray="0, 100" stroke-linecap="round" stroke="currentColor" fill="none" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" />
            </svg>
            <i data-lucide="chevron-up" class="w-5 h-5 relative z-10 group-hover:-translate-y-1 transition-transform"></i>
        </button>
    </div>

    <div class="fixed bottom-6 right-6 z-[100] flex flex-col items-center gap-4">
        <!-- Contact Us Button -->
        <a href="mailto:contact@ridedrop.ng" class="w-12 h-12 flex items-center justify-center bg-blue-600 text-white rounded-full shadow-xl hover:bg-blue-700 hover:shadow-blue-600/30 transition-all duration-300 hover:scale-110 active:scale-95 group" title="Contact Support">
            <i data-lucide="mail" class="w-5 h-5 group-hover:animate-bounce"></i>
        </a>
    </div>

    <script>
        // Progress tracking and back to top
        const backToTopBtn = document.getElementById('back-to-top');
        const progressCircle = document.getElementById('progress-circle');

        if (backToTopBtn && progressCircle) {
            window.addEventListener('scroll', () => {
                const scrollPos = window.scrollY;
                const docHeight = document.documentElement.scrollHeight - window.innerHeight;
                const scrollPercent = docHeight > 0 ? Math.min((scrollPos / docHeight) * 100, 100) : 0;
                
                // Update circle stroke dasharray
                progressCircle.setAttribute('stroke-dasharray', scrollPercent + ', 100');

                // Show/hide button based on scroll
                if (scrollPos > 300) {
                    backToTopBtn.classList.remove('opacity-0', 'translate-y-4');
                    backToTopBtn.classList.add('opacity-100', 'translate-y-0');
                    backToTopBtn.style.pointerEvents = 'auto';
                } else {
                    backToTopBtn.classList.remove('opacity-100', 'translate-y-0');
                    backToTopBtn.classList.add('opacity-0', 'translate-y-4');
                    backToTopBtn.style.pointerEvents = 'none';
                }
            });

            backToTopBtn.addEventListener('click', () => {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
            
            // Re-init lucide icons for new elements
            if(window.lucide) { window.lucide.createIcons(); }
        }
    </script>
</body>
"@

$files = Get-ChildItem -Path 'c:\Users\user\Desktop\drop2' -Filter *.html
$files += Get-Item -Path 'c:\Users\user\Desktop\DROP\blog.html' -ErrorAction SilentlyContinue

foreach ($f in $files) {
    if (-Not $f) { continue }
    $content = Get-Content -Path $f.FullName -Raw
    
    # Avoid injecting multiple times
    if (-not $content.Contains('id="back-to-top"')) {
        $content = [regex]::Replace($content, '</body>', $snippet, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        Set-Content -Path $f.FullName -Value $content -Encoding UTF8
    }
}
