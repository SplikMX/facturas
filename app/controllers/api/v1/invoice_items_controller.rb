class Api::V1::InvoiceItemsController < ApplicationController
  before_action :set_invoice_item, only: [:show, :edit, :update, :destroy]
  respond_to :json

  # GET /invoice_items
  def index
    @invoice_items = InvoiceItem.all
    if params[:ids]
      @invoice_items = @invoice_items.where(id: params[:ids])
    end

    respond_with @invoice_items
  end

  # POST /invoice_items
  def create
    @invoice_item = InvoiceItem.new(invoice_item_params)

    if @invoice_item.save
      respond_with @invoice_item, status: :ok, location: api_invoice_item_url(@invoice_item)
    else
      render json: @invoice_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoice_items/1
  def update
    if @invoice_item.update(invoice_item_params)
      head :no_content
    else
      render json: @invoice_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invoice_items/1
  def destroy
    @invoice_item.destroy

    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_item
      @invoice_item = InvoiceItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invoice_item_params
      params.require(:invoice_item).permit(:amount, :description, :client_id)
    end
end
