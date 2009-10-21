class SharedAccountInvitationsController < ApplicationController
  before_filter :require_user
  
  def new
    	@account = Bankaccount.find(params[:bankaccount_id])
     @sharedinvitation = @account.shared_account_invitations.new

      respond_to do |format|
        format.html # new.html.erb
  	    format.iphone  { render :layout => false }
        format.xml  { render :xml => @sharedinvitation }
      end
  end

  def create
    	@account = Bankaccount.find(params[:bankaccount_id])
    @sharedinvitation = @account.shared_account_invitations.build(params[:shared_account_invitation])
    @sharedinvitation.user_id = @account.user_id
    
    
    respond_to do |format|
      if @sharedinvitation.save
        @sharedinvitation.shared_account_invitation(@current_user)
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
  end

  def destroy
    @account = Bankaccount.find(params[:bankaccount_id])
     @sharedinvitation = @account.shared_account_invitations.find(params[:id])
      @sharedinvitation.destroy

      respond_to do |format|
        format.html { redirect_to(polymorphic_path([@account,:movements])) }
  	    format.iphone { redirect_to(polymorphic_path([@account,:movements])) }
        format.xml  { head :ok }
      end
  end
  
  def accept
  end 
  


end
