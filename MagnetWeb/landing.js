
function initializeParse() {
	Parse.initialize('fCRM0CEXdoWkzlEv9QxTZUJKEmVf96Cz4rhsbw7Y', 'fuintiLioLjatdhcsxpcqL4pkISJ7DdU2dWI6vDX');

window.fbAsyncInit = function() {
	        Parse.FacebookUtils.init({
	          appId      : '214135578760225',
	          status	 : true,
	          cookie	 : true,
	          xfbml      : true,
	          version    : 'v2.1'
	        });

	        Parse.FacebookUtils.logIn(null, {
			  success: function(user) {
			    if (!user.existed()) {
			      alert("User signed up and logged in through Facebook!");
			    } else {
			      alert("User logged in through Facebook!");
			    }
			  },
			  error: function(user, error) {
			    alert("User cancelled the Facebook login or did not fully authorize.");
			  }
			});
	      };

		(function(d, s, id) {
		  var js, fjs = d.getElementsByTagName(s)[0];
		  if (d.getElementById(id)) return;
		  js = d.createElement(s); js.id = id;
		  js.src = "https://connect.facebook.net/en_US/all.js";
		  fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));	
}
