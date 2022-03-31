
(function () {
    'use strict';

    const input = $("#main > div.w3-responsive > table > tbody > tr:nth-child(1) > th:nth-child(2)")
    const table = $("#main > div.w3-responsive > table > tbody")

    input.html("<input/>")

    input.on("keyup", function () {
        const value = $(this).val()
        table.children("tr").toggle()
    })
})();