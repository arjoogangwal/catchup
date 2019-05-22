/*
 * Your dashboard ViewModel code goes here
 */
define(['ojs/ojcore', 'knockout', 'jquery', 'partials/postQuestion', 'partials/drilldownlist',
        'ojs/ojarraydataprovider',
        'ojs/ojknockout',
        'ojs/ojnavigationlist',
        'ojs/ojlistview', 'ojs/ojbutton',
        'ojs/ojradioset',
        'ojs/ojswitch'],
       function(oj, ko, $, PostQuestion, DrillDownList, ArrayDataProvider) {

         function JobsViewModel() {
           var self = this;

           // Below are a set of the ViewModel methods invoked by the oj-module component.
           // Please reference the oj-module jsDoc for additional information.


           self.selectedItem = ko.observable("onCampus");


           self.currentTab = ko.observable("onCampus");

           self.tabChangeHandler = function(event){
             if(event && event.detail && event.detail.previousKey!== event.detail.key && (event.detail.key === "onCampus" || event.detail.key === "industry"))
               self.currentTab(event.detail.key);
           };

           self.backToAllQuestionsList = function(event){
             self.questionPosted(false);
           };


           //Post Question text area and button REGION
           self.questionPosted = ko.observable(false);
           self.postedQuestionText = ko.observable("Your Posted Question");  // can be postQuestionVM.questionText()
           self.postQuestionVM = new PostQuestion(self);

           //Drill down list REGION
           self.drillDownListVM = new DrillDownList(self, "jobs");



           self.allItems = ko.observableArray([{"id": 1, "item": "Milk"},
                                                {"id": 2, "item": "Flour"},
                                                {"id": 3, "item": "Sugar"},
                                                {"id": 4, "item": "Vanilla Extract"}
                                              ]);
           self.selectedIndustryJobItems = ko.observableArray([]);

           var lastItemId = self.allItems().length;

           self.industryJobsDataProvider = new ArrayDataProvider(this.allItems, {'keyAttributes': 'id'});

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

         }


         //region register partials

         ko.components

             .register(
                 "jobspostquestion",
                 {
                   viewModel: {
                     createViewModel: function (params,
                                                componentInfo) {
                       var postQuestion = ko
                           .contextFor(componentInfo.element).$data;
                       return postQuestion.postQuestionVM;
                     }
                   },
                   template: {
                     require: "text!partials/postQuestion.html"
                   }
                 });

         //region register partials
         ko.components
             .register(
                 "jobsdrilldownlist",
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
         return new JobsViewModel();
       }
);
