class TechnologyDecorator < Draper::Decorator
  include Draper::LazyHelpers 
  decorates_finders 
  delegate_all

  decorates_associations :projects 

  def years_of_experience 
    "#{object.years_of_experience} years"
  end

  def history
    markdown.render(personal_history).html_safe
  end

  # def related_projects 
  #   projects.each do |project| 
  #     content_tag :article, class: 'related_project' do 
  #       concat image_tag project.main_image.url 
  #       concat content_tag :header, class: 'persona header' do 
  #         concat content_tag :h2 do 
  #           concat link_to project.title, project_path(project)
  #           concat content_tag :p, project.byline 
  #         end
  #       end
  #     end
  #   end
  # end
end

