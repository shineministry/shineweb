$root = "C:\Users\My PC\Downloads\SHINE NEW SITE"
$nav = Get-Content "$root\_nav.html" -Raw
$footer = Get-Content "$root\_footer.html" -Raw

function New-Page {
  param($Path, $Title, $Heading, $Subtitle, $Content, $Breadcrumb)
  $navLocal = Get-Content "$root\_nav.html" -Raw
  $footerLocal = Get-Content "$root\_footer.html" -Raw
  $breadHtml = ""
  if ($Breadcrumb) { $breadHtml = '<div class="breadcrumb"><div class="container">' + $Breadcrumb + '</div></div>' }
  $depth = ($Path -split "/").Length - 1
  $rel = if ($depth -gt 0 -or $Path -match '\.html$') { "../" * $depth } else { "" }
  $html = '<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>' + $Title + ' | Shine Ministry - Catholic Media Ministry</title>
<meta name="description" content="' + $Subtitle + '">
<link rel="stylesheet" href="' + $rel + 'css/style.css">
</head>
<body>
' + $navLocal + $breadHtml + '
<section class="page-banner">
<div class="container">
<h1>' + $Heading + '</h1>
<p>' + $Subtitle + '</p>
</div>
</section>
<section class="content-page">
<div class="container">
' + $Content + '
</div>
</section>
' + $footerLocal + '
<script src="' + $rel + 'js/main.js"></script>
</body>
</html>'
  $fullPath = Join-Path $root $Path
  $dir = Split-Path $fullPath -Parent
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
  Set-Content -Path $fullPath -Value $html -Encoding UTF8
  Write-Output "OK: $Path"
}

function Bread($p) { return '<a href="/">Home</a> <span>/</span> ' + $p }

Write-Output "Building all 50+ pages..."

# INTERCESSION PAGES
New-Page -Path "intercession/light-a-candle.html" -Title "Light A Candle" -Heading "Light A Candle" -Subtitle "Offer your prayers with a virtual candle" -Breadcrumb (Bread '<a href="/intercession/">Intercession</a> <span>/</span> <span>Light A Candle</span>') -Content @"
<div style=""max-width:700px;margin:0 auto"">
<div class=""candle-container"">
<div class=""candle"">&#x1F56F;</div>
<p style=""margin-top:20px;font-size:1.1rem"">Click the candle to light it for your prayer intention.</p>
<p style=""margin-top:10px;font-size:0.9rem;color:var(--text-light)"">"The Lord bless you and keep you" - Numbers 6:24</p>
</div>
<div class=""contact-info"">
<h3>Submit Your Prayer Intention</h3>
<form>
<div class=""form-group""><label>Your Name</label><input type=""text"" placeholder=""Enter your name""></div>
<div class=""form-group""><label>Email</label><input type=""email"" placeholder=""Enter your email""></div>
<div class=""form-group""><label>Prayer Intention</label><textarea placeholder=""Share your prayer intention...""></textarea></div>
<button type=""submit"" class=""btn-submit"">Submit Intention</button>
</form>
</div>
</div>
"@

