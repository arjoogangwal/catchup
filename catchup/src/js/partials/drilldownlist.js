/**
 * DrillDownList View Model
 */

define(
    [ 'ojs/ojcore', 'knockout', 'jquery','ojs/ojarraydataprovider', 'partials/drilldownlist', 'ojs/ojknockout', 'ojs/ojdialog',
      'ojs/ojlistview', 'ojs/ojbutton','ojs/ojinputtext', 'ojs/ojlabel' ],
    function(oj, ko, $, ArrayDataProvider) {

        "use strict";

        function DrillDownListVM(params, type) {

            // Make certain this function is called as a constructor.
            // This is naturally the case when called by ojModule.
            if (!(this instanceof DrillDownListVM)) {
                return new DrillDownListVM();
            }

            var self = this; // this == ViewModel instance

            self.parentVM = params;

            self.type = type;

            var data = [{id: 0, name: 'Potential cat names', date: 'Apr 30', content: {"id": 1, "description": "Milk",
                    "address": "2147 Newhall Street", "city": "Santa Clara", "state": "CA", "zipcode": "95050", "condition": "Good", "price": "$2400"}},
                {id: 1, name: 'Todo list for work', date: 'Apr 29', content: {"id": 1, "description": "Milk",
                        "address": "2147 Newhall Street", "city": "Santa Clara", "state": "CA", "zipcode": "95050", "condition": "Good", "price": "$2400"}},
                {id: 2, name: 'Chicken recipes', date: 'Apr 15', content: {"id": 1, "description": "Milk",
                        "address": "2147 Newhall Street", "city": "Santa Clara", "state": "CA", "zipcode": "95050", "condition": "Good", "price": "$2400"}},
                {id: 3, name: 'Running routes', date: 'Apr 3', content: {"id": 1, "description": "Milk",
                        "address": "2147 Newhall Street", "city": "Santa Clara", "state": "CA", "zipcode": "95050", "condition": "Good", "price": "$2400"}},
                {id: 4, name: 'Groceries', date: 'Apr 1', content: {"id": 1, "description": "Milk",
                        "address": "2147 Newhall Street", "city": "Santa Clara", "state": "CA", "zipcode": "95050", "condition": "Good", "price": "$2400"}},
                {id: 5, name: 'Party guest list', date: 'Mar 29', content: {"id": 1, "description": "Milk",
                        "address": "2147 Newhall Street", "city": "Santa Clara", "state": "CA", "zipcode": "95050", "condition": "Good", "price": "$2400"}},
                {id: 6, name: 'Weekend projects', date: 'Mar 2', content: {"id": 1, "description": "Milk",
                        "address": "2147 Newhall Street", "city": "Santa Clara", "state": "CA", "zipcode": "95050", "condition": "Good", "price": "$2400"}}
            ];
            self.dataProvider = new ArrayDataProvider(data,
                                                      {keys:data.map(function(value) {
                                                              return value.id;
                                                          })});
            self.content = ko.observable("");

            self.gotoList = function(event, ui) {
                document.getElementById("listview").currentItem = null;
                self.slide();
            };

            self.currentListItemSelectedId = ko.observable();

            self.gotoContent = function(event) {
                if (event.detail.value != null && event.detail.value.length > 0)
                {
                    var row = data[event.detail.value];
                    self.content(row.content);
                    self.currentListItemSelectedId(row.id);
                    self.slide();
                }
            };

            self.slide = function() {
                $("#page1").toggleClass("demo-page1-hide");
                $("#page2").toggleClass("demo-page2-hide");
                $("#postButton").toggleClass("display-none-toggle");
            };

            //REGION INTERNAL DRILLED LIST


            self.allItems = ko.observableArray([{"id": 1, "description": "Milk",
                "address": "2147 Newhall Street", "city": "Santa Clara", "state": "CA", "zipcode": "95050", "condition": "Good", "price": "$2400"},
                                                   {"id": 2, "description": "Flour",
                                                       "address": "2147 Newhall Street", "city": "Santa Clara", "state": "CA", "zipcode": "95050", "condition": "Good", "price": "$2400"},
                                                   {"id": 3, "description": "Sugar",
                                                       "address": "2147 Newhall Street", "city": "Santa Clara", "state": "CA", "zipcode": "95050", "condition": "Good", "price": "$2400"},
                                                   {"id": 4, "description": "Vanilla Extract", "address": "Milk",
                                                       "city": "Milk", "state": "Milk", "zipcode": "Milk", "condition": "Milk", "price": "Milk"}
                                               ]);

            self.internalListDataProvider = new ArrayDataProvider(self.allItems, {'keyAttributes': 'id'});
            self.selectedItems = ko.observableArray([]);

            self.replyToPost = function(event){
                // document.getElementById('modalDialog1').open();
            };

            var lastItemId = self.allItems().length;


        }
        return DrillDownListVM;
    });
