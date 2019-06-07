/*
 * Your dashboard ViewModel code goes here
 */
define(['ojs/ojcore', 'knockout', 'jquery', 'partials/postQuestion', 'partials/drilldownlist',
        'ojs/ojknockout',
        'ojs/ojnavigationlist',
        'ojs/ojradioset',
        'ojs/ojswitch'],
 function(oj, ko, $, PostQuestion, DrillDownList) {
  
    function AcademicViewModel() {
        var self = this;

        // Below are a set of the ViewModel methods invoked by the oj-module component.
        // Please reference the oj-module jsDoc for additional information.


        self.selectedItem = ko.observable("courseWorkList");


        self.currentTab = ko.observable("courseWorkList");

        self.drillDownListHeading = ko.observable("Questions Related To Coursework:");

        self.tabChangeHandler = function(event){
            if(event && event.detail && event.detail.previousKey!== event.detail.key && (event.detail.key === "courseWorkList" || event.detail.key === "hotSkillsList")){
              self.currentTab(event.detail.key);
              self.postQuestionVM = new PostQuestion(self, self.currentTab()=="courseWorkList" ? "COURSEWORK" : "HOT SKILLS");
              self.drillDownListVM = new DrillDownList(self, self.currentTab()=="courseWorkList" ? "COURSEWORK" : "HOT SKILLS");
              if(self.currentTab()=="courseWorkList")
                self.drillDownListHeading("Questions Related To Coursework:");
              else
                self.drillDownListHeading("Questions Related To Hot Skills:");
            }
                
        };

        //Post Question text area and button REGION
        self.questionPosted = ko.observable(false);
        self.postQuestionVM = new PostQuestion(self, self.currentTab()=="courseWorkList" ? "COURSEWORK" : "HOT SKILLS");

        //Drill down list REGION
        self.drillDownListVM = new DrillDownList(self, self.currentTab()=="courseWorkList" ? "COURSEWORK" : "HOT SKILLS");

        self.postedQuestionText = self.postQuestionVM.questionText;


        self.backToAllQuestionsList = function(event){
            self.postQuestionVM.questionText("");
            self.drillDownListVM.fetchData();
            self.questionPosted(false);
        };

        self.updateQuestionsWithRelatedQuestions = function(relatedQuestions){
            self.drillDownListVM.outerListData(relatedQuestions.data);
            self.questionPosted(true);
        }

    }


    //region register partials

     ko.components
     .register(
           "academicpostquestion",
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
           "academicdrilldownlist",
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
    return new AcademicViewModel();
  }
);
