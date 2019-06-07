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

            self.outerListData = ko.observableArray();

            self.fetchData =  function(){
                var url = self.type === "buySell" ? 'http://0.0.0.0:4000/market' : 'http://0.0.0.0:4000/questions?category=' + self.type;
                $.get(url, function(responseText) {
                    self.outerListData(responseText.data);

                    if(self.type === "buySell"){
                        self.outerListData.sort(function(a, b){
                            return b.id-a.id;
                        })
                    }else{
                        self.outerListData.sort(function(a, b){
                            return b.question_id-a.question_id;
                        })
                    }
                });
            }

            self.listHeading = self.parentVM.drillDownListHeading;

            self.dataProvider = self.type === "buySell" ? new ArrayDataProvider(self.outerListData, {'keyAttributes': 'id'}):
                                     new ArrayDataProvider(self.outerListData, {'keyAttributes': 'question_id'});

            self.fetchData();

            self.currentQuestion = ko.observable("");

            self.internalListData = ko.observableArray();

            self.gotoOuterList = function(event, ui) {
                document.getElementById("listview").currentItem = null;
                self.slide();
            };

            self.currentListItemSelectedId = ko.observable();

            self.gotoContent = function(event, data) {
                if (event.detail.value != null && event.detail.value.length > 0)
                {
                    if(self.type === "buySell"){
                        var row = self.outerListData().find(function(item){
                            return item.id == event.detail.value;
                        });
                        self.currentListItemSelectedId(row.id);
                        self.currentQuestion(row.description);
                        var repliesUrl = 'http://0.0.0.0:4000/marketResponse?marketId=' + row.id;
                    }else{
                        var row = self.outerListData().find(function(item){
                            return item.question_id == event.detail.value;
                        });
                        self.currentListItemSelectedId(row.question_id);
                        self.currentQuestion(row.question_description);
                        var repliesUrl = 'http://0.0.0.0:4000/replies?questionId=' + row.question_id;
                    }
                    $.get(repliesUrl, function(responseText) {
                        self.internalListData(responseText.data);
                        self.slide();
                    });
                }
            };

            self.slide = function() {
                $("#page1").toggleClass("demo-page1-hide");
                $("#page2").toggleClass("demo-page2-hide");
                $("#postButton").toggleClass("display-none-toggle");
            };

            //REGION INTERNAL DRILLED LIST

            self.internalListDataProvider = new ArrayDataProvider(self.internalListData, {'keyAttributes': 'response_id'});
            self.selectedItems = ko.observableArray([]);


            self.replyText = ko.observable("");

            self.replyToPost = function(event){
                var successFunction = function(responseText){
                  self.internalListData(responseText.data);
                  self.replyText("");
                }

                var data = {
                    "question_id" : self.currentListItemSelectedId(),
                    "reply" : self.replyText()
                }

                $.ajax({
                    url: self.type === "buySell" ? 'http://0.0.0.0:4000/marketResponse' : 'http://0.0.0.0:4000/questionResponse',
                    type: 'POST',
                    data: data
                })
                .done(function(data) {
                    successFunction(data);
                });
                return true;
            };

            var lastItemId = self.internalListData().length;


        }
        return DrillDownListVM;
    });
