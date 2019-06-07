/*
 * Your dashboard ViewModel code goes here
 */
define(['ojs/ojcore', 'knockout', 'jquery','ojs/ojarraydataprovider', 'partials/drilldownlist', 'ojs/ojknockout', 'ojs/ojdialog',
        'ojs/ojlistview', 'ojs/ojbutton','ojs/ojinputtext', 'ojs/ojlabel', 'ojs/ojradioset', 'ojs/ojselectcombobox'],
       function(oj, ko, $, ArrayDataProvider, DrillDownList) {

         function BuySellViewModel() {
           var self = this;
           // Below are a set of the ViewModel methods invoked by the oj-module component.
           // Please reference the oj-module jsDoc for additional information


           //POST DIALOG REGION
           self.postButtonClick = function(event){
             document.getElementById('modalDialog1').open();
           };

           self.closePostDialog = function (event) {
            self.resetPostDialog();
             document.getElementById('modalDialog1').close();
           };

           self.drillDownListHeading= ko.observable("All Events:");

           self.savePost = function (event) {var successFunction = function(responseText){
                  self.outerListData(responseText.data);
                  self.outerListData.sort(function(a, b){
                            return b.id-a.id;
                        })
                  self.closePostDialog();
                }

                var data = {
                    "address" : self.postAddress(),
                    "city" : self.postCity(),
                    "title" : self.postTitle(),
                    "description" : self.postDescription(),
                    "state" : self.postState(),
                    "zip" : self.postZip(),
                    "price" : self.postPrice(),
                    "url" : self.postUrl(),
                    "type" : self.postType(),
                    "date" : self.postDate()
                }

                $.ajax({
                    url: 'http://0.0.0.0:4000/postEvent',
                    type: 'POST',
                    data: data
                })
                .done(function(data) {
                    successFunction(data);
                });
                return true;
           };
           
           self.postType = ko.observable("");
           self.postUrl = ko.observable("");
           self.postDescription = ko.observable("");
           self.postTitle = ko.observable("");
           self.postCity = ko.observable("");
           self.postState = ko.observable("");
           self.postAddress = ko.observable("");
           self.postZip = ko.observable("");
           self.postPrice = ko.observable("");
           self.postDate = ko.observable("");

           self.outerListData = ko.observableArray();

            self.fetchData =  function(){
                var url = 'http://0.0.0.0:4000/events';
                $.get(url, function(responseText) {
                  responseText.data.sort(function(a, b){
                            return b.id-a.id;
                        });
                    self.outerListData(responseText.data);
                    
                });
            }

            self.dataProvider = new ArrayDataProvider(self.outerListData, {'keyAttributes': 'id'});

            self.fetchData();

            self.currentListItemSelectedId = ko.observable();

            self.resetPostDialog = function(){
            self.postDescription("");
            self.postType("");
            self.postTitle("");
            self.postCity("");
            self.postState("");
            self.postZip("");
            self.postPrice("");
            self.postAddress("");
            self.postUrl("");
            self.postDate("");
        }

         }

         /*
          * Returns a constructor for the ViewModel so that the ViewModel is constructed
          * each time the view is displayed.  Return an instance of the ViewModel if
          * only one instance of the ViewModel is needed.
          */
         return new BuySellViewModel();
       }
);
