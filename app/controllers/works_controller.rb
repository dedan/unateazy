class WorksController < ApplicationController

  before_filter :authenticate, :only => [:admin,:edit,:update,:create, :destroy]

  # how many related works are shown below the current work
  N_RELATED = 5
  
  
  # GET /works GET /works.xml
  def show_text
    @work = Work.find(params[:id])
  end

  #show the index page 
  def index
    @rand_work = Work.find(:all).sort_by { rand }.first
  end

  def admin
    @works = Work.find(:all)
  end

  def thumb
   @work = Work.find(params[:id])
   render :inline => "@work.operate {|p| p.resize '100x100'}", :type => :flexi
  end

  def mid_thumb
   @work = Work.find(params[:id])
   render :inline => "@work.operate {|p| p.resize '120x120'}", :type => :flexi
  end


  # GET /works/1 GET /works/1.xml
  def show
   if params[:id].nil?
    @work = Work.find(:all).sort_by { rand }.first
   else
    @work = Work.find(params[:id])
   end
   @rel_works = @work.rel_works.first(N_RELATED) unless @work.nil?

    respond_to do |format|
    format.jpg if params[:format] == 'jpg'  
      format.html # index.html.erb
    end
  end

  # GET /works/new GET /works/new.xml
  def new
    @work = Work.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /works/1/edit
  def edit
    @work = Work.find(params[:id])
   @others = Work.find(:all) - [@work]
  end

  # POST /works POST /works.xml
  def create
    @work = Work.new(params[:work])

    respond_to do |format|
      if @work.save
        flash[:notice] = 'Work was successfully created.'
        format.html { redirect_to(@work) }
        format.xml  { render :xml => @work, :status => :created, :location => @work }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /works/1 PUT /works/1.xml
  def update
    @work = Work.find(params[:id])

   params[:checkbox].each do |box|
    logger.debug "message  #{box[1].to_i == 1}"
    logger.debug "message  #{Work.find(box[0])}"
    tmp = Work.find(box[0].to_i)
    if box[1].to_i == 1
      @work.rel_works << tmp unless @work.rel_works.include?(tmp)
    else
      @work.rel_works.delete(tmp)
    end
   end

    respond_to do |format|
      if @work.update_attributes(params[:work])
        flash[:notice] = 'Work was successfully updated.'
        format.html { redirect_to(@work) }
        format.xml  { head :ok }
      else
    @others = Work.find(:all) - [@work]
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end 
  end

  # DELETE /works/1 DELETE /works/1.xml
  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    respond_to do |format|
      format.html { redirect_to("/login") }
      format.xml  { head :ok }
    end
  end


private
  def authenticate
   authenticate_or_request_with_http_basic do |name, psw|
    name == "matan" && psw == "test"
   end
  end


end
