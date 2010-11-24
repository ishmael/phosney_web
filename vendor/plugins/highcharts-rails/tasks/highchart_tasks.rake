namespace :highcharts_rails do
  to_copy = ["jquery-1.4.3.min.js", "modules/exporting.js", "highcharts.js","adapters/mootools-adapter.js","themes/dark-blue.js","themes/dark-green.js","themes/gray.js","themes/grid.js"]
  to_create = ["modules","adapters","themes"]
  
  # install
  desc 'Copies required scripts files to the public/javascripts directory.'
  task :install do
    
    # inform the user of whats happening
    puts "Creating directories #{to_create.to_sentence} in public/javascripts/..."
    
    success = true

    to_create.each do |directory|
      # create
    	destination = File.join(RAILS_ROOT, "/public/javascripts/", directory)
    	  	
    	# create
    	unless File.exist?(destination)
      	unless FileUtils.mkdir(destination)
      	  success = false
    	  end
    	end
    end


    puts "Copying #{to_copy.to_sentence} to public/javascripts/..."
        
    to_copy.each do |script|
      # copy from
    	destination = File.join(RAILS_ROOT, "/public/javascripts/", script)
    	
    	# copy to
    	source = File.join(RAILS_ROOT + "/vendor/plugins/highcharts-rails/javascripts/", script)
    	
    	# copy
    	unless FileUtils.cp_r(source, destination)
    	  success = false
  	  end
    end
    
    puts "Required scripts copied successfully!"
  end
  
  # uninstall
  desc 'Removes required scripts from the public/javascripts directory.'
  task :uninstall do
    FileUtils.rm_r to_copy.collect { |script| RAILS_ROOT + "/public/javascripts/" + script  }
    
    puts "#{to_copy.to_sentence} removed successfully."
  end
end