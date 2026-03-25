# Build Forty Seconds InDesign document — staged execution
# Runs the build in sequential stages to avoid COM marshalling issues with large scripts
$ErrorActionPreference = "Continue"
$app = New-Object -ComObject 'InDesign.Application.2026'
Write-Output ("InDesign " + $app.Version)

$step = 0
function RunJSX($name, $code) {
    $script:step++
    # Force garbage collection to prevent COM marshalling failures
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    try {
        $null = $app.DoScript($code, 1246973031)
        Write-Output ("  [$script:step] $name")
        return $true
    } catch {
        Write-Output ("  [$script:step] FAIL: $name -> " + $_.Exception.Message)
        return $false
    }
}

Write-Output "=== Stage 1: Document Setup ==="
RunJSX "Create document" @"
app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;
app.scriptPreferences.measurementUnit = MeasurementUnits.INCHES;
var doc = app.documents.add();
doc.documentPreferences.properties = {
    pageWidth: 5.5, pageHeight: 8.5,
    facingPages: true, pagesPerDocument: 1,
    documentBleedTopOffset: 0.125, documentBleedBottomOffset: 0.125,
    documentBleedInsideOrLeftOffset: 0, documentBleedOutsideOrRightOffset: 0.125
};
doc.viewPreferences.horizontalMeasurementUnits = MeasurementUnits.INCHES;
doc.viewPreferences.verticalMeasurementUnits = MeasurementUnits.INCHES;
doc.marginPreferences.properties = { top: 0.5, bottom: 0.625, left: 0.75, right: 0.625 };
doc.textPreferences.smartTextReflow = true;
doc.textPreferences.addPages = AddPageOptions.END_OF_STORY;
doc.textPreferences.limitToMasterTextFrames = false;
doc.textPreferences.deleteEmptyPages = true;
"@

Write-Output "=== Stage 2: Character Styles ==="
RunJSX "Character styles" @"
var doc = app.activeDocument;
doc.characterStyles.add({name: 'Emphasis', fontStyle: 'Italic'});
doc.characterStyles.add({name: 'Strong', fontStyle: 'Bold'});
"@

Write-Output "=== Stage 3: Paragraph Styles ==="
RunJSX "Body styles" @"
var doc = app.activeDocument;
doc.paragraphStyles.add({
    name: 'Body Text', appliedFont: 'Garamond', fontStyle: 'Regular',
    pointSize: '14pt', autoLeading: 110,
    justification: Justification.LEFT_JUSTIFIED, firstLineIndent: '16pt',
    spaceBefore: 0, spaceAfter: 0,
    hyphenation: true, hyphenateWordsLongerThan: 6,
    hyphenateAfterFirst: 3, hyphenateBeforeLast: 3, hyphenateLadderLimit: 2,
    hyphenateCapitalizedWords: false, hyphenateLastWord: false,
    keepFirstLines: 2, keepLastLines: 2
});
var psNormal = doc.paragraphStyles.itemByName('Body Text');
doc.paragraphStyles.add({name: 'Body First', basedOn: psNormal, firstLineIndent: 0});
doc.paragraphStyles.add({name: 'Body After Break', basedOn: doc.paragraphStyles.itemByName('Body First')});
"@

RunJSX "Chapter & Section styles" @"
var doc = app.activeDocument;
doc.paragraphStyles.add({
    name: 'Chapter Number', appliedFont: 'EB Garamond', fontStyle: 'Regular',
    pointSize: '36pt', justification: Justification.LEFT_ALIGN, firstLineIndent: 0,
    spaceBefore: '16pt', spaceAfter: '120pt',
    ruleBelow: true, ruleBelowWeight: 0.5, ruleBelowOffset: '6pt',
    ruleBelowColor: doc.colors.itemByName('Black')
});
doc.paragraphStyles.add({
    name: 'Section Header', appliedFont: 'Garamond', fontStyle: 'Regular',
    pointSize: '16pt', justification: Justification.CENTER_ALIGN, firstLineIndent: 0
});
doc.paragraphStyles.add({
    name: 'Scene Break', basedOn: doc.paragraphStyles.itemByName('Body Text'), pointSize: '14pt',
    justification: Justification.CENTER_ALIGN, firstLineIndent: 0,
    spaceBefore: '12pt', spaceAfter: '12pt'
});
"@

