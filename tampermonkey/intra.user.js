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

function injectStyles() {
  $(`<style>
		.button-utils-holder {
			display: flex;
			float: right;
			justify-items: flex-end;
			gap: 2px;
		}
	</style>`).appendTo("head");
}

// Returns the object to be appended
function createProjectLinkDecoration(url) {
  const holderElement = $("<div class='button-utils-holder'></div>");
  const copyElement = $(`<a></a>`);
  const subjectElement = $("<a></a>");

  holderElement.append(copyElement, subjectElement);

  getProjectPage(url, (htmlDoc) => {
    console.log(`Got the doc for ${url}`);
    // For the repo url
    (function () {
      const gitUrlElement = htmlDoc.querySelector(
        "div.team-repo > div > input"
      );
      if (!gitUrlElement) return;

      copyElement.text("Copy repo");

      copyElement.click(function (event) {
        navigator.clipboard.writeText(htmlDoc);
        event.preventDefault();
        const original_text = $(this).text();
        $(this).text("Copied!");
        setTimeout(() => {
          $(this).text(original_text);
        }, 1000);
      });
    })();
    // For the subject
    (function () {
      const subjectLinkElement = htmlDoc.querySelector(
        "#project-show > div.project-main > div.project-summary > div:nth-child(3) > div > div:nth-child(1) > h4 > a"
      );
      if (!subjectLinkElement || subjectLinkElement.innerText != "subject.pdf")
        return;
      subjectElement.text("Subject").attr("href", subjectLinkElement.href);
      console.log(`Subject ID ${subjectLinkElement.href}`);
    })();
  });

  return holderElement;
}

function getProjectPage(url, onComplete) {
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

      onComplete(htmlDoc);
    })
    .catch(function (err) {
      // There was an error
      console.warn(`Requesting ${url} unsuccessfull`, err);
    });
}

(function () {
  "use strict";

  // When the doc is ready
  $(function () {
    injectStyles();
    const currUrl = new URL(window.location.href);
    const commandName = currUrl.searchParams.get("command");

    const urlBase = currUrl.hostname.toString().split(".")[0];

    // We are on the main page
    if (urlBase == "profile") {
      const projectsHolder = $(
        "body > div.page > div.page-content.page-content-fluid > div > div.align-top > div > div.container-fullsize.full-width.fixed-height > div > div:nth-child(5) > div > div"
      );

      const links = projectsHolder.children();

      // Copy git ID
      links.append(function (index, str) {
        const originalUrl = $(this).attr("href");
        return createProjectLinkDecoration(originalUrl);
      });
      // Subject link
      //   links.append(function (index, str) {
      //     const original_link = $(this).attr("href");

      //     const new_link = `${original_link}?command=click_subject`;

      //     return `<a style="float: right;" href="${new_link}">Subject</a>`;
      //   });

      // links.each(function (id, link) {
      //     const new_element = $(`<p>Selam sekerim</p>`)

      //     link.append(new_element)
      // })
      console.log(links);
    } else if (urlBase == "projects") {
      if (commandName == "click_subject") {
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
