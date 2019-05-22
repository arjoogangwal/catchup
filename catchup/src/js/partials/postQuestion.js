/**
 * DrillDownList View Model
 */

define(
    [ 'ojs/ojcore', 'knockout', 'jquery','ojs/ojarraydataprovider', 'partials/drilldownlist', 'ojs/ojknockout', 'ojs/ojdialog',
      'ojs/ojlistview', 'ojs/ojbutton','ojs/ojinputtext', 'ojs/ojlabel' ],
    function(oj, ko, $, ArrayDataProvider) {

        "use strict";

        function PostQuestionVM(params) {

            // Make certain this function is called as a constructor.
            // This is naturally the case when called by ojModule.
            if (!(this instanceof PostQuestionVM)) {
                return new PostQuestionVM();
            }

            var self = this; // this == ViewModel instance

            self.parentVM = params;

            self.questionText = ko.observable("");

            self.postButtonClick = function(event){
                console.log("post button clicked");
                /*$.get('http://0.0.0.0:4000/show', function(responseText) {
                    console.log(responseText);
                });*/

                self.parentVM.questionPosted(true);

                //TODO -> navigate to related questions list after clicking post
                return true;
            };


        }
        return PostQuestionVM;
    });
