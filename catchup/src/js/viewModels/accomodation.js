/*
 * Your dashboard ViewModel code goes here
 */
define(['ojs/ojcore', 'knockout', 'jquery', 'ojs/ojarraydataprovider',  'ojs/ojlistview', 'ojs/ojdialog', 'ojs/ojbutton',
        'ojs/ojinputtext', 'ojs/ojlabel'],
 function(oj, ko, $, ArrayDataProvider) {
  
    function DashboardViewModel() {
        var self = this;
      // Below are a set of the ViewModel methods invoked by the oj-module component.
      // Please reference the oj-module jsDoc for additional information.

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
        self.postLocation = ko.observable("");
        self.postZip = ko.observable("");
        self.postPrice = ko.observable("");


        self.outerListData = ko.observableArray();

        self.fetchData =  function(){
                var url = 'http://0.0.0.0:4000/accomodations';
                $.get(url, function(responseText) {
                    console.log(responseText.data);
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
                        console.log(responseText.data);
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

        self.replyToPost = function(event){
                // document.getElementById('modalDialog1').open();
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
