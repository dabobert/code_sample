class ExportFlowTemplate < ActiveRecord::Base
  belongs_to :last_editor, :class_name => "Designer", :foreign_key => :last_editor_id
  belongs_to :creator, :class_name => "Designer", :foreign_key => :creator_id
end
