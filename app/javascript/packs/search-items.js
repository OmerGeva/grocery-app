// const puppeteer = require('puppeteer');

// // document.querySelector('#keyword').addEventListener('keyup', event => {
// //   // console.log(event.target.value);
// // })


// async function scrapeProduct(url){
//   const browser  = await puppeteer.launch();
//   const page = await browser.newPage();
//   await page.goto(url);

//   const[el] = await page.$x('//*[@id="landingImage"]');
//   const src = await el.getProperty('src');
//   const srcTxt = await src.jsonValue();

//   console.log({srcTxt});
// }

// scrapeProduct('https://www.amazon.com/Fashion-Business-Minimalism-Leather-Stainless/dp/B07G123WZQ/ref=bbp_bb_939231_st_6EAt_w_12?psc=1&smid=A358LV57IGSQXD');
