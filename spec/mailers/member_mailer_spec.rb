require "rails_helper"

RSpec.describe FrontMailer, type: :mailer do
  describe "purchase_complete" do
    let(:mail) { FrontMailer.purchase_complete }

    it "renders the headers" do
      expect(mail.subject).to eq("Purchase complete")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
