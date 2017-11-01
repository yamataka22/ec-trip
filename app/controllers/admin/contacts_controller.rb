class Admin::ContactsController < Admin::AdminBase
  def index
    @contacts = Contact.all.page(params[:page]).per(50).order(id: :desc)
  end

  def show
    @contact = Contact.find(params[:id])
    @contact.read = true
    @contact.save!

    @before_contact = Contact.where('id < ?', @contact.id).order(id: :desc).first
    @next_contact = Contact.where('id > ?', @contact.id).order(:id).first
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy!
    flash[:success] = '削除が完了しました'
    redirect_to admin_contacts_path
  end

end
