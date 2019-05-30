/*
 * Your dashboard ViewModel code goes here
 */
define(['ojs/ojcore', 'knockout', 'jquery', 'partials/postQuestion', 'partials/drilldownlist',
        'ojs/ojknockout',
        'ojs/ojnavigationlist',
        'ojs/ojradioset',
        'ojs/ojswitch'],
       function(oj, ko, $, PostQuestion, DrillDownList) {

         function FoodAndNightLifeViewModel() {
           var self = this;

           // Below are a set of the ViewModel methods invoked by the oj-module component.
           // Please reference the oj-module jsDoc for additional information.

           self.backToAllQuestionsList = function(event){
             self.questionPosted(false);
           };


           //Post Question text area and button REGION
           self.questionPosted = ko.observable(false);
           self.postedQuestionText = ko.observable("Your Posted Question");  // can be postQuestionVM.questionText()
           self.postQuestionVM = new PostQuestion(self);

           //Drill down list REGION
           self.drillDownListVM = new DrillDownList(self, "FOOD AND NIGHTLIFE");

         }


         //region register partials

         ko.components

             .register(
                 "foodnightpostquestion",
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
                 "foodnightdrilldownlist",
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
         return new FoodAndNightLifeViewModel();
       }
);
