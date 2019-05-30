/*
 * Your dashboard ViewModel code goes here
 */
define(['ojs/ojcore', 'knockout', 'jquery','ojs/ojarraydataprovider', 'partials/drilldownlist', 'ojs/ojknockout', 'ojs/ojdialog',
        'ojs/ojlistview', 'ojs/ojbutton','ojs/ojinputtext', 'ojs/ojlabel', 'ojs/ojradioset', 'ojs/ojselectcombobox'],
       function(oj, ko, $, ArrayDataProvider, DrillDownList) {

         function BuySellViewModel() {
           var self = this;
           // Below are a set of the ViewModel methods invoked by the oj-module component.
           // Please reference the oj-module jsDoc for additional information.

           self.buttonClick = function(event){
             console.log("button clicked");
             $.get('http://0.0.0.0:4000/show', function(responseText) {
               console.log(responseText);
             });
             return true;
           };


           //POST DIALOG REGION
           self.postButtonClick = function(event){
             document.getElementById('modalDialog1').open();
           };

           self.closePostDialog = function (event) {
             document.getElementById('modalDialog1').close();
           };

           self.savePost = function (event) {

             //TODO -> Write code for saving post
             document.getElementById('modalDialog1').close();
           };

           self.postDescription = ko.observable("");
           self.postTitle = ko.observable("");
           self.postCity = ko.observable("");
           self.postState = ko.observable("");
           self.postLocation = ko.observable("");
           self.postZip = ko.observable("");
           self.postPrice = ko.observable("");

           self.outerListData = ko.observableArray();

            self.fetchData =  function(){
                var url = 'http://0.0.0.0:4000/events';
                $.get(url, function(responseText) {
                    console.log(responseText.data);
                    self.outerListData(responseText.data);
                });
            }

            self.dataProvider = new ArrayDataProvider(self.outerListData, {'keyAttributes': 'id'});

            self.fetchData();

            self.currentListItemSelectedId = ko.observable();

         }

         /*
          * Returns a constructor for the ViewModel so that the ViewModel is constructed
          * each time the view is displayed.  Return an instance of the ViewModel if
          * only one instance of the ViewModel is needed.
          */
         return new BuySellViewModel();
       }
);
