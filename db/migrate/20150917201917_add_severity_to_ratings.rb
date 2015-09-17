class AddSeverityToRatings < ActiveRecord::Migration
  def change
  	change_table :ratings do |t|
		t.string :severity
		t.references :rateable, polymorphic: true, index: true
	end
  end
end