RunJSX "Display styles" @"
var doc = app.activeDocument;
var psSH = doc.paragraphStyles.itemByName('Section Header');
doc.paragraphStyles.add({name: 'Half Title', basedOn: psSH, pointSize: '28pt'});
doc.paragraphStyles.add({name: 'Title Author', basedOn: psSH, spaceBefore: '18pt'});
doc.paragraphStyles.add({name: 'Title Photo Credit', basedOn: psSH, pointSize: '12pt', fontStyle: 'Italic', spaceBefore: '12pt'});
doc.paragraphStyles.add({name: 'Publisher', basedOn: psSH, pointSize: '10pt'});
doc.paragraphStyles.add({name: 'Dedication', basedOn: psSH, pointSize: '14pt', fontStyle: 'Italic'});
doc.paragraphStyles.add({name: 'Epigraph Quote', basedOn: psSH, pointSize: '12pt', fontStyle: 'Italic', leading: '16pt'});
doc.paragraphStyles.add({name: 'Epigraph Attribution', basedOn: psSH, pointSize: '10pt', fontStyle: 'Regular', spaceBefore: '6pt'});
doc.paragraphStyles.add({name: 'Also By Category', basedOn: psSH, pointSize: '11pt', fontStyle: 'Bold', spaceBefore: '12pt', spaceAfter: '4pt'});
doc.paragraphStyles.add({name: 'Also By Title', basedOn: psSH, pointSize: '11pt', fontStyle: 'Italic', leading: '15pt', spaceBefore: '4pt', spaceAfter: '4pt'});
doc.paragraphStyles.add({name: 'Also By Annotation', basedOn: psSH, pointSize: '9pt'});
"@

RunJSX "Matter styles" @"
var doc = app.activeDocument;
doc.paragraphStyles.add({name: 'Copyright', appliedFont: 'Garamond', pointSize: '9pt', leading: '12pt', justification: Justification.LEFT_ALIGN, firstLineIndent: 0, spaceBefore: '6pt', spaceAfter: '6pt'});
doc.paragraphStyles.add({name: 'Blurb Quote', appliedFont: 'Garamond', fontStyle: 'Italic', pointSize: '11pt', leading: '15pt', justification: Justification.LEFT_JUSTIFIED, firstLineIndent: 0, spaceBefore: '12pt', spaceAfter: 0});
doc.paragraphStyles.add({name: 'Blurb Attribution', basedOn: doc.paragraphStyles.itemByName('Blurb Quote'), fontStyle: 'Regular', pointSize: '10pt', spaceBefore: '4pt'});
doc.paragraphStyles.add({name: 'Permissions Lyric', basedOn: doc.paragraphStyles.itemByName('Blurb Quote'), spaceBefore: '10pt'});
doc.paragraphStyles.add({name: 'Permissions Attribution', appliedFont: 'Garamond', pointSize: '10pt', leading: '14pt', justification: Justification.LEFT_ALIGN, firstLineIndent: 0, spaceBefore: '2pt', spaceAfter: '6pt'});
doc.paragraphStyles.add({name: 'About Author', appliedFont: 'Garamond', pointSize: '11pt', leading: '15pt', justification: Justification.LEFT_JUSTIFIED, firstLineIndent: 0});
doc.paragraphStyles.add({name: 'Colophon', appliedFont: 'Garamond', pointSize: '10pt', leading: '14pt', justification: Justification.LEFT_ALIGN, firstLineIndent: 0});
doc.paragraphStyles.add({name: 'Page Number', appliedFont: 'Garamond', pointSize: '9pt', justification: Justification.LEFT_ALIGN, firstLineIndent: 0});
doc.paragraphStyles.add({name: 'Fin', basedOn: doc.paragraphStyles.itemByName('Body Text'), justification: Justification.CENTER_ALIGN, firstLineIndent: 0, fontStyle: 'Bold', spaceBefore: '24pt'});
"@

Write-Output "=== Stage 4: Master Pages ==="
RunJSX "Masters setup" @"
var doc = app.activeDocument;
var masterA = doc.masterSpreads[0];
masterA.baseName = 'Body';
// Page numbers
var psPN = doc.paragraphStyles.itemByName('Page Number');
var aL = masterA.pages[0];
var aR = masterA.pages[1];
var pnL = aL.textFrames.add({geometricBounds: [0.15, 0.625, 0.4, 1.125]});
pnL.parentStory.contents = SpecialCharacters.AUTO_PAGE_NUMBER;
pnL.parentStory.paragraphs[0].appliedParagraphStyle = psPN;
pnL.parentStory.paragraphs[0].justification = Justification.LEFT_ALIGN;
var pnR = aR.textFrames.add({geometricBounds: [0.15, 4.375, 0.4, 4.875]});
pnR.parentStory.contents = SpecialCharacters.AUTO_PAGE_NUMBER;
pnR.parentStory.paragraphs[0].appliedParagraphStyle = psPN;
pnR.parentStory.paragraphs[0].justification = Justification.RIGHT_ALIGN;
// Additional masters
var mB = doc.masterSpreads.add(); mB.namePrefix = 'B'; mB.baseName = 'Chapter';
var mC = doc.masterSpreads.add(); mC.namePrefix = 'C'; mC.baseName = 'Front';
var mD = doc.masterSpreads.add(); mD.namePrefix = 'D'; mD.baseName = 'Blank';
"@

