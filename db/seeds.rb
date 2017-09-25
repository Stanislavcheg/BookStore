AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
OrderStatus.create!([{ name: 'In progress' }, { name: 'Waiting for processing' },
  { name: 'In delivery' }, { name: 'Delivered' }, { name: 'Canceled' }])
Delivery.create!([{ method: 'Standard Shipping', days: "10-14 days", price: 34.22 },
  { method: 'Priority Shipping', days: "2-5 days", price: 65.49 }])
Coupon.create!([{ code: 'book_store', discount: 0.15 }])
Category.create!([{name: 'Mobile development'}, {name: 'Web development'}, {name: 'Web design'}, {name: 'Photo'}])


book1 = Book.create!(name: "Real-Life Responsive Web Design", price: 32.9, description: "Responsive design is a default approach these days, but we all still try to figure out just the right process and just the right techniques to design and build responsive websites better, smarter, faster. That’s why we created a new book — to collect the most practical techniques and experience from people who learned how to get things done right, in actual projects with actual real-world challenges.", year: 2016, height: 6.4, depth: 0.9, width: 5.0, materials: "Hardcove, glossy paper", category_id: 3)
book1.authors.create!([{first_name: 'Vitaly', last_name: 'Friedman'}, {first_name: 'Daniel', last_name: 'Mall'}])

book2 = Book.create!(name: "iPhone Basics In 30 Minutes", price: 43.45, description: "Unlock the secrets to your iPhone! How good are your iPhone skills? Whether you own an iPhone or are thinking about buying one, this guide will help you get the most out of the device and its powerful hardware, the iOS operating system, and the ever-expanding universe of iPhone apps. Written in plain English with a touch of humor and lots of screenshots, this iPhone manual covers basic features as well as hidden tricks and time-savers for the iPhone 6S, iPhone 6S Plus, iPhone SE, iPhone 7, and iPhone 7 Plus.", year: 2017, height: 5.7, depth: 0.9, width: 3.4, materials: "paper", category_id: 1)
book2.authors.create!([{first_name: 'Ian', last_name: 'Lamon'}])

book3 = Book.create!(name: "Learning Swift: Building Apps for iOS", price: 39.99, description: "Get hands-on experience with Apple’s Swift programming language by building real working apps. With this practical guide, skilled programmers with little or no knowledge of Apple development will learn how to code with Swift 2 by developing three complete, tightly linked versions of the Notes application for the OS X, iOS, and watchOS platforms. In the process, you’ll learn Swift’s fundamentals, including its syntax and features, along with the basics of the Cocoa, CocoaTouch, and WatchKit frameworks. This book teaches you how to use common design patterns for Swift, how to structure an application for Apple’s platforms, and how to submit working apps to the App Store.", year: 2014, height: 6.3, depth: 0.6, width: 4.0, materials: "Paperback", category_id: 1)
book3.authors.create!([{first_name: 'Paris', last_name: 'Buttfield-Addison'}, {first_name: 'Jon', last_name: 'Manning'}, {first_name: 'Tim', last_name: 'Nugent'}])

book4 = Book.create!(name: "Photoshop CC: Visual QuickStart Guide", price: 26.7, description: "This best-selling guide from authors Elaine Weinmann and Peter Lourekas has been the go-to tutorial and reference book for photography/design professionals and the textbook of choice in college classrooms for decades. This edition includes their trademark features of clear, concise, step-by-step instructions; hundreds of full-color images; screen captures of program features; and supplemental tips and sidebars in every chapter. Among the new CC features covered in this extensively updated guide are: Smart Sharpen, Adobe Camera Raw as filter, intelligent upscaling, multi-shape and path selection, and camera shake reduction. New and updated Photoshop CC features are clearly marked with bright red stars in both the table of contents and main text.", year: 2015, height: 6.3, depth: 0.6, width: 4.0, materials: "Paperback", category_id: 4)
book4.authors.create!([{first_name: 'Elaine', last_name: 'Weinmann'}, {first_name: 'Peter', last_name: 'Lourekas'}])

book5 = Book.create!(name: "Web Design with HTML, CSS, JavaScript and jQuery S...", price: 36.7, description: "This two-book set combines the titles HTML & CSS: Designing and Building Web Sites and JavaScript & jQuery: Interactive Front-End Development. Together these two books form an ideal platform for anyone who wants to master HTML and CSS before stepping up to JavaScript and jQuery. HTML & CSS covers structure, text, links, images, tables, forms, useful options, adding style with CSS, fonts, colors, thinking in boxes, styling lists and tables, layouts, grids, and even SEO, Google analytics, ftp, and HTML5. JavaScript & jQuery offers an excellent combined introduction to these two technologies using a clear and simple visual approach using diagrams, infographics, and photographs.", year: 2014, height: 7.3, depth: 2.6, width: 5.0, materials: "Paperback", category_id: 2)
book5.authors.create!([{first_name: 'Jon', last_name: 'Ducket'}])


book6 = Book.create!(name: "Nikon D3400 For Dummies", price: 21.9, description: "The Nikon D3400 hits stores as Nikon's most advanced entry-level DSLR camera. Along with the pixel power to deliver sharp images, it also offers tools to be instantly creative and quickly share photos to a smartphone. This book will get you up to speed on the D3400 in a flash—teaching you all the basic photography skills needed to get great shots from a DSLR camera, while also giving you clear, hands-on guidance through the D3400's specific controls. Nikon D3400 for Dummies helps you learn the ins and outs of the Nikon D3400, including how to get started right away in auto mode, get creative with scene modes, and take full control in manual mode. Filled with practical, easy-to-follow instructions, this book will help you transform from an inexperienced beginner to an advanced shutterbug whose shots could grace the cover of any popular magazine.", year: 2017, height: 7.3, depth: 2.6, width: 5.0, materials: "Paperback", category_id: 4)
book6.authors.create!([{first_name: 'Julie', last_name: 'King'}])

book7 = Book.create!(name: "Professional JavaScript for Web Developers", price: 44.2, description: "Professional JavaScript for Web Developers is the essential guide to next-level JavaScript development. Written for intermediate-to-advanced programmers, this book jumps right into the technical details to help you clean up your code and become a more sophisticated JavaScript developer. From JavaScript-specific object-oriented programming and inheritance, to combining JavaScript with HTML and other markup languages, expert instruction walks you through the fundamentals and beyond. This new fourth edition has been updated to cover ECMAScript 6 and 7 (also known as ES2015 and ES2016) and the major re-imagination and departure from ES 5.1; new frameworks and libraries, new techniques, new testing tools, and more are explained in detail for the professional developer, with a practical focus that helps you put your new skills to work on real-world projects.", year: 2017, height: 5.3, depth: 1.4, width: 4.5, materials: "Paperback", category_id: 4)
book7.authors.create!([{first_name: 'Matt', last_name: 'Frisbie'}])

book8 = Book.create!(name: "Future-Proof Web Design", price: 44.2, description: "The web is constantly changing and evolving with an increased range of devices, browsers, and standards that need to be considered in design. Web designers know they must stay sharp in order to keep up with the rapid pace of technology change. This much-needed book teaches the art of flexible and adaptable design that can work easily with new devices, technologies, and standards. You'll quickly discover how this resource stands out from the crowd as it provides you with a roadmap for ensuring that your designs are stable and flexible enough to handle whatever technology changes are coming in the future.", year: 2012, height: 6.5, depth: 2.1, width: 4.1, materials: "Paperback", category_id: 3)
book8.authors.create!([{first_name: 'Alexander', last_name: 'Dawson'}])
