class SharedAccountInvitationsController < ApplicationController
  before_filter :require_user
  
  def new
	
    	@account = @current_user.bankaccounts.find_by_id(params[:bankaccount_id])
	    if @account
     	  @sharedinvitation = @account.shared_account_invitations.new

		    respond_to do |format|
			    format.html # new.html.erb
			    format.iphone  { render :layout => false }
			    format.xml  { render :xml => @sharedinvitation }
		    end
	    else
		    redirect( dashboard_url)
	    end
  end

  def create
    	@account = @current_user.bankaccounts.find_by_id(params[:bankaccount_id])
	    if @account		
		    @sharedinvitation = @account.shared_account_invitations.build(params[:shared_account_invitation])
		    @sharedinvitation.user_id = @account.user_id
    
    
    	respond_to do |format|
    	  if @sharedinvitation.save
    		@sharedinvitation.send_invitation(@current_user)
    		flash[:notice] = 'Invitation was successfully created.'
    		format.html { redirect_to(polymorphic_path([@account,:movements])) }
    			format.iphone { redirect_to(polymorphic_path([@account,:movements])) }
    		format.xml  { render :xml => @sharedinvitation, :status => :created, :location => @sharedinvitation }
    	  else
    		format.html { render :action => "new" }
    			format.iphone { render :action => "new", :layout=> false }
    		format.xml  { render :xml => @sharedinvitation.errors, :status => :unprocessable_entity }
    	  end
		end
  	else
  		redirect( dashboard_url)
  	end
  end

  def destroy
    @account = @current_user.bankaccounts.find_by_id(params[:bankaccount_id])
	  if @account		
      @sharedinvitation = @account.shared_account_invitations.find(params[:id])
      @sharedinvitation.destroy

      respond_to do |format|
				format.html { redirect_to(polymorphic_path([@account,:movements])) }
				format.iphone { redirect_to(polymorphic_path([@account,:movements])) }
				format.xml	{ head :ok }
			end
	  else
		    redirect( dashboard_url)
	  end
  end
  
  def accept
    @sharedinvitation = SharedAccountInvitation.find_by_token(params[:id])
    if @sharedinvitation
      @sharedaccount = SharedAccount.new
      @sharedaccount.user_id = @current_user.id
      @sharedaccount.account_id = @sharedinvitation.account_id
      @sharedaccount.allow_insert =  @sharedinvitation.allow_insert
      @sharedaccount.allow_edit =  @sharedinvitation.allow_edit
      @sharedaccount.allow_delete =  @sharedinvitation.allow_delete
      
        respond_to do |format|
      	  if @sharedaccount.save
      		
      		flash[:notice] = 'Invitation was successfully created.'
      		format.html { redirect_to(dashboard_url) }
      		format.iphone { redirect_to(dashboard_url) }
      		format.xml  { render :xml => @sharedaccount, :status => :created, :location => @sharedaccount }
      	  end
      	end
    else
      respond_to do |format|
    	  format.html { redirect_to(dashboard_url) }
    		format.iphone { redirect_to(dashboard_url) }
    	end   
    end
    
  end 
  


end