Write-Output "=== Stage 5: Pages ==="
RunJSX "Add and assign pages" @'
var doc = app.activeDocument;
// Create 11 pages for front matter (indices 0-9) + first story page (index 10)
while (doc.pages.length < 11) doc.pages.add();
var mC = doc.masterSpreads.itemByName('C-Front');
var mD = doc.masterSpreads.itemByName('D-Blank');
var mA = doc.masterSpreads.itemByName('A-Body');
for (var i = 0; i < 10; i++) doc.pages[i].appliedMaster = mC;
doc.pages[7].appliedMaster = mD; // blank after dedication
doc.pages[9].appliedMaster = mD; // blank after epigraph
doc.pages[10].appliedMaster = mA; // first story page
// Enable smart text reflow so story text auto-adds pages
doc.textPreferences.smartTextReflow = true;
doc.textPreferences.addPages = AddPageOptions.END_OF_STORY;
doc.textPreferences.limitToMasterTextFrames = false;
doc.textPreferences.deleteEmptyPages = true;
'@

Write-Output "=== Stage 6: Front Matter ==="
RunJSX "Praise (p1-2)" @"
var doc = app.activeDocument;
var psSH = doc.paragraphStyles.itemByName('Section Header');
var psBQ = doc.paragraphStyles.itemByName('Blurb Quote');
var psBA = doc.paragraphStyles.itemByName('Blurb Attribution');
var pg = doc.pages[0];
var tf = pg.textFrames.add({geometricBounds: [0.5, 0.625, 7.875, 4.75]});
var praise = [
    {t: 'Advance Praise for Forty Seconds', s: 'Section Header'},
    {t: '\u201CA haunting meditation on corruption, identity, and the consequences of pressing play. Also, a zebra strangles an ostrich. I have never read anything like this, and I mean that in every possible sense.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *The New York Times Book Review*', s: 'Blurb Attribution'},
    {t: '\u201CButler delivers a masterclass in noir tension. The fact that every character is a stuffed animal somehow makes it more unsettling, not less.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *Kirkus Reviews*', s: 'Blurb Attribution'},
    {t: '\u201CForty Seconds asks the question every great detective novel must: who did it, and why? It then asks a second question, which is: why is the zebra still on his head? That question is never answered. I docked a star.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *Publishers Weekly*', s: 'Blurb Attribution'},
    {t: '\u201CI was asked to take a look at this. Just a look. That was six drafts ago.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *The Author\u2019s Mother*', s: 'Blurb Attribution'},
    {t: '\u201CGripping. Taut. Unflinching. These are all words that describe books that are not about stuffed animals photographed with a disposable camera in 1997, and yet here we are.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *The Washington Post*', s: 'Blurb Attribution'},
    {t: '\u201CThe most anticipated release of the summer. And the fall. And the winter. And twenty-seven more years after that.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *Entertainment Weekly*', s: 'Blurb Attribution'},
    {t: '\u201CI did ask for this. I just didn\u2019t think it would take twenty-nine years.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *Becky*', s: 'Blurb Attribution'},
    {t: '\u201CButler has crafted a villain so compelling, so psychologically complex, that you forget he is fourteen inches tall and filled with polyester fiberfill. The twist at the end left me staring at my own stuffed animals with suspicion.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *The Guardian*', s: 'Blurb Attribution'},
    {t: '\u201CDo NOT press play.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *Vivian Plume*', s: 'Blurb Attribution'},
    {t: '\u201CA searing work of noir fiction that takes the genre\u2019s oldest convention \u2014 the case that walks through the door \u2014 and makes it literal, in the sense that the case is a stuffed zebra and it does, technically, walk through a door. Essential reading.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *The Atlantic*', s: 'Blurb Attribution'},
    {t: '\u201CI\u2019d do anything \u2014 *anything* \u2014 to read this book again.\u201D', s: 'Blurb Quote'},
    {t: '\u2014 *Francois*', s: 'Blurb Attribution'}
];
var content = '';
for (var i = 0; i < praise.length; i++) {
    content += praise[i].t;
    if (i < praise.length - 1) content += '\r';
}
tf.contents = content;
for (var i = 0; i < tf.parentStory.paragraphs.length && i < praise.length; i++) {
    tf.parentStory.paragraphs[i].appliedParagraphStyle = doc.paragraphStyles.itemByName(praise[i].s);
}
// Overflow to page 2
if (tf.overflows) {
    var tf2 = doc.pages[1].textFrames.add({geometricBounds: [0.5, 0.75, 7.875, 4.875]});
    tf.nextTextFrame = tf2;
}
"@

