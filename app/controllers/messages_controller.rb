class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
   @messages = Message.order(created_at: :desc).page(params[:page]).per(10)
  # render :index が省略されている
  end

  def show
#    @message = Message.find(params[:id])
#    set_message
  end

  def new
    @message= Message.new
  end


  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = 'Message が正常に投稿されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message の投稿に失敗しました'
      render :new
    end

  end


  def edit
#    @message = Message.find(params[:id])
#    set_message
  end

  def update
#    @message = Message.find(params[:id])
#    set_message
   # binding.pry
    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
#    @message = Message.find(params[:id])
#    set_message

    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
  end

  private

  # Strong Parameter
  def message_params
    params.require(:message).permit(:content, :title)
  end

  def set_message
    @message = Message.find_by(id: params[:id])
    #redirect_to root_url if @message.nil?
    render_404 if @message.nil?
  end 
end