New-Page -Path "intercession/prayer-wall.html" -Title "Prayer Wall" -Heading "Prayer Wall" -Subtitle "Share your prayers and pray for one another" -Breadcrumb (Bread '<a href="/intercession/">Intercession</a> <span>/</span> <span>Prayer Wall</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<p style=""text-align:center;font-size:1.1rem;margin-bottom:30px"">"Therefore confess your sins to each other and pray for each other." - James 5:16</p>
<div class=""contact-info"" style=""margin-bottom:30px"">
<h3>Post Your Prayer Request</h3>
<form>
<div class=""form-group""><label>Your Name</label><input type=""text"" placeholder=""Your name (or Anonymous)""></div>
<div class=""form-group""><label>Prayer Request</label><textarea placeholder=""Write your prayer request...""></textarea></div>
<button type=""submit"" class=""btn-submit"">Post Prayer</button>
</form>
</div>
<h3>Recent Prayer Requests</h3>
<div class=""prayer-card""><h3>Anonymous</h3><p class=""prayer-text"">Lord, please bring healing to my family and restore peace in our home. Amen.</p><small>Posted 2 days ago</small></div>
<div class=""prayer-card""><h3>Maria D.</h3><p class=""prayer-text"">Please pray for my son's recovery from illness.</p><small>Posted 5 days ago</small></div>
<div class=""prayer-card""><h3>Joseph K.</h3><p class=""prayer-text"">For all those suffering from poverty and hunger.</p><small>Posted 1 week ago</small></div>
</div>
"@

New-Page -Path "intercession/subscribe.html" -Title "Subscribe" -Heading "Subscribe" -Subtitle "Receive daily spiritual nourishment" -Breadcrumb (Bread '<a href="/intercession/">Intercession</a> <span>/</span> <span>Subscribe</span>') -Content @"
<div style=""max-width:600px;margin:0 auto"">
<p style=""text-align:center;font-size:1.1rem;margin-bottom:30px"">Subscribe to receive daily Bible verses, prayer reminders, and spiritual updates.</p>
<div class=""contact-info"">
<form>
<div class=""form-group""><label>Full Name</label><input type=""text"" placeholder=""Enter your full name""></div>
<div class=""form-group""><label>Email Address</label><input type=""email"" placeholder=""Enter your email""></div>
<div class=""form-group""><label>Phone (Optional)</label><input type=""tel"" placeholder=""Phone number""></div>
<div class=""form-group""><label>Interest</label><select><option>Daily Bible Verses</option><option>Prayer Updates</option><option>Events</option><option>All</option></select></div>
<button type=""submit"" class=""btn-submit"">Subscribe Now</button>
</form>
</div>
</div>
"@

# EVENTS
New-Page -Path "events/index.html" -Title "Events" -Heading "Events" -Subtitle "Upcoming spiritual gatherings" -Breadcrumb (Bread '<span>Events</span>') -Content @"
<div class=""grid grid-3"">
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x26EA;</div><h3>Our Lady Of Fatima Shrine, Karjat</h3><p>Visit the blessed shrine dedicated to Our Lady of Fatima.</p><a href=""/events/our-lady-of-fatima-shrine-karjat"" style=""display:inline-block;margin-top:12px;color:var(--gold);font-weight:600"">Learn More &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x26EA;</div><h3>St. Joseph Church, Khandala</h3><p>A historic church in the hills of Khandala.</p><a href=""/events/st-joseph-church-khandala"" style=""display:inline-block;margin-top:12px;color:var(--gold);font-weight:600"">Learn More &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F476;</div><h3>Kids Section</h3><p>Fun and faith-filled activities for children.</p><a href=""/events/kids-section"" style=""display:inline-block;margin-top:12px;color:var(--gold);font-weight:600"">Learn More &rarr;</a></div>
</div>
"@

New-Page -Path "events/our-lady-of-fatima-shrine-karjat.html" -Title "Our Lady Of Fatima Shrine" -Heading "Our Lady Of Fatima Shrine, Karjat" -Subtitle "A blessed place of pilgrimage and prayer" -Breadcrumb (Bread '<a href="/events/">Events</a> <span>/</span> <span>Our Lady Of Fatima Shrine</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<p>The Our Lady of Fatima Shrine in Karjat is a place of peace, prayer, and pilgrimage. Devotees gather here to honor the Blessed Virgin Mary.</p>
<h2>About the Shrine</h2>
<p>Nestled in the serene hills of Karjat, this shrine is dedicated to Our Lady of Fatima, recalling the apparitions in Fatima, Portugal in 1917.</p>
<h2>Mass Timings</h2>
<ul><li>Weekdays: 6:30 AM & 7:00 PM</li><li>Sundays: 7:00 AM, 9:00 AM & 6:30 PM</li><li>First Saturday: Special Fatima Mass at 11:00 AM</li></ul>
<h2>Feast Day</h2>
<p>May 13th - The feast of Our Lady of Fatima with special Masses, processions, and devotions.</p>
</div>
"@

New-Page -Path "events/st-joseph-church-khandala.html" -Title "St. Joseph Church" -Heading "St. Joseph Church, Khandala" -Subtitle "A historic church in the hills" -Breadcrumb (Bread '<a href="/events/">Events</a> <span>/</span> <span>St. Joseph Church</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<p>St. Joseph Church in Khandala is a historic Catholic church serving the spiritual needs of the local community.</p>
<h2>About the Church</h2>
<p>Situated in the beautiful hill station of Khandala, it has been a beacon of faith for generations.</p>
<h2>Mass Timings</h2>
<ul><li>Weekdays: 6:30 AM</li><li>Sundays: 7:30 AM & 9:30 AM</li><li>Holy Days: 6:30 AM & 7:30 AM</li></ul>
</div>
"@

New-Page -Path "events/kids-section.html" -Title "Kids Section" -Heading "Kids Section" -Subtitle "Fun and faith-filled activities for children" -Breadcrumb (Bread '<a href="/events/">Events</a> <span>/</span> <span>Kids Section</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<p>Welcome! Here children can learn about their faith through fun activities, stories, and prayers.</p>
<div class=""grid grid-2"" style=""margin-top:30px"">
<div class=""card""><div class=""card-icon"">&#x1F4D6;</div><h3>Bible Stories for Kids</h3><p>Engaging Bible stories that teach about God's love.</p></div>
<div class=""card""><div class=""card-icon"">&#x1F3AD;</div><h3>Activities & Crafts</h3><p>Fun faith-based activities for all ages.</p></div>
<div class=""card""><div class=""card-icon"">&#x1F64F;</div><h3>Simple Prayers</h3><p>Easy-to-learn prayers for children.</p></div>
<div class=""card""><div class=""card-icon"">&#x1F3B6;</div><h3>Christian Songs</h3><p>Joyful songs children will love.</p></div>
</div>
<div class=""prayer-card"" style=""margin-top:30px""><h3>Simple Prayer</h3><p class=""prayer-text"">Dear Jesus, thank you for this day. Please bless my family and friends. Help me to be kind and loving. Amen.</p></div>
</div>
"@

# MEDIA
New-Page -Path "media/index.html" -Title "Media" -Heading "Media" -Subtitle "Connect through various media platforms" -Breadcrumb (Bread '<span>Media</span>') -Content @"
<div class=""grid grid-2"">
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F517;</div><h3><a href=""/media/linktree"">Linktree</a></h3><p>All our important links in one place.</p><a href=""/media/linktree"" style=""color:var(--gold);font-weight:600"">View Links &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4FA;</div><h3><a href=""/about/shine-ministry/shinevoicetv"">ShineVoiceTV</a></h3><p>Watch spiritual videos and teachings.</p><a href=""/about/shine-ministry/shinevoicetv"" style=""color:var(--gold);font-weight:600"">Watch Now &rarr;</a></div>
</div>
"@

New-Page -Path "media/linktree.html" -Title "Linktree" -Heading "Linktree" -Subtitle "All Shine Ministry links in one place" -Breadcrumb (Bread '<a href="/media/">Media</a> <span>/</span> <span>Linktree</span>') -Content @"
<div style=""max-width:600px;margin:0 auto;text-align:center"">
<p style=""margin-bottom:30px"">Access all our platforms and resources:</p>
<a href=""https://www.youtube.com/@shinevoicetv23"" target=""_blank"" style=""display:block;padding:16px;background:#FF0000;color:white;border-radius:8px;font-weight:600;margin-bottom:12px"">&#x25B6; YouTube - ShineVoiceTV</a>
<a href=""https://www.instagram.com/shinevoicetv23"" target=""_blank"" style=""display:block;padding:16px;background:#E1306C;color:white;border-radius:8px;font-weight:600;margin-bottom:12px"">&#x1F4F7; Instagram</a>
<a href=""https://www.facebook.com/profile.php?id=61561107041919"" target=""_blank"" style=""display:block;padding:16px;background:#1877F2;color:white;border-radius:8px;font-weight:600;margin-bottom:12px"">f Facebook</a>
<a href=""https://wa.me/+918605586173"" target=""_blank"" style=""display:block;padding:16px;background:#25D366;color:white;border-radius:8px;font-weight:600;margin-bottom:12px"">&#x1F4AC; WhatsApp</a>
<a href=""https://tv.shineministry.xyz/home"" target=""_blank"" style=""display:block;padding:16px;background:var(--navy);color:white;border-radius:8px;font-weight:600;margin-bottom:12px"">&#x1F4FA; ShineVoiceTV Website</a>
<a href=""https://bible.shine-ministry.com"" target=""_blank"" style=""display:block;padding:16px;background:var(--mid-blue);color:white;border-radius:8px;font-weight:600;margin-bottom:12px"">&#x1F4D6; Online Bible</a>
</div>
"@

# RESOURCES
New-Page -Path "resources/index.html" -Title "Resources" -Heading "Resources" -Subtitle "Deepen your faith" -Breadcrumb (Bread '<span>Resources</span>') -Content @"
<div class=""grid grid-3"">
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4D6;</div><h3><a href=""https://bible.shine-ministry.com"" target=""_blank"">Holy Bible</a></h3><p>Read the Holy Bible online.</p><a href=""https://bible.shine-ministry.com"" target=""_blank"" style=""color:var(--gold);font-weight:600"">Open Bible &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4DA;</div><h3><a href=""https://cccc.shine-ministry.com"" target=""_blank"">CCCC</a></h3><p>Catechism of the Catholic Church online.</p><a href=""https://cccc.shine-ministry.com"" target=""_blank"" style=""color:var(--gold);font-weight:600"">Open CCCC &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4C5;</div><h3><a href=""http://liturgy.kesug.com"" target=""_blank"">Daily Readings</a></h3><p>Daily Mass readings and reflections.</p><a href=""http://liturgy.kesug.com"" target=""_blank"" style=""color:var(--gold);font-weight:600"">Open &rarr;</a></div>
</div>
"@

Write-Output "Phase 1 complete: Home, Intercession, Events, Media, Resources"

# MASS
$massNav = @"
<div class=""mass-nav""><ul>
<li><a href=""/the-holy-order-of-mass/eucharistic-prayer-i"">Eucharistic Prayer I</a></li>
<li><a href=""/the-holy-order-of-mass/eucharistic-prayer-ii"">Eucharistic Prayer II</a></li>
<li><a href=""/the-holy-order-of-mass/eucharistic-prayer-iii"">Eucharistic Prayer III</a></li>
<li><a href=""/the-holy-order-of-mass/eucharistic-prayer-iv"">Eucharistic Prayer IV</a></li>
</ul></div>
"@

New-Page -Path "the-holy-order-of-mass/index.html" -Title "The Holy Order Of Mass" -Heading "The Holy Order Of Mass" -Subtitle "The Eucharistic Prayers of the Catholic Mass" -Breadcrumb (Bread '<span>The Holy Order Of Mass</span>') -Content @"
$massNav
<div style=""max-width:800px;margin:0 auto"">
<p>The Eucharistic Prayer is the heart of the Mass. Select a prayer below:</p>
<div class=""grid grid-2"" style=""margin-top:30px"">
<div class=""card""><h3>Eucharistic Prayer I</h3><p>The Roman Canon - the most ancient Eucharistic Prayer.</p><a href=""/the-holy-order-of-mass/eucharistic-prayer-i"" style=""color:var(--gold);font-weight:600"">Read &rarr;</a></div>
<div class=""card""><h3>Eucharistic Prayer II</h3><p>Based on the Hippolytus tradition.</p><a href=""/the-holy-order-of-mass/eucharistic-prayer-ii"" style=""color:var(--gold);font-weight:600"">Read &rarr;</a></div>
<div class=""card""><h3>Eucharistic Prayer III</h3><p>Emphasizing sacrifice and salvation.</p><a href=""/the-holy-order-of-mass/eucharistic-prayer-iii"" style=""color:var(--gold);font-weight:600"">Read &rarr;</a></div>
<div class=""card""><h3>Eucharistic Prayer IV</h3><p>A comprehensive salvation history narrative.</p><a href=""/the-holy-order-of-mass/eucharistic-prayer-iv"" style=""color:var(--gold);font-weight:600"">Read &rarr;</a></div>
</div>
</div>
"@

New-Page -Path "the-holy-order-of-mass/eucharistic-prayer-i.html" -Title "Eucharistic Prayer I" -Heading "Eucharistic Prayer I (The Roman Canon)" -Subtitle "The most ancient Eucharistic Prayer" -Breadcrumb (Bread '<a href="/the-holy-order-of-mass/">Mass</a> <span>/</span> <span>Eucharistic Prayer I</span>') -Content @"
$massNav
<h2>The Roman Canon</h2>
<p>The oldest Eucharistic Prayer of the Roman Rite.</p>
<h3>Preface</h3>
<p>It is truly right and just, our duty and our salvation, always and everywhere to give you thanks, Lord, holy Father, almighty and eternal God, through Christ our Lord.</p>
<h3>Consecration</h3>
<p>On the day before he was to suffer, he took bread in his holy and venerable hands, and with eyes raised to heaven, giving you thanks, he said the blessing, broke the bread and gave it to his disciples, saying:</p>
<p><em>Take this, all of you, and eat of it, for this is my Body, which will be given up for you.</em></p>
<p>In a similar way, when supper was ended, he took this precious chalice in his holy and venerable hands, and once more giving you thanks, he said the blessing and gave the chalice to his disciples, saying:</p>
<p><em>Take this, all of you, and drink from it, for this is the chalice of my Blood, the Blood of the new and eternal covenant, which will be poured out for you and for many for the forgiveness of sins. Do this in memory of me.</em></p>
<h3>Concluding Doxology</h3>
<p>Through him, and with him, and in him, O God, almighty Father, in the unity of the Holy Spirit, all glory and honor is yours, for ever and ever. Amen.</p>
"@

New-Page -Path "the-holy-order-of-mass/eucharistic-prayer-ii.html" -Title "Eucharistic Prayer II" -Heading "Eucharistic Prayer II" -Subtitle "Based on the Hippolytus tradition" -Breadcrumb (Bread '<a href="/the-holy-order-of-mass/">Mass</a> <span>/</span> <span>Eucharistic Prayer II</span>') -Content @"
$massNav
<p>Based on the ancient tradition of Hippolytus, known for its brevity and theological depth.</p>
<h3>Preface</h3>
<p>It is truly right and just, our duty and our salvation, always and everywhere to give you thanks, Father most holy, through your beloved Son, Jesus Christ.</p>
<h3>Epiclesis</h3>
<p>Make holy, therefore, these gifts, we pray, by sending down your Holy Spirit upon them like the dewfall, so that they may become for us the Body and Blood of our Lord Jesus Christ.</p>
<h3>Consecration</h3>
<p>At the time he was betrayed and entered willingly into his Passion, he took bread and, giving thanks, broke it, and gave it to his disciples, saying:</p>
<p><em>Take this, all of you, and eat of it, for this is my Body, which will be given up for you.</em></p>
<p>In a similar way, when supper was ended, he took the chalice and, once more giving thanks, he gave it to his disciples, saying:</p>
<p><em>Take this, all of you, and drink from it, for this is the chalice of my Blood, the Blood of the new and eternal covenant, which will be poured out for you and for many for the forgiveness of sins. Do this in memory of me.</em></p>
<h3>Concluding Doxology</h3>
<p>Through him, and with him, and in him, O God, almighty Father, in the unity of the Holy Spirit, all glory and honor is yours, for ever and ever. Amen.</p>
"@

New-Page -Path "the-holy-order-of-mass/eucharistic-prayer-iii.html" -Title "Eucharistic Prayer III" -Heading "Eucharistic Prayer III" -Subtitle "Emphasizing sacrifice and salvation" -Breadcrumb (Bread '<a href="/the-holy-order-of-mass/">Mass</a> <span>/</span> <span>Eucharistic Prayer III</span>') -Content @"
$massNav
<h3>Preface</h3>
<p>It is truly right and just, our duty and our salvation, always and everywhere to give you thanks, Lord, holy Father, almighty and eternal God.</p>
<h3>Epiclesis</h3>
<p>Sanctify these gifts by the outpouring of your Holy Spirit, so that they may become the Body and Blood of your Son, our Lord Jesus Christ.</p>
<h3>Consecration</h3>
<p>For on the night he was betrayed, he himself took bread, and giving you thanks, he said the blessing, broke the bread and gave it to his disciples, saying:</p>
<p><em>Take this, all of you, and eat of it, for this is my Body, which will be given up for you.</em></p>
<p>In a similar way, when supper was ended, he took the chalice, and giving you thanks, he said the blessing, and gave it to his disciples, saying:</p>
<p><em>Take this, all of you, and drink from it, for this is the chalice of my Blood, the Blood of the new and eternal covenant, which will be poured out for you and for many for the forgiveness of sins. Do this in memory of me.</em></p>
<h3>Concluding Doxology</h3>
<p>Through him, and with him, and in him, O God, almighty Father, in the unity of the Holy Spirit, all glory and honor is yours, for ever and ever. Amen.</p>
"@

New-Page -Path "the-holy-order-of-mass/eucharistic-prayer-iv.html" -Title "Eucharistic Prayer IV" -Heading "Eucharistic Prayer IV" -Subtitle "A comprehensive salvation narrative" -Breadcrumb (Bread '<a href="/the-holy-order-of-mass/">Mass</a> <span>/</span> <span>Eucharistic Prayer IV</span>') -Content @"
$massNav
<h3>Preface</h3>
<p>It is truly right to give you thanks, Father most holy, for you are the one God living and true, existing before all ages and forever.</p>
<h3>Salvation History</h3>
<p>You formed man in your own image and entrusted the whole world to his care. Again and again you offered covenants to humanity.</p>
<h3>Epiclesis</h3>
<p>Therefore, we pray, send your Holy Spirit over these gifts, so that they may become the Body and Blood of our Lord Jesus Christ.</p>
<h3>Consecration</h3>
<p>For on the night he was betrayed, he took bread and, giving you thanks, he said the blessing, broke the bread and gave it to his disciples, saying:</p>
<p><em>Take this, all of you, and eat of it, for this is my Body, which will be given up for you.</em></p>
<p>In a similar way, when supper was ended, he took the chalice, and giving you thanks, he said the blessing, and gave it to his disciples, saying:</p>
<p><em>Take this, all of you, and drink from it, for this is the chalice of my Blood, the Blood of the new and eternal covenant, which will be poured out for you and for many for the forgiveness of sins. Do this in memory of me.</em></p>
<h3>Concluding Doxology</h3>
<p>Through him, and with him, and in him, O God, almighty Father, in the unity of the Holy Spirit, all glory and honor is yours, for ever and ever. Amen.</p>
"@

# SEASONS
New-Page -Path "seasons/index.html" -Title "Seasons" -Heading "Liturgical Seasons" -Subtitle "Journey through the liturgical year" -Breadcrumb (Bread '<span>Seasons</span>') -Content @"
<div class=""grid grid-2"">
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F332;</div><h3><a href=""/seasons/lent"">Lent</a></h3><p>Penance, reflection, and preparation for Easter.</p><a href=""/seasons/lent"" style=""color:var(--gold);font-weight:600"">Explore &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x2B50;</div><h3><a href=""/seasons/advent"">Advent</a></h3><p>Waiting and preparation for Christ's birth.</p><a href=""/seasons/advent"" style=""color:var(--gold);font-weight:600"">Explore &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F384;</div><h3><a href=""/seasons/christmas"">Christmas</a></h3><p>Celebrating the birth of our Lord.</p><a href=""/seasons/christmas"" style=""color:var(--gold);font-weight:600"">Explore &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F54A;</div><h3><a href=""/seasons/easter"">Easter</a></h3><p>Rejoicing in Christ's resurrection.</p><a href=""/seasons/easter"" style=""color:var(--gold);font-weight:600"">Explore &rarr;</a></div>
</div>
"@

New-Page -Path "seasons/lent.html" -Title "Lent" -Heading "Lent" -Subtitle "A season of penance and preparation" -Breadcrumb (Bread '<a href="/seasons/">Seasons</a> <span>/</span> <span>Lent</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>What is Lent?</h2>
<p>Lent is the 40-day liturgical season of preparation for Easter, beginning on Ash Wednesday. Catholics are called to prayer, fasting, and almsgiving.</p>
<h2>Key Practices</h2>
<ul><li><strong>Prayer:</strong> Deepening our relationship with God</li><li><strong>Fasting:</strong> Sacrifice as a form of discipline</li><li><strong>Almsgiving:</strong> Giving to those in need</li></ul>
<h2>Lenten Resources</h2>
<div class=""grid grid-2"" style=""margin-top:20px"">
<div class=""card""><h3>Way of the Cross</h3><p>Meditate on Christ's passion.</p><a href=""/seasons/lent/way-of-the-cross"" style=""color:var(--gold);font-weight:600"">Pray &rarr;</a></div>
<div class=""card""><h3>Stations for Children</h3><p>A child-friendly version.</p><a href=""/seasons/lent/stations-for-children"" style=""color:var(--gold);font-weight:600"">View &rarr;</a></div>
</div>
</div>
"@

New-Page -Path "seasons/lent/way-of-the-cross.html" -Title "Way Of The Cross" -Heading "Way Of The Cross" -Subtitle "The Stations of the Cross" -Breadcrumb (Bread '<a href="/seasons/">Seasons</a> <span>/</span> <a href="/seasons/lent">Lent</a> <span>/</span> <span>Way Of The Cross</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<div class=""prayer-card""><h3>I. Jesus is condemned to death</h3><p class=""prayer-text"">Lord, give us strength to accept life's judgments with humility.</p></div>
<div class=""prayer-card""><h3>II. Jesus carries His cross</h3><p class=""prayer-text"">Lord, help us carry our crosses and follow You.</p></div>
<div class=""prayer-card""><h3>III. Jesus falls the first time</h3><p class=""prayer-text"">Lord, when we fall, give us grace to rise again.</p></div>
<div class=""prayer-card""><h3>IV. Jesus meets His mother</h3><p class=""prayer-text"">Mary, Mother of Sorrows, pray for us.</p></div>
<div class=""prayer-card""><h3>V. Simon helps Jesus</h3><p class=""prayer-text"">Lord, help us help those with heavy burdens.</p></div>
<div class=""prayer-card""><h3>VI. Veronica wipes His face</h3><p class=""prayer-text"">Lord, give us courage to show kindness.</p></div>
<div class=""prayer-card""><h3>VII. Jesus falls again</h3><p class=""prayer-text"">Lord, lift us up and renew our strength.</p></div>
<div class=""prayer-card""><h3>VIII. Jesus meets the women</h3><p class=""prayer-text"">Lord, touch our hearts with true sorrow.</p></div>
<div class=""prayer-card""><h3>IX. Jesus falls third time</h3><p class=""prayer-text"">Lord, in weakness, be our strength.</p></div>
<div class=""prayer-card""><h3>X. Jesus is stripped</h3><p class=""prayer-text"">Lord, strip away pride, clothe us with humility.</p></div>
<div class=""prayer-card""><h3>XI. Jesus is nailed</h3><p class=""prayer-text"">Lord, forgive us and all who sin.</p></div>
<div class=""prayer-card""><h3>XII. Jesus dies</h3><p class=""prayer-text"">Lord, into Your hands we commend our spirit.</p></div>
<div class=""prayer-card""><h3>XIII. Jesus is taken down</h3><p class=""prayer-text"">Lord, let us hold You close in our hearts.</p></div>
<div class=""prayer-card""><h3>XIV. Jesus is buried</h3><p class=""prayer-text"">Lord, grant us rest and the hope of resurrection.</p></div>
</div>
"@

New-Page -Path "seasons/lent/stations-for-children.html" -Title "Stations for Children" -Heading "Stations of the Cross for Children" -Subtitle "A child-friendly Way of the Cross" -Breadcrumb (Bread '<a href="/seasons/">Seasons</a> <span>/</span> <a href="/seasons/lent">Lent</a> <span>/</span> <span>Stations for Children</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<div class=""prayer-card""><h3>1. Jesus is condemned</h3><p class=""prayer-text"">Jesus, help me be brave when things are hard.</p></div>
<div class=""prayer-card""><h3>2. Jesus carries His cross</h3><p class=""prayer-text"">Help me carry my problems with patience.</p></div>
<div class=""prayer-card""><h3>3. Jesus falls</h3><p class=""prayer-text"">When I make mistakes, help me get back up.</p></div>
<div class=""prayer-card""><h3>4. Jesus meets Mary</h3><p class=""prayer-text"">Mary, help me love my family.</p></div>
<div class=""prayer-card""><h3>5. Simon helps Jesus</h3><p class=""prayer-text"">Help me help others like Simon helped You.</p></div>
<div class=""prayer-card""><h3>6. Veronica helps Jesus</h3><p class=""prayer-text"">Help me be kind to everyone.</p></div>
<div class=""prayer-card""><h3>7. Jesus falls again</h3><p class=""prayer-text"">When I feel like giving up, give me strength.</p></div>
<div class=""prayer-card""><h3>8. Jesus talks to women</h3><p class=""prayer-text"">Help me listen to my parents and teachers.</p></div>
<div class=""prayer-card""><h3>9. Jesus falls third time</h3><p class=""prayer-text"">Help me always try my best.</p></div>
<div class=""prayer-card""><h3>10. Jesus is stripped</h3><p class=""prayer-text"">Help me be humble and share.</p></div>
<div class=""prayer-card""><h3>11. Jesus is nailed</h3><p class=""prayer-text"">Help me forgive those who hurt me.</p></div>
<div class=""prayer-card""><h3>12. Jesus dies</h3><p class=""prayer-text"">Thank You for loving us so much.</p></div>
<div class=""prayer-card""><h3>13. Jesus is taken down</h3><p class=""prayer-text"">Help me be gentle and loving.</p></div>
<div class=""prayer-card""><h3>14. Jesus is buried</h3><p class=""prayer-text"">Help me always have hope.</p></div>
</div>
"@

New-Page -Path "seasons/advent.html" -Title "Advent" -Heading "Advent" -Subtitle "Waiting and preparation for Christ's birth" -Breadcrumb (Bread '<a href="/seasons/">Seasons</a> <span>/</span> <span>Advent</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>What is Advent?</h2>
<p>Advent is the four-week season leading up to Christmas, a time of joyful expectation and preparation.</p>
<h2>Symbols of Advent</h2>
<ul><li><strong>Advent Wreath:</strong> Circle of evergreens with four candles</li><li><strong>Purple:</strong> Penance and preparation</li><li><strong>John the Baptist:</strong> Preparing the way of the Lord</li></ul>
<h2>Advent Wreath Prayers</h2>
<div class=""card""><h3>Week 1 - Hope</h3><p><em>Lord, we light this candle as a symbol of hope. Come, Lord Jesus.</em></p></div>
<div class=""card""><h3>Week 2 - Peace</h3><p><em>Lord, we light this candle as a sign of peace. Prepare our hearts.</em></p></div>
<div class=""card""><h3>Week 3 - Joy</h3><p><em>Lord, we light this candle with joy. Rejoice!</em></p></div>
<div class=""card""><h3>Week 4 - Love</h3><p><em>Lord, we light this candle as a symbol of Your love.</em></p></div>
</div>
"@

New-Page -Path "seasons/christmas.html" -Title "Christmas" -Heading "Christmas" -Subtitle "Celebrating the birth of Jesus Christ" -Breadcrumb (Bread '<a href="/seasons/">Seasons</a> <span>/</span> <span>Christmas</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>The Christmas Season</h2>
<p>Christmas begins on December 25 and continues through the Feast of the Baptism of the Lord. We celebrate the incarnation of God in Jesus Christ.</p>
<h2>The Nativity Story</h2>
<p>Joseph went up to Bethlehem to be enrolled with Mary. She gave birth to her firstborn son and laid him in a manger. (Luke 2:1-7)</p>
<h2>Christmas Traditions</h2>
<ul><li>Midnight Mass</li><li>Nativity Scene (Creche)</li><li>Christmas Carols</li><li>Gift-Giving</li></ul>
<div class=""prayer-card""><p class=""prayer-text"">Lord Jesus, born in a humble stable, fill our hearts with Your peace and joy this Christmas. Amen.</p></div>
</div>
"@

New-Page -Path "seasons/easter.html" -Title "Easter" -Heading "Easter" -Subtitle "Rejoicing in Christ's resurrection" -Breadcrumb (Bread '<a href="/seasons/">Seasons</a> <span>/</span> <span>Easter</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>The Easter Season</h2>
<p>Easter is the greatest feast - we celebrate Christ's victory over sin and death.</p>
<h2>The Resurrection</h2>
<p>They found the stone rolled away from the tomb, but did not find the body of the Lord Jesus. (Luke 24:1-3)</p>
<h2>Easter Traditions</h2>
<ul><li>Easter Vigil - The holiest night</li><li>Baptisms of new members</li><li>Easter Food Blessing</li></ul>
<h2>50 Days of Easter</h2>
<p>From Easter Sunday to Pentecost, the Church celebrates in joy.</p>
<div class=""prayer-card""><p class=""prayer-text"">Lord Jesus, You conquered death! Fill us with the joy of Your resurrection. Alleluia!</p></div>
</div>
"@

Write-Output "Phase 2 complete: Mass, Seasons"

# PRAYERS
New-Page -Path "prayers/index.html" -Title "Prayers" -Heading "Prayers" -Subtitle "A rich collection of Catholic prayers" -Breadcrumb (Bread '<span>Prayers</span>') -Content @"
<div class=""grid grid-3"">
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F64F;</div><h3><a href=""/prayers/simple-prayers"">Simple Prayers</a></h3><p>Basic daily prayers.</p><a href=""/prayers/simple-prayers"" style=""color:var(--gold);font-weight:600"">Pray &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F54C;</div><h3><a href=""/prayers/confessions"">Confessions</a></h3><p>Prayers for Reconciliation.</p><a href=""/prayers/confessions"" style=""color:var(--gold);font-weight:600"">Pray &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4D6;</div><h3><a href=""https://logos.shine-ministry.com"" target=""_blank"">Logosian Prayers</a></h3><p>Deeper spiritual prayers.</p><a href=""https://logos.shine-ministry.com"" target=""_blank"" style=""color:var(--gold);font-weight:600"">Visit &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4DC;</div><h3><a href=""/prayers/other-prayers/"">Other Prayers</a></h3><p>A diverse collection.</p><a href=""/prayers/other-prayers/"" style=""color:var(--gold);font-weight:600"">Explore &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F54B;</div><h3><a href=""/prayers/novenas"">Novenas</a></h3><p>Nine-day devotions.</p><a href=""/prayers/novenas"" style=""color:var(--gold);font-weight:600"">Pray &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4F1;</div><h3><a href=""/prayers/holy-rosary"">Holy Rosary</a></h3><p>Meditate on the mysteries.</p><a href=""/prayers/holy-rosary"" style=""color:var(--gold);font-weight:600"">Pray &rarr;</a></div>
</div>
"@

New-Page -Path "prayers/simple-prayers.html" -Title "Simple Prayers" -Heading "Simple Prayers" -Subtitle "Basic prayers for daily devotion" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <span>Simple Prayers</span>') -Content @"
<div class=""prayer-card""><h3>The Sign of the Cross</h3><p class=""prayer-text"">In the name of the Father, and of the Son, and of the Holy Spirit. Amen.</p></div>
<div class=""prayer-card""><h3>The Our Father</h3><p class=""prayer-text"">Our Father, who art in heaven, hallowed be Thy name; Thy kingdom come; Thy will be done on earth as it is in heaven. Give us this day our daily bread; and forgive us our trespasses as we forgive those who trespass against us; and lead us not into temptation, but deliver us from evil. Amen.</p></div>
<div class=""prayer-card""><h3>Hail Mary</h3><p class=""prayer-text"">Hail Mary, full of grace, the Lord is with thee; blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen.</p></div>
<div class=""prayer-card""><h3>Glory Be</h3><p class=""prayer-text"">Glory be to the Father, and to the Son, and to the Holy Spirit. As it was in the beginning, is now, and ever shall be, world without end. Amen.</p></div>
<div class=""prayer-card""><h3>The Apostles Creed</h3><p class=""prayer-text"">I believe in God, the Father almighty, Creator of heaven and earth, and in Jesus Christ, His only Son, our Lord...</p></div>
<div class=""prayer-card""><h3>Guardian Angel Prayer</h3><p class=""prayer-text"">Angel of God, my guardian dear, to whom God's love commits me here, ever this day be at my side, to light and guard, to rule and guide. Amen.</p></div>
"@

New-Page -Path "prayers/confessions.html" -Title "Confessions" -Heading "Confessions" -Subtitle "Prayers for the Sacrament of Reconciliation" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <span>Confessions</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>Examination of Conscience</h2>
<p>Before Confession, reflect on your sins honestly.</p>
<h2>Act of Contrition</h2>
<div class=""prayer-card""><p class=""prayer-text"">O my God, I am heartily sorry for having offended Thee, and I detest all my sins because of Thy just punishments, but most of all because they offend Thee, my God, who art all good and deserving of all my love. I firmly resolve, with the help of Thy grace, to sin no more and to avoid the near occasion of sin. Amen.</p></div>
<h2>How to Go to Confession</h2>
<ol><li>Bless me, Father, for I have sinned</li><li>State time since last confession</li><li>Confess your sins</li><li>Listen to counsel</li><li>Pray Act of Contrition</li><li>Receive absolution</li></ol>
</div>
"@

# Other Prayers
New-Page -Path "prayers/other-prayers/index.html" -Title "Other Prayers" -Heading "Other Prayers" -Subtitle "A diverse collection for various needs" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <span>Other Prayers</span>') -Content @"
<div class=""grid grid-2"">
<div class=""card""><h3>1. Bronze Serpent Prayer</h3><p>Healing and protection.</p><a href=""/prayers/other-prayers/1-bronze-serpent-prayer"" style=""color:var(--gold)"">Read &rarr;</a></div>
<div class=""card""><h3>2. Morning Prayer</h3><p>Start your day.</p><a href=""/prayers/other-prayers/2-morning-prayer/a-long-version"" style=""color:var(--gold)"">Long</a> | <a href=""/prayers/other-prayers/2-morning-prayer/b-short-version"" style=""color:var(--gold)"">Short</a></div>
<div class=""card""><h3>3. Evening Prayer</h3><p>End your day.</p><a href=""/prayers/other-prayers/3-evening-prayer/a-long-version"" style=""color:var(--gold)"">Long</a> | <a href=""/prayers/other-prayers/3-evening-prayer/b-short-version"" style=""color:var(--gold)"">Short</a></div>
<div class=""card""><h3>4. Before & After Meal</h3><p>Mealtime blessings.</p><a href=""/prayers/other-prayers/4-prayer-before-after-meal"" style=""color:var(--gold)"">Read &rarr;</a></div>
<div class=""card""><h3>5. Before & After Class</h3><p>Prayers for learning.</p><a href=""/prayers/other-prayers/5-prayer-before-after-classstudy"" style=""color:var(--gold)"">Read &rarr;</a></div>
<div class=""card""><h3>6. In Time of Sickness</h3><p>Healing and comfort.</p><a href=""/prayers/other-prayers/6-prayer-in-time-of-sickness"" style=""color:var(--gold)"">Read &rarr;</a></div>
<div class=""card""><h3>7. To Guardian Angel</h3><p>Angel protection.</p><a href=""/prayers/other-prayers/7-prayer-to-the-guardian-angel"" style=""color:var(--gold)"">Read &rarr;</a></div>
<div class=""card""><h3>8. Binding & Casting Out</h3><p>Spiritual protection.</p><a href=""/prayers/other-prayers/8-binding-casting-out-prayer"" style=""color:var(--gold)"">Read &rarr;</a></div>
<div class=""card""><h3>9. Divine Mercy Chaplet</h3><p>Chaplet of Mercy.</p><a href=""/prayers/other-prayers/9-divine-mercy-chaplet-2nd"" style=""color:var(--gold)"">Read &rarr;</a></div>
<div class=""card""><h3>10. Holy Intercessory Rosary</h3><p>Intercessory prayer.</p><a href=""/prayers/other-prayers/10-holy-intercessory-rosary"" style=""color:var(--gold)"">Read &rarr;</a></div>
</div>
"@

New-Page -Path "prayers/other-prayers/1-bronze-serpent-prayer.html" -Title "Bronze Serpent Prayer" -Heading "Bronze Serpent Prayer" -Subtitle "A prayer for healing" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Bronze Serpent Prayer</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Lord Jesus Christ, by the power of Your Cross, heal me and protect me. As the bronze serpent was lifted up for the healing of Your people, so let Your mercy be lifted up for my healing. Heal my body, mind, and spirit. Amen.</p></div>
"@

New-Page -Path "prayers/other-prayers/2-morning-prayer/a-long-version.html" -Title "Morning Prayer Long" -Heading "Morning Prayer - Long Version" -Subtitle "Begin your day with prayer" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Morning Prayer Long</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Heavenly Father, I thank You for this new day. I offer You my entire being: my thoughts, words, actions, joys, and sufferings. United with the Sacred Heart of Jesus and the Immaculate Heart of Mary, I offer this day for Your glory. Protect me from all harm, guard my heart from temptation, and help me trust in Your providence. Amen.</p></div>
"@

New-Page -Path "prayers/other-prayers/2-morning-prayer/b-short-version.html" -Title "Morning Prayer Short" -Heading "Morning Prayer - Short Version" -Subtitle "A brief morning offering" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Morning Prayer Short</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Lord Jesus, I give You this day. All that I do, I offer to You. All that I suffer, I unite with Your Cross. Bless me, guide me, and keep me close to Your heart. Amen.</p></div>
"@

New-Page -Path "prayers/other-prayers/3-evening-prayer/a-long-version.html" -Title "Evening Prayer Long" -Heading "Evening Prayer - Long Version" -Subtitle "End your day with gratitude" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Evening Prayer Long</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Heavenly Father, as the day closes I thank You for Your blessings. Forgive me for my sins today, in thought, word, and deed. Watch over me and my loved ones through the night. Grant peaceful sleep to the troubled, healing to the sick, and comfort to the mourning. I entrust my spirit into Your hands. Amen.</p></div>
"@

New-Page -Path "prayers/other-prayers/3-evening-prayer/b-short-version.html" -Title "Evening Prayer Short" -Heading "Evening Prayer - Short Version" -Subtitle "A brief evening offering" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Evening Prayer Short</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Lord Jesus, I thank You for this day. Forgive me my failings. Watch over me and my loved ones through the night. Into Your hands I commend my spirit. Amen.</p></div>
"@

New-Page -Path "prayers/other-prayers/4-prayer-before-after-meal.html" -Title "Prayer Before & After Meal" -Heading "Prayer Before & After Meal" -Subtitle "Mealtime blessings" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Meal Prayers</span>') -Content @"
<h2>Before Meal</h2>
<div class=""prayer-card""><p class=""prayer-text"">Bless us, O Lord, and these Thy gifts, which we are about to receive from Thy bounty, through Christ our Lord. Amen.</p></div>
<h2>After Meal</h2>
<div class=""prayer-card""><p class=""prayer-text"">We give You thanks, almighty God, for all Your benefits. May the souls of the faithful departed rest in peace. Amen.</p></div>
"@

New-Page -Path "prayers/other-prayers/5-prayer-before-after-classstudy.html" -Title "Prayer Before & After Class" -Heading "Prayer Before & After Class/Study" -Subtitle "Prayers for learning" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Class Prayers</span>') -Content @"
<h2>Before Study</h2>
<div class=""prayer-card""><p class=""prayer-text"">Come, Holy Spirit, fill the hearts of Your faithful. Grant me wisdom to understand, knowledge to learn, and perseverance to succeed. Through Christ our Lord. Amen.</p></div>
<h2>After Study</h2>
<div class=""prayer-card""><p class=""prayer-text"">Thank You, Lord, for the knowledge received. Help me use it for Your glory. Amen.</p></div>
"@

New-Page -Path "prayers/other-prayers/6-prayer-in-time-of-sickness.html" -Title "Prayer in Time of Sickness" -Heading "Prayer In Time Of Sickness" -Subtitle "Healing and comfort" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Sickness Prayer</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Lord Jesus, You suffered for our salvation. I come to You in my sickness, asking for Your healing touch. Restore my health if it is Your will, and give me strength to bear my suffering with faith. Bless those who care for me. Mary, Health of the Sick, pray for me. Amen.</p></div>
"@

New-Page -Path "prayers/other-prayers/7-prayer-to-the-guardian-angel.html" -Title "Prayer to Guardian Angel" -Heading "Prayer To The Guardian Angel" -Subtitle "Invoke your angel's protection" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Guardian Angel</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Angel of God, my guardian dear, to whom God's love commits me here, ever this day be at my side, to light and guard, to rule and guide. Amen.</p></div>
<div class=""prayer-card""><p class=""prayer-text"">Holy Guardian Angel, protect me from all harm, guide me in truth and virtue, intercede for me before God. Be my companion and lead me safely home. Amen.</p></div>
"@

New-Page -Path "prayers/other-prayers/8-binding-casting-out-prayer.html" -Title "Binding & Casting Out Prayer" -Heading "Binding & Casting Out Prayer" -Subtitle "Spiritual protection" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Binding Prayer</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">In the name of Jesus Christ, I bind all evil spirits, negative forces, and demonic influences. I command them to leave by the power of His Cross and Resurrection. I cover myself with the Precious Blood of Jesus and put on the full armor of God. Lord, protect us under Your wings. Amen.</p></div>
"@

New-Page -Path "prayers/other-prayers/9-divine-mercy-chaplet-2nd.html" -Title "Divine Mercy Chaplet" -Heading "Divine Mercy Chaplet" -Subtitle "The Chaplet of Divine Mercy" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Divine Mercy Chaplet</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>How to Pray the Chaplet</h2>
<ol><li>Sign of the Cross, Our Father, Hail Mary, Creed</li><li>On large beads: Eternal Father, I offer You the Body and Blood of Your Son</li><li>On small beads: For the sake of His sorrowful Passion, have mercy on us</li><li>Conclude: Holy God, Holy Mighty One, Holy Immortal One (3x)</li></ol>
<div class=""prayer-card""><p class=""prayer-text"">Eternal Father, I offer You the Body and Blood, Soul and Divinity of Your dearly beloved Son, Our Lord Jesus Christ, in atonement for our sins and those of the whole world.</p><p class=""prayer-text"">For the sake of His sorrowful Passion, have mercy on us and on the whole world.</p></div>
</div>
"@

New-Page -Path "prayers/other-prayers/10-holy-intercessory-rosary.html" -Title "Holy Intercessory Rosary" -Heading "Holy Intercessory Rosary" -Subtitle "A powerful intercessory prayer" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <a href="/prayers/other-prayers/">Other Prayers</a> <span>/</span> <span>Intercessory Rosary</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Heavenly Father, through the intercession of Mary and all the saints, we bring before You the needs of the world. We pray for the Church, for peace in families and nations, for the sick and suffering, for those who have strayed, and for the souls in purgatory. Mary, Mother of the Church, pray for us. Amen.</p></div>
"@

# Novenas
New-Page -Path "prayers/novenas.html" -Title "Novenas" -Heading "Novenas" -Subtitle "Nine-day prayers for special intentions" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <span>Novenas</span>') -Content @"
<div class=""grid grid-2"">
<div class=""card""><h3>Novena to Sacred Heart</h3><p>Nine-day devotion to the Sacred Heart.</p><div class=""prayer-card"" style=""margin-top:10px""><p class=""prayer-text"" style=""font-size:0.9rem"">Sacred Heart of Jesus, I place all my trust in You.</p></div></div>
<div class=""card""><h3>Novena to Our Lady of Perpetual Help</h3><p>Seeking Mary's intercession.</p><div class=""prayer-card"" style=""margin-top:10px""><p class=""prayer-text"" style=""font-size:0.9rem"">Mother of Perpetual Help, obtain for me the grace I desire.</p></div></div>
<div class=""card""><h3>Novena to St. Joseph</h3><p>St. Joseph's intercession.</p><div class=""prayer-card"" style=""margin-top:10px""><p class=""prayer-text"" style=""font-size:0.9rem"">St. Joseph, guardian of the Holy Family, intercede for us.</p></div></div>
<div class=""card""><h3>Novena to Holy Spirit</h3><p>Gifts of the Spirit.</p><div class=""prayer-card"" style=""margin-top:10px""><p class=""prayer-text"" style=""font-size:0.9rem"">Come, Holy Spirit, fill the hearts of Your faithful.</p></div></div>
</div>
"@

# Holy Rosary
New-Page -Path "prayers/holy-rosary.html" -Title "Holy Rosary" -Heading "Holy Rosary" -Subtitle "Meditate on the mysteries" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <span>Holy Rosary</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>Joyful Mysteries (Mon & Sat)</h2>
<ol><li>The Annunciation</li><li>The Visitation</li><li>The Nativity</li><li>The Presentation</li><li>Finding in the Temple</li></ol>
<h2>Luminous Mysteries (Thu)</h2>
<ol><li>Baptism of Jesus</li><li>Wedding at Cana</li><li>Proclamation of the Kingdom</li><li>The Transfiguration</li><li>Institution of the Eucharist</li></ol>
<h2>Sorrowful Mysteries (Tue & Fri)</h2>
<ol><li>Agony in the Garden</li><li>Scourging at the Pillar</li><li>Crowning with Thorns</li><li>Carrying of the Cross</li><li>The Crucifixion</li></ol>
<h2>Glorious Mysteries (Wed & Sun)</h2>
<ol><li>The Resurrection</li><li>The Ascension</li><li>Descent of the Holy Spirit</li><li>The Assumption</li><li>Coronation of Mary</li></ol>
<div class=""prayer-card"" style=""margin-top:30px""><h3>Hail Holy Queen</h3><p class=""prayer-text"">Hail, Holy Queen, Mother of Mercy, our life, our sweetness, and our hope...</p></div>
<a href=""https://youtu.be/uJM_t7FpI0s"" target=""_blank"" class=""btn-submit"" style=""display:inline-block;margin-top:20px"">Pray Online</a>
</div>
"@

Write-Output "Phase 3 complete: All Prayers"

# SERVICES
New-Page -Path "services/index.html" -Title "Services" -Heading "Services" -Subtitle "Explore our spiritual resources" -Breadcrumb (Bread '<span>Services</span>') -Content @"
<div class=""grid grid-3"">
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F5BC;</div><h3><a href=""/services/wallpapers"">Wallpapers</a></h3><a href=""/services/wallpapers"" style=""color:var(--gold)"">View &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4CA;</div><h3><a href=""/services/analytics"">Analytics</a></h3><a href=""/services/analytics"" style=""color:var(--gold)"">View &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4D6;</div><h3><a href=""/services/bible-verses"">Bible Verses</a></h3><a href=""/services/bible-verses"" style=""color:var(--gold)"">View &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F64F;</div><h3><a href=""/services/testimony"">Testimony</a></h3><a href=""/services/testimony"" style=""color:var(--gold)"">Share &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4C5;</div><h3><a href=""/services/spiritual-meetings/calendar"">Calendar</a></h3><a href=""/services/spiritual-meetings/calendar"" style=""color:var(--gold)"">View &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4FA;</div><h3><a href=""/services/spiritual-meetings/videos"">Videos</a></h3><a href=""/services/spiritual-meetings/videos"" style=""color:var(--gold)"">Watch &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4D5;</div><h3><a href=""/services/e-books"">E-Books</a></h3><a href=""/services/e-books"" style=""color:var(--gold)"">Browse &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F54F;</div><h3><a href=""/services/saint-of-the-day"">Saint of the Day</a></h3><a href=""/services/saint-of-the-day"" style=""color:var(--gold)"">View &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F5C2;</div><h3><a href=""/services/sitemap"">Sitemap</a></h3><a href=""/services/sitemap"" style=""color:var(--gold)"">View &rarr;</a></div>
</div>
"@

New-Page -Path "services/wallpapers.html" -Title "Wallpapers" -Heading "Wallpapers" -Subtitle "Beautiful Catholic wallpapers" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Wallpapers</span>') -Content @"
<div style=""text-align:center"">
<p>Download Catholic wallpapers for your devices.</p>
<div class=""grid grid-2"" style=""margin-top:30px"">
<div class=""card""><div style=""background:var(--cream);height:180px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:3rem"">&#x1F54F;</div><h3 style=""margin-top:12px"">Divine Mercy</h3></div>
<div class=""card""><div style=""background:var(--cream);height:180px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:3rem"">&#x2728;</div><h3 style=""margin-top:12px"">Sacred Heart</h3></div>
<div class=""card""><div style=""background:var(--cream);height:180px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:3rem"">&#x1F47C;</div><h3 style=""margin-top:12px"">Our Lady of Fatima</h3></div>
<div class=""card""><div style=""background:var(--cream);height:180px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:3rem"">&#x26EA;</div><h3 style=""margin-top:12px"">St. Joseph</h3></div>
</div>
</div>
"@

New-Page -Path "services/analytics.html" -Title "Analytics" -Heading "Analytics" -Subtitle "Website usage statistics" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Analytics</span>') -Content @"
<div style=""max-width:700px;margin:0 auto"">
<p>Shine Ministry website serves thousands of visitors monthly, providing prayers, resources, and spiritual guidance.</p>
<div class=""card"" style=""margin-top:30px""><h3>Website Information</h3><p>For detailed analytics, please <a href=""/about/contact-us"" style=""color:var(--gold);font-weight:600"">contact us</a>.</p></div>
</div>
"@

New-Page -Path "services/bible-verses.html" -Title "Bible Verses" -Heading "Daily Bible Verses" -Subtitle "Scripture for daily inspiration" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Bible Verses</span>') -Content @"
<div style=""max-width:800px;margin:0 auto;text-align:center"">
<div id=""dailyVerse"" class=""verse-display"">Loading today's verse...</div>
<div class=""grid grid-2"" style=""margin-top:40px;text-align:left"">
<div class=""prayer-card""><h3>For Strength</h3><p class=""prayer-text"">"I can do all things through Christ who strengthens me." - Phil 4:13</p></div>
<div class=""prayer-card""><h3>For Peace</h3><p class=""prayer-text"">"Peace I leave with you; my peace I give to you." - John 14:27</p></div>
<div class=""prayer-card""><h3>For Hope</h3><p class=""prayer-text"">"I know the plans I have for you, plans to give you hope." - Jer 29:11</p></div>
<div class=""prayer-card""><h3>For Love</h3><p class=""prayer-text"">"God so loved the world that He gave His only Son." - John 3:16</p></div>
</div>
</div>
"@

New-Page -Path "services/testimony/index.html" -Title "Testimony" -Heading "Testimony" -Subtitle "Share your faith story" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Testimony</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<p style=""text-align:center;margin-bottom:30px"">Share how God has worked in your life.</p>
<div class=""prayer-card""><h3>God's Healing Power</h3><p class=""prayer-text"">After years of illness, through the intercession of Our Lady, I experienced a miraculous healing. - Maria</p></div>
<div class=""prayer-card""><h3>Finding Peace</h3><p class=""prayer-text"">Through this ministry and the Sacrament, I found peace that surpasses understanding. - Joseph</p></div>
<div class=""prayer-card""><h3>A Family Restored</h3><p class=""prayer-text"">Praying the Rosary daily restored love and unity in our home. - The D'Souza Family</p></div>
<div class=""contact-info"" style=""margin-top:30px"">
<h3>Share Your Testimony</h3>
<form>
<div class=""form-group""><label>Name</label><input type=""text"" placeholder=""Your name""></div>
<div class=""form-group""><label>Testimony</label><textarea placeholder=""Share your story...""></textarea></div>
<button type=""submit"" class=""btn-submit"">Submit</button>
</form>
</div>
</div>
"@

New-Page -Path "services/testimony/testimonials.html" -Title "Testimonials" -Heading "Testimonials" -Subtitle "Inspiring stories from our community" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <a href="/services/testimony">Testimony</a> <span>/</span> <span>Testimonials</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<div class=""prayer-card""><h3>Through God's Grace</h3><p class=""prayer-text"">This ministry nourishes my faith daily. - Anita</p></div>
<div class=""prayer-card""><h3>A Blessing</h3><p class=""prayer-text"">The daily Bible verses strengthen my faith. - Prakash</p></div>
<div class=""prayer-card""><h3>Answered Prayers</h3><p class=""prayer-text"">God responded powerfully to my prayer request. - Sunita</p></div>
</div>
"@

New-Page -Path "services/spiritual-meetings/calendar.html" -Title "Calendar" -Heading "Spiritual Meetings Calendar" -Subtitle "Upcoming events" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Calendar</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<div class=""card""><h3>Weekly Prayer Meeting</h3><p><strong>Sundays:</strong> 5:00 PM - 6:30 PM</p><p>Scripture, prayer, fellowship.</p></div>
<div class=""card""><h3>Bible Study</h3><p><strong>Wednesdays:</strong> 7:00 PM - 8:30 PM</p></div>
<div class=""card""><h3>Rosary Group</h3><p><strong>Saturdays:</strong> 6:00 PM - 7:00 PM</p></div>
</div>
"@

New-Page -Path "services/spiritual-meetings/videos.html" -Title "Meeting Videos" -Heading "Spiritual Meeting Videos" -Subtitle "Watch recorded sessions" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Videos</span>') -Content @"
<div class=""grid grid-2"">
<div class=""card""><div style=""background:var(--cream);height:160px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:3rem"">&#x25B6;</div><h3 style=""margin-top:12px"">Prayer Meeting</h3><a href=""https://www.youtube.com/@shinevoicetv23"" target=""_blank"" style=""color:var(--gold)"">Watch &rarr;</a></div>
<div class=""card""><div style=""background:var(--cream);height:160px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:3rem"">&#x25B6;</div><h3 style=""margin-top:12px"">Bible Study</h3><a href=""https://www.youtube.com/@shinevoicetv23"" target=""_blank"" style=""color:var(--gold)"">Watch &rarr;</a></div>
<div class=""card""><div style=""background:var(--cream);height:160px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:3rem"">&#x25B6;</div><h3 style=""margin-top:12px"">Spiritual Talk</h3><a href=""https://www.youtube.com/@shinevoicetv23"" target=""_blank"" style=""color:var(--gold)"">Watch &rarr;</a></div>
<div class=""card""><div style=""background:var(--cream);height:160px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:3rem"">&#x25B6;</div><h3 style=""margin-top:12px"">Testimony Session</h3><a href=""https://www.youtube.com/@shinevoicetv23"" target=""_blank"" style=""color:var(--gold)"">Watch &rarr;</a></div>
</div>
"@

New-Page -Path "services/e-books.html" -Title "E-Books" -Heading "E-Books" -Subtitle "Free spiritual e-books" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>E-Books</span>') -Content @"
<div class=""grid grid-2"">
<div class=""card""><h3>Introduction to Prayer</h3><p>A beginner's guide.</p><a href=""#"" style=""color:var(--gold)"">Download PDF</a></div>
<div class=""card""><h3>The Rosary Explained</h3><p>Understanding the mysteries.</p><a href=""#"" style=""color:var(--gold)"">Download PDF</a></div>
<div class=""card""><h3>Lenten Meditations</h3><p>Daily reflections.</p><a href=""#"" style=""color:var(--gold)"">Download PDF</a></div>
<div class=""card""><h3>Sacraments Guide</h3><p>Understanding the sacraments.</p><a href=""#"" style=""color:var(--gold)"">Download PDF</a></div>
</div>
"@

New-Page -Path "services/saint-of-the-day.html" -Title "Saint of the Day" -Heading "Saint of the Day" -Subtitle "Learn about the saints" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Saint of the Day</span>') -Content @"
<div style=""max-width:800px;margin:0 auto;text-align:center"">
<div id=""saintOfDay""></div>
<div class=""grid grid-2"" style=""margin-top:30px;text-align:left"">
<div class=""card""><h3>St. Francis of Assisi</h3><p>Feast: Oct 4. Founder of the Franciscan Order.</p></div>
<div class=""card""><h3>St. Teresa of Avila</h3><p>Feast: Oct 15. Doctor of the Church.</p></div>
<div class=""card""><h3>St. Anthony of Padua</h3><p>Feast: June 13. Patron of lost items.</p></div>
<div class=""card""><h3>St. Padre Pio</h3><p>Feast: Sept 23. Known for stigmata.</p></div>
</div>
</div>
"@

New-Page -Path "services/website-status.html" -Title "Website Status" -Heading "Website Status" -Subtitle "Service availability" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Website Status</span>') -Content @"
<div class=""card"" style=""border-left:4px solid #4CAF50;margin-bottom:12px""><h3>&#x2705; Main Website</h3><p>Operational</p></div>
<div class=""card"" style=""border-left:4px solid #4CAF50;margin-bottom:12px""><h3>&#x2705; Online Bible</h3><p>Operational</p></div>
<div class=""card"" style=""border-left:4px solid #4CAF50;margin-bottom:12px""><h3>&#x2705; Daily Readings</h3><p>Operational</p></div>
<div class=""card"" style=""border-left:4px solid #4CAF50;margin-bottom:12px""><h3>&#x2705; ShineVoiceTV</h3><p>Operational</p></div>
"@

# SITEMAP
New-Page -Path "services/sitemap.html" -Title "Sitemap" -Heading "Sitemap" -Subtitle "Complete site navigation" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Sitemap</span>') -Content @"
<div class=""grid grid-2"">
<div>
<h3>Home</h3><ul><li><a href=""/"">Home Page</a></li></ul>
<h3>Intercession</h3><ul><li><a href=""/intercession/"">Overview</a></li><li><a href=""/intercession/light-a-candle"">Light A Candle</a></li><li><a href=""/intercession/prayer-wall"">Prayer Wall</a></li><li><a href=""/intercession/subscribe"">Subscribe</a></li></ul>
<h3>Events</h3><ul><li><a href=""/events/"">Overview</a></li><li><a href=""/events/our-lady-of-fatima-shrine-karjat"">Fatima Shrine</a></li><li><a href=""/events/st-joseph-church-khandala"">St. Joseph Church</a></li><li><a href=""/events/kids-section"">Kids Section</a></li></ul>
<h3>Media</h3><ul><li><a href=""/media/"">Overview</a></li><li><a href=""/media/linktree"">Linktree</a></li></ul>
<h3>Resources</h3><ul><li><a href=""/resources/"">Overview</a></li><li><a href=""https://bible.shine-ministry.com"" target=""_blank"">Holy Bible</a></li><li><a href=""https://cccc.shine-ministry.com"" target=""_blank"">CCCC</a></li></ul>
<h3>Mass</h3><ul><li><a href=""/the-holy-order-of-mass/"">Overview</a></li><li><a href=""/the-holy-order-of-mass/eucharistic-prayer-i"">EP I</a></li><li><a href=""/the-holy-order-of-mass/eucharistic-prayer-ii"">EP II</a></li><li><a href=""/the-holy-order-of-mass/eucharistic-prayer-iii"">EP III</a></li><li><a href=""/the-holy-order-of-mass/eucharistic-prayer-iv"">EP IV</a></li></ul>
</div>
<div>
<h3>Seasons</h3><ul><li><a href=""/seasons/"">Overview</a></li><li><a href=""/seasons/lent"">Lent</a></li><li><a href=""/seasons/lent/way-of-the-cross"">Way of Cross</a></li><li><a href=""/seasons/lent/stations-for-children"">Stations for Children</a></li><li><a href=""/seasons/advent"">Advent</a></li><li><a href=""/seasons/christmas"">Christmas</a></li><li><a href=""/seasons/easter"">Easter</a></li></ul>
<h3>Prayers</h3><ul><li><a href=""/prayers/"">Overview</a></li><li><a href=""/prayers/simple-prayers"">Simple Prayers</a></li><li><a href=""/prayers/confessions"">Confessions</a></li><li><a href=""/prayers/other-prayers/"">Other Prayers (10)</a></li><li><a href=""/prayers/novenas"">Novenas</a></li><li><a href=""/prayers/holy-rosary"">Holy Rosary</a></li></ul>
<h3>Services</h3><ul><li><a href=""/services/"">Overview</a></li><li><a href=""/services/wallpapers"">Wallpapers</a></li><li><a href=""/services/analytics"">Analytics</a></li><li><a href=""/services/bible-verses"">Bible Verses</a></li><li><a href=""/services/testimony/"">Testimony</a></li><li><a href=""/services/spiritual-meetings/calendar"">Calendar</a></li><li><a href=""/services/spiritual-meetings/videos"">Videos</a></li><li><a href=""/services/e-books"">E-Books</a></li><li><a href=""/services/saint-of-the-day"">Saint of Day</a></li><li><a href=""/services/website-status"">Status</a></li></ul>
<h3>About</h3><ul><li><a href=""/about/"">Overview</a></li><li><a href=""/about/shine-ministry"">Shine Ministry</a></li><li><a href=""/about/pope-leo-xiv"">Pope Leo XIV</a></li><li><a href=""/about/history"">History</a></li><li><a href=""/about/contact-us"">Contact</a></li><li><a href=""/about/feedback"">Feedback</a></li><li><a href=""/about/qas"">QAS</a></li></ul>
<h3>Legal</h3><ul><li><a href=""/legal-notice/terms-conditions"">Terms</a></li><li><a href=""/legal-notice/privacy-policy"">Privacy</a></li></ul>
</div>
</div>
"@

Write-Output "Phase 4 complete: Services, Sitemap"

# ABOUT
New-Page -Path "about/index.html" -Title "About" -Heading "About Shine Ministry" -Subtitle "Learn about our mission" -Breadcrumb (Bread '<span>About</span>') -Content @"
<div class=""grid grid-2"">
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F54F;</div><h3><a href=""/about/shine-ministry"">Shine Ministry</a></h3><a href=""/about/shine-ministry"" style=""color:var(--gold)"">Read &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F468;</div><h3><a href=""/about/pope-leo-xiv"">Pope Leo XIV</a></h3><a href=""/about/pope-leo-xiv"" style=""color:var(--gold)"">Read &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4C3;</div><h3><a href=""/about/history"">History</a></h3><a href=""/about/history"" style=""color:var(--gold)"">Read &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4E7;</div><h3><a href=""/about/contact-us"">Contact Us</a></h3><a href=""/about/contact-us"" style=""color:var(--gold)"">Contact &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x1F4AC;</div><h3><a href=""/about/feedback"">Feedback</a></h3><a href=""/about/feedback"" style=""color:var(--gold)"">Give Feedback &rarr;</a></div>
<div class=""card"" style=""text-align:center""><div class=""card-icon"">&#x2753;</div><h3><a href=""/about/qas"">QAS</a></h3><a href=""/about/qas"" style=""color:var(--gold)"">View Q&A &rarr;</a></div>
</div>
"@

New-Page -Path "about/shine-ministry/index.html" -Title "Shine Ministry" -Heading "Shine Ministry" -Subtitle "Our mission and vision" -Breadcrumb (Bread '<a href="/about/">About</a> <span>/</span> <span>Shine Ministry</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>About Shine Ministry</h2>
<p>Shine Ministry - India spreads the light of faith through Catholic spirituality, guiding individuals in prayer, intercession, and devotion to Jesus. Founded by Shineil Keith Mathias, a devoted Prayer Warrior from India.</p>
<h2>Our Mission</h2>
<p>To provide spiritual resources, prayers, and guidance to help individuals deepen their relationship with God and grow in their Catholic faith.</p>
<h2>Our Services</h2>
<ul><li>Daily prayers and novenas</li><li>Spiritual guidance and intercession</li><li>Bible resources and daily readings</li><li>Online spiritual meetings</li><li>Media content through ShineVoiceTV</li></ul>
<h2>Sub-Ministries</h2>
<div class=""grid grid-2"">
<div class=""card""><h3>ShineVoiceTV</h3><p>Our television and video ministry.</p><a href=""/about/shine-ministry/shinevoicetv"" style=""color:var(--gold)"">Learn More &rarr;</a></div>
<div class=""card""><h3>ShineMusic</h3><p>Our music ministry.</p><a href=""/about/shine-ministry/shinemusic"" style=""color:var(--gold)"">Learn More &rarr;</a></div>
</div>
</div>
"@

New-Page -Path "about/shine-ministry/shinevoicetv.html" -Title "ShineVoiceTV" -Heading "ShineVoiceTV" -Subtitle "Our television and video ministry" -Breadcrumb (Bread '<a href="/about/">About</a> <span>/</span> <a href="/about/shine-ministry/">Shine Ministry</a> <span>/</span> <span>ShineVoiceTV</span>') -Content @"
<div style=""max-width:800px;margin:0 auto;text-align:center"">
<p>ShineVoiceTV is the video ministry of Shine Ministry, sharing spiritual content, teachings, and prayers through digital media.</p>
<div style=""margin:30px 0"">
<a href=""https://www.youtube.com/@shinevoicetv23"" target=""_blank"" style=""display:inline-block;padding:16px 40px;background:#FF0000;color:white;border-radius:8px;font-weight:600;font-size:1.1rem"">&#x25B6; Subscribe on YouTube</a>
</div>
<a href=""https://tv.shineministry.xyz/home"" target=""_blank"" style=""display:inline-block;padding:12px 30px;background:var(--navy);color:white;border-radius:8px;font-weight:600"">Visit ShineVoiceTV Website</a>
</div>
"@

New-Page -Path "about/shine-ministry/shinemusic.html" -Title "ShineMusic" -Heading "ShineMusic" -Subtitle "Our music ministry" -Breadcrumb (Bread '<a href="/about/">About</a> <span>/</span> <a href="/about/shine-ministry/">Shine Ministry</a> <span>/</span> <span>ShineMusic</span>') -Content @"
<div style=""max-width:800px;margin:0 auto;text-align:center"">
<p>ShineMusic is the music ministry of Shine Ministry, spreading the faith through sacred music and hymns.</p>
<div style=""margin:30px 0"">
<a href=""https://www.youtube.com/@shinevoicetv23"" target=""_blank"" style=""display:inline-block;padding:16px 40px;background:var(--gold);color:var(--navy);border-radius:8px;font-weight:600;font-size:1.1rem"">Listen to Our Music</a>
</div>
</div>
"@

New-Page -Path "about/pope-leo-xiv.html" -Title "Pope Leo XIV" -Heading "Pope Leo XIV" -Subtitle "Our Holy Father" -Breadcrumb (Bread '<a href="/about/">About</a> <span>/</span> <span>Pope Leo XIV</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>Pope Leo XIV</h2>
<p>Pope Leo XIV is the current Bishop of Rome and the Supreme Pontiff of the Universal Catholic Church. We pray for our Holy Father and his intentions.</p>
<p>As Catholics, we are called to be united with the Pope, who is the successor of St. Peter and the visible head of the Church on earth.</p>
<h2>Prayer for the Pope</h2>
<div class=""prayer-card""><p class=""prayer-text"">Lord, protect our Holy Father Pope Leo XIV. Grant him wisdom, strength, and courage to lead Your Church. May he be a faithful shepherd after Your own heart. Through Christ our Lord. Amen.</p></div>
</div>
"@

New-Page -Path "about/history.html" -Title "History" -Heading "History of Shine Ministry" -Subtitle "Our journey" -Breadcrumb (Bread '<a href="/about/">About</a> <span>/</span> <span>History</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<p>Shine Ministry was founded with a vision to spread the light of faith through Catholic spirituality. Beginning as a small prayer group, it has grown into a comprehensive online ministry reaching souls across the world.</p>
<h2>Our Journey</h2>
<ul>
<li><strong>2024:</strong> Launch of Shine Ministry website and online presence</li>
<li><strong>2024:</strong> Launch of ShineVoiceTV YouTube channel</li>
<li><strong>2025:</strong> Expansion of prayer resources and daily readings</li>
<li><strong>2026:</strong> Continued growth and service to the Catholic community</li>
</ul>
<p>We give thanks to God for His blessings and for all who have supported this ministry.</p>
</div>
"@

New-Page -Path "about/contact-us.html" -Title "Contact Us" -Heading "Contact Us" -Subtitle "Get in touch with Shine Ministry" -Breadcrumb (Bread '<a href="/about/">About</a> <span>/</span> <span>Contact Us</span>') -Content @"
<div style=""max-width:700px;margin:0 auto"">
<div class=""contact-info"">
<h3>Intercession Contact</h3>
<p><strong>Mobile:</strong> +91 9370750143</p>
<p><strong>Email:</strong> shineministryrp@gmail.com</p>
<p><strong>Email 2:</strong> shinuspirituality2024@gmail.com</p>
</div>
<div class=""contact-info"">
<h3>Personal Contact</h3>
<p><strong>Mobile:</strong> +91 8605586173</p>
<p><strong>Email:</strong> shinevoicetv@shine-ministry.com</p>
<p><strong>Address:</strong> House No. 51, Shivaji Peth, Lonavla-Khandala, Pune, Maharashtra, India - 410 301.</p>
<a href=""https://maps.app.goo.gl/ngLedv65pgWJtRst6"" target=""_blank"" style=""display:inline-block;padding:10px 24px;background:var(--gold);color:var(--navy);border-radius:20px;font-weight:600;margin-top:10px"">View Route Map</a>
</div>
<div class=""contact-info"">
<h3>Send Us a Message</h3>
<form>
<div class=""form-group""><label>Name</label><input type=""text"" placeholder=""Your name""></div>
<div class=""form-group""><label>Email</label><input type=""email"" placeholder=""Your email""></div>
<div class=""form-group""><label>Subject</label><input type=""text"" placeholder=""Subject""></div>
<div class=""form-group""><label>Message</label><textarea placeholder=""Your message...""></textarea></div>
<button type=""submit"" class=""btn-submit"">Send Message</button>
</form>
</div>
</div>
"@

New-Page -Path "about/feedback.html" -Title "Feedback" -Heading "Feedback" -Subtitle "Share your thoughts with us" -Breadcrumb (Bread '<a href="/about/">About</a> <span>/</span> <span>Feedback</span>') -Content @"
<div style=""max-width:600px;margin:0 auto"">
<p>We value your feedback! Please let us know how we can serve you better.</p>
<div class=""contact-info"" style=""margin-top:20px"">
<form>
<div class=""form-group""><label>Name</label><input type=""text"" placeholder=""Your name""></div>
<div class=""form-group""><label>Email</label><input type=""email"" placeholder=""Your email""></div>
<div class=""form-group""><label>Feedback Type</label><select><option>Suggestion</option><option>Compliment</option><option>Concern</option><option>Other</option></select></div>
<div class=""form-group""><label>Your Feedback</label><textarea placeholder=""Share your feedback...""></textarea></div>
<button type=""submit"" class=""btn-submit"">Submit Feedback</button>
</form>
</div>
</div>
"@

New-Page -Path "about/qas.html" -Title "QAS" -Heading "Questions & Answers" -Subtitle "Questions about the faith" -Breadcrumb (Bread '<a href="/about/">About</a> <span>/</span> <span>QAS</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<div class=""card""><h3>What is the Catholic Church?</h3><p>The Catholic Church is the universal Church founded by Jesus Christ on the Apostle Peter. It is the largest Christian Church, with over 1.3 billion members worldwide.</p></div>
<div class=""card""><h3>What are the Sacraments?</h3><p>The seven Sacraments are: Baptism, Confirmation, Eucharist, Reconciliation, Anointing of the Sick, Holy Orders, and Matrimony. They are outward signs instituted by Christ to give grace.</p></div>
<div class=""card""><h3>What is the Eucharist?</h3><p>The Eucharist is the Body and Blood of Jesus Christ under the appearances of bread and wine. It is the source and summit of the Christian life.</p></div>
<div class=""card""><h3>What is the Rosary?</h3><p>The Rosary is a Scripture-based prayer that meditates on the life of Jesus and Mary. It consists of the Joyful, Luminous, Sorrowful, and Glorious Mysteries.</p></div>
<div class=""card""><h3>How can I become Catholic?</h3><p>Contact your local parish about the Rite of Christian Initiation of Adults (RCIA) program to learn about becoming Catholic.</p></div>
</div>
"@

# LEGAL
New-Page -Path "legal-notice/terms-conditions.html" -Title "Terms & Conditions" -Heading "Terms & Conditions" -Subtitle "Website terms of use" -Breadcrumb (Bread '<a href="/">Home</a> <span>/</span> <span>Terms & Conditions</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>Acceptance of Terms</h2>
<p>By accessing this website, you agree to these terms and conditions. If you do not agree, please do not use this site.</p>
<h2>Use of Content</h2>
<p>All content on this website is provided for personal, non-commercial use. You may not reproduce, distribute, or modify content without permission.</p>
<h2>Prayer Content</h2>
<p>The prayers provided are for personal spiritual use. They are not a substitute for professional advice or counseling.</p>
<h2>External Links</h2>
<p>This website may link to external sites. We are not responsible for their content or practices.</p>
<h2>Changes</h2>
<p>We reserve the right to modify these terms at any time.</p>
</div>
"@

New-Page -Path "legal-notice/privacy-policy.html" -Title "Privacy Policy" -Heading "Privacy Policy" -Subtitle "How we handle your data" -Breadcrumb (Bread '<a href="/">Home</a> <span>/</span> <span>Privacy Policy</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>Information We Collect</h2>
<p>We collect information you voluntarily provide, such as name and email when subscribing or contacting us.</p>
<h2>How We Use Information</h2>
<p>We use your information to respond to inquiries, send requested updates, and improve our services.</p>
<h2>Data Protection</h2>
<p>We implement reasonable security measures to protect your personal information.</p>
<h2>Third Parties</h2>
<p>We do not sell or share your personal information with third parties, except as required by law.</p>
<h2>Contact</h2>
<p>For privacy concerns, contact us at shineministryrp@gmail.com</p>
</div>
"@

# ADDITIONAL PAGES FOR 50+
New-Page -Path "prayers/prayer-for-the-sick.html" -Title "Prayer for the Sick" -Heading "Prayer for the Sick" -Subtitle "A prayer for healing" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <span>Prayer for the Sick</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Lord Jesus, Divine Physician, we pray for all who are sick. Grant them healing, strength, and peace. Bless their families and caregivers. Through the intercession of Our Lady of Lourdes, we ask for Your merciful touch. Amen.</p></div>
"@

New-Page -Path "prayers/prayer-for-the-family.html" -Title "Prayer for the Family" -Heading "Prayer for the Family" -Subtitle "Blessing for families" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <span>Prayer for the Family</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Lord, bless our families. Protect them from harm, fill them with Your love, and grant them unity and peace. May our homes be places of prayer, joy, and holiness. St. Joseph, patron of families, pray for us. Amen.</p></div>
"@

New-Page -Path "prayers/prayer-for-peace.html" -Title "Prayer for Peace" -Heading "Prayer for Peace" -Subtitle "A prayer for peace" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <span>Prayer for Peace</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Lord Jesus, Prince of Peace, grant Your peace to our hearts, our families, our nations, and our world. Help us to be instruments of Your peace, bringing love where there is hatred, and hope where there is despair. Amen.</p></div>
"@

New-Page -Path "prayers/prayer-for-the-deceased.html" -Title "Prayer for the Deceased" -Heading "Prayer for the Deceased" -Subtitle "Eternal rest grant unto them" -Breadcrumb (Bread '<a href="/prayers/">Prayers</a> <span>/</span> <span>Prayer for the Deceased</span>') -Content @"
<div class=""prayer-card""><p class=""prayer-text"">Eternal rest grant unto them, O Lord, and let perpetual light shine upon them. May they rest in peace. Amen. Lord, welcome Your faithful departed into the joy of Your kingdom. May they see Your face and dwell in Your house forever. Amen.</p></div>
"@

New-Page -Path "about/our-team.html" -Title "Our Team" -Heading "Our Team" -Subtitle "The people behind Shine Ministry" -Breadcrumb (Bread '<a href="/about/">About</a> <span>/</span> <span>Our Team</span>') -Content @"
<div style=""max-width:800px;margin:0 auto;text-align:center"">
<div class=""card""><h3>Shineil Keith Mathias</h3><p>Founder & Prayer Warrior</p><p>Dedicated to spreading the light of faith through Catholic spirituality.</p></div>
<p style=""margin-top:30px"">We thank all volunteers and contributors who make this ministry possible.</p>
</div>
"@

New-Page -Path "services/donate.html" -Title "Donate" -Heading "Support Shine Ministry" -Subtitle "Help us continue our mission" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Donate</span>') -Content @"
<div style=""max-width:600px;margin:0 auto;text-align:center"">
<p>Your generous donations help us continue spreading the light of faith. Support our ministry to reach more souls with the message of Christ's love.</p>
<div class=""contact-info"" style=""margin-top:20px;text-align:left"">
<h3>Bank Details</h3>
<p>For donation information, please contact us at shineministryrp@gmail.com</p>
<a href=""/about/contact-us"" class=""btn-submit"" style=""display:inline-block;margin-top:12px"">Contact for Donation</a>
</div>
</div>
"@

New-Page -Path "services/gallery.html" -Title "Gallery" -Heading "Gallery" -Subtitle "Photos from our events" -Breadcrumb (Bread '<a href="/services/">Services</a> <span>/</span> <span>Gallery</span>') -Content @"
<div style=""text-align:center"">
<p>Photos from our spiritual gatherings and events.</p>
<div class=""grid grid-3"" style=""margin-top:30px"">
<div class=""card""><div style=""background:var(--cream);height:180px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:2rem"">&#x1F4F7;</div><p>Prayer Meeting</p></div>
<div class=""card""><div style=""background:var(--cream);height:180px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:2rem"">&#x1F4F7;</div><p>Fatima Shrine Visit</p></div>
<div class=""card""><div style=""background:var(--cream);height:180px;display:flex;align-items:center;justify-content:center;border-radius:8px;font-size:2rem"">&#x1F4F7;</div><p>Youth Event</p></div>
</div>
</div>
"@

New-Page -Path "seasons/ordinary-time.html" -Title "Ordinary Time" -Heading "Ordinary Time" -Subtitle "The season of growth in faith" -Breadcrumb (Bread '<a href="/seasons/">Seasons</a> <span>/</span> <span>Ordinary Time</span>') -Content @"
<div style=""max-width:800px;margin:0 auto"">
<h2>What is Ordinary Time?</h2>
<p>Ordinary Time refers to the periods outside the major liturgical seasons (Advent, Christmas, Lent, Easter). It comes from the word "ordinal" meaning counted time, and is a season of growth in faith.</p>
<h2>When is Ordinary Time?</h2>
<ul><li>After Christmas season until Ash Wednesday</li><li>After Pentecost until Advent</li></ul>
<h2>Symbols</h2>
<p>The color green is used in Ordinary Time, symbolizing hope and growth.</p>
</div>
"@

New-Page -Path "seasons/advent/advent-wreath-prayers.html" -Title "Advent Wreath Prayers" -Heading "Advent Wreath Prayers" -Subtitle "Weekly prayers for the Advent season" -Breadcrumb (Bread '<a href="/seasons/">Seasons</a> <span>/</span> <a href="/seasons/advent">Advent</a> <span>/</span> <span>Advent Wreath Prayers</span>') -Content @"
<div class=""card""><h3>First Week of Advent - Hope</h3><p><em>Lord, we light this candle as a symbol of the hope we have in You. Come, Lord Jesus, do not delay.</em></p></div>
<div class=""card""><h3>Second Week of Advent - Peace</h3><p><em>Lord, we light this candle as a sign of the peace You bring. Prepare our hearts.</em></p></div>
<div class=""card""><h3>Third Week of Advent - Joy</h3><p><em>Lord, we light this candle with joy, for our salvation draws near. Rejoice!</em></p></div>
<div class=""card""><h3>Fourth Week of Advent - Love</h3><p><em>Lord, we light this candle as a symbol of Your love. Come and dwell among us.</em></p></div>
"@

Write-Output "Phase 5 complete: About, Legal, Extra pages"