RunJSX "Half title (p3)" @"
var doc = app.activeDocument;
var pg = doc.pages[2];
var tf = pg.textFrames.add({geometricBounds: [0.5, 0.75, 7.875, 4.875]});
tf.textFramePreferences.verticalJustification = VerticalJustification.CENTER_ALIGN;
tf.contents = 'Forty Seconds';
tf.parentStory.paragraphs[0].appliedParagraphStyle = doc.paragraphStyles.itemByName('Half Title');
"@

RunJSX "Also By (p4)" @"
var doc = app.activeDocument;
var pg = doc.pages[3];
var tf = pg.textFrames.add({geometricBounds: [0.5, 0.625, 7.875, 4.75]});
var lines = [
    {t: 'Also by Thomas Butler', s: 'Section Header'},
    {t: 'The Stuffed Animal Noir Cycle', s: 'Also By Category'},
    {t: 'Forty Seconds (2025)', s: 'Also By Title'},
    {t: 'The Disposable Camera Trilogy', s: 'Also By Category'},
    {t: 'Twenty-Seven Exposures (forthcoming)', s: 'Also By Title'},
    {t: 'Zero Remaining (forthcoming)', s: 'Also By Title'},
    {t: 'We Should Have Just Bought a Real Camera (forthcoming, pending funding)', s: 'Also By Title'},
    {t: 'Standalone Works', s: 'Also By Category'},
    {t: 'The Thirty-Year Turnaround: A Guide to Keeping Creative Promises on a Geologic Timescale', s: 'Also By Title'},
    {t: 'I\u2019ll Get to It: Essays on Procrastination, Written Over the Course of Three Decades, Mostly in the Last Week', s: 'Also By Title'},
    {t: 'Polyester Fiberfill: A Memoir', s: 'Also By Title'},
    {t: 'What the Zebra Saw', s: 'Also By Title'},
    {t: 'Why Is the Zebra Still on His Head: An Unanswered Question in Eight Photographs', s: 'Also By Title'},
    {t: 'One Roll Left: The Economics of Film Photography When You Are Eleven and Have No Income', s: 'Also By Title'},
    {t: 'Press Play: And Other Things You Should Not Have Done', s: 'Also By Title'},
    {t: 'The Corrective Edit: How to Ask Your Mother to \u201CJust Take a Look\u201D and Survive the Consequences', s: 'Also By Title'},
    {t: 'Quiet and Patient: Meditations on Things That Wait in Drawers for Twenty-Eight Years', s: 'Also By Title'},
    {t: 'Do NOT Read This Book \u2014 A Novel (blurbed by Vivian Plume, posthumously)', s: 'Also By Title'},
    {t: 'Children\u2019s Books', s: 'Also By Category'},
    {t: 'Francois Goes to Bed (pulled from shelves)', s: 'Also By Title'},
    {t: 'Francois Makes a Friend (pulled from shelves)', s: 'Also By Title'},
    {t: 'Francois Listens to a CD and Something Fundamentally Changes Inside Him (never shelved)', s: 'Also By Title'}
];
var content = '';
for (var i = 0; i < lines.length; i++) {
    content += lines[i].t;
    if (i < lines.length - 1) content += '\r';
}
tf.contents = content;
for (var i = 0; i < tf.parentStory.paragraphs.length && i < lines.length; i++) {
    tf.parentStory.paragraphs[i].appliedParagraphStyle = doc.paragraphStyles.itemByName(lines[i].s);
}
"@

RunJSX "Title page (p5)" @"
var doc = app.activeDocument;
var pg = doc.pages[4];
var tfT = pg.textFrames.add({geometricBounds: [2.5, 0.75, 5.0, 4.875]});
tfT.contents = 'Forty Seconds\rThomas Butler\rPhotographs by Rebecca Stewart';
tfT.parentStory.paragraphs[0].appliedParagraphStyle = doc.paragraphStyles.itemByName('Half Title');
tfT.parentStory.paragraphs[1].appliedParagraphStyle = doc.paragraphStyles.itemByName('Title Author');
tfT.parentStory.paragraphs[2].appliedParagraphStyle = doc.paragraphStyles.itemByName('Title Photo Credit');
var tfP = pg.textFrames.add({geometricBounds: [7.375, 0.75, 7.875, 4.875]});
tfP.contents = 'Disposable Camera Press';
tfP.parentStory.paragraphs[0].appliedParagraphStyle = doc.paragraphStyles.itemByName('Publisher');
"@

