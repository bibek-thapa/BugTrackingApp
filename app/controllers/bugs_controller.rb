class BugsController < ApplicationController
  before_action:set_alltypes	
  before_action :set_bug, only: [:show, :edit, :update, :destroy]

  # GET /bugs
  # GET /bugs.json
  def index
    @bugs = Bug.all


    # Apply XSLT
    document = Nokogiri::XML(@bugs.as_json.to_xml)
    template = Nokogiri::XSLT(File.read('app/assets/bug.xsl'));
    transformed_document = template.transform(document) 

    # dumps the transformed document to the console so you can see the effects
     puts "---\nBefore"
     puts document
     puts "---\nAfter"
     puts transformed_document 
    respond_to do |format|
      format.html{render :index}
      format.json{render :index, status: :ok}
      #format.xml{render xml: @bugs.as_json}
      format.xml {render xml: transformed_document}
    end

  end

  # GET /bugs/1
  # GET /bugs/1.json
  def show
  end

  # GET /bugs/new
  def new
    @bug = Bug.new
  end

  # GET /bugs/1/edit
  def edit
  end

  # POST /bugs
  # POST /bugs.json
  def create
    @bug = Bug.new(bug_params)
  user=User.find(bug_params[:user_id])
    @bug.build_user(:id=>user.id)

    respond_to do |format|
      if @bug.save
        format.html { redirect_to @bug, notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1
  # PATCH/PUT /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to @bug, notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1
  # DELETE /bugs/1.json
  def destroy
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to bugs_url, notice: 'Bug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:titile, :description, :issue_type, :priority, :status,:user_id)
    end

    def set_alltypes
	    @issuetypes=Bug.issue_types	    
	    @priorities=Bug.priorities
    	@statuses=Bug.statuses	
    end
end

