(function () {
	YUI().use('dd-constrain', 'dd-proxy', 'dd-drop', 'dd-scroll', function(Y) {

		var updateCategory = function(event) {
			var drag = event.target;
			var dragNode = drag.get('node');
			var parent = dragNode.get('parentNode').get('id') ;
			var id = dragNode.one('ul').get('id');
			if ( parent.indexOf('yui') >=0)
			{
				parent = 0;
				alert(parent);
			}
			YUI().use("io-base", function(Y) {
			var uri = 'update_parent_id?id='+id + '&parent_id='+parent;
		   	var cfg,
					request;
				// Create a configuration object for the synchronous transaction.
				cfg = {
					method: 'POST',
					sync: true,
					headers: {
							'Content-Type': 'application/json',
					}
				};

				/*
				 * var request will contain the following fields, when the
				 * transaction is complete:
				 * - id
				 * - status
				 * - statusText
				 * - getResponseHeader()
				 * - getAllResponseHeaders()
				 * - responseText
				 * - responseXML
				 * - arguments
				 */
				request = Y.io(uri, cfg);

			});
			
		};
	    //Listen for all drop:over events
	    //Y.DD.DDM._debugShim = true;
		Y.DD.DDM.on('drop:over', function(e) {
		        //Get a reference to our drag and drop nodes
		        var drag = e.drag.get('node'),
		            drop = e.drop.get('node');
		        //Are we dropping on a li node?
			 	if (drop.get('tagName').toLowerCase() === 'li') {
						drop.one('ul').appendChild(drag);
			            //Resize this nodes shim, so we can drop on it later.
			            e.drop.sizeShim();
			    }
				else  if (drop.get('tagName').toLowerCase() === 'ul') {
						if(drag!=e.drop.get('node').get('parentNode')) {
							drop.appendChild(drag);
				        	e.drop.sizeShim();		
						}
			    }
		    });

	    //Listen for all drag:start events
	    Y.DD.DDM.on('drag:start', function(e) {
	        //Get our drag object
	        var drag = e.target;
	        //Set some styles here
	        drag.get('node').setStyle('opacity', '.25');
	        drag.get('dragNode').set('innerHTML', drag.get('node').get('innerHTML'));
	        drag.get('dragNode').setStyles({
	            opacity: '.5',
				border: '0px'
	        });
			drag.get('dragNode').all('ul li').setStyles({
	            visibility: 'hidden'           
	        });
	    });
	    //Listen for a drag:end events
	    Y.DD.DDM.on('drag:end', function(e) {
	        var drag = e.target;
	        //Put out styles back
	        drag.get('node').setStyles({
	            visibility: '',
	            opacity: '1'
	        });	
			 updateCategory(e);
	    });
	    //Listen for all drag:drophit events
	    Y.DD.DDM.on('drag:drophit', function(e) {
	        var drop = e.drop.get('node'),
	            drag = e.drag.get('node');
	        //if we are not on an li, we must have been dropped on a ul
	        //yconsole.log(drop.get('tagName').toLowerCase() );
	        if (drop.get('tagName').toLowerCase() !== 'li') {
		 		//yconsole.log('drop: ' + drop);	
				drop.appendChild(drag);
					e.drop.sizeShim();
	        }

	    });
	    //Static Vars

	    //Get the list of li's in the lists and make them draggable
	    var lis = Y.all('#categoriesnl .moveable');
	    lis.each(function(v, k) {
	        var dd = new Y.DD.Drag({
	            node: v
	        }).plug(Y.Plugin.DDProxy, {
	            moveOnEnd: false
	        }).plug(Y.Plugin.DDConstrained, {
	            constrain2node: '#categoriesnl'
	        });
	    });

	    //Create simple targets for the 2 lists.
	    var uls = Y.all('#categoriesnl .droppable');
	    uls.each(function(v, k) {
	        var tar = new Y.DD.Drop({
	            node: v,
				//Make it Drop target and pass this config to the Drop constructor
				target: {
				     padding: '0 0 0 20'
				}
	        });
	    });    
	});
}());