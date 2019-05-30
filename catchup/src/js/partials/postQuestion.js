/**
 * DrillDownList View Model
 */

define(
    [ 'ojs/ojcore', 'knockout', 'jquery','ojs/ojarraydataprovider', 'partials/drilldownlist', 'ojs/ojknockout', 'ojs/ojdialog',
      'ojs/ojlistview', 'ojs/ojbutton','ojs/ojinputtext', 'ojs/ojlabel' ],
    function(oj, ko, $, ArrayDataProvider) {

        "use strict";

        function PostQuestionVM(params, type) {

            // Make certain this function is called as a constructor.
            // This is naturally the case when called by ojModule.
            if (!(this instanceof PostQuestionVM)) {
                return new PostQuestionVM();
            }

            var self = this; // this == ViewModel instance

            self.type = type;

            self.parentVM = params;

            self.questionText = ko.observable("");

            self.postButtonClick = function(event){
                var successFunction = function(data){
                    self.parentVM.questionPosted(true);
                }

                var data = {
                    "q_description" : self.questionText(),
                    "q_category" : self.type
                }

                $.ajax({
                    url: 'http://0.0.0.0:4000/postQuestions',
                    type: 'POST',
                    data: data
                })
                .done(function(data) {
                    successFunction();
                });
                //TODO -> navigate to related questions list after clicking post
                return true;
            };


        }
        return PostQuestionVM;
    });
