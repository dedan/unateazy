class WorksController < ApplicationController

  before_filter :authenticate, :only => [:admin,:edit,:update,:create, :destroy]

  # how many related works are shown below the current work
  N_RELATED = 5
  
  
  # show the description of a work using javascript
  def show_text
    @work = Work.find(params[:id])
  end

  #show the index page linking to a random work
  def index
    @works = Work.find(:all)
    
    respond_to do |format|
      format.html
      format.atom
    end
  end

  # render a table containing all works
  def admin
    @works = Work.find(:all)
  end

  # display works
  def show
    # if now work id is given, show a random work
    if params[:id].nil?
      @work = Work.find(:all).sort_by { rand }.first
    else
      @work = Work.find(params[:id])
    end

    unless @work.nil?
      # determine whether the shadowbox plugin is needed (large image)
      dimensions        = ImageSpec::Dimensions.new(@work.image.path(:display).downcase)
      @shadowbox_needed = dimensions.width > 600 || dimensions.height > 600
      @rel_works        = @work.rel_works.first(N_RELATED) unless @work.nil?
    end

    respond_to do |format|
      format.html
    end
  end

  # GET /works/new 
  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
    @work   = Work.find(params[:id])
    @others = Work.find(:all) - [@work]
  end

  # POST /works 
  def create
    @work = Work.new(params[:work])

    respond_to do |format|
      if @work.save
        flash[:notice] = 'Work was successfully created.'
        format.html { redirect_to(@work) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /works/1 PUT /works/1.xml
  def update
    @work = Work.find(params[:id])

    params[:checkbox].each do |box|
      logger.debug "message  #{box[1].to_i == 1}"
      logger.debug "message  #{Work.find(box[0])}"
      tmp = Work.find(box[0].to_i)                  # number of box
      if box[1].to_i == 1                           # is this box checked
        @work.rel_works << tmp unless @work.rel_works.include?(tmp)
      else
        @work.rel_works.delete(tmp)
      end
    end

    respond_to do |format|
      if @work.update_attributes(params[:work])
        flash[:notice] = 'Work was successfully updated.'
        format.html { redirect_to(@work) }
      else
        @others = Work.find(:all) - [@work]
        format.html { render :action => "edit" }
      end
    end 
  end

  # DELETE /works/1 DELETE /works/1.xml
  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    respond_to do |format|
      format.html { redirect_to("/login") }
    end
  end


private
  def authenticate
    authenticate_or_request_with_http_basic do |name, psw|
      name == "matan" && psw == "test"
    end
  end

end
