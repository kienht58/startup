class ScholarshipsController < ApplicationController
  before_action :set_scholarship, only: [:show, :edit, :update, :destroy]
  before_filter :load_university
  # GET /scholarships
  # GET /scholarships.json
  def index
    @scholarships = @university.scholarships
  end

  # GET /scholarships/1
  # GET /scholarships/1.json
  def show
    @scholarship = @university.scholarships.find(params[:id])
  end

  # GET /scholarships/new
  def new
    @scholarship = @university.scholarships.build
  end

  # GET /scholarships/1/edit
  def edit
    @scholarship = @university.scholarships.find(params[:id])
  end

  # POST /scholarships
  # POST /scholarships.json
  def create
    @scholarship = @university.scholarships.create(scholarship_params)

    respond_to do |format|
      if @scholarship.save
        format.html { redirect_to ([@scholarship.university, @scholarship]), notice: 'Scholarship was successfully created.' }
        format.json { render :show, status: :created, location: @scholarship }
      else
        format.html { render :new }
        format.json { render json: @scholarship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scholarships/1
  # PATCH/PUT /scholarships/1.json
  def update
    @scholarship = @university.scholarships.find(params[:id])
    respond_to do |format|
      if @scholarship.update(scholarship_params)
        format.html { redirect_to ([@scholarship.university, @scholarship]), notice: 'Scholarship was successfully updated.' }
        format.json { render :show, status: :ok, location: @scholarship }
      else
        format.html { render :edit }
        format.json { render json: @scholarship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scholarships/1
  # DELETE /scholarships/1.json
  def destroy
    @scholarship = @university.scholarships.find(params[:id])
    @scholarship.destroy
    respond_to do |format|
      format.html { redirect_to university_scholarship_url, notice: 'Scholarship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def searchtop
    @scholarship = Search::Scholarship.new
  end

  def search
    @scholarship = Search::Scholarship.new(search_params)
    @scholarships = @scholarship
     .matches
     .includes(:university)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scholarship
      @scholarship = Scholarship.find(params[:id])
    end

   def load_university
     @university = University.find(params[:university_id])
   end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scholarship_params
      params.require(:scholarship).permit(:title, :sponsor, :award, :requirements, :start_time, :end_time, :content, :contact, :university_id)
    end


  def search_params
      params
      .require(:search_scholarship)
      .permit(Search::Scholarship::ATTRIBUTES)
  end
end