RunJSX "Copyright (p6)" @"
var doc = app.activeDocument;
var pg = doc.pages[5];
var tf = pg.textFrames.add({geometricBounds: [0.5, 0.625, 7.875, 4.75]});
var f = new File('C:/dev/Becky/stories/detective_noir/06.copyright.md');
f.encoding = 'UTF-8'; f.open('r'); var raw = f.read(); f.close();
raw = raw.replace(/&copy;/g, '\u00A9');
var lines = raw.split(/\r?\n/);
var content = '';
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.match(/^\s*$/)) { if (content.length > 0) content += '\r'; continue; }
    content += line + '\r';
}
content = content.replace(/\r+$/, '');
tf.contents = content;
tf.parentStory.paragraphs.everyItem().appliedParagraphStyle = doc.paragraphStyles.itemByName('Copyright');
"@

RunJSX "Dedication (p7)" @"
var doc = app.activeDocument;
var pg = doc.pages[6];
var tf = pg.textFrames.add({geometricBounds: [0.5, 0.75, 7.875, 4.875]});
tf.textFramePreferences.verticalJustification = VerticalJustification.CENTER_ALIGN;
tf.contents = '*For Becky, obviously.*';
tf.parentStory.paragraphs[0].appliedParagraphStyle = doc.paragraphStyles.itemByName('Dedication');
"@

RunJSX "Epigraph (p9)" @"
var doc = app.activeDocument;
var pg = doc.pages[8];
var tf = pg.textFrames.add({geometricBounds: [0.5, 0.75, 7.875, 4.875]});
tf.textFramePreferences.verticalJustification = VerticalJustification.CENTER_ALIGN;
tf.contents = '*Contents: one boombox, one compact disc. Status: sealed. Do not press play.*\r\u2014 Evidence locker tag, City PD, 1997';
tf.parentStory.paragraphs[0].appliedParagraphStyle = doc.paragraphStyles.itemByName('Epigraph Quote');
tf.parentStory.paragraphs[1].appliedParagraphStyle = doc.paragraphStyles.itemByName('Epigraph Attribution');
"@

Write-Output "=== Stage 7: Story Content ==="
RunJSX "Story text" @'
var doc = app.activeDocument;
var IMG_DIR = 'C:/dev/Becky/images/';

// Read story markdown
var f = new File('C:/dev/Becky/stories/detective_noir/11.forty_seconds.md');
f.encoding = 'UTF-8'; f.open('r'); var raw = f.read(); f.close();
var lines = raw.split(/\r?\n/);

// Parse into elements
var elements = [];
var curPara = [];
var inSources = false;
var skipHead = true;

function flush() {
    if (curPara.length > 0) {
        var text = curPara.join(' ');
        text = text.replace(/\[\^\w+\]/g, '');
        elements.push({type: 'text', text: text});
        curPara = [];
    }
}

