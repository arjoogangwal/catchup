/*
 * Your dashboard ViewModel code goes here
 */
define(['ojs/ojcore', 'knockout', 'jquery', 'ojs/ojarraydataprovider',  'ojs/ojlistview', 'ojs/ojbutton', 'ojs/ojinputtext', 'ojs/ojlabel'],
 function(oj, ko, $, ArrayDataProvider) {
  
    function DashboardViewModel() {
      var self = this;
      // Below are a set of the ViewModel methods invoked by the oj-module component.
      // Please reference the oj-module jsDoc for additional information.

      self.postButtonClick = function(event){
        console.log("button clicked");
        //show dialog for posting question
        return true;
      }

      var data = [{name: 'Timberleaf Apartments', version: '10.3.6', nodes: 2, cpu: 2, type: 'Townhome', balancer: 1, memory: 'April 1, 2019'},
                    {name: 'Park Central', version: '10.3.6', nodes: 1, cpu: 1, type: 'Flat', balancer: 1, memory: 'April 1, 2019'},
                    {name: 'Domicilio Apartments', version: '10.3.6', nodes: 2, cpu: 1, type: 'Townhome', balancer: 1, memory: 'April 1, 2019'},
                    {name: 'Environment', version: '10.3.6', nodes: 2, cpu: 2, type: 'Townhome', balancer: 1, memory: 'April 1, 2019'},
                    {name: 'Security', version: '10.3.6', nodes: 2, cpu: 2, type: 'Townhome', balancer: 1, memory: 'April 1, 2019'},
                    {name: 'Security1', version: '10.3.6', nodes: 2, cpu: 2, type: 'Townhome', balancer: 1, memory: 'April 1, 2019'},
                    {name: 'Security2', version: '10.3.6', nodes: 2, cpu: 2, type: 'Townhome', balancer: 1, memory: 'April 1, 2019'},
                    {name: 'Security3', version: '10.3.6', nodes: 2, cpu: 2, type: 'Townhome', balancer: 1, memory: 'April 1, 2019'},
                    {name: 'Security4', version: '10.3.6', nodes: 2, cpu: 2, type: 'Townhome', balancer: 1, memory: 'April 1, 2019'},
                    {name: 'Security5', version: '10.3.6', nodes: 2, cpu: 2, type: 'Townhome', balancer: 1, memory: 'April 1, 2019'},
                    {name: 'Security6', version: '10.3.6', nodes: 2, cpu: 2, type: 'Townhome', balancer: 1, memory: 'April 1, 2019'}
                   ];
      self.dataProvider = new ArrayDataProvider(data, 
                                                    {keys: data.map(function(value) {
                                                         return value.name;
                                                     })}); 
    };
    /*
     * Returns a constructor for the ViewModel so that the ViewModel is constructed
     * each time the view is displayed.  Return an instance of the ViewModel if
     * only one instance of the ViewModel is needed.
     */
    return new DashboardViewModel();
  }
);
