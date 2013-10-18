class ChangeMissingUrlReasonColumnFromProjects < ActiveRecord::Migration
  def change
    change_column :projects, :missing_url_reason, :text
  end
end
