class ScripturesController < ApplicationController
  # GET /scriptures
  # GET /scriptures.xml
  def index
    @scriptures = Scripture.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scriptures }
    end
  end

  # GET /scriptures/1
  # GET /scriptures/1.xml
  def show
    @scripture = Scripture.find(params[:id], :include => 'comments')
    @scriptures = Scripture.find(:all)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scripture }
    end
  end

  # GET /scriptures/new
  # GET /scriptures/new.xml
  def new
    @scripture = Scripture.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @scripture }
    end
  end

  # GET /scriptures/1/edit
  def edit
    @scripture = Scripture.find(params[:id])
  end

  # POST /scriptures
  # POST /scriptures.xml
  def create
    @scripture = Scripture.new(params[:scripture])
    @scripture[:user_id] = current_user.id
    respond_to do |format|
      if @scripture.save
        flash[:notice] = 'Scripture was successfully created.'
        format.html { redirect_to(@scripture) }
        format.xml  { render :xml => @scripture, :status => :created, :location => @scripture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @scripture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /scriptures/1
  # PUT /scriptures/1.xml
  def update
    @scripture = Scripture.find(params[:id])
    if @scripture[:user_id].nil?
      @scripture[:user_id] = current_user.id
    end
    respond_to do |format|
      if @scripture.update_attributes(params[:scripture])
        flash[:notice] = 'Scripture was successfully updated.'
        format.html { redirect_to(@scripture) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @scripture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scriptures/1
  # DELETE /scriptures/1.xml
  def destroy
    @scripture = Scripture.find(params[:id])
    @scripture.destroy

    respond_to do |format|
      format.html { redirect_to(scriptures_url) }
      format.xml  { head :ok }
    end
  end
  
end
