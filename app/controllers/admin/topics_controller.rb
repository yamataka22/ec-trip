class Admin::TopicsController < Admin::AdminBase
  def index
    @topics = Topic.all.page(params[:page]).per(30).order(id: :desc)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(post_params)
    if @topic.save
      flash[:success] = '登録が完了しました'
      redirect_to admin_topics_path
    else
      flash.now[:error] = '入力内容をご確認ください'
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(post_params)

    if @topic.save
      flash[:success] = '更新が完了しました'
      redirect_to admin_topics_path
    else
      flash.now[:error] = '入力内容をご確認ください'
      render :edit
    end
  end

  def destroy
    topic = Topic.find(params[:id])
    topic.destroy!
    flash[:success] = '削除が完了しました'
    redirect_to admin_topics_path
  end

  private
  def post_params
    params.require(:topic).permit(:title, :link_url)
  end
end
