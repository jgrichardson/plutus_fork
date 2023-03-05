module Plutus
  # This controller provides restful route handling for Accounts.
  #
  # The controller supports ActiveResource, and provides for
  # HMTL, XML, and JSON presentation.
  #
  # == Security:
  # Only GET requests are supported. You should ensure that your application
  # controller enforces its own authentication and authorization, which this
  # controller will inherit.
  #
  # @author Michael Bulat
  class AccountsController < ::Plutus::ApplicationController
    unloadable if respond_to?(:unloadable)

    before_action :set_account, only: %i[ show edit update destroy ]
    
    def index
      @accounts = Account.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @accounts }
        format.json  { render :json => @accounts }
      end
    end

    def show; end

    def new
      @account = Account.new
    end

    def edit; end

    def create
      @account = Account.new(account_params)
      respond_to do |format|
        if @account.save
          format.turbo_stream
          format.html { redirect_to account_url(@account), notice: "Account was successfully created." }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@account)}_form", partial: "form", locals: { account: @account }) }
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @account.update(account_params)
          format.turbo_stream
          format.html { redirect_to account_url(@account), notice: "Account was successfully updated." }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@account)}_form", partial: "form", locals: { account: @account }) }
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @account.destroy
          format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@account)}_container") }
          format.html { redirect_to account_url, notice: "Account was successfully destroyed." }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@account)}_form", partial: "form", locals: { account: @account }) }
        end
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :type, :contra)
    end
  end
end
