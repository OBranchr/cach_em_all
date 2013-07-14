class ArbitraryRecordsController < ApplicationController
  before_action :set_arbitrary_record, only: [:show, :edit, :update, :destroy]

  # GET /arbitrary_records
  def index
    @arbitrary_records = ArbitraryRecord.all
  end

  # GET /arbitrary_records/1
  def show
  end

  # GET /arbitrary_records/new
  def new
    @arbitrary_record = ArbitraryRecord.new
  end

  # GET /arbitrary_records/1/edit
  def edit
  end

  # POST /arbitrary_records
  def create
    @arbitrary_record = ArbitraryRecord.new(arbitrary_record_params)

    if @arbitrary_record.save
      redirect_to @arbitrary_record, notice: 'Arbitrary record was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /arbitrary_records/1
  def update
    if @arbitrary_record.update(arbitrary_record_params)
      redirect_to @arbitrary_record, notice: 'Arbitrary record was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /arbitrary_records/1
  def destroy
    @arbitrary_record.destroy
    redirect_to arbitrary_records_url, notice: 'Arbitrary record was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arbitrary_record
      @arbitrary_record = ArbitraryRecord.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def arbitrary_record_params
      params.require(:arbitrary_record).permit(:name)
    end
end
