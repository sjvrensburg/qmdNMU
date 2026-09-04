$if(assessment)$
#show: body => nmu-assessment(
$if(title)$
  title: [$title$],
$endif$
$if(module-name)$
  module-name: [$module-name$],
$endif$
$if(module-code)$
  module-code: [$module-code$],
$endif$
$if(examiner)$
  examiner: [$examiner$],
$endif$
$if(duration)$
  duration: [$duration$],
$endif$
$if(assessment-date)$
  date: [$assessment-date$],
$endif$
$if(total-marks)$
  total-marks: [$total-marks$],
$endif$
$if(instructions)$
  instructions: [$instructions$],
$endif$
$if(solutions)$
  solutions: true,
$endif$
$if(monochrome)$
  monochrome: true,
$endif$
$if(brand-font)$
  brand-font: "$brand-font$",
$endif$
$if(body-size)$
  body-size: $body-size$,
$endif$
  body,
)
$elseif(lecture-notes)$
#show: body => nmu-notes(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(by-author)$
  author: [$for(by-author)$$it.name.literal$$sep$, $endfor$],
$endif$
$if(notes-date)$
  date: [$notes-date$],
$endif$
$if(module-code)$
  module-code: [$module-code$],
$endif$
$if(toc)$
  toc: true,
$endif$
$if(brand-font)$
  brand-font: "$brand-font$",
$endif$
  body,
)
$elseif(poster)$
#show: body => nmu-poster(
$if(title)$
  title: [$title$],
$endif$
$if(by-author)$
  author: [$for(by-author)$$it.name.literal$$sep$, $endfor$],
$endif$
$if(affiliation)$
  affiliation: [$affiliation$],
$endif$
$if(poster-cols)$
  cols: $poster-cols$,
$endif$
$if(footer-url)$
  footer-url: [$footer-url$],
$endif$
$if(brand-font)$
  brand-font: "$brand-font$",
$endif$
  body,
)
$elseif(slides)$
#show: body => nmu-slides(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(by-author)$
  author: [$for(by-author)$$it.name.literal$$sep$, $endfor$],
$endif$
$if(institute)$
  institute: [$institute$],
$endif$
$if(slide-date)$
  date: [$slide-date$],
$endif$
$if(aspect)$
  aspect: "$aspect$",
$endif$
$if(cover-image)$
  cover-image: "$cover-image$",
$endif$
$if(brand-font)$
  brand-font: "$brand-font$",
$endif$
  body,
)
$elseif(letter)$
#show: body => nmu-letter(
$if(campus)$
  campus: [$campus$],
$endif$
$if(school)$
  school: [$school$],
$endif$
$if(tel)$
  tel: [$tel$],
$endif$
$if(fax)$
  fax: [$fax$],
$endif$
$if(email)$
  email: "$email$",
$endif$
$if(ref)$
  ref: [$ref$],
$endif$
$if(contact)$
  contact: [$contact$],
$endif$
$if(letter-date)$
  date: [$letter-date$],
$endif$
$if(to)$
  to: [$to$],
$endif$
$if(salutation)$
  salutation: [$salutation$],
$endif$
$if(closing)$
  closing: [$closing$],
$endif$
$if(signature)$
  signature: [$signature$],
$endif$
$if(signature-title)$
  signature-title: [$signature-title$],
$endif$
$if(brand-font)$
  brand-font: "$brand-font$",
$endif$
  body,
)
$else$
#show: body => nmu-moduleguide(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(faculty)$
  faculty: [$faculty$],
$endif$
$if(hashtag)$
  hashtag: [$hashtag$],
$endif$
$if(module-code)$
  module-code: [$module-code$],
$endif$
$if(module-name)$
  module-name: [$module-name$],
$endif$
$if(qualification)$
  qualification: [$qualification$],
$endif$
$if(campus)$
  campus: [$campus$],
$endif$
$if(department)$
  department: [$department$],
$endif$
$if(lecturer)$
  lecturer: [$lecturer$],
$endif$
$if(year)$
  year: [$year$],
$endif$
$if(cover-image)$
  cover-image: "$cover-image$",
$endif$
$if(brand-font)$
  brand-font: "$brand-font$",
$endif$
  body,
)
$endif$
