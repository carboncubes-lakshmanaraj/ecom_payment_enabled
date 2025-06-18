import 'package:ecom_payment/datas/categoryandsubcat.dart';
import 'package:ecom_payment/datas/product.dart';
import 'package:flutter/material.dart';

final endDate = DateTime(
  2025,
  5,
  10,
  17,
  0,
); // May 10, 2025, 5:00 PM// replace with your real end date for deal of the day

final trendingProductDate = DateTime(2025, 5, 10); // May 10, 2025 at 00:00

final List<Category> categoryList = [
  Category(id: 1, title: 'Beauty', image: 'assets/cate/beauty.png'),
  Category(id: 2, title: 'Fashion', image: "assets/cate/fashion.png"),
  Category(id: 3, title: 'Kids', image: "assets/cate/kids.png"),
  Category(id: 4, title: 'Mens', image: "assets/cate/men.png"),
  Category(id: 5, title: 'Womens', image: "assets/cate/women.png"),
];

final subCategories = [
  SubCategory(id: 1, title: 'Footwear'),
  SubCategory(id: 2, title: 'Dress'),
  SubCategory(id: 3, title: 'Electronics'),
  SubCategory(id: 4, title: 'Accessories'),
];

List<Product> dummyProducts = [
  Product(
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    title: 'Women Printed Kurta',
    productDescrip: " Neque porro quisquam est qui dolorem ipsum quia",
    mrpPrice: 2499,
    percentageOff: 40,
    categoryIds: [1, 2],
    subCategoryId: 2,
    dealsOfTheDay: true,
    trendingProducts: false,
    additionalImages: [
      'assets/procars/kurta/one.jpg',
      'assets/procars/kurta/two.jpg',
      'assets/procars/kurta/three.jpg',
      'assets/procars/kurta/four.jpg',
    ],
    productImage: 'assets/products/kurtha.png',
  ),
  Product(
    title: 'HRX by Hrithik Roshan',
    moreinfo: '''Earliest evidence
The earliest known shoes are sagebrush bark sandals dating from approximately 7000 or 8000 BC, found in the Fort Rock Cave in the US state of Oregon in 1938.[5] The world's oldest leather shoe, made from a single piece of cowhide laced with a leather cord along seams at the front and back, was found in the Areni-1 cave complex in Armenia in 2008 and is believed to date to 3500 BC.[6][7] Ötzi the Iceman's shoes, dating to 3300 BC, featured brown bearskin bases, deerskin side panels, and a bark-string net, which pulled tight around the foot.[6] The Jotunheimen shoe was discovered in August 2006: archaeologists estimate that this leather shoe was made between 1800 and 1100 BC,[8][9] making it the oldest article of clothing discovered in Scandinavia. Sandals and other plant fiber based tools were found in Cueva de los Murciélagos in Albuñol in southern Spain in 2023, dating to approximately 7500 to 4200 BC, making them what are believed to be the oldest shoes found in Europe.[10]

It is thought that shoes may have been used long before this, but because the materials used were highly perishable, it is difficult to find evidence of the earliest footwear.[11]

Footprints suggestive of shoes or sandals due to having crisp edges, no signs of toes found and three small divots where leather tying laces/straps would have been attached have been at Garden Route National Park, Addo Elephant National Park and Goukamma Nature Reserve in South Africa.[12] These date back to between 73,000 and 136,000 BP. Consistent with the existence of such shoe is the finding of bone awls dating back to this period that could have made simple footwear.[12]''',
    productDescrip: "Neque porro quisquam est qui dolorem ipsum quia",
    mrpPrice: 4999,
    percentageOff: 50,
    subCategoryId: 1,
    categoryIds: [3],
    dealsOfTheDay: true,
    trendingProducts: false,
    additionalImages: [
      'assets/procars/shoe/one.jpg',
      'assets/procars/shoe/two.jpg',
      'assets/procars/shoe/three.jpg',
      'assets/procars/shoe/four.jpg',
    ],
    productImage: 'assets/products/nike shoe.png',
  ),
  Product(
    moreinfo:
        '''A watch is a timepiece carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. A wristwatch is designed to be worn around the wrist, attached by a watch strap or other type of bracelet, including metal bands or leather straps. A pocket watch is carried in a pocket, often attached to a chain. A stopwatch is a watch that measures intervals of time.

During most of their history, beginning in the 16th century, watches were mechanical devices, driven by clockwork, powered by winding a mainspring, and keeping time with an oscillating balance wheel. These are called mechanical watches.[1][2] In the 1960s the electronic quartz watch was invented, powered by a battery and keeping time with a vibrating quartz crystal. By the 1980s it took over most of the watch market, in what was called the quartz revolution (or the quartz crisis in Switzerland, whose renowned watch industry it decimated).[3][4] In the 2010s, smartwatches emerged, small wrist-worn computers with touchscreens, with functions that go far beyond timekeeping.

Modern watches often display the day, date, month, and year. Mechanical watches may have extra features ("complications") such as moon-phase displays and different types of tourbillon. Quartz watches often include timers, chronographs, and alarm functions. Smartwatches and more complicated electronic watches may even incorporate calculators, GPS[5] and Bluetooth technology or have heart-rate monitoring capabilities, and some use radio clock technology to regularly correct the time.

Most watches used mainly for timekeeping have quartz movements. But expensive collectible watches, valued more for their elaborate craftsmanship, aesthetic appeal, and glamorous design than for timekeeping, often have traditional mechanical movements, despite being less accurate and more expensive than their electronic counterparts.[3][4][6] As of 2019, the most expensive watch ever sold at auction was the Patek Philippe Grandmaster Chime for US31.2 million.[7]''',
    title: 'IWC Schaffhausen',
    productDescrip: "2021 Pilot's Watch 'SIHH 2019' 44mm",
    mrpPrice: 1599,
    subCategoryId: 4,
    percentageOff: 60,
    categoryIds: [2],
    dealsOfTheDay: true,
    trendingProducts: true,
    additionalImages: [
      'assets/procars/watches/one.jpg',
      'assets/procars/watches/two.jpg',
      'assets/procars/watches/three.jpg',
      'assets/procars/watches/four.jpg',
    ],
    productImage: 'assets/products/watch.png',
  ),
  Product(
    moreinfo: '''Antiquity
During the ancient period bags were utilised to carry various items including flint, tools, supplies, weapons and currency. Early examples of these bags have been uncovered in Egyptian burial sites (c. 2686–2160 BCE) and were made of leather with two straps or handles for carrying or suspending from a stick.[3] The ancient Greeks made use of leather, papyrus and linen purses known as byrsa to store coins, which is the etymological origin of the English word "purse". The emergence of money further inspired the creation of drawstring purses, most commonly hung from a belt or kept in clothing folds.

A handbag was discovered with the remains of Ötzi, who lived between 3350 and 3105 BC.[4] Whilst one of the earliest discoveries of an ornate leather purse came from Anglo-Saxon Britain, dated circa 625 CE, revealed from the burial site of King Roewald in the mounds of Sutton Hoo in Suffolk.[5][6] Although the leather had deteriorated, its gold ornaments were still intact. Inside the purse was forty gold coins and it was held in place by a gold belt buckle and golden hinged straps.[5] These features symbolised a display of opulence, making the purse part of a lavish suite of possessions.''',
    title: "Mammon Women's Handbag",
    subCategoryId: 4,
    productDescrip: "(Set of 3, Beige)",
    mrpPrice: 1999,
    percentageOff: 60,
    categoryIds: [1],
    dealsOfTheDay: false,
    trendingProducts: true,
    additionalImages: [
      'assets/procars/handbag/one.jpg',
      'assets/procars/handbag/two.jpg',
      'assets/procars/handbag/three.jpg',
      'assets/procars/handbag/four.jpg',
    ],
    productImage: 'assets/products/handbag.png',
  ),
  Product(
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    title: 'Black Winter...',
    subCategoryId: 2,
    productDescrip: " Autumn And Winter Casual cotton-padded jacket...",
    mrpPrice: 499,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/blackwinter.png',
  ),
  Product(
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    title: 'Mens Starry',
    subCategoryId: 2,
    productDescrip: " Mens Starry Sky Printed Shirt 100% Cotton Fabric",
    mrpPrice: 399,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/menshirt.png',
  ),
  Product(
    title: 'Black Dress',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 2,
    productDescrip: " Solid Black Dress for Women, Sexy Chain Shorts Ladi...",
    mrpPrice: 2000,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/blackdress.png',
  ),
  Product(
    title: 'Pink Embroide...',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 2,
    productDescrip: " EARTHEN Rose Pink Embroidered Tiered Max...",
    mrpPrice: 1900,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/pinkdress.png',
  ),
  Product(
    title: 'Flare Dress',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 2,
    productDescrip: "Antheaa Black & Rust Orange Floral Print Tiered Midi F...",
    mrpPrice: 1990,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/flaredress.png',
  ),
  Product(
    title: 'denim dress',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 2,
    productDescrip: " Blue cotton denim dress Look 2 Printed cotton dr...",
    mrpPrice: 999,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/denimdress.png',
  ),
  Product(
    title: 'Jordan Stay',
    moreinfo: '''Earliest evidence
The earliest known shoes are sagebrush bark sandals dating from approximately 7000 or 8000 BC, found in the Fort Rock Cave in the US state of Oregon in 1938.[5] The world's oldest leather shoe, made from a single piece of cowhide laced with a leather cord along seams at the front and back, was found in the Areni-1 cave complex in Armenia in 2008 and is believed to date to 3500 BC.[6][7] Ötzi the Iceman's shoes, dating to 3300 BC, featured brown bearskin bases, deerskin side panels, and a bark-string net, which pulled tight around the foot.[6] The Jotunheimen shoe was discovered in August 2006: archaeologists estimate that this leather shoe was made between 1800 and 1100 BC,[8][9] making it the oldest article of clothing discovered in Scandinavia. Sandals and other plant fiber based tools were found in Cueva de los Murciélagos in Albuñol in southern Spain in 2023, dating to approximately 7500 to 4200 BC, making them what are believed to be the oldest shoes found in Europe.[10]

It is thought that shoes may have been used long before this, but because the materials used were highly perishable, it is difficult to find evidence of the earliest footwear.[11]

Footprints suggestive of shoes or sandals due to having crisp edges, no signs of toes found and three small divots where leather tying laces/straps would have been attached have been at Garden Route National Park, Addo Elephant National Park and Goukamma Nature Reserve in South Africa.[12] These date back to between 73,000 and 136,000 BP. Consistent with the existence of such shoe is the finding of bone awls dating back to this period that could have made simple footwear.[12]''',
    subCategoryId: 1,
    productDescrip: "The classic Air Jordan 12 to create a shoe that's fres...",
    mrpPrice: 4999,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/jordanstay.png',
  ),
  Product(
    moreinfo:
        '''Accompanied refers to an object being loosely bound and accompanying a mobile host, e.g., a smartphone can be carried in a bag or pocket but can easily be misplaced.[2] Hence, mobile hosts with embedded devices such as an autonomous vehicle can appear larger than pocket-sized.

The most common size of a mobile computing device is pocket-sized, but other sizes for mobile devices exist. Mark Weiser, known as the father of ubiquitous computing,[3] referred to device sizes that are tab-sized, pad, and board sized,[4] where tabs are defined as accompanied or wearable centimeter-sized devices, e.g. smartphones, phablets and tablets are defined as hand-held decimeter-sized devices. If one changes the form of the mobile devices in terms of being non-planar, one can also have skin devices and tiny dust-sized devices.[2]

Dust refers to miniaturized devices without direct HCI interfaces, e.g., micro-electromechanical systems (MEMS), ranging from nanometers through micrometers to millimeters. See also Smart dust. Skin: fabrics based upon light emitting and conductive polymers and organic computer devices. These can be formed into more flexible non-planar display surfaces and products such as clothes and curtains, see OLED display. Also, see smart device.

Although mobility is often regarded as synonymous with having wireless connectivity, these terms are different. Not all network access by mobile users, applications, and devices needs to be via wireless networks and vice versa. Wireless access devices can be static and mobile users can move between wired and wireless hotspots such as in Internet cafés.[2] Some mobile devices can be used as mobile Internet devices to access the Internet while moving, but they do not need to do this and many phone functions or applications are still operational even while disconnected from the Internet.

What makes the mobile device unique compared to other technologies is the inherent flexibility in the hardware and software. Flexible applications include video chat, web browsing, payment systems, near field communication, audio recording etc.[5] As mobile devices become ubiquitous, there will be an increase of services which include the use of the cloud.[6] Although a common form of mobile device, a smartphone, has a display, another perhaps even more common form of smart computing device, the smart card, e.g., used as a bank card or travel card, does not have a display. This mobile device often has a CPU and memory but needs to connect or be inserted into a reader to display its internal data or state.''',
    title: 'Realme 7 ',
    subCategoryId: 3,
    productDescrip: "6 GB RAM | 64 GB ROM | Expandable Upto 256... ",
    mrpPrice: 3499,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/realme7.png',
  ),
  Product(
    moreinfo:
        '''The PlayStation 4 (PS4) is a home video game console developed by Sony Interactive Entertainment. Announced as the successor to the PlayStation 3 in February 2013, it was launched on November 15, 2013, in North America, November 29, 2013, in Europe, South America, and Australia, and on February 22, 2014, in Japan. A console of the eighth generation, it competes with Microsoft's Xbox One and Nintendo's Wii U and Switch.

Moving away from the more complex Cell microarchitecture of its predecessor, the console features an APU from AMD built upon the x86-64 architecture, which can theoretically peak at 1.84 teraflops; AMD stated that it was the "most powerful" APU it had developed to date. The PlayStation 4 places an increased emphasis on social interaction and integration with other devices and services, including the ability to play games off-console on PlayStation Vita and other supported devices ("Remote Play"), the ability to stream gameplay online or to friends, with them controlling gameplay remotely ("Share Play"). The console's controller was also redesigned and improved over the PlayStation 3, with updated buttons and analog sticks, and an integrated touchpad among other changes. The console also supports HDR10 high-dynamic-range video and playback of 4K resolution multimedia.

The PlayStation 4 was released to critical acclaim, with critics praising Sony for acknowledging its consumers' needs, embracing independent game development, and for not imposing the restrictive digital rights management schemes like those originally announced by Microsoft for the Xbox One. Critics and third-party studios, before its launch, also praised the capabilities of the PlayStation 4 in comparison to its competitors. Heightened demand also helped Sony top global console sales. In September 2016, the console was refreshed with a new, smaller revision, popularly referred to as the "Slim" model, as well as a high-end version called the PlayStation 4 Pro, which features an upgraded GPU and a higher CPU clock rate to support enhanced performance and 4K resolution in supported games. By October 2019, PS4 had become the second best-selling PlayStation console of all time, behind the PlayStation 2. Its successor, the PlayStation 5, was released in November 2020; the PS4 continues to be produced as of 2025.[11]''',
    title: 'Sony PS4',
    subCategoryId: 3,
    productDescrip: "Sony PS4 Console, 1TB Slim with 3 Games: Gran Turis... ",
    mrpPrice: 1999,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/sonyps4.png',
  ),
  Product(
    title: 'Black Jacket 12...',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    productDescrip: "This warm and comfortable jacket is great for learni... ",
    mrpPrice: 2999,
    subCategoryId: 2,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/blackjacket.png',
  ),
  Product(
    moreinfo:
        '''A camera is an instrument used to capture and store images and videos, either digitally via an electronic image sensor, or chemically via a light-sensitive material such as photographic film. As a pivotal technology in the fields of photography and videography, cameras have played a significant role in the progression of visual arts, media, entertainment, surveillance, and scientific research. The invention of the camera dates back to the 19th century and has since evolved with advancements in technology, leading to a vast array of types and models in the 21st century.

Cameras function through a combination of multiple mechanical components and principles. These include exposure control, which regulates the amount of light reaching the sensor or film; the lens, which focuses the light; the viewfinder, which allows the user to preview the scene; and the film or sensor, which captures the image.

Several types of camera exist, each suited to specific uses and offering unique capabilities. Single-lens reflex (SLR) cameras provide real-time, exact imaging through the lens. Large-format and medium-format cameras offer higher image resolution and are often used in professional and artistic photography. Compact cameras, known for their portability and simplicity, are popular in consumer photography. Rangefinder cameras, with separate viewing and imaging systems, were historically widely used in photojournalism. Motion picture cameras are specialized for filming cinematic content, while digital cameras, which became prevalent in the late 20th and early 21st century, use electronic sensors to capture and store images.

The rapid development of smartphone camera technology in the 21st century has blurred the lines between dedicated cameras and multifunctional devices, as the smartphone camera is easier to use, profoundly influencing how society creates, shares, and consumes visual content.''',
    title: 'D7200 Digital C...',
    subCategoryId: 3,
    productDescrip: "D7200 Digital Camera (Nikon) In New Area... ",
    mrpPrice: 26999,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/D7200digitalcamera.png',
  ),
  Product(
    title: 'men’s & boys s...',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 1,
    productDescrip: "George Walker Derby Brown Formal Shoes ",
    mrpPrice: 999,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/menbrownshoe.png',
  ),
  Product(
    moreinfo:
        '''Nutrition is the biochemical and physiological process by which an organism uses food to support its life. It provides organisms with nutrients, which can be metabolized to create energy and chemical structures. Failure to obtain the required amount of nutrients causes malnutrition. Nutritional science is the study of nutrition, though it typically emphasizes human nutrition.

The type of organism determines what nutrients it needs and how it obtains them. Organisms obtain nutrients by consuming organic matter, consuming inorganic matter, absorbing light, or some combination of these. Some can produce nutrients internally by consuming basic elements, while some must consume other organisms to obtain pre-existing nutrients. All forms of life require carbon, energy, and water as well as various other molecules. Animals require complex nutrients such as carbohydrates, lipids, and proteins, obtaining them by consuming other organisms. Humans have developed agriculture and cooking to replace foraging and advance human nutrition. Plants acquire nutrients through the soil and the atmosphere. Fungi absorb nutrients around them by breaking them down and absorbing them through the mycelium.''',
    title: 'Muscle Blaze...',
    subCategoryId: 4,
    productDescrip: "NUTRITIONAL POWERHOUSE: MuscleBl... ",
    mrpPrice: 3900,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/mbmuslei.png',
  ),
];

