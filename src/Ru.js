'use strict';

var request = require('request');
var cheerio = require('cheerio');

var URL_MENU = "http://proap.ufabc.edu.br/nutricao-e-restaurantes-universitarios/cardapio-semanal";
var DAY_IDX_TO_KEY = ["mon", "tue", "wed", "thu", "fri", "sat"];
var DISH_IDX_TO_KEY = ["lunch", "diner", "veggie", "garrison", "salad", "dessert"];

exports.thisWeek = function thisWeek() {
    var menu = {};
    request(URL_MENU, function (err, res, body) {
        if (err) {
            // TODO
        } else {
            var $ = cheerio.load(body);
            var test = $(".cardapio-semanal > table")[0].children[0].next.children.filter(function (x) {
                return x.name == "tr";
            });

            menu["sun"] = {};
            DISH_IDX_TO_KEY.forEach(function (x) {
                return menu["sun"][x] = "-";
            });
            for (var i = 1; i < test.length; i += 2) {
                var dx = DAY_IDX_TO_KEY[(i + 1) / 2 - 1];
                menu[dx] = {};

                var table = test[i].children[1].children[0].next.children;

                for (var j = 1; j < table.length; j += 2) {
                    var mx = DISH_IDX_TO_KEY[(j + 1) / 2 - 1];
                    menu[dx][mx] = table[j].children[1].data.replace(': ', '');
                }
            }
            Promise.resolve(menu);
        }
    });
}
