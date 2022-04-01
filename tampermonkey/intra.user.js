// ==UserScript==
// @name         42 Intra
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       ykimirti
// @match        https://*.intra.42.fr/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=google.com
// @grant        none
// Copy
// ==/UserScript==

function getProjectGitUrl(url, onComplete) {
  console.log(`Getting ${url}`);
  fetch(url, {
    headers: {
      accept:
        "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
      "accept-language": "tr-TR,tr;q=0.9,en-US;q=0.8,en;q=0.7,fr;q=0.6",
      "cache-control": "max-age=0",
      "if-none-match": 'W/"86142865d583c56c820695657d459cc9"',
      "sec-ch-ua":
        '" Not;A Brand";v="99", "Google Chrome";v="91", "Chromium";v="91"',
      "sec-ch-ua-mobile": "?0",
      "sec-fetch-dest": "document",
      "sec-fetch-mode": "navigate",
      "sec-fetch-site": "same-site",
      "sec-fetch-user": "?1",
      "upgrade-insecure-requests": "1",
    },
    referrer: "https://profile.intra.42.fr/",
    referrerPolicy: "strict-origin-when-cross-origin",
    body: null,
    method: "GET",
    mode: "cors",
    credentials: "include",
  })
    .then(function (response) {
      return response.text();
    })
    .then(function (html) {
      console.log(`Success getting ${url}`);
      // SUCCESSS HERE
      var parser = new DOMParser();
      var htmlDoc = parser.parseFromString(html, "text/html");

      const gitUrlElement = htmlDoc.querySelector(
        "div.team-repo > div > input"
      );
      if (!gitUrlElement) return;

      console.log(gitUrlElement.value);

      // Execute the callback function
      if (onComplete) onComplete(gitUrlElement.value);
    })
    .catch(function (err) {
      // There was an error
      console.warn(`Requesting ${url} unsuccessfull`, err);
    });
}

(function () {
  "use strict";

  $(function () {
    console.log(window.location.href);

    const url = new URL(window.location.href);
    const command_name = url.searchParams.get("command");

    const url_base = url.hostname.toString().split(".")[0];

    if (url_base == "profile") {
      const project_item = $(
        "body > div.page > div.page-content.page-content-fluid > div > div.align-top > div > div.container-fullsize.full-width.fixed-height > div > div:nth-child(5) > div > div"
      );

      //project_item.children().css("background-color", "red")
      const links = project_item.children();

      const new_obj = $("<a>Heloo!</a>");

      // Copy git ID
      links.append(function (index, str) {
        const original_link = $(this).attr("href");

        const new_object = $(
          `<a style="float: right; margin-left: 5px;">Copy URL</a>`
        );

        const new_link = getProjectGitUrl(original_link, (gitUrl) => {
          new_object.text("NAJS");

          new_object.click(function (event) {
            navigator.clipboard.writeText(gitUrl);
            event.preventDefault();
            const original_text = $(this).text();
            $(this).text("Copied!");
            setTimeout(() => {
              $(this).text(original_text);
            }, 1000);
          });
        });

        return new_object;
      });
      // Subject link
      links.append(function (index, str) {
        const original_link = $(this).attr("href");

        const new_link = `${original_link}?command=click_subject`;

        return `<a style="float: right;" href="${new_link}">Subject</a>`;
      });

      // links.each(function (id, link) {
      //     const new_element = $(`<p>Selam sekerim</p>`)

      //     link.append(new_element)
      // })
      console.log(links);
    } else if (url_base == "projects") {
      if (command_name == "click_subject") {
        const subject_link = $(
          "#project-show > div.project-main > div.project-summary > div:nth-child(3) > div > div > h4 > a"
        );
        //subject_link.attr("target", "")
        subject_link[0].click();

        $(
          "body > div.main-navbar > div.main-navbar-left > div > a > img"
        )[0].click();
      }
    }
  });
})();
