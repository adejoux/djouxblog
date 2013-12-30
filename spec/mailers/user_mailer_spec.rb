require "spec_helper"

describe UserMailer do
  describe "posted_comment" do
    let(:mail) { UserMailer.posted_comment }

    it "renders the headers" do
      mail.subject.should eq("Posted comment")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
