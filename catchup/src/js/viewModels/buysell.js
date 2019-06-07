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


      //POST DIALOG REGION
      self.postButtonClick = function(event){
        document.getElementById('modalDialog1').open();
      };

      self.closePostDialog = function (event) {
        self.resetPostDialog();
        document.getElementById('modalDialog1').close();
      };

      self.drillDownListHeading= ko.observable("Market Posts:");

      self.savePost = function (event) {
        var successFunction = function(responseText){
                  self.drillDownListVM.outerListData(responseText.data);
                  self.drillDownListVM.outerListData.sort(function(a, b){
                            return b.id-a.id;
                        })
                  self.closePostDialog();
                }

                var data = {
                    "address" : self.address(),
                    "city" : self.postCity(),
                    "title" : self.postTitle(),
                    "description" : self.postDescription(),
                    "state" : self.postState(),
                    "zip" : self.postZip(),
                    "price" : self.postPrice(),
                    "condition" : self.condition(),
                    "status" : self.status(),
                    "category" : self.category(),
                    "type" : self.type()
                }

                $.ajax({
                    url: 'http://0.0.0.0:4000/postMarket',
                    type: 'POST',
                    data: data
                })
                .done(function(data) {
                    successFunction(data);
                });
                return true;
      };

      self.resetPostDialog = function(){
            self.postDescription("");
            self.type("SELL");
            self.postTitle("");
            self.postCity("");
            self.postState("");
            self.address("");
            self.postZip("");
            self.postPrice("");
            self.category();
            self.status();
            self.condition();
        }

      self.postDescription = ko.observable("");
      self.type = ko.observable("SELL");
      self.postTitle = ko.observable("");
      self.postCity = ko.observable("");
      self.postState = ko.observable("");
      self.address = ko.observable("");
      self.postZip = ko.observable("");
      self.postPrice = ko.observable("");
      self.category = ko.observable();
      self.status = ko.observable();
      self.condition = ko.observable();
      self.drillDownListVM = new DrillDownList(self, "buySell");

    }

   //region register partials
   ko.components
       .register(
           "marketdrilldownlist",
           {
             viewModel: {
               createViewModel: function (params,
                                          componentInfo) {
                 var buySellViewModel = ko
                     .contextFor(componentInfo.element).$data;
                 return buySellViewModel.drillDownListVM;
               }
             },
             template: {
               require: "text!partials/drilldownlist.html"
             }
           });

    /*
     * Returns a constructor for the ViewModel so that the ViewModel is constructed
     * each time the view is displayed.  Return an instance of the ViewModel if
     * only one instance of the ViewModel is needed.
     */
    return new BuySellViewModel();
  }
);
