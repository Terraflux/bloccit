require 'rails_helper'

RSpec.describe Answer, type: :model do
	let(:question){Question.create!(title: "New Question Title", body: "New Body Text", resolved: false)}
	let(:answer){Answer.create!(body: "Answer Body")}
	context "attributes" do
		it "should respond to body" do
			expect(answer).to respond_to(:body)
		end
	end
end