for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.match(/^## Sources/)) { inSources = true; continue; }
    if (inSources) continue;
    if (line.match(/^\[\^/)) continue;
    if (skipHead) {
        if (line.match(/^# /) || line.match(/^\*Written/) || line.match(/^\*Pictures/) || line.match(/^\*Edited/)) continue;
        if (line.match(/^## \d/)) skipHead = false;
        else if (line.match(/^\s*$/)) continue;
        else continue;
    }
    if (line.match(/^\s*$/)) { flush(); continue; }
    var chM = line.match(/^## (\d+)$/);
    if (chM) { flush(); elements.push(chM[1] === '6' ? {type:'break'} : {type:'chapter', text:chM[1]}); continue; }
    if (line.match(/^---$/)) { flush(); elements.push({type:'break'}); continue; }
    var imgM = line.match(/!\[.*?\]\((.*?)\)/);
    if (imgM) { flush(); elements.push({type:'image', path: imgM[1].replace(/\.\.\/\.\.\/images\//g, IMG_DIR)}); continue; }
    if (line.indexOf('**\u2014 FIN \u2014**') >= 0) { flush(); elements.push({type:'fin', text:'\u2014 FIN \u2014'}); continue; }
    curPara.push(line);
}
flush();

// Build story text and style list — use placeholder for images
var storyText = '';
var styles = [];
var firstAfter = false;
var imagePaths = []; // track image placeholders for later placement

for (var i = 0; i < elements.length; i++) {
    var el = elements[i];
    if (el.type === 'chapter') {
        if (storyText.length > 0) storyText += '\r';
        storyText += el.text; styles.push('Chapter Number'); firstAfter = true;
    } else if (el.type === 'break') {
        if (storyText.length > 0) storyText += '\r';
        storyText += '* * *'; styles.push('Scene Break'); firstAfter = true;
    } else if (el.type === 'image') {
        if (storyText.length > 0) storyText += '\r';
        var placeholder = '\uFFFD'; // replacement char as image anchor
        storyText += placeholder; styles.push('Body First');
        imagePaths.push(el.path);
        firstAfter = true;
    } else if (el.type === 'fin') {
        if (storyText.length > 0) storyText += '\r';
        storyText += el.text; styles.push('Fin');
    } else if (el.type === 'text') {
        if (storyText.length > 0) storyText += '\r';
        storyText += el.text;
        styles.push(firstAfter ? 'Body First' : 'Body Text');
        firstAfter = false;
    }
}

// Create first story frame on page 11 (index 10)
var firstFrame = doc.pages[10].textFrames.add({
    geometricBounds: [0.5, 0.75, 7.875, 4.875]
});

// Pour text — smart text reflow will add pages as needed
firstFrame.contents = storyText;

// Apply paragraph styles
var story = firstFrame.parentStory;
for (var i = 0; i < story.paragraphs.length && i < styles.length; i++) {
    try {
        story.paragraphs[i].appliedParagraphStyle = doc.paragraphStyles.itemByName(styles[i]);
    } catch(e) {}
}

// Record how many pages story used for back matter placement
var lastFrame = story.textContainers[story.textContainers.length - 1];
var storyEndPageIndex = lastFrame.parentPage.documentOffset;
doc.insertLabel('storyEndPage', String(storyEndPageIndex));
'@

RunJSX "Place images in story" @'
var doc = app.activeDocument;

// Find all placeholder characters
app.findGrepPreferences = NothingEnum.NOTHING;
app.changeGrepPreferences = NothingEnum.NOTHING;
app.findGrepPreferences.findWhat = '\uFFFD';
var found = doc.findGrep();

// Read image paths from the markdown
var IMG_DIR = 'C:/dev/Becky/images/';
var f = new File('C:/dev/Becky/stories/detective_noir/11.forty_seconds.md');
f.encoding = 'UTF-8'; f.open('r'); var raw = f.read(); f.close();
var imgPaths = [];
var imgRe = /!\[.*?\]\((.*?)\)/g;
var m;
while ((m = imgRe.exec(raw)) !== null) {
    imgPaths.push(m[1].replace(/\.\.\/\.\.\/images\//g, IMG_DIR));
}

// Process in reverse order so indices stay valid
for (var i = found.length - 1; i >= 0; i--) {
    if (i >= imgPaths.length) continue;
    try {
        var insertPt = found[i];
        var imgFile = new File(imgPaths[i]);
        if (!imgFile.exists) continue;

        // Insert inline anchored object at the placeholder position
        var ip = insertPt.insertionPoints[0];
        var rect = ip.rectangles.add({geometricBounds: [0, 0, 3.5, 4.0]});
        rect.place(imgFile);
        rect.fit(FitOptions.PROPORTIONALLY);
        rect.fit(FitOptions.CENTER_CONTENT);

        // Remove the placeholder character (it's right after the anchored object now)
        var paraText = insertPt.contents;
        if (paraText === '\uFFFD') {
            // Select just the placeholder char and delete it
            insertPt.insertionPoints[-1].contents = '';
        }
    } catch(e) {}
}

// Update storyEndPage after image placement may have reflowed
var story = doc.stories[doc.stories.length - 1];
var lastFrame = story.textContainers[story.textContainers.length - 1];
doc.insertLabel('storyEndPage', String(lastFrame.parentPage.documentOffset));

app.findGrepPreferences = NothingEnum.NOTHING;
app.changeGrepPreferences = NothingEnum.NOTHING;
'@

Write-Output "=== Stage 8: Back Matter ==="
RunJSX "Trim excess pages + setup back matter" @'
var doc = app.activeDocument;
var storyEnd = parseInt(doc.extractLabel('storyEndPage'), 10);
// Back matter starts on next recto (right-hand page) after story ends
// In InDesign facing pages: even indices (0,2,4...) = recto, odd (1,3,5...) = verso
var nextPage = storyEnd + 1;
if (nextPage % 2 !== 0) nextPage++; // ensure recto (even index)
// Need 7 back matter pages: ack, blank, perm, perm-overflow, about, blank, colophon
var totalNeeded = nextPage + 7;
while (doc.pages.length < totalNeeded) doc.pages.add();
while (doc.pages.length > totalNeeded) {
    doc.pages[doc.pages.length - 1].remove();
}
doc.insertLabel('backMatterStart', String(nextPage));
'@

RunJSX "Acknowledgements" @'
var doc = app.activeDocument;
var bmStart = parseInt(doc.extractLabel('backMatterStart'), 10);
// Ack on first recto of back matter
var pgIdx = bmStart;
var pg = doc.pages[pgIdx];
pg.appliedMaster = doc.masterSpreads.itemByName('A-Body');
var b = (pg.side === PageSideOptions.RIGHT_HAND) ? [0.5, 0.75, 7.875, 4.875] : [0.5, 0.625, 7.875, 4.75];
var tf = pg.textFrames.add({geometricBounds: b});
var f = new File('C:/dev/Becky/stories/detective_noir/91.acknowledgements.md');
f.encoding = 'UTF-8'; f.open('r'); var raw = f.read(); f.close();
raw = raw.replace(/^##\s+.*\r?\n+/, '');
var lines = raw.split(/\r?\n/);
var content = 'Acknowledgements\r';
var curPara = [];
for (var i = 0; i < lines.length; i++) {
    if (lines[i].match(/^\s*$/)) {
        if (curPara.length > 0) { content += curPara.join(' ') + '\r'; curPara = []; }
    } else { curPara.push(lines[i]); }
}
if (curPara.length > 0) content += curPara.join(' ');
content = content.replace(/\r+$/, '');
tf.contents = content;
tf.parentStory.paragraphs[0].appliedParagraphStyle = doc.paragraphStyles.itemByName('Section Header');
var psN = doc.paragraphStyles.itemByName('Body Text');
for (var i = 1; i < tf.parentStory.paragraphs.length; i++) {
    tf.parentStory.paragraphs[i].appliedParagraphStyle = psN;
    tf.parentStory.paragraphs[i].firstLineIndent = 0;
}
'@

RunJSX "Blank + Permissions" @'
var doc = app.activeDocument;
var bmStart = parseInt(doc.extractLabel('backMatterStart'), 10);
// Blank verso after ack, then permissions on next recto
var blankIdx = bmStart + 1;
var permIdx = bmStart + 2;
doc.pages[blankIdx].appliedMaster = doc.masterSpreads.itemByName('D-Blank');
var pg = doc.pages[permIdx];
pg.appliedMaster = doc.masterSpreads.itemByName('A-Body');
var b = (pg.side === PageSideOptions.RIGHT_HAND) ? [0.5, 0.75, 7.875, 4.875] : [0.5, 0.625, 7.875, 4.75];
var tf = pg.textFrames.add({geometricBounds: b});
var f = new File('C:/dev/Becky/stories/detective_noir/93.permissions.md');
f.encoding = 'UTF-8'; f.open('r'); var raw = f.read(); f.close();
var lines = raw.split(/\r?\n/);
var content = 'Permissions\r';
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.match(/^##/) || line.match(/^---$/) || line.match(/^\s*$/)) continue;
    content += line + '\r';
}
content = content.replace(/\r+$/, '');
tf.contents = content;
tf.parentStory.paragraphs[0].appliedParagraphStyle = doc.paragraphStyles.itemByName('Section Header');
var psPL = doc.paragraphStyles.itemByName('Permissions Lyric');
var psPA = doc.paragraphStyles.itemByName('Permissions Attribution');
for (var i = 1; i < tf.parentStory.paragraphs.length; i++) {
    var txt = tf.parentStory.paragraphs[i].contents;
    if (txt.charAt(0) === '*') tf.parentStory.paragraphs[i].appliedParagraphStyle = psPL;
    else tf.parentStory.paragraphs[i].appliedParagraphStyle = psPA;
}
if (tf.overflows) {
    var permIdx2 = permIdx + 1;
    while (doc.pages.length <= permIdx2) doc.pages.add();
    var tf2 = doc.pages[permIdx2].textFrames.add({geometricBounds: [0.5, 0.625, 7.875, 4.75]});
    tf.nextTextFrame = tf2;
    doc.pages[permIdx2].appliedMaster = doc.masterSpreads.itemByName('A-Body');
}
'@

RunJSX "About Author" @'
var doc = app.activeDocument;
var bmStart = parseInt(doc.extractLabel('backMatterStart'), 10);
var pgIdx = bmStart + 4;
while (doc.pages.length <= pgIdx) doc.pages.add();
var pg = doc.pages[pgIdx];
pg.appliedMaster = doc.masterSpreads.itemByName('A-Body');
var b = (pg.side === PageSideOptions.RIGHT_HAND) ? [0.5, 0.75, 7.875, 4.875] : [0.5, 0.625, 7.875, 4.75];
var tf = pg.textFrames.add({geometricBounds: b});
var f = new File('C:/dev/Becky/stories/detective_noir/95.about_the_author.md');
f.encoding = 'UTF-8'; f.open('r'); var raw = f.read(); f.close();
raw = raw.replace(/^##\s+.*\r?\n+/, '');
raw = raw.replace(/!\[.*?\]\(.*?\)\r?\n*/g, '');
var lines = raw.split(/\r?\n/);
var content = 'About the Author\r';
var curPara = [];
for (var i = 0; i < lines.length; i++) {
    if (lines[i].match(/^\s*$/)) {
        if (curPara.length > 0) { content += curPara.join(' ') + '\r'; curPara = []; }
    } else { curPara.push(lines[i]); }
}
if (curPara.length > 0) content += curPara.join(' ');
content = content.replace(/\r+$/, '');
tf.contents = content;
tf.parentStory.paragraphs[0].appliedParagraphStyle = doc.paragraphStyles.itemByName('Section Header');
var psAA = doc.paragraphStyles.itemByName('About Author');
for (var i = 1; i < tf.parentStory.paragraphs.length; i++) {
    tf.parentStory.paragraphs[i].appliedParagraphStyle = psAA;
}
// Place author photo
try {
    var imgFile = new File('C:/dev/Becky/images/600-ice-48004.jpg');
    if (imgFile.exists) {
        var imgFrame = pg.rectangles.add({geometricBounds: [0.7, 1.5, 3.0, 3.75]});
        imgFrame.place(imgFile);
        imgFrame.fit(FitOptions.PROPORTIONALLY);
        imgFrame.fit(FitOptions.CENTER_CONTENT);
        tf.geometricBounds = [3.2, b[1], b[2], b[3]];
    }
} catch(e) {}
'@

RunJSX "Blank + Colophon" @'
var doc = app.activeDocument;
var bmStart = parseInt(doc.extractLabel('backMatterStart'), 10);
var blankIdx = bmStart + 5;
var colIdx = bmStart + 6;
while (doc.pages.length <= colIdx) doc.pages.add();
doc.pages[blankIdx].appliedMaster = doc.masterSpreads.itemByName('D-Blank');
var pg = doc.pages[colIdx];
pg.appliedMaster = doc.masterSpreads.itemByName('A-Body');
var b = (pg.side === PageSideOptions.RIGHT_HAND) ? [0.5, 0.75, 7.875, 4.875] : [0.5, 0.625, 7.875, 4.75];
var tf = pg.textFrames.add({geometricBounds: b});
var f = new File('C:/dev/Becky/stories/detective_noir/97.colophon.md');
f.encoding = 'UTF-8'; f.open('r'); var raw = f.read(); f.close();
raw = raw.replace(/^##\s+.*\r?\n+/, '');
var lines = raw.split(/\r?\n/);
var content = 'Colophon\r';
var curPara = [];
for (var i = 0; i < lines.length; i++) {
    if (lines[i].match(/^\s*$/)) {
        if (curPara.length > 0) { content += curPara.join(' ') + '\r'; curPara = []; }
    } else { curPara.push(lines[i]); }
}
if (curPara.length > 0) content += curPara.join(' ');
content = content.replace(/\r+$/, '');
tf.contents = content;
tf.parentStory.paragraphs[0].appliedParagraphStyle = doc.paragraphStyles.itemByName('Section Header');
var psCol = doc.paragraphStyles.itemByName('Colophon');
for (var i = 1; i < tf.parentStory.paragraphs.length; i++) {
    tf.parentStory.paragraphs[i].appliedParagraphStyle = psCol;
}
'@

Write-Output "=== Stage 9: GREP Formatting ==="
RunJSX "Apply italics and bold via GREP" @'
var doc = app.activeDocument;
var csB = doc.characterStyles.itemByName('Strong');
var csE = doc.characterStyles.itemByName('Emphasis');
// Bold first
app.findGrepPreferences = NothingEnum.NOTHING;
app.changeGrepPreferences = NothingEnum.NOTHING;
app.findGrepPreferences.findWhat = '\\*\\*([^*]+?)\\*\\*';
app.changeGrepPreferences.changeTo = '$1';
app.changeGrepPreferences.appliedCharacterStyle = csB;
doc.changeGrep();
// Then italic
app.findGrepPreferences = NothingEnum.NOTHING;
app.changeGrepPreferences = NothingEnum.NOTHING;
app.findGrepPreferences.findWhat = '\\*([^*]+?)\\*';
app.changeGrepPreferences.changeTo = '$1';
app.changeGrepPreferences.appliedCharacterStyle = csE;
doc.changeGrep();
// Cleanup
app.findGrepPreferences = NothingEnum.NOTHING;
app.changeGrepPreferences = NothingEnum.NOTHING;
'@

Write-Output "=== Stage 10: Save ==="
RunJSX "Save document" @"
var doc = app.activeDocument;
doc.save(new File('C:/dev/Becky/stories/detective_noir/Forty Seconds.indd'));
"@

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($app) | Out-Null
Write-Output "`n=== BUILD COMPLETE ==="
Write-Output "Document saved to: C:\dev\Becky\stories\detective_noir\Forty Seconds.indd"
