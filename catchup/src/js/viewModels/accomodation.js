/*
 * Your dashboard ViewModel code goes here
 */
define(['ojs/ojcore', 'knockout', 'jquery', 'ojs/ojarraydataprovider',  'ojs/ojlistview', 'ojs/ojdialog', 'ojs/ojbutton',
        'ojs/ojinputtext', 'ojs/ojlabel', 'ojs/ojselectcombobox', 'ojs/ojinputnumber','ojs/ojradioset' ],
 function(oj, ko, $, ArrayDataProvider) {
  
    function DashboardViewModel() {
        var self = this;
      // Below are a set of the ViewModel methods invoked by the oj-module component.
      // Please reference the oj-module jsDoc for additional information.

        self.postButtonClick = function(event){
          document.getElementById('modalDialog1').open();
        };

        self.closePostDialog = function (event) {
            self.resetPostDialog();
          document.getElementById('modalDialog1').close();
        };

        self.savePost = function (event) {
            var successFunction = function(responseText){
                  self.outerListData(responseText.data);
                  self.outerListData.sort(function(a, b){
                            return b.id-a.id;
                        })
                  self.closePostDialog();
                }

                var data = {
                    "address" : self.address(),
                    "city" : self.city(),
                    "description" : self.description(),
                    "state" : self.state(),
                    "zip" : self.zip(),
                    "description" : self.description(),
                    "price" : self.price(),
                    "bed" : self.bed(),
                    "bath" : self.bath(),
                    "occupancy" : self.occupancy(),
                    "home_type" : self.apartment_type(),
                    "type" : self.type()
                }

                $.ajax({
                    url: 'http://0.0.0.0:4000/postAcommodation',
                    type: 'POST',
                    data: data
                })
                .done(function(data) {
                    successFunction(data);
                });
                return true;
        };

        self.resetPostDialog = function(){
            self.description("");
            self.address("");
            self.zip("");
            self.price("");
            self.city("");
            self.state("");
            self.occupancy();
            self.bed(0);
            self.bath(0);
            self.type("LOOKING");
            self.apartment_type("APARTMENT")
        }

        self.description = ko.observable("");
        self.address = ko.observable("");
        self.zip = ko.observable("");
        self.price = ko.observable("");
        self.city = ko.observable("");
        self.state = ko.observable("");
        self.occupancy = ko.observable();
        self.bed = ko.observable();
        self.bath = ko.observable();
        self.type = ko.observable("LOOKING");
        self.apartment_type = ko.observable("APARTMENT");


        self.outerListData = ko.observableArray();

        self.fetchData =  function(){
                var url = 'http://0.0.0.0:4000/accomodations';
                $.get(url, function(responseText) {
                    responseText.data.sort(function(a, b){
                            return b.id-a.id;
                        });
                    self.outerListData(responseText.data);
                    
                });
        }

        self.dataProvider = new ArrayDataProvider(self.outerListData, {'keyAttributes': 'id'});

        self.fetchData();

        self.currentAccomodation = ko.observable("");

        self.internalListData = ko.observableArray();

        self.gotoOuterList = function(event, ui) {
              document.getElementById("listview").currentItem = null;
              self.slide();
        };

        self.currentListItemSelectedId = ko.observable();

        self.gotoContent = function(event, data) {
                if (event.detail.value != null && event.detail.value.length > 0)
                {
                    var row = self.outerListData().find(function(item){
                        return item.id == event.detail.value;

                    });
                    self.currentListItemSelectedId(row.id);
                    self.currentAccomodation(row.description);
                    var repliesUrl = 'http://0.0.0.0:4000/accomodationReplies?accomodationId=' + row.id;
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

        self.internalListDataProvider = new ArrayDataProvider(self.internalListData, {'keyAttributes': 'id'});
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
                    url: 'http://0.0.0.0:4000/accomodationReplies',
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
    /*
     * Returns a constructor for the ViewModel so that the ViewModel is constructed
     * each time the view is displayed.  Return an instance of the ViewModel if
     * only one instance of the ViewModel is needed.
     */
    return new DashboardViewModel();
  }
);
