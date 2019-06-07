
/*
 * Your application specific code will go here
 */
define(['ojs/ojcore', 'knockout', 'ojs/ojmodule-element-utils', 'jquery', 'ojs/ojmodule-element', 'ojs/ojrouter', 'ojs/ojknockout', 'ojs/ojarraytabledatasource',
  'ojs/ojoffcanvas',  'ojs/ojbutton',
        'ojs/ojmenu', 'ojs/ojoption',
        'ojs/ojinputtext', 'ojs/ojlabel',
        'ojs/ojradioset', 'ojs/ojselectcombobox',
        'ojs/ojdialog', 'ojs/ojselectcombobox', 'ojs/ojdefer', 'ojs/ojmessages', 'ojs/ojarraydataprovider'],
  function(oj, ko, moduleUtils, $) {
     function ControllerViewModel() {

         var self = this;

      // Media queries for repsonsive layouts
      var smQuery = oj.ResponsiveUtils.getFrameworkQuery(oj.ResponsiveUtils.FRAMEWORK_QUERY_KEY.SM_ONLY);
      self.smScreen = oj.ResponsiveKnockoutUtils.createMediaQueryObservable(smQuery);
      var mdQuery = oj.ResponsiveUtils.getFrameworkQuery(oj.ResponsiveUtils.FRAMEWORK_QUERY_KEY.MD_UP);
      self.mdScreen = oj.ResponsiveKnockoutUtils.createMediaQueryObservable(mdQuery);

       // Router setup
       self.router = oj.Router.rootInstance;
       self.router.configure({
         'home': {label: 'Home', isDefault: true},
         'academic': {label: 'Academic Guidance'},
         'jobs': {label: 'Job Opportunities'},
         'accomodation': {label: 'Accomodation'},
         'buysell': {label: 'Buy/Sell'},
         'events': {label: 'Events'},
         'foodnight': {label: 'Food & Nightlife'}
       });
      oj.Router.defaults['urlAdapter'] = new oj.Router.urlParamAdapter();

      self.moduleConfig = ko.observable({'view':[], 'viewModel':null});

      self.loadModule = function() {
        ko.computed(function() {
          var name = self.router.moduleConfig.name();
          var viewPath = 'views/' + name + '.html';
          var modelPath = 'viewModels/' + name;
          var masterPromise = Promise.all([
            moduleUtils.createView({'viewPath':viewPath}),
            moduleUtils.createViewModel({'viewModelPath':modelPath})
          ]);
          masterPromise.then(
            function(values){
              self.moduleConfig({'view':values[0],'viewModel':values[1]});
            }
          );
        });
      };

      // Navigation setup
      var navData = [
      {name: 'Home', id: 'home'},
      {name: 'Academic Guidance', id: 'academic'},
      {name: 'Job Opportunities', id: 'jobs'},
      {name: 'Accomodation', id: 'accomodation'},
       {name: 'Buy/Sell', id: 'buysell'},
       {name: 'Events', id: 'events'},
       {name: 'Food & Nightlife', id: 'foodnight'}
      ];
      self.navDataSource = new oj.ArrayTableDataSource(navData, {idAttribute: 'id'});

      // Drawer
      // Close offcanvas on medium and larger screens
      self.mdScreen.subscribe(function() {oj.OffcanvasUtils.close(self.drawerParams);});
      self.drawerParams = {
        displayMode: 'push',
        selector: '#navDrawer',
        content: '#pageContent'
      };
      // Called by navigation drawer toggle button and after selection of nav drawer item
      self.toggleDrawer = function() {
        return oj.OffcanvasUtils.toggle(self.drawerParams);
      }
      // Add a close listener so we can move focus back to the toggle button when the drawer closes
      $("#navDrawer").on("ojclose", function() { $('#drawerToggleButton').focus(); });

      // Header
      // Application Name used in Branding Area
      self.appName = ko.observable("          Catchup");
      // User Info used in Global Navigation area
      self.userLogin = ko.observable("agangwal@scu.edu");

      // Footer
      function footerLink(name, id, linkTarget) {
        this.name = name;
        this.linkId = id;
        this.linkTarget = linkTarget;
      }
      self.footerLinks = ko.observableArray([
        new footerLink('About Scu', 'aboutScu', 'http://www.oracle.com/us/corporate/index.html#menu-about'),
        new footerLink('Contact Us', 'contactUs', 'http://www.oracle.com/us/corporate/contact/index.html'),
        new footerLink('Legal Notices', 'legalNotices', 'http://www.oracle.com/us/legal/index.html'),
        new footerLink('Terms Of Use', 'termsOfUse', 'http://www.oracle.com/us/legal/terms/index.html'),
        new footerLink('Your Privacy Rights', 'yourPrivacyRights', 'http://www.oracle.com/us/legal/privacy/index.html')
      ]);

      self.loggedIn = ko.observable(false);

      self.loginUsername = ko.observable("");
      self.loginPassword = ko.observable("");
      self.userType = ko.observable("ALUMNI");
      self.username = ko.observable("");
      self.password = ko.observable("");
      self.city = ko.observable("");
      self.state = ko.observable("");
      self.zip = ko.observable("");
      self.address = ko.observable("");
      self.program = ko.observable("");
      self.firstName = ko.observable("");
      self.lastName = ko.observable("");
      self.repassword = ko.observable("");
      self.phone = ko.observable("");
      self.email = ko.observable("");
      self.undergrad = ko.observable("");

      self.loginDialog = function(event)
         {

self.signUpShowing(false);
            document.getElementById("loginDialog").open();
         };

      self.closeLoginDialog = function (event) {
              self.reset();
              self.signUpShowing(false);
              
              document.getElementById('loginDialog').close();
           };

           self.reset = function(){
            self.loginUsername("");
      self.loginPassword("");
      self.userType ("ALUMNI");
      self.username ("");
      self.password("");
      self.city("");
      self.state ("");
      self.zip ("");
      self.address ("");
      self.program ("");
      self.firstName ("");
      self.lastName ("");
      self.repassword("");
      self.phone("");
      self.email ("");
      self.undergrad("");
           }

           self.signUpShowing = ko.observable(false);

           self.signUpClicked = function(event)
         {
          self.reset();

            self.signUpShowing(true);
         };

         self.signUpConfirm = function(event)
         {
          self.reset();

            self.signUpShowing(false);
         };



      self.login = function (event) {

            self.loggedIn(true);
            self.reset();
              
              document.getElementById('loginDialog').close();
           };

      self.goToHome = function( data, event) {
          if(event && event.target && (event.target.id === "scuIconContainer" || event.target.id === "scuIconContainerIcon" || event.target.id === "scuIconContainerText")){
              self.router.go('home');
          }
      }.bind(this);

      self.menuItemAction = function( event ) {
          if(event && event.target && event.target.value === "msg"){
              self.openMessagesDialog();
          }
          if(event && event.target && event.target.value === "out"){
              self.loggedIn(false);
          }

      }.bind(this);

      //Messages Dialog region

         // TODO -> Fetch real time messages from the server
         self.applicationMessages = ko.observableArray();

         self.dataprovider = new oj.ArrayDataProvider(self.applicationMessages);

         self.openMessagesDialog = function(event)
         {
             // self.selectedLayoutOption("inline");
             var url = 'http://0.0.0.0:4000/messages';
                $.get(url, function(responseText) {
                    self.applicationMessages(responseText.data);
                    self.applicationMessages.sort(function(a, b){
                            return b.response_id-a.response_id;
                        })
                    
                    document.getElementById("messagesContainerDialog").open();
                });
                
         };

         this.messagesReady = function(event) {
              if($( "div.oj-message-detail a:last-child" ).length == 0)             
                  $('div.oj-message-detail').append("<br><a href='#''>Resume</a>");
           }.bind(this);

         self.closeMessagesDialog = function(event)
         {
             document.getElementById("messagesContainerDialog").close();
         };

         self.messagesStyle = ko.computed(function() {
             return {"width": "100%", "min-width": "100%", "maxWidth": "100%"};
         });

         self.messagesPosition = ko.computed(function() {
             return null;
         });

         self.messagesDisplay = ko.computed(function() {
             return "general";
         });

     }

     return new ControllerViewModel();
  }
);