List<Product> wishlistProducts = [
  Product(
    title: 'Black Winter...',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 2,
    productDescrip: " Autumn And Winter Casual cotton-padded jacket...",
    mrpPrice: 499,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/blackwinter.png',
  ),
  Product(
    title: 'Mens Starry',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 2,
    productDescrip: " Mens Starry Sky Printed Shirt 100% Cotton Fabric",
    mrpPrice: 399,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/menshirt.png',
  ),
  Product(
    title: 'Black Dress',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 2,
    productDescrip: " Solid Black Dress for Women, Sexy Chain Shorts Ladi...",
    mrpPrice: 2000,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/blackdress.png',
  ),
  Product(
    title: 'Pink Embroide...',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 2,
    productDescrip: " EARTHEN Rose Pink Embroidered Tiered Max...",
    mrpPrice: 1900,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/pinkdress.png',
  ),
  Product(
    title: 'Flare Dress',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 2,
    productDescrip: "Antheaa Black & Rust Orange Floral Print Tiered Midi F...",
    mrpPrice: 1990,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/flaredress.png',
  ),
  Product(
    title: 'denim dress',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 2,
    productDescrip: " Blue cotton denim dress Look 2 Printed cotton dr...",
    mrpPrice: 999,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/denimdress.png',
  ),
  Product(
    title: 'Jordan Stay',
    moreinfo: '''Earliest evidence
The earliest known shoes are sagebrush bark sandals dating from approximately 7000 or 8000 BC, found in the Fort Rock Cave in the US state of Oregon in 1938.[5] The world's oldest leather shoe, made from a single piece of cowhide laced with a leather cord along seams at the front and back, was found in the Areni-1 cave complex in Armenia in 2008 and is believed to date to 3500 BC.[6][7] Ötzi the Iceman's shoes, dating to 3300 BC, featured brown bearskin bases, deerskin side panels, and a bark-string net, which pulled tight around the foot.[6] The Jotunheimen shoe was discovered in August 2006: archaeologists estimate that this leather shoe was made between 1800 and 1100 BC,[8][9] making it the oldest article of clothing discovered in Scandinavia. Sandals and other plant fiber based tools were found in Cueva de los Murciélagos in Albuñol in southern Spain in 2023, dating to approximately 7500 to 4200 BC, making them what are believed to be the oldest shoes found in Europe.[10]

It is thought that shoes may have been used long before this, but because the materials used were highly perishable, it is difficult to find evidence of the earliest footwear.[11]

Footprints suggestive of shoes or sandals due to having crisp edges, no signs of toes found and three small divots where leather tying laces/straps would have been attached have been at Garden Route National Park, Addo Elephant National Park and Goukamma Nature Reserve in South Africa.[12] These date back to between 73,000 and 136,000 BP. Consistent with the existence of such shoe is the finding of bone awls dating back to this period that could have made simple footwear.[12]''',
    subCategoryId: 1,
    productDescrip: "The classic Air Jordan 12 to create a shoe that's fres...",
    mrpPrice: 4999,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/jordanstay.png',
  ),
  Product(
    moreinfo:
        '''Accompanied refers to an object being loosely bound and accompanying a mobile host, e.g., a smartphone can be carried in a bag or pocket but can easily be misplaced.[2] Hence, mobile hosts with embedded devices such as an autonomous vehicle can appear larger than pocket-sized.

The most common size of a mobile computing device is pocket-sized, but other sizes for mobile devices exist. Mark Weiser, known as the father of ubiquitous computing,[3] referred to device sizes that are tab-sized, pad, and board sized,[4] where tabs are defined as accompanied or wearable centimeter-sized devices, e.g. smartphones, phablets and tablets are defined as hand-held decimeter-sized devices. If one changes the form of the mobile devices in terms of being non-planar, one can also have skin devices and tiny dust-sized devices.[2]

Dust refers to miniaturized devices without direct HCI interfaces, e.g., micro-electromechanical systems (MEMS), ranging from nanometers through micrometers to millimeters. See also Smart dust. Skin: fabrics based upon light emitting and conductive polymers and organic computer devices. These can be formed into more flexible non-planar display surfaces and products such as clothes and curtains, see OLED display. Also, see smart device.

Although mobility is often regarded as synonymous with having wireless connectivity, these terms are different. Not all network access by mobile users, applications, and devices needs to be via wireless networks and vice versa. Wireless access devices can be static and mobile users can move between wired and wireless hotspots such as in Internet cafés.[2] Some mobile devices can be used as mobile Internet devices to access the Internet while moving, but they do not need to do this and many phone functions or applications are still operational even while disconnected from the Internet.

What makes the mobile device unique compared to other technologies is the inherent flexibility in the hardware and software. Flexible applications include video chat, web browsing, payment systems, near field communication, audio recording etc.[5] As mobile devices become ubiquitous, there will be an increase of services which include the use of the cloud.[6] Although a common form of mobile device, a smartphone, has a display, another perhaps even more common form of smart computing device, the smart card, e.g., used as a bank card or travel card, does not have a display. This mobile device often has a CPU and memory but needs to connect or be inserted into a reader to display its internal data or state.''',
    title: 'Realme 7 ',
    subCategoryId: 3,
    productDescrip: "6 GB RAM | 64 GB ROM | Expandable Upto 256... ",
    mrpPrice: 3499,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/realme7.png',
  ),
  Product(
    moreinfo:
        '''The PlayStation 4 (PS4) is a home video game console developed by Sony Interactive Entertainment. Announced as the successor to the PlayStation 3 in February 2013, it was launched on November 15, 2013, in North America, November 29, 2013, in Europe, South America, and Australia, and on February 22, 2014, in Japan. A console of the eighth generation, it competes with Microsoft's Xbox One and Nintendo's Wii U and Switch.

Moving away from the more complex Cell microarchitecture of its predecessor, the console features an APU from AMD built upon the x86-64 architecture, which can theoretically peak at 1.84 teraflops; AMD stated that it was the "most powerful" APU it had developed to date. The PlayStation 4 places an increased emphasis on social interaction and integration with other devices and services, including the ability to play games off-console on PlayStation Vita and other supported devices ("Remote Play"), the ability to stream gameplay online or to friends, with them controlling gameplay remotely ("Share Play"). The console's controller was also redesigned and improved over the PlayStation 3, with updated buttons and analog sticks, and an integrated touchpad among other changes. The console also supports HDR10 high-dynamic-range video and playback of 4K resolution multimedia.

The PlayStation 4 was released to critical acclaim, with critics praising Sony for acknowledging its consumers' needs, embracing independent game development, and for not imposing the restrictive digital rights management schemes like those originally announced by Microsoft for the Xbox One. Critics and third-party studios, before its launch, also praised the capabilities of the PlayStation 4 in comparison to its competitors. Heightened demand also helped Sony top global console sales. In September 2016, the console was refreshed with a new, smaller revision, popularly referred to as the "Slim" model, as well as a high-end version called the PlayStation 4 Pro, which features an upgraded GPU and a higher CPU clock rate to support enhanced performance and 4K resolution in supported games. By October 2019, PS4 had become the second best-selling PlayStation console of all time, behind the PlayStation 2. Its successor, the PlayStation 5, was released in November 2020; the PS4 continues to be produced as of 2025.[11]''',
    title: 'Sony PS4',
    subCategoryId: 3,
    productDescrip: "Sony PS4 Console, 1TB Slim with 3 Games: Gran Turis... ",
    mrpPrice: 1999,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/sonyps4.png',
  ),
  Product(
    title: 'Black Jacket 12...',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    productDescrip: "This warm and comfortable jacket is great for learni... ",
    mrpPrice: 2999,
    subCategoryId: 2,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/blackjacket.png',
  ),
  Product(
    moreinfo:
        '''A camera is an instrument used to capture and store images and videos, either digitally via an electronic image sensor, or chemically via a light-sensitive material such as photographic film. As a pivotal technology in the fields of photography and videography, cameras have played a significant role in the progression of visual arts, media, entertainment, surveillance, and scientific research. The invention of the camera dates back to the 19th century and has since evolved with advancements in technology, leading to a vast array of types and models in the 21st century.

Cameras function through a combination of multiple mechanical components and principles. These include exposure control, which regulates the amount of light reaching the sensor or film; the lens, which focuses the light; the viewfinder, which allows the user to preview the scene; and the film or sensor, which captures the image.

Several types of camera exist, each suited to specific uses and offering unique capabilities. Single-lens reflex (SLR) cameras provide real-time, exact imaging through the lens. Large-format and medium-format cameras offer higher image resolution and are often used in professional and artistic photography. Compact cameras, known for their portability and simplicity, are popular in consumer photography. Rangefinder cameras, with separate viewing and imaging systems, were historically widely used in photojournalism. Motion picture cameras are specialized for filming cinematic content, while digital cameras, which became prevalent in the late 20th and early 21st century, use electronic sensors to capture and store images.

The rapid development of smartphone camera technology in the 21st century has blurred the lines between dedicated cameras and multifunctional devices, as the smartphone camera is easier to use, profoundly influencing how society creates, shares, and consumes visual content.''',
    title: 'D7200 Digital C...',
    subCategoryId: 3,
    productDescrip: "D7200 Digital Camera (Nikon) In New Area... ",
    mrpPrice: 26999,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/D7200digitalcamera.png',
  ),
  Product(
    title: 'men’s & boys s...',
    moreinfo:
        '''In the 11th century, women in Europe wore loose garments that were similar in shape to the tunics worn by men.[7] Sleeves varied in fit and length, and hemlines fell below the knees, most often reaching the ankle or ground.[7] These dresses were worn over ankle-length chemise garments.[7] As the century progressed, these dresses featured a tighter fit on the arms and upper body.[7] The tighter fit was achieved by making slits to the waist and in the sleeves that were laced closed to fit the figure.[8] Laces were gradually replaced by buttons.[8] By the end of the 11th century, sleeves widened with cuffs sometimes reaching several feet in circumference.[8] This style remained popular into the 13th century, although the sleeves once again became more fitted.[8]

In the 13th and 14th centuries, a similar dress known as a cote-hardie came into fashion.[9][10] This garment was closed down the front of the bodice with buttons that extended to the hip; this resulted in a dress that was more fitted through the hip rather than just to the waist.[9] These dresses also often featured decorative elements such as long strips of cloth around the elbow known as tippets.[9]

In the 15th century, houppelandes and gowns became popular. Houppelandes were full-cut, floor-length dresses with high collars and full sleeves.[11] Gowns were also long dresses, but they had open necklines, a closer-fitted bodice, and sleeves that became more fitted as the century progressed.[12] Both houppelandes and gowns were often belted just below the bust.[12]''',
    subCategoryId: 1,
    productDescrip: "George Walker Derby Brown Formal Shoes ",
    mrpPrice: 999,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/menbrownshoe.png',
  ),
  Product(
    moreinfo:
        '''Nutrition is the biochemical and physiological process by which an organism uses food to support its life. It provides organisms with nutrients, which can be metabolized to create energy and chemical structures. Failure to obtain the required amount of nutrients causes malnutrition. Nutritional science is the study of nutrition, though it typically emphasizes human nutrition.

The type of organism determines what nutrients it needs and how it obtains them. Organisms obtain nutrients by consuming organic matter, consuming inorganic matter, absorbing light, or some combination of these. Some can produce nutrients internally by consuming basic elements, while some must consume other organisms to obtain pre-existing nutrients. All forms of life require carbon, energy, and water as well as various other molecules. Animals require complex nutrients such as carbohydrates, lipids, and proteins, obtaining them by consuming other organisms. Humans have developed agriculture and cooking to replace foraging and advance human nutrition. Plants acquire nutrients through the soil and the atmosphere. Fungi absorb nutrients around them by breaking them down and absorbing them through the mycelium.''',
    title: 'Muscle Blaze...',
    subCategoryId: 4,
    productDescrip: "NUTRITIONAL POWERHOUSE: MuscleBl... ",
    mrpPrice: 3900,
    percentageOff: 40,
    categoryIds: [1, 2],
    dealsOfTheDay: false,
    trendingProducts: false,
    productImage: 'assets/wishlist/mbmuslei.png',
  ),
];
