/*
 * Your dashboard ViewModel code goes here
 */
define(['ojs/ojcore', 'knockout', 'jquery', 'partials/postQuestion', 'partials/drilldownlist',
        'ojs/ojarraydataprovider',
        'ojs/ojknockout',
        'ojs/ojdialog',
        'ojs/ojnavigationlist',
        'ojs/ojlistview', 'ojs/ojbutton',
        'ojs/ojfilepicker',
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
             if(event && event.detail && event.detail.previousKey!== event.detail.key && (event.detail.key === "onCampus" || event.detail.key === "industry")){
               self.currentTab(event.detail.key);
               if(self.currentTab() == "industry")
                self.fetchData();
             }
           };

           self.postQuestionVM = new PostQuestion(self, "ON_CAMPUS");

           self.drillDownListHeading= ko.observable("Questions related to On Campus Jobs:");

           //Drill down list REGION
           self.drillDownListVM = new DrillDownList(self, "ON_CAMPUS");

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


           //Post Question text area and button REGION
           self.questionPosted = ko.observable(false);
           



          self.industryJobs = ko.observableArray();
                                          
          self.fetchData =  function(){
                var url = 'http://0.0.0.0:4000/industry';
                $.get(url, function(responseText) {
                    console.log(responseText.data);
                    self.industryJobs(responseText.data);
                    self.industryJobs.sort(function(a, b){
                            return b.id-a.id;
                        })
                });
            }
            

           self.selectedIndustryJobItem = ko.observable();

           this.handleCurrentItemChanged = function(event){
              var itemId = event.detail.value;
              // Access current item via ui.item
              this.selectedIndustryJobItem(itemId);
            }.bind(this);

           var lastItemId = self.industryJobs().length;

           self.industryJobsDataProvider = new ArrayDataProvider(self.industryJobs, {'keyAttributes': 'id'});

            // >>>>>>>>>>>>>>>>>>>>>>>>>>>>> RGEION POST DIALOG <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
           self.postButtonClick = function(event){
             document.getElementById('modalDialog1').open();
           };

           self.closePostDialog = function (event) {
              self.resetPostDialog();
              document.getElementById('modalDialog1').close();
           };

           self.savePost = function (event) {
              var successFunction = function(responseText){
                  self.industryJobs(responseText.data);
                  self.industryJobs.sort(function(a, b){
                            return b.id-a.id;
                        })
                  self.closePostDialog();
                }

                var data = {
                    "company_name" : self.companyName(),
                    "position" : self.position(),
                    "description" : self.jobDescription(),
                    "location" : self.location(),
                    "experience" : self.experience(),
                    "job_category" : self.jobCategory()
                }

                $.ajax({
                    url: 'http://0.0.0.0:4000/postJob',
                    type: 'POST',
                    data: data
                })
                .done(function(data) {
                    successFunction(data);
                });
                return true;
           };

           self.jobCategory = ko.observable("FULL TIME");

           self.jobDescription = ko.observable("");
           self.companyName = ko.observable("");
           self.position = ko.observable("");
           self.location = ko.observable("");
           self.experience = ko.observable("");

           self.resetPostDialog = function(){
              self.jobCategory("FULL TIME");
              self.jobDescription("");
              self.companyName("");
              self.position("");
              self.location("");
              self.experience("");
           }

           // >>>>>>>>>>>>>>>>>>>>>>>>>>>>> RGEION END POST DIALOG <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

           // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  REFERRAL DIALOG REGION <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

           self.referralMessage = ko.observable("");

           
           self.referralButtonClick = function(event){
            document.getElementById('referralDialog').open();
           }

           self.closeReferralDialog = function (event) {
             document.getElementById('referralDialog').close();
           };

           self.saveReferral= function (event) {
              var successFunction = function(responseText){
                  self.closeReferralDialog();
                }

                var data = {
                    "job_id" : self.selectedIndustryJobItem(),
                    "message" : self.referralMessage()
                }

                $.ajax({
                    url: 'http://0.0.0.0:4000/jobResponse',
                    type: 'POST',
                    data: data
                })
                .done(function(data) {
                    successFunction(data);
                });
                return true;
           };

           self.fileNames = ko.observableArray([]);
           self.selectListener = function(event) {
            var files = event.detail.files;
            for (var i = 0; i < files.length; i++) {
              self.fileNames.push(files[i].name);
            }
          }

           // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  END FREGION REFERRAL DIALOG  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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